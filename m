Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316802AbSEVAti>; Tue, 21 May 2002 20:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSEVAti>; Tue, 21 May 2002 20:49:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:50297 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316802AbSEVAtg>; Tue, 21 May 2002 20:49:36 -0400
Date: Wed, 22 May 2002 02:47:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020522004740.GR21806@dualathlon.random>
In-Reply-To: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz> <E17AHQw-0000Jq-00@the-village.bc.nu> <3CEAC020.4F63A181@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 02:46:08PM -0700, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > > So if you pass bad pointer to read(), why would you expect "number of
> > > bytes read" return? Its true that kernel can't simply not return
> > 
> > Because the standard says either you return the errorcode and no data
> > is transferred or for a partial I/O you return how much was done. Its
> > not neccessarily about accuracy either. If you do a 4k copy_from_user and
> > error after for some reason returning -Esomething thats fine providing you
> > didnt do anything that consumed data or shifted the file position etc
> 
> Is it safe to stick a nose in here with some irrelevancies?
> 
> Pavel makes a reasonable point that copy_*_user may elect
> to copy the data in something other than strictly ascending
> user virtual addresses.  In which case it's not possible to return
> a sane "how much was copied" number.
> 
> And copy_*_user is buggy at present: it doesn't correctly handle
> the case where the source and destination of the copy are overlapping
> in the same physical page.  Example code below.  One fix is to
> do the copy with descending addresses if src<dest or whatever.
> But then how to return the number of bytes??
> 
> Also, I see all these noises from x86 gurus about how copy_*_user()
> could be sped up heaps with fancy CPU-specific features.  Could
> someone actually alight from butt and code that up?
> 
> 
> akpm-1:/usr/src/ext3/tools> ./copy-user-test foo
> aabcddfghhjkllnopprsttvwxx
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <string.h>
> #include <sys/mman.h>
> 
> int main(int argc, char *argv[])
> {
> 	int fd;
> 	char *filename;
> 	char *mapped_mem;
> 	char buf[26];
> 	int i;
> 
> 	if (argc != 2) {
> 		fprintf(stderr, "Usage; %s filename\n", argv[0]);
> 		exit(1);
> 	}
> 
> 	filename = argv[1];
> 	fd = open(filename, O_RDWR|O_TRUNC|O_CREAT, 0666);
> 	if (fd < 0) {
> 		fprintf(stderr, "%s: Cannot open `%s': %s\n",
> 			argv[0], filename, strerror(errno));
> 		exit(1);
> 	}
> 
> 	for (i = 0; i < 26; i++)
> 		buf[i] = 'a' + i;
> 
> 	mapped_mem = mmap(0, 26, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> 	if (mapped_mem == 0) {
	    ^^^^^^^^^^^^^^^ minor reminder: you should check against MAP_FAILED here (-1 not 0)

> 		perror("mmap");
> 		exit(1);
> 	}
> 	write(fd, buf, 26);
> 	lseek(fd, 1, SEEK_SET);
> 	write(fd, mapped_mem, 25);

very funny test really (it's like those games leading to an absurd), so
you actually notice that copy_user reads and writes 4 byte at once till
the last few bytes in the buffer :). I don't think anybody cares about
those kind of semantics of physical page overlapping in a "word" range
between pagecache destination and buffers source that is again the same
phys page.


If we use mmx unrolled loops faster on the athlons the "word"
granularity of copy_user would be 40bytes so it would be even more
noticeable (by luck in your above testcase then it would actually write
what you expect because the string is shorter and it wouldn't trigger a
roll of the unrolled loop).

An easy fix to resurrect the "expected" semantics of write, is to read
userspace and write pagecache in 1byte units, but that's slow, and I
don't think it really worth.  Let's declare this case undefined, it's
not a security matter and it's not useful either I think.


> 	msync(mapped_mem, 26, MS_SYNC);

other minor side note: msync actually cannot make differences to this case.

> 	munmap(mapped_mem, 26);
> 	close(fd);
> 
> 	{
> 		char *p = malloc(strlen(filename) + 20);
> 		sprintf(p, "cat %s ; echo", filename);
> 		system(p);
> 	}
> 	exit(0);
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
