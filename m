Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbRHFJmy>; Mon, 6 Aug 2001 05:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbRHFJmp>; Mon, 6 Aug 2001 05:42:45 -0400
Received: from weta.f00f.org ([203.167.249.89]:52624 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S267771AbRHFJme>;
	Mon, 6 Aug 2001 05:42:34 -0400
Date: Mon, 6 Aug 2001 21:43:27 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: [LONGish] Brief analysis of VMAs (was: /proc/<n>/maps getting _VERY_ long)
Message-ID: <20010806214327.A23464@weta.f00f.org>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <E15TNbk-0007pu-00@the-village.bc.nu> <200108052341.f75Nfhx08227@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <200108052341.f75Nfhx08227@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 05, 2001 at 04:41:43PM -0700, Linus Torvalds wrote:

    I'd like to know more than just the app that shows problems - I'd
    like to know what it is doing.

Well, since I initially complained (this time).... I thought I would
try and quantify things a little.

Attached is a program I use for reading 'maps' files and showing what
levels of aggregation are possible, vma-merge-test.c (barf).



Now, I wrote a small proglet to malloc (I'm interested in testing how
glibc behaves, since pretty much everything uses glibc) memory in
chunks until it can do so no longer, this means getting pretty close
to 3G in my machine (not all pages need be resident).

Now, if I malloc 1 megabyte chunks, things coalesce very nicely, in
fact, the coalesce as much as you reasonable can coalesce things,
to about 13 vmas or so, which is about as good as you can hope for if
using shared libraries.

If I allocate 4K chunks, I get 65746 vmas! Values in between obviously
have varying effects:

     13 alloc-1M
   3069 alloc-512K
   7151 alloc-256K
  32731 alloc-64K
  65746 alloc-4K

like so.

the 4K allocations will actually coalesce into only 11 vmas (the fact
is does better than 1M is because we have better granularity so it
fills in gaps where 1M chunks simply won't fit)!

alloc-512K can't be coalesced at all, alloc-256K can be by about 50%,
alloc-128K by 25% and alloc-64K by 12.5% --- no points for spotting
the pattern.

Using strace....

... for 1M allocations, I can see there are 2038 mmap's for 257*4k to
allocate the 2G or so, and brk is used to 'allocate' 257*4k chunks of
memory 897 times, which pretty much gives us our 3G.  FWIW, mmap is
used for the first 1G or so, brk for the next 1G, and mmap for the
last 1G, with a call to mprotect hidden in there.  The mmaps are
PROT_READ|PROT_WRITE.

... for 4K allocations, I can see brk is used to allocate 8K chunks,
114000 times or so, getting 1G, then mmap is used to allocate 2M
chunks, of which about 1M is munmapp'ed and for the remaining 1M
mprotect is called (page by page!) making about 250 odd mprotect
calls.  This appears to happen until 3G is allocated. The mmaps are
PROT_NONE and the mprotect's change this to PROT_READ|PROT_WRITE.

... for 128K allocations, mmap is used to grab 33*4k about 1024 times,
netting 128M, brk using to allocate 32(+/-1)*4k pages about 7000 times
netting around 1G and then a pattern of mmap 2M, munmap 1M, protect
{33,32,32,32,32,32}*4k of the still mapped 1M --- this is the bit that
sucks.  The mmap was done PROT_NONE, the protect's change this to
PROT_READ|PROT_WRITE, but not all of the 1M, so the ability to
coalesce here is thwarted (you can coalesce the 32*4k mprotect
regions, the remain region has the wrong protection).



What does this have to do with reality?

IT DEPENDS ON WHAT APPLICATION(S) YOU ARE RUNNING.

It appears mozilla, that super lean, super fast and very stable
web-browser mostly grows using brk with fairly small increments (under
64K) as it reads data in form various places --- and from several
threads at a time.... and lots of small allocates appears to be a
"Very Bad Thing".  A couple of people sent me examples of other
applications that cause problems too, for example David Luyer sent me
the map for evolution-mail which is some new "fangled pointy-clicky
Gnome super-widget-enhanced" mail application --- perhaps that also
grows memory slowly (I don't have an strace of it, so this is just
speculation).

VMware (capatalisation?) also causes large numbers of vmas, but my
attempts to get Xfree86, gimp or gcc (when compiling C code) to do so
were unsuccessful, all showed little if any ability to merge vmas.
Compiling a large c++ application might show some gains here, but I
don't have anything large enough to try.


In linux/mm/mmap.c:do_brk I see:

        /* Can we just expand an old anonymous mapping? */
        if (addr) {
                struct vm_area_struct * vma = find_vma(mm, addr-1);
                if (vma && vma->vm_end == addr && !vma->vm_file &&
                    vma->vm_flags == flags) {
                        vma->vm_end = addr + len;
                        goto out;
                }
        }

which explains why allocations from increments of brk do coalesce
well.  Elsewhere in linux/mm/mmap.c:do_mmap_pgoff we have:

        /* Can we just expand an old anonymous mapping? */
        if (addr && !file && !(vm_flags & VM_SHARED)) {
                struct vm_area_struct * vma = find_vma(mm, addr-1);
                if (vma && vma->vm_end == addr && !vma->vm_file &&
                    vma->vm_flags == vm_flags) {
                        vma->vm_end = addr + len;
                        goto out;
                }
        }

so I assume consistent use of mmap will produce good results too.


BUT, glibc doesn't always have consistent use, as I mentioned about,
it will often do

        mmap( .... PROT_FOO ... )
        munmap ( some of the above )           [optional]
        for( ... )
                mprotect ( PROT_BAR ... )

        which means the simple logic above cannot coalesce things.




This leaves three (four) possibilities:

   (1) change glibc to avoid the above behavior

   (2) fiddle with mprotect to expand/coalesce regions

   (3) declare problematic applications borked

or maybe

   (4) have more complex vma logic all over the place in the kernel


Anyhow, that's my very brief rather unscientific handy-waving
explanation that seems to make sense to me!

Incidentally, the algorithm in linux/fs/proc/aarry.c:proc_pid_read_maps
is _terribly_ slow for reading /proc/<n>/maps when there are many
vmas.  We could possible hack around this by assuming a contact
line-length or something (too gross?).




  --cw

--/04w6evG8XlLl3ft
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="vma-merge-test.c"

/*
 * vma-merge-test.c --- count # entries in /proc/<n>/maps as well as
 * indication of mergability (is that a word?)
 *
 * technically this is buggy --- pass the paper bag :)
 *
 * cw@f00f.org, 6 Aug 2001
 *
 */

#include <errno.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    FILE *f;
    char linebuf[128];
    long st, en, len, dunno;
    long pen = 0, ms = 0;
    char flags[32], indev[32], path[256];
    char pflags[32], pindev[32];
    int cu = 0, cm = 0, mc = 0;

    if(argc != 2) {
        fprintf(stderr, "Please supply one argument, the 'maps' file\n");
        return 1;
    }

    if(!(f = fopen(argv[1],"r"))) {
        fprintf(stderr, "error (%s) trying to open '%s'\n", strerror(errno), argv[1]);
        return 2;
    }

    pflags[0] = '\000';
    pindev[0] = '\000';

    while(!feof(f)) {
        if(!fgets(linebuf, sizeof linebuf, f))
            break;

        if(sscanf(linebuf, "%lx-%lx %s %8lx %s %ld %s\n",
                  &st, &en, flags, &len, indev, &dunno, path) < 5) {
            fprintf(stderr, "Bad line\n\t%s\nAborting\n", linebuf);
            break;
        }

        cu++;

        /* same as previous mapping and adjacent, then merge is
           possible */

        if(!strcmp(indev, pindev) && !strcmp(flags, pflags) && (st == pen)) {
            cm++;
            mc++;
        } else {
            if(mc) {
                /* show merged results */
                printf("%08lx-%08lx %s %s (%d)\n", ms, pen, flags, indev, mc);
            }

            /* show these results */
            printf("%08lx-%08lx %s %s\n", st, en, flags, indev);

            strcpy(pindev, indev);
            strcpy(pflags, flags);
            ms = st;
            mc = 0;
        }
        pen = en;
    }

    printf("\n%d entries, %d merges\n", cu, cm);
    printf("%d with merging, %4.1f%% of original\n", cu - cm,
           (double)(100.0 * (cu - cm) / cu));

    fclose(f);

    return 0;
}

--/04w6evG8XlLl3ft--
