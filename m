Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSEKDWU>; Fri, 10 May 2002 23:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316205AbSEKDWT>; Fri, 10 May 2002 23:22:19 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:16844 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S316204AbSEKDWS>; Fri, 10 May 2002 23:22:18 -0400
Message-Id: <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 11 May 2002 13:23:11 +1000
To: Andrea Arcangeli <andrea@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH]
  2.5.14IDE  56)
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020510143616.C13730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:36 PM 10/05/2002 +0200, Andrea Arcangeli wrote:
> > being fair to O_DIRECT and giving it 1mbyte disk-reads to work with and
> > giving normal i/o 8kbyte reads to work with.
..
>is any of the disks mounted?

no.
for the O_DIRECT tests i also didn't have the MD driver touching 
them.  (ie. raidstop /dev/md[0-1]).

> > O_DIRECT is still a ~30% performance hit versus just talking to the
> > /dev/sdX device directly.  profile traces at bottom.
> >
> > normal block-device disks sd[m-r] without O_DIRECT, 64K x 8k reads:
> >         [root@mel-stglab-host1 src]# readprofile -r;
> > ./test_disk_performance blocks=64K bs=8k /dev/sd[m-r]
> >         Completed reading 12000 mbytes in 125.028612 seconds (95.98
> > Mbytes/sec), 76usec mean
>
>can you post your test_disk_performance program

i'll post the program later on this weekend.  (its suffering from continual 
scope-creap and additional development. :) ).

but basically, its similar to 'dd' except works on multiple devices 
simultaneously.
operation consists of sequential-reads or sequential-writes.

its main loop basically consists entirely of:
         /* loop thru blocks */
         for (blocknum=0; blocknum < blocks; blocknum++) {
                 /* loop thru devices */
                 for (devicenum=0; devicenum < num_devices; devicenum++) {
                         before_time = time_tick();
                         if (operation == 0) {
                                 /* read op */
                                 amt_read = read(fd[devicenum], 
aligned_buffer[devicenum], block_size);
                         } else {
                                 /* write-op */
                                 amt_read = write(fd[devicenum], 
aligned_buffer[devicenum], block_size);
                         }
                         after_time = time_tick();

                         [check amt_read == block_size, calculate time 
histograms]
                 }
         }

the open call consists of:
         for (i=0; i < num_devices; i++) {
                 flags = (O_RDWR | O_LARGEFILE);
                 if (nocopy) flags |= O_NOCOPY;
                 if (direct) flags |= O_DIRECT;
                 fd[i] = open(devices[i], flags);
         ...

i've since 'expanded' its functionality a bit so that i can do tests where 
i'm rate-limiting different devices to different limits, variable 
read/write/seeks, etc etc.

>so I in particular we
>can see the semantics of blocks and bs? 64k*8k == 5k * 1M / 10.

K == 1000
k == 1024
M == 1000*1000
m == 1024*1024
g == 1024*1024*1024
G == 1000*1000*1000

so the above is:
   blocks = 64K, bs=8k means 64000 x 8192-byte read()s = 524288000 bytes
   blocks = 5K, bs=1m means 5000 x 1048576-byte read()s = 5242880000 bytes

>O_DIRECT has to do some more work to check for the coherency with the
>pagecache and it has some more overhead with the address space
>operations, but O_DIRECT by default uses the blocksize of the blkdev,
>that is set to 1k by default (if you never mounted it) versus the
>hardblocksize of 512bytes used by the raw device (assuming the sd[m-r]
>aren't mounted).

i wonder if the MD driver set it to 512 bytes if it has been touched.
i'll reboot the box after each test to validate.  (which, unfortunately, is 
about a 10 minute reboot cycle for 22 x SCSI disks and 16 FC disks).

>This is most probably why O_DIRECT is faster than raw.c, otherwise they
>would run almost at the same rate, the pagecache coherency fast paths
>and the address space ops overhead of O_DIRECT shouldn't be noticeable.

as the statistics show, O_DIRECT is about 5% superior to raw.c.

> > of course, these are all ~25% worse than if a mechanism of performing the
> > i/o avoiding the copy_to_user() altogether:
> >         [root@mel-stglab-host1 src]# readprofile -r;
> > ./test_disk_performance blocks=64K bs=8k nocopy /dev/sd[m-r]
> >         Completed reading 12000 mbytes in 97.846938 seconds (122.64
> > Mbytes/sec), 59usec mean
>
>the nocopy hack is not an interesting test for O_DIRECT/rawio, it
>doesn't walk pagetables, it doesn't allow the DMA to be done into
>userspace memory. If you want the pagecache to be visible into userspace
>(i.e. MAP_PRIVATE/MAP_SHARED) you must deal with pagetables somehow,
>and if you want the read/write syscalls to DMA directly into userspace
>memory (raw/O_DIRECT) you must still walk pagetables during those

the nocopy hack is interesting from the point-of-view of seeing what the 
copy_to_user() overhead actually is.
it is interesting to compare that to O_DIRECT.

i agree that doing pagecache-visible-in-userspace is hard to get right and 
to do it fast.
but i'm not proposing any such development.

what i am thinking is "interesting" is for privileged programs which can 
mmap() /dev/mem and have some async-i/o scheme which returns back 
physical-address information about blocks.
sure, it has a lot of potential-security-issues associated with it, and 
isn't useful for anything but really big-iron program, but so has other 
schemes that involve "lets put this userspace module in the kernel to avoid 
user<->kernel copies".

>syscalls before starting the DMA. If you don't want to explicitly deal
>with the pagetables then you need to copy_user (case 1). In most archs
>where mem bandwith is very expensive avoiding the copy-user is a big
>global win (other cpus won't collapse in smp etc..).
>
>Your nocopy hack benchmark has some relevance only for usages of the
>data done by kernel. So if it is the kernel that reads the data directly
>from pagecache (i.e.  a kernel module), then your nocopy benchmark
>matters. For example your nocopy benchmark also matters for sendfile
>zerocopy, it will read at 122M/sec. But if it's userspace supposed to
>receive the data (so not directly from pagecache on the kernel direct
>mapping, but in userspace mapped memory) it cannot be 122M/sec, it has
>to be less due the user address space management.

i guess i simply see that there are a bunch of possible big-iron programs 
which:
  - read from [raw] disk
  - write results to network
  - don't actually look at the payload

a few program like this that come to mind are:
  - Samba
  - (user-space) NFS
  - [HTTP] caching software

> > comparative profile=2 traces:
...
>Can you use -k4? this is the number of hits per function, but we should
>take the size of the function into account too. Otherwise small
>functions won't show up.

will do.

>Can you also give a spin to the same benchmark with 2.4.19pre8aa2? It
>has the vary-io stuff from Badari and futher kiobuf optimization from
>Chuck.

will do so.

>(vary-io will work only with aic and qlogic, enabling it is a one
>liner if the driver is just ok with variable bh->b_size in the same I/O
>request). right fix for avoiding the flood of small bh is bio in 2.5,
>for 2.4 vary-io should be fine.

i'm using the qlogic HBA driver from their web-site rather than the current 
driver in the kernel which doesn't function with the 2gbit/s HBAs.
care to point out the line i should be looking for to change?


cheers,

lincoln.

