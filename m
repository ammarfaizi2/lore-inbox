Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315738AbSEJMfa>; Fri, 10 May 2002 08:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315796AbSEJMf3>; Fri, 10 May 2002 08:35:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35888 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315738AbSEJMf1>; Fri, 10 May 2002 08:35:27 -0400
Date: Fri, 10 May 2002 14:36:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE  56)
Message-ID: <20020510143616.C13730@dualathlon.random>
In-Reply-To: <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 08:14:10PM +1000, Lincoln Dale wrote:
> At 12:15 AM 10/05/2002 -0700, Andrew Morton wrote:
> >Try it with the block-highmem patch:
> >
> >http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/00_block-highmem-all-18b-4.gz
> 
> given i had to recompile the kernel to add lockmeter, i'd already cheated 
> and changed PAGE_OFFSET from 0xc0000000 to 0x80000000, obviating the 
> requirement for highmem altogether.
> 
> being fair to O_DIRECT and giving it 1mbyte disk-reads to work with and 
> giving normal i/o 8kbyte reads to work with.
> still using 2.4.18 with profile=2 enabled and lockmeter in the kernel but 
> not turned on.  still using the same disk spindles (just 6 this time), each 
> a 18G 15K RPM disk spindle.
> i got tired of scanning the entire available space on an 18G disk so just 
> dropped the test down to the first 2G of each disk.

is any of the disks mounted?

> 
> O_DIRECT is still a ~30% performance hit versus just talking to the 
> /dev/sdX device directly.  profile traces at bottom.
> 
> normal block-device disks sd[m-r] without O_DIRECT, 64K x 8k reads:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance blocks=64K bs=8k /dev/sd[m-r]
>         Completed reading 12000 mbytes in 125.028612 seconds (95.98 
> Mbytes/sec), 76usec mean

can you post your test_disk_performance program so I in particular we
can see the semantics of blocks and bs? 64k*8k == 5k * 1M / 10.

> 
> normal block-device disks sd[m-r] with O_DIRECT, 5K x 1 megabyte reads:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance blocks=5K bs=1m direct /dev/sd[m-r]
>         Completed reading 12000 mbytes in 182.492975 seconds (65.76 
> Mbytes/sec), 15416usec mean
> 
> for interests-sake, compare this to using the 'raw' versions of the same 
> disks:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance blocks=5K bs=1m /dev/raw/raw[2-7]
>         Completed reading 12000 mbytes in 206.346371 seconds (58.15 
> Mbytes/sec), 16860usec mean

O_DIRECT has to do some more work to check for the coherency with the
pagecache and it has some more overhead with the address space
operations, but O_DIRECT by default uses the blocksize of the blkdev,
that is set to 1k by default (if you never mounted it) versus the
hardblocksize of 512bytes used by the raw device (assuming the sd[m-r]
aren't mounted).

This is most probably why O_DIRECT is faster than raw.c, otherwise they
would run almost at the same rate, the pagecache coherency fast paths
and the address space ops overhead of O_DIRECT shouldn't be noticeable.

> 
> of course, these are all ~25% worse than if a mechanism of performing the 
> i/o avoiding the copy_to_user() altogether:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance blocks=64K bs=8k nocopy /dev/sd[m-r]
>         Completed reading 12000 mbytes in 97.846938 seconds (122.64 
> Mbytes/sec), 59usec mean

the nocopy hack is not an interesting test for O_DIRECT/rawio, it
doesn't walk pagetables, it doesn't allow the DMA to be done into
userspace memory. If you want the pagecache to be visible into userspace
(i.e. MAP_PRIVATE/MAP_SHARED) you must deal with pagetables somehow,
and if you want the read/write syscalls to DMA directly into userspace
memory (raw/O_DIRECT) you must still walk pagetables during those
syscalls before starting the DMA. If you don't want to explicitly deal
with the pagetables then you need to copy_user (case 1). In most archs
where mem bandwith is very expensive avoiding the copy-user is a big
global win (other cpus won't collapse in smp etc..).

Your nocopy hack benchmark has some relevance only for usages of the
data done by kernel. So if it is the kernel that reads the data directly
from pagecache (i.e.  a kernel module), then your nocopy benchmark
matters. For example your nocopy benchmark also matters for sendfile
zerocopy, it will read at 122M/sec. But if it's userspace supposed to
receive the data (so not directly from pagecache on the kernel direct
mapping, but in userspace mapped memory) it cannot be 122M/sec, it has
to be less due the user address space management.

> 
> 
> anyone want to see any other benchmarks performed?  would a comparison to 
> 2.5.x be useful?
> 
> 
> comparative profile=2 traces:
>  - no O_DIRECT:
>         [root@mel-stglab-host1 src]# readprofile -v | sort -n -k3 | tail -10
>         80125060 _spin_lock_                                 718   6.4107
>         8013bfc0 brw_kiovec                                  798   0.9591
>         801cbb40 generic_make_request                        830   2.8819
>         801f9400 scsi_init_io_vc                             831   2.2582
>         8013c840 try_to_free_buffers                        1198   3.4034
>         8013a190 end_buffer_io_async                        2453  12.7760
>         8012b100 file_read_actor                            3459  36.0312
>         801cb4e0 __make_request                             7532   4.6152
>         80105220 default_idle                             106468 1663.5625
>         00000000 total                                    134102   0.0726
> 
>  - O_DIRECT, disks /dev/sd[m-r]:
>         [root@mel-stglab-host1 src]# readprofile -v | sort -n -k3 | tail -10
>         801cbb40 generic_make_request                         72   0.2500
>         8013ab00 set_bh_page                                  73   1.1406
>         801cbc60 submit_bh                                   116   1.0357
>         801f72a0 __scsi_end_request                          133   0.4618
>         80139540 unlock_buffer                               139   1.7375
>         8013bf10 end_buffer_io_kiobuf                        302   4.7188
>         8013bfc0 brw_kiovec                                  357   0.4291
>         801cb4e0 __make_request                              995   0.6097
>         80105220 default_idle                              34243 535.0469
>         00000000 total                                     37101   0.0201
> 
>  - /dev/raw/raw[2-7]:
>         [root@mel-stglab-host1 src]# readprofile -v | sort -n -k3 | tail -10
>         8013bf50 wait_kio                                    349   3.1161
>         801cbb40 generic_make_request                        461   1.6007
>         801cbc60 submit_bh                                   526   4.6964
>         80139540 unlock_buffer                               666   8.3250
>         801f72a0 __scsi_end_request                          699   2.4271
>         8013bf10 end_buffer_io_kiobuf                       1672  26.1250
>         8013bfc0 brw_kiovec                                 1906   2.2909
>         801cb4e0 __make_request                            10495   6.4308
>         80105220 default_idle                              84418 1319.0312
>         00000000 total                                    103516   0.0560
> 
>  - O_NOCOPY hack: (userspace doesn't actually get the read data)
>         801f9400 scsi_init_io_vc                             785   2.1332
>         8013c840 try_to_free_buffers                         950   2.6989
>         801f72a0 __scsi_end_request                          966   3.3542
>         801cbb40 generic_make_request                       1017   3.5312
>         8013bf10 end_buffer_io_kiobuf                       1672  26.1250
>         8013a190 end_buffer_io_async                        1693   8.8177
>         8013bfc0 brw_kiovec                                 1906   2.2909
>         801cb4e0 __make_request                            13682   8.3836
>         80105220 default_idle                             112345 1755.3906
>         00000000 total                                    144891   0.0784

Can you use -k4? this is the number of hits per function, but we should
take the size of the function into account too. Otherwise small
functions won't show up.

Can you also give a spin to the same benchmark with 2.4.19pre8aa2? It
has the vary-io stuff from Badari and futher kiobuf optimization from
Chuck. (vary-io will work only with aic and qlogic, enabling it is a one
liner if the driver is just ok with variable bh->b_size in the same I/O
request). right fix for avoiding the flood of small bh is bio in 2.5,
for 2.4 vary-io should be fine.

thanks,

Andrea
