Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSEMLSx>; Mon, 13 May 2002 07:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSEMLSw>; Mon, 13 May 2002 07:18:52 -0400
Received: from [195.223.140.120] ([195.223.140.120]:7264 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312169AbSEMLSu>; Mon, 13 May 2002 07:18:50 -0400
Date: Mon, 13 May 2002 13:19:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE  56)
Message-ID: <20020513131940.P13730@dualathlon.random>
In-Reply-To: <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 01:23:11PM +1000, Lincoln Dale wrote:
> At 02:36 PM 10/05/2002 +0200, Andrea Arcangeli wrote:
> >> being fair to O_DIRECT and giving it 1mbyte disk-reads to work with and
> >> giving normal i/o 8kbyte reads to work with.
> ..
> >is any of the disks mounted?
> 
> no.
> for the O_DIRECT tests i also didn't have the MD driver touching 
> them.  (ie. raidstop /dev/md[0-1]).
> 
> >> O_DIRECT is still a ~30% performance hit versus just talking to the
> >> /dev/sdX device directly.  profile traces at bottom.
> >>
> >> normal block-device disks sd[m-r] without O_DIRECT, 64K x 8k reads:
> >>         [root@mel-stglab-host1 src]# readprofile -r;
> >> ./test_disk_performance blocks=64K bs=8k /dev/sd[m-r]
> >>         Completed reading 12000 mbytes in 125.028612 seconds (95.98
> >> Mbytes/sec), 76usec mean
> >
> >can you post your test_disk_performance program
> 
> i'll post the program later on this weekend.  (its suffering from continual 
> scope-creap and additional development. :) ).
> 
> but basically, its similar to 'dd' except works on multiple devices 
> simultaneously.
> operation consists of sequential-reads or sequential-writes.
> 
> its main loop basically consists entirely of:
>         /* loop thru blocks */
>         for (blocknum=0; blocknum < blocks; blocknum++) {
>                 /* loop thru devices */
>                 for (devicenum=0; devicenum < num_devices; devicenum++) {
>                         before_time = time_tick();
>                         if (operation == 0) {
>                                 /* read op */
>                                 amt_read = read(fd[devicenum], 
> aligned_buffer[devicenum], block_size);
>                         } else {
>                                 /* write-op */
>                                 amt_read = write(fd[devicenum], 
> aligned_buffer[devicenum], block_size);
>                         }
>                         after_time = time_tick();
> 
>                         [check amt_read == block_size, calculate time 
> histograms]
>                 }
>         }
> 
> the open call consists of:
>         for (i=0; i < num_devices; i++) {
>                 flags = (O_RDWR | O_LARGEFILE);
>                 if (nocopy) flags |= O_NOCOPY;
>                 if (direct) flags |= O_DIRECT;
>                 fd[i] = open(devices[i], flags);
>         ...
> 
> i've since 'expanded' its functionality a bit so that i can do tests where 
> i'm rate-limiting different devices to different limits, variable 
> read/write/seeks, etc etc.
> 
> >so I in particular we
> >can see the semantics of blocks and bs? 64k*8k == 5k * 1M / 10.
> 
> K == 1000
> k == 1024
> M == 1000*1000
> m == 1024*1024
> g == 1024*1024*1024
> G == 1000*1000*1000
> 
> so the above is:
>   blocks = 64K, bs=8k means 64000 x 8192-byte read()s = 524288000 bytes
>   blocks = 5K, bs=1m means 5000 x 1048576-byte read()s = 5242880000 bytes

if the program is doing only what shown in the main loop, then you're
reading 10 times more data with O_DIRECT, that was my point in saying
64k*8k == 5k * 1M / 10, but I assume you took it into account (otherwise
it means O_DIRECT is just 5 times faster than buffered-I/O for you)

Also I would suggest to measure the time taken by the whole workload, not only
the time for read/write syscalls.

> 
> >O_DIRECT has to do some more work to check for the coherency with the
> >pagecache and it has some more overhead with the address space
> >operations, but O_DIRECT by default uses the blocksize of the blkdev,
> >that is set to 1k by default (if you never mounted it) versus the
> >hardblocksize of 512bytes used by the raw device (assuming the sd[m-r]
> >aren't mounted).
> 
> i wonder if the MD driver set it to 512 bytes if it has been touched.

it is set to 512 bytes.

> i'll reboot the box after each test to validate.  (which, unfortunately, is 
> about a 10 minute reboot cycle for 22 x SCSI disks and 16 FC disks).
> 
> >This is most probably why O_DIRECT is faster than raw.c, otherwise they
> >would run almost at the same rate, the pagecache coherency fast paths
> >and the address space ops overhead of O_DIRECT shouldn't be noticeable.
> 
> as the statistics show, O_DIRECT is about 5% superior to raw.c.

yep, as said that's because O_DIRECT uses the softblocksize (1k) large
b_size, while raw uses the hardblocksize that is 512bytes, so raw wastes 2
times more memory and cpu in handling those list of smaller bh. That is fair
comparison with the buffered-IO, also the buffered-IO uses 1k b_size.

> 
> >> of course, these are all ~25% worse than if a mechanism of performing the
> >> i/o avoiding the copy_to_user() altogether:
> >>         [root@mel-stglab-host1 src]# readprofile -r;
> >> ./test_disk_performance blocks=64K bs=8k nocopy /dev/sd[m-r]
> >>         Completed reading 12000 mbytes in 97.846938 seconds (122.64
> >> Mbytes/sec), 59usec mean
> >
> >the nocopy hack is not an interesting test for O_DIRECT/rawio, it
> >doesn't walk pagetables, it doesn't allow the DMA to be done into
> >userspace memory. If you want the pagecache to be visible into userspace
> >(i.e. MAP_PRIVATE/MAP_SHARED) you must deal with pagetables somehow,
> >and if you want the read/write syscalls to DMA directly into userspace
> >memory (raw/O_DIRECT) you must still walk pagetables during those
> 
> the nocopy hack is interesting from the point-of-view of seeing what the 
> copy_to_user() overhead actually is.
> it is interesting to compare that to O_DIRECT.
> 
> i agree that doing pagecache-visible-in-userspace is hard to get right and 
> to do it fast.
> but i'm not proposing any such development.

Yes, I only wanted to make clear the no-copy hack will always be faster
then anything that ends putting the data in user memory (or providing
information where the data in userspace is) somehow.

> what i am thinking is "interesting" is for privileged programs which can 
> mmap() /dev/mem and have some async-i/o scheme which returns back 
> physical-address information about blocks.

You'd at least need to reserve only a contigous part of the physical
pages for that purposes, or you would run out of virtual address space on a
32bit arch, that just is a problem with fragmentation.  Secondly you should use
such mmapped /dev/mem area as your backing store for the application cache or
it's again a copy-user.  It seems very messy. I think writing a software TLB
for a certain special VMA allowing the resolution of a virtual address in the
VMA to a struct page with a very efficient lookup would be better if something
to skip the overhead of the pagetable management. And it doesn't need special
userspace hacks with horrible API.

> sure, it has a lot of potential-security-issues associated with it, and 
> isn't useful for anything but really big-iron program, but so has other 
> schemes that involve "lets put this userspace module in the kernel to avoid 
> user<->kernel copies".
> 
> >syscalls before starting the DMA. If you don't want to explicitly deal
> >with the pagetables then you need to copy_user (case 1). In most archs
> >where mem bandwith is very expensive avoiding the copy-user is a big
> >global win (other cpus won't collapse in smp etc..).
> >
> >Your nocopy hack benchmark has some relevance only for usages of the
> >data done by kernel. So if it is the kernel that reads the data directly
> >from pagecache (i.e.  a kernel module), then your nocopy benchmark
> >matters. For example your nocopy benchmark also matters for sendfile
> >zerocopy, it will read at 122M/sec. But if it's userspace supposed to
> >receive the data (so not directly from pagecache on the kernel direct
> >mapping, but in userspace mapped memory) it cannot be 122M/sec, it has
> >to be less due the user address space management.
> 
> i guess i simply see that there are a bunch of possible big-iron programs 
> which:
>  - read from [raw] disk
>  - write results to network
>  - don't actually look at the payload
> 
> a few program like this that come to mind are:
>  - Samba
>  - (user-space) NFS
>  - [HTTP] caching software
> 
> >> comparative profile=2 traces:
> ...
> >Can you use -k4? this is the number of hits per function, but we should
> >take the size of the function into account too. Otherwise small
> >functions won't show up.
> 
> will do.
> 
> >Can you also give a spin to the same benchmark with 2.4.19pre8aa2? It
> >has the vary-io stuff from Badari and futher kiobuf optimization from
> >Chuck.
> 
> will do so.
> 
> >(vary-io will work only with aic and qlogic, enabling it is a one
> >liner if the driver is just ok with variable bh->b_size in the same I/O
> >request). right fix for avoiding the flood of small bh is bio in 2.5,
> >for 2.4 vary-io should be fine.
> 
> i'm using the qlogic HBA driver from their web-site rather than the current 
> driver in the kernel which doesn't function with the 2gbit/s HBAs.
> care to point out the line i should be looking for to change?

Sure just search the .h file for something like this:

#define QLOGICISP {							   \
	detect:			isp1020_detect,				   \
	release:		isp1020_release,			   \
	info:			isp1020_info,				   \
	queuecommand:		isp1020_queuecommand,			   \
	abort:			isp1020_abort,				   \
	reset:			isp1020_reset,				   \
	bios_param:		isp1020_biosparam,			   \
	can_queue:		QLOGICISP_REQ_QUEUE_LEN,		   \
	this_id:		-1,					   \
	sg_tablesize:		QLOGICISP_MAX_SG(QLOGICISP_REQ_QUEUE_LEN), \
	cmd_per_lun:		1,					   \
	present:		0,					   \
	unchecked_isa_dma:	0,					   \
	use_clustering:		DISABLE_CLUSTERING,			   \
	can_do_varyio:		1,					   \
}

and add can_do_varyio: 1 like in the above file for qlogicisp.h.

(btw, then the vary-io will allow more efficient I/O handling than the
buffered-IO, so it would get unfair with the so underpowered buffered-IO,
but still it would be interesting to see the effect of varyio in numbers)

You also mentioned the md device. If you do I/O to a raid0 array with 5 disks
attached to an MD device then your buffersize with O_DIRECT must be 5*512k at
least or you cannot send bit large scsi commands to each scsi disk and
performance would be very bad compared to reading 1M from each /dev/sd
separately.

One thing I would also recommend is to write a threaded version of the program,
that reads or writes to all the /dev/sd disks simultaneously, first w/ O_DIRECT
then w/o O_DIRECT. The reason is that currently you aren't using all the disks
at once with O_DIRECT due the lack of async-io, while for example
async-writeback w/o O_DIRECT allows a better scaling over the disks, not to
tell the fact you only benchmark the duration of the syscall sounds not
accurate if async I/O happens over userspace (userspace can get stalled by
completion interrupts etc.. and you're not measuring such overhead).

If you instead make a single raid0 array and you use a buffer size of nr_PV*512k
(or nr_PV*1M even better) then also O_DIRECT without threading should perform
similar to the buffered IO.

In my measurements the lack of async-io with O_DIRECT (with a single disk)
wasn't significant in the bandwith numbers, let's say a few percent slower than
the buffered-IO, but the CPU utilization and mem bandwith was so much optimized
that I thought it definitely pays off even now without a kernel side async-io
(note that I wasn't doing simultaneous I/O to multiple devices, futhmore the
bandwith of the membus was not shared with any other workload).

Since you "stripe" by hand in all disks you do a different workload than my
previous benchs and you definitely want to keep all the harddisk running at the
same time. I would also suggest to benchmark a single disk, to see if there is
still such a big performance difference (again: including the cost outside the
syscalls too).

Thanks for the interesting big-iron number-feedback :)

Andrea
