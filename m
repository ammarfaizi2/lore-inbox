Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRKSQgm>; Mon, 19 Nov 2001 11:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279992AbRKSQgd>; Mon, 19 Nov 2001 11:36:33 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:47778 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S279997AbRKSQgS>; Mon, 19 Nov 2001 11:36:18 -0500
Date: Mon, 19 Nov 2001 10:36:03 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200111191636.KAA17722@tomcat.admin.navo.hpc.mil>
To: jas88@cam.ac.uk, Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <E165oY1-0006Db-00@mauve.csi.cam.ac.uk>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James A Sutherland <jas88@cam.ac.uk>:
> On Monday 19 November 2001 10:51 am, Remco Post wrote:
> > --8<--
> >
> > > Except that openoffice and mozilla can be swapped out in BOTH cases: the
> > > kernel can discard mapped pages and reread as needed, whether you have a
> > > swap partition or not.
> >
> > No they can't without swap, nothing can be SWAPPED out. The code pages can
> > be paged out (discarded), but no SWAPPING takes place.
> 
> OK, s/swapped/paged/.
> 
> > > Whereas without swapspace, only the read-only mapped pages can be swapped
> > > out.
> >
> > Again, pages do not gat swapped out, only applications can get swapped out.
> > Swapping is per definition the process of removing all pages used by one
> > application from RAM, and moving ALL pages to swap.
> 
> So in effect, Linux never ever swaps. At all. Under any circumstances. (Using 
> your interpretation of the word). Which does raise the question of WTF that 
> "swap space" is for, and why it's really used for "paging"...

Linux doesn't - but some UNIX systems do swap. This is when the kernel pages
out the process header, page tables, process kernel stack ...

At this point the process is in the equivalent state as that of the system
that only does "swapping".

The swap space is used when more physical memory is required than is available
for user data. The modified pages of user data are written to the swap space
and the physical page re-used for another purpose. Effectively "swapping" the
use of the page... :-)

> > > Provided the VM is doing its job properly, adding swap will always be a
> > > net win for efficiency: the kernel is able to dump unused pages to make
> > > more room for others. Of course, you tend to "feel" the response times to
> > > interactive events, rather than the overall throughput, so a change which
> > > slows the system down but makes it more "responsive" to mouse clicks etc
> > > feels like a net win...
> >
> > With any properly sized system, it will NEVER SWAP. Paging is a completely
> > different thing. A little paging is not a problem. Up to 70 pagescans/s on
> > occasion is quite acceptable. If paging activety grows above that, you may
> > have a real problem. I don't know about the current VM, but with most
> > unixes when you hit this mark, the system actually starts swapping, and
> > your responsiveness goes down the drain....
> 
> By your definition, Linux does not swap, ever. It only "pages". This is what 
> I was referring to as swapping, since this involves the SWAPspace/partition, 
> rather than PAGEfile :)

The problem is determining "properly sized system". Second - ALL linux systems
will page in (or swap in) executables, if only at the start of executution
(easiest/fasted way to load the program... mmap is quick, even if it does
blur the distinction between process pages and I/O cache)

Linux uses RAM+SWAP for virtual memory operation, and swaps pages used for
data to the "swap space" to use different "swapped pages" to load back into
physical memory. Since this is effectively hidden from most activity (and
measures), it becomes easy to oversubscribe memory, causing thrashing (lots
of page activity for little gain), where a system with mixed paging + swapping
(page out entire processes and disable scheduling them) CAN make significant
progress.

The other use of RAM is for data caching. Usually is faster to keep file data
loaded into RAM for use by programs. Runtime libraries are frequently where
the majority of CPU time is spent - Instead of waiting for data to be
transferred to RAM for use, Linux tries to "read ahead" accomplishing more
throughput that way by not forcing the active process to wait for the data.

The tricky part is determining the balance between the data cache, and process
memory.

The systems that use a combined pageing + swapping use a variety of measures
to decide what should be paged or swapped. Some characteristics used by these
systems are:

 1. number of page faults/sec (swap if > watermark - reduces thrashing)
 2. time elapsed since last completed I/O (if greater than some watermark, swap
	- makes more RAM available)
 3. idle processes (wait time > watermark, swap - discard executable pages,
	swap out data pages)
 4. batch processes (operate at a lower priority - swap non-interactive
	processes - makes more RAM available)
 5. High memory requirements (reduce resident set size; which invokes item 1)
 6. Users priority (swap lower priority processes - make more RAM available)

Of course the sys admin must have control over all of the watermarks and/or
resource allocations. These are more characteristics of a general computation
or batch system than they are of a single user workstation, which is where
Linux started.

Hope I've help clear up some things.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
