Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSEVCxg>; Tue, 21 May 2002 22:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSEVCxf>; Tue, 21 May 2002 22:53:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8972 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316835AbSEVCxe>; Tue, 21 May 2002 22:53:34 -0400
Date: Wed, 22 May 2002 04:51:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: O_DIRECT on 2.4.19pre8aa2 md device
Message-ID: <20020522025159.GA21164@dualathlon.random>
In-Reply-To: <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020514105002.03b54760@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020522110621.03098bf8@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 11:18:13AM +1000, Lincoln Dale wrote:
> At 05:51 PM 21/05/2002 +0200, Andrea Arcangeli wrote:
> ...
> >In any real usage where I/O is combined with CPU and mem bus utilization
> >for computations, not only to move data from disk to userspace memory
> >O_DIRECT is an _huge_ win as you found out. You have 100000 more usable
> >ticks for computations over 150000 total ticks.
> ...
> 
> no disagreement there.
> 
> however, there is still an enormous difference between 
> access-/dev/sdX-via-block-layer and access-dev/sdX-via-mmap (127mbyte/sec 
> versus 175+mbyte/sec) that for many "disk intensive" applications is a huge 
> difference.

hmm wait a moment, in your last email 175MB/sec was the nocopy hack, not
mmap("/dev/sda"). mmap has the same overhead of O_DIRECT in dealing with
the user pagetables (actually O_DIRECT has the potential to be a bit
lighter because map_user_kiobuf solves the page faults before triggering
a real CPU page fault that has to pass through do_page_fault for every
single page, and we prefault all of them before starting the I/O), so if
175MB/sec was the nocopy hack, 175MB/sec definitely cannot be the mmap too.

Infact a nice addition to your proggy would be to also benchmark the I/O
bandwith using mmap driven I/O, instead of buffered I/O, raw, O_DIRECT
and the nocopy hack. Like raw and O_DIRECT also the mmap driven I/O is
zerocopy I/O, so only the buffered-IO would show the total waste of cpu
and mem bandwith. I guess mmap will be on the same performance lines
with O_DIRECT (potentially a bit faster thanks to readahead), at least
during reads, writes are a bit different, you've to flush by hand with
msync region by region like if they would be write syscalls, or to wait
vm pressure.

175MB/sec means you only read to kernel space and you don't make such
information visible to userspace, so it is unbeatable no matter what :).
Only in kernel service like sendfile and/or tux can take advantage of it by
taking the radix tree lock and looking up the radix tree to find the
physical page. 

> 
> if we _could_ produce superior performance with something like:
>  (a) additional improvements to O_DIRECT (say, a mmap() hack for O_DIRECT)
>      whereby i/o can go direct-to-userspace or 
> userspace-can-mmap(readonly)-into-
>      kernel-space

even if you get a direct physical view of some of the address space (as
said in a earlier email on 32bit the lack of address space would reduce
the place you can map to a little zone), you still need the information
on the physical memory where the I/O gone, so that's still an API from
kernel to user, so again an overhead compared to the nocopy hack. And
that information is exactly the radix tree/hashtable (and btw, I still
I'm not a believer in the radix tree and I wonder if anybody did any
real benchmark on the big irons with a properly tuned hashtable that
takes into account the highmem too like with Davem's patch, the last
benchmarks I seen where fake IIRC, the bonus of the radix tree is the
per-inode locking and that it reduces the amount of normal zone needed
to be allocated statically for numa-q, of course until somebody notices
they can exploit the radix tree with a few liner proggy and hogs the
machine with unfreable radix tree metadata by allocating only 1 page of
highmem cache for each radix tree leaf entry and that will need further
instrumentation to the vm so that it will release highmem memory related
to the lowmem radix tree metadata, at least it's only a security
problem, not a pratical problem with useful users). Not to tell if
there's a bug in your proggy you'd destabilize the kernel. The truth is,
this is no different at all than writing a proper kernel service, if you
need that kind of performance you should write kernel code, not user
code, and to work with the pagecache directly. That's what tux does of
course, that's what sendfile does too, sendfile is like a part of an
userspace fileserver that is been moved in kernel space to send stuff
over the wire in zerocopy with knowledge about kernel data structures
incidentally like pagecache/raidx tree. You should build a sendfile like
operation and anyways to do the stuff in kernel. So you also take all
the advantages of tlb 4Mpages etc..etc..  that kernel code has. Also
take in mind sendfile can just now work to copy data in the fs too,
infact before 2.4.3 it was useful only for doing that fs copies avoiding
passing through userspace before the pskb layer was introduced in the
network code. Now thanks to the blkdev-in-pagecache introduced in 2.4.10
sendfile will even work with blkdevices, it couldn't work with
blockdevices previously. Unfortunately /bin/cp never started using it, I
made a patch to change cp to use sendfile it and to fallback to
read/write if it returned -ENOSYS, but it is never been integrated, it's
still available in my ftp area at suse.com/pub/people/andrea if anybody
is interested to actually copy data in the filesystem without wasting
mem bandwith (I don't copy heavily stuff around [I only create directory
with -l] so it is never been a real need for me). The worst part of my
/bin/cp sendfile patch is that sendfile isn't capable of being
interrupted by a signal, so copying an huge file would hang the machine,
but the same is just for huge read and write, so I consider that a kernel
issue and I think userspace should just write the whole thing at once
(however until the kernel remains uncapable of interrupting sendfile,
userspace can as well sendfile in chunks of a few mbyte each so there's
no risk of an accidental DoS at least, as far as the chunks are of the
order of the few megs there should be no loss in performance). btw, now
that sendfile64 is available in 2.5 the cp hack is doable again with LFS
support too.

Returning to our topic :), the pagetables can be see as a representation
of the same information encoded in the radix tree. They're the data
structure meant to provide the information of where is the physical page
where the I/O happened to userspace, and they provide a security layer
between kernel and userspace unlike /dev/mem or a kernel service
accessing the radix tree directly.  instead of mapping physical
contigous ram via /dev/mem, and telling userspace where's the ram it
needs to use, the kenrel sets the pagetables that lead userspace to
reach the right ram without having to deal with its physical position,
and this provides protection and the app cannot crash the kernel (unless
you find a bug in map_user_kiobuf :).


> or
>  (b) O_DIRECT with async-i/o

that's a different problem, this only increases the I/O pipeline, so it
will only give you such 7mbyte/sec back, it won't reduce cpu utilization
further or it won't make the I/O significantly faster (compared to using
large buffers for synchronous read/writes). It makes sure that no disk
is idle for no good reason, but it doesn't change at all the overhead in
the VM side to provide the information from disk to userspace (and the
other way around for writes).

> or
>  (c) /dev/rawN-like interface (eg. /dev/directN) within a fixed disk 
> buffer in kernel
>      (eg. physical memory allocated at bootup) that is populated readonly 
>      into
>      user-space)
> would such a hack be accepted in the 2.5 tree?
> 
> it sure isn't your "average desktop" setup where you hit these things as 
> performance limitations, but many folk (myself included) have very specific 
> applications which are essentially bottlenecked on PC hardware 
> limitations.  these limitations are a side-effect of how the linux kernel 
> works.

again, if you need to skip the overhead of passing the info to the
usersapce you should write kernel code. If you want to take advantage of
the protection of the userspace, you also need to pay for the pagetable
settings or pagetable walking instead. Anything that knows physical
pages is kernel code, writing userspace mapping /dev/mem is an illusion
of writing userspace code, that's kernel code anyways. The framebuffer
thing of X is different, X really only needs to talk to a device, it
doesn't really care about the kernel, it doesn't need to communicate
with the kernel, infact if it needs to communicate with the kernel to do
that it needs proper kernel modules like the pci/drm/agpgart/mtrr kernel drivers.
What the X server does with /dev/mem is no different than
mmap("/dev/fb0") and using the so mapped framebuffer. For read and
writes via pagecache or userspace memory, you instead need to enterely
deal with kernel internals data structures instead that only the kernel
knows, and that's why it's kernel code as soon as you want to bypass the
protection layer of the pagetables.

One way to speedup overwrites would be to make faster the lookup from
[virtual address,vma] to [physical page] using a data structure that would
act as a software tlb, that could be attached to a vma, and to en abled
with an mmap flag so you enable it only on the SGA, so an overwrite of
disk data would be faster and you could skip the pagetable walking the
second time, but if you seek an huge lot and the number of pages is
huge, at least if they're not 4M pages, the number of entries to remeber
would be quite huge and it would waste some ram, plus it wouldn't be a
critical optimization, you would skip a few levels of indirection in the
lookup, like a radix tree with only one level vs a radix tree with 3
levels of indirection and such data structure would need some
sychronization during the vma modifications too.

> that doesn't mean that other OSes don't suffer from the same thing -- since 
> no-other mainstream OS does the right thing, that doesn't mean that we 
> cannot make linux even better.
> 
> obviously, many of the above would only be suitable for disk-read 
> operations and less-so for disk-write -- but its probably easier to tackle 
> these one by one.

the point is, why are you reading from disk, what are you going to do
with such data? For example, assume you read from disk to find the
string "xxx" in a file the fastest possible, then the right way to
exploit the max bandwith is to write a kernel module that triggers the
readpage asynchronously (trivial in kernel, just don't wait_on_page
until you need the data), lookup the radix tree, kmap the page and
search the string, kunmap, start a new async readpage, lookup the next
page, wait_on_page the next page and so on. That's the only way to run
at the core 175MB/sec speed, anything running in userspace would be
slower (even kernel code will be slower than 175MB if kmap actually does
something with the pte if you've more than 1G and CONFIG_3G selected etc..)

Now I'm not suggesting to move a database to kernel space for the sake
of performance, the layer of protection is foundamental for the
reliability of the system, but if you have special needs for certain
special things, then a kernel module accellerator is the only way to go
faster than buffered-IO/read/mmap/O_DIRECT/raw or whatever that makes
that disk data visible from disk to userspace and that in turn needs to
deal with the virtual mappings too and not only with the physical pages
mapped in the kernel direct mapping.

Long email sorry.

Andrea
