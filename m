Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317270AbSFCEy6>; Mon, 3 Jun 2002 00:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317271AbSFCEy5>; Mon, 3 Jun 2002 00:54:57 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:191 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S317270AbSFCEyz>; Mon, 3 Jun 2002 00:54:55 -0400
Message-Id: <5.1.0.14.2.20020603141650.01acc8c0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Jun 2002 14:53:26 +1000
To: Andrea Arcangeli <andrea@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: high-end i/o performance of 2.4.19pre8aa2 (was: Re: O_DIRECT
  on 2.4.19pre8aa2 device)
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020522025159.GA21164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

g'day Andrea,

At 04:51 AM 22/05/2002 +0200, Andrea Arcangeli wrote:
>Infact a nice addition to your proggy would be to also benchmark the I/O
>bandwith using mmap driven I/O, instead of buffered I/O, raw, O_DIRECT
>and the nocopy hack. Like raw and O_DIRECT also the mmap driven I/O is
>zerocopy I/O, so only the buffered-IO would show the total waste of cpu
..

i've had some spare time to enhance my benchmark program.  it is now 
multithreaded and can do mmap() i/o also.

interestingly enough, it shows that mmap() actually sucks.  i didn't take a 
"readprofile" to see why, but it used far more cpu time than anything else.

with the same hardware as before (Dual P3 Xeon 733MHz, 133MHz FSB, 2G PC133 
SDRAM, QLogic 2300 HBA in 64/66 PCI slot) and same kernel (linux 2.4.19pre8 
with vary-io, lockmeter & profile=2), the aggregate throughput across 8 x 
15K RPM FC disks (2gbit/s FC switched network) are:

now that i've multithreaded the test app.  the results change somewhat 
given we now have multiple threads issuing i/o operations:
raw i/o is slightly better than O_DIRECT again.  mmap()'ed i/o is the worst.

[summary]
  'base'         Completed reading 81920 mbytes in 524.289107 seconds 
(156.25 Mbytes/sec), 386usec mean/block
  'nocopy'       Completed reading 81920 mbytes in 435.653909 seconds 
(188.04 Mbytes/sec), 302usec mean/block
  'o_direct'     Completed reading 81920 mbytes in 429.757513 seconds 
(190.62 Mbytes/sec), 157655usec mean/block
  'raw'          Completed reading 81920 mbytes in 420.940382 seconds 
(194.61 Mbytes/sec), 164368usec mean/block
  'mmap' Completed reading 81920 mbytes in 1049.446053 seconds (78.06 
Mbytes/sec), 401124usec mean/block


given i'm not hitting the peak performance of a single 2gbit/s fibre 
channel connection, i'll now migrate to dual FC HBAs and see what happens 
... :-)


[detail]

(1)
# performance of a single disk-spindle using normal linux block i/o 
layer.  use 10G worth of 8kbyte blocks.
# this will show the peak performance of a single 15K RPM disk without any 
bus contention.
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=8k blocks=1280k 
mode=basic /dev/sde
Completed reading 10240 mbytes across 1 devices using 1310720 blocks of 
8192 in 190.028450 seconds (53.89 Mbytes/sec), 151usec mean

(2)
# performance of multiple disk-spindles (8 disks, sde-sdl) using normal 
linux block i/o layer.
# read 10G sequentially from each disk using 8kbyte blocks parallel across 
all disks.
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=8k blocks=1280k 
mode=basic /dev/sd[e-l]
Completed reading 81920 mbytes across 8 devices using 10485760 blocks of 
8192 in 524.289107 seconds (156.25 Mbytes/sec), 386usec mean
   device #0 (/dev/sde) 10240 megabytes in 520.588206 seconds using 1310720 
reads of 8192 bytes (19.67 Mbytes/sec), 320usec
   device #1 (/dev/sdf) 10240 megabytes in 509.305642 seconds using 1310720 
reads of 8192 bytes (20.11 Mbytes/sec), 352usec
   device #2 (/dev/sdg) 10240 megabytes in 516.744421 seconds using 1310720 
reads of 8192 bytes (19.82 Mbytes/sec), 351usec
   device #3 (/dev/sdh) 10240 megabytes in 519.215781 seconds using 1310720 
reads of 8192 bytes (19.72 Mbytes/sec), 382usec
   device #4 (/dev/sdi) 10240 megabytes in 517.312922 seconds using 1310720 
reads of 8192 bytes (19.79 Mbytes/sec), 339usec
   device #5 (/dev/sdj) 10240 megabytes in 524.289183 seconds using 1310720 
reads of 8192 bytes (19.53 Mbytes/sec), 315usec
   device #6 (/dev/sdk) 10240 megabytes in 521.006994 seconds using 1310720 
reads of 8192 bytes (19.65 Mbytes/sec), 322usec
   device #7 (/dev/sdl) 10240 megabytes in 518.434472 seconds using 1310720 
reads of 8192 bytes (19.75 Mbytes/sec), 345usec

(3)
# same test as above, but using 'nocopy hack' so PC architecture isn't the 
bottleneck.
# look at 8 disks (sde-sdl) using 8kbyte/block, 10G on each disk: (80G 
total) in parallel.
# using 'nocopy' means we can measure peak performance without PC 
front-side-bus becoming
# the bottleneck, but we're still using the normal read-file case.
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=8k blocks=1280k 
mode=nocopy /dev/sd[e-l]
Completed reading 81920 mbytes across 8 devices using 10485760 blocks of 
8192 in 435.653909 seconds (188.04 Mbytes/sec), 302usec mean
   device #0 (/dev/sde) 10240 megabytes in 408.566056 seconds using 1310720 
reads of 8192 bytes (25.06 Mbytes/sec), 305usec
   device #1 (/dev/sdf) 10240 megabytes in 411.353237 seconds using 1310720 
reads of 8192 bytes (24.89 Mbytes/sec), 309usec
   device #2 (/dev/sdg) 10240 megabytes in 414.244129 seconds using 1310720 
reads of 8192 bytes (24.72 Mbytes/sec), 295usec
   device #3 (/dev/sdh) 10240 megabytes in 416.225989 seconds using 1310720 
reads of 8192 bytes (24.60 Mbytes/sec), 293usec
   device #4 (/dev/sdi) 10240 megabytes in 417.593914 seconds using 1310720 
reads of 8192 bytes (24.52 Mbytes/sec), 268usec
   device #5 (/dev/sdj) 10240 megabytes in 422.646633 seconds using 1310720 
reads of 8192 bytes (24.23 Mbytes/sec), 259usec
   device #6 (/dev/sdk) 10240 megabytes in 431.343133 seconds using 1310720 
reads of 8192 bytes (23.74 Mbytes/sec), 209usec
   device #7 (/dev/sdl) 10240 megabytes in 435.654122 seconds using 1310720 
reads of 8192 bytes (23.50 Mbytes/sec), 216usec

(4)
# use O_DIRECT to bypass readahead and most of block-layer memory-copies
# since there isn't any readahead anymore, use a large buffer to achieve 
peak performance
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=4m blocks=2560 
mode=direct /dev/sd[e-l]
Completed reading 81920 mbytes across 8 devices using 20480 blocks of 
4194304 in 429.757513 seconds (190.62 Mbytes/sec), 157655usec mean
   device #0 (/dev/sde) 10240 megabytes in 412.931460 seconds using 2560 
reads of 4194304 bytes (24.80 Mbytes/sec), 160898usec
   device #1 (/dev/sdf) 10240 megabytes in 414.531502 seconds using 2560 
reads of 4194304 bytes (24.70 Mbytes/sec), 159234usec
   device #2 (/dev/sdg) 10240 megabytes in 414.585683 seconds using 2560 
reads of 4194304 bytes (24.70 Mbytes/sec), 158187usec
   device #3 (/dev/sdh) 10240 megabytes in 415.257838 seconds using 2560 
reads of 4194304 bytes (24.66 Mbytes/sec), 154983usec
   device #4 (/dev/sdi) 10240 megabytes in 416.209758 seconds using 2560 
reads of 4194304 bytes (24.60 Mbytes/sec), 138563usec
   device #5 (/dev/sdj) 10240 megabytes in 419.144473 seconds using 2560 
reads of 4194304 bytes (24.43 Mbytes/sec), 133593usec
   device #6 (/dev/sdk) 10240 megabytes in 424.031534 seconds using 2560 
reads of 4194304 bytes (24.15 Mbytes/sec), 102836usec
   device #7 (/dev/sdl) 10240 megabytes in 429.773878 seconds using 2560 
reads of 4194304 bytes (23.83 Mbytes/sec), 98300usec

(5)
# same as (4) but using /dev/raw/rawX instead of O_DIRECT
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=4m blocks=2560 
mode=basic /dev/raw/raw[1-8]
Completed reading 81920 mbytes across 8 devices using 20480 blocks of 
4194304 in 420.940382 seconds (194.61 Mbytes/sec), 164368usec mean
   device #0 (raw1) 10240 megabytes in 420.869676 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164385usec
   device #1 (raw2) 10240 megabytes in 420.859291 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164386usec
   device #2 (raw3) 10240 megabytes in 420.834023 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164385usec
   device #3 (raw4) 10240 megabytes in 420.896964 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 163879usec
   device #4 (raw5) 10240 megabytes in 420.838551 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164385usec
   device #5 (raw6) 10240 megabytes in 420.867115 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164060usec
   device #6 (raw7) 10240 megabytes in 420.906691 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164386usec
   device #7 (raw8) 10240 megabytes in 420.932318 seconds using 2560 reads 
of 4194304 bytes (24.33 Mbytes/sec), 164357usec

(6)
# use memory-mapped i/o, more for interests-sake looking at the efficiency 
of the virtual-mapping of the linux kernel.
# use a large blocksize as it was shown that a 8kbyte blocksize is about 
40% of the performance with a 4m blocksize
[root@mel-stglab-host1 root]#  ./test_disk_performance2 bs=4m blocks=2560 
mode=mmap /dev/sd[e-l]
Completed reading 81920 mbytes across 8 devices using 20480 blocks of 
4194304 in 1049.446053 seconds (78.06 Mbytes/sec), 401124usec mean
   device #0 (/dev/sde) 10240 megabytes in 1045.814369 seconds using 2560 
reads of 4194304 bytes (9.79 Mbytes/sec), 342912usec
   device #1 (/dev/sdf) 10240 megabytes in 1034.783187 seconds using 2560 
reads of 4194304 bytes (9.90 Mbytes/sec), 430320usec
   device #2 (/dev/sdg) 10240 megabytes in 1046.222514 seconds using 2560 
reads of 4194304 bytes (9.79 Mbytes/sec), 340732usec
   device #3 (/dev/sdh) 10240 megabytes in 1049.445858 seconds using 2560 
reads of 4194304 bytes (9.76 Mbytes/sec), 353895usec
   device #4 (/dev/sdi) 10240 megabytes in 1047.926118 seconds using 2560 
reads of 4194304 bytes (9.77 Mbytes/sec), 362176usec
   device #5 (/dev/sdj) 10240 megabytes in 1047.454030 seconds using 2560 
reads of 4194304 bytes (9.78 Mbytes/sec), 377308usec
   device #6 (/dev/sdk) 10240 megabytes in 1043.274980 seconds using 2560 
reads of 4194304 bytes (9.82 Mbytes/sec), 387720usec
   device #7 (/dev/sdl) 10240 megabytes in 1048.326277 seconds using 2560 
reads of 4194304 bytes (9.77 Mbytes/sec), 347532usec

>175MB/sec means you only read to kernel space and you don't make such
>information visible to userspace, so it is unbeatable no matter what :).
>Only in kernel service like sendfile and/or tux can take advantage of it by
>taking the radix tree lock and looking up the radix tree to find the
>physical page.
>
> > if we _could_ produce superior performance with something like:
> >  (a) additional improvements to O_DIRECT (say, a mmap() hack for O_DIRECT)
> >      whereby i/o can go direct-to-userspace or
> > userspace-can-mmap(readonly)-into-
> >      kernel-space
>
>even if you get a direct physical view of some of the address space (as
>said in a earlier email on 32bit the lack of address space would reduce
>the place you can map to a little zone), you still need the information
>on the physical memory where the I/O gone, so that's still an API from
>kernel to user, so again an overhead compared to the nocopy hack

[ ignoring the fact that O_DIRECT and /dev/rawN are faster than 'nocopy' 
for a moment ...  :-) ]

around 18 months ago, i had it working.

basically, there was a character device-driver which allowed user-space to 
mmap() kernel space.
a seperate 'zone' existed that was reserved exclusively for data to/from 
disk and network.
this zone was sized to 75% of RAM -- and (on the hardware being used) with 
2G RAM, meant that there was 1.5GB available in this space.

the kernel would indicate the physical address of a "skb" on network 
sockets and each packet put on the skbuff receive_q for a socket marked for 
'zerocopy' would result in a zerocopy_buf_t being queued to user-space.
user-space could poll to get a list of the current zerocopy_buf_t's.  (this 
list wasn't copied to userspace using copy_to_user; user-space picked this 
list up via the mmap() into kernel space too)

userspace could control what to do with buffers by various ioctl() calls on 
the character-device.  things like marking "i'm not interested in that 
buffer anymore" would result in atomic_dec_and_test() on the refcount and a 
subsequent skb_free() if there wasn't any more interest in the 
buffer.  there were also ioctl()s for queueing the buffer on a different 
socket.

yes -- rather radical -- but it did bypass the bottleneck of 
memory-bandwidth becoming the bottleneck in an application which 
predominantly did:
  - read-from-disk, send on network socket
  - read from network socket, write to disk
  - read from network socket, write to alternate network socket, write to disk

given user-space could crash at any point, there was some housekeeping that 
ensured that buffers tied to a process that had failed didn't stay around - 
they were cleaned up.

there was also some rudimentary checks to ensure that user-space passing 
buffer pointers to kernel-space was passing buffers that kernel-space 
already knew about.  ie. you couldn't crash the kernel by passing a bad 
pointer.


i haven't resurrected this work since the VM underwent some radical changes 
-- but it wouldn't be too hard to do.  it'd still be a bit ugly in the 
tie-ins to the tcp stack and buffer-cache but ....


i guess given O_DIRECT and /dev/rawN performance for to-disk/from-disk 
being what it currently is (very good), there's less importance on having 
it, if we could find a 'fast' way to queue to/from disk from/to network.
perhaps Ben's async i/o is the way to go for those apps.

>Long email sorry.

i was travelling and it gave me a chance to test out the 8 hour battery 
life in my new laptop on a 14 hour flight. :-)


cheers,

lincoln.

