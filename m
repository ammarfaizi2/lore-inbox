Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315819AbSEJGvP>; Fri, 10 May 2002 02:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315820AbSEJGvO>; Fri, 10 May 2002 02:51:14 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:5575 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S315819AbSEJGvM>; Fri, 10 May 2002 02:51:12 -0400
Message-Id: <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 10 May 2002 16:50:23 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
  IDE 56)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CDAC4EB.FC4FE5CF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:50 AM 9/05/2002 -0700, Andrew Morton wrote:
> >          /dev/md0 raid-0 with O_DIRECT:          91847kbyte/sec (2781usec
> >          /dev/md0 
> raid-0:                                129455kbyte/sec (1978usec
> >          /dev/md0 raid-0 with O_NOCOPY:  195868kbyte/sec (1297usec
>
>hmm.  Why is O_DIRECT always the slowest?  (and it would presumably do
>even worse with an 8k transfer size).

i just reproduced the test to validate the data.  i'm using 8kbyte blocks here.
on kernel is 2.4.18, O_DIRECT is still the slowest.

this machine has 2GB RAM, so it has 1.1GB RAM in HighMem.

booting a kernel with 'profile=2' set, the numbers were as follows:

  - Base performance, /dev/md0 raid-0 8-disk array:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=8k blocks=4M /dev/md0
         Completed writing 31250 mbytes in 214. 94761 seconds (153.05 
Mbytes/sec), 53usec mean latency

  - using /dev/md0 raid-0 8-disk array with O_DIRECT:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=8k blocks=4M direct /dev/md0
         Completed reading 31250 mbytes in 1229.830726 seconds (26.64 
Mbytes/sec), 306usec mean latency

  - using /dev/md0 raid-0 8-disk array with O_NOCOPY hack:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=8k blocks=4M nocopy /dev/md0
         Completed writing 31250 mbytes in 163.602116 seconds (200.29 
Mbytes/sec), 39usec mean latency

so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no 
O_DIRECT.
anyone have any clues?

from the profile of the O_DIRECT kernel, we have:
         [root@mel-stglab-host1 src]# cat /tmp/profile2.txt | sort -n -k3 | 
tail -20
         c01ceb90 submit_bh                                   270   2.4107
         c01fc8c0 scsi_init_io_vc                             286   0.7772
         c0136ec0 create_bounce                               323   0.9908
         c0139d80 unlock_buffer                               353   4.4125
         c012f7d0 kmem_cache_alloc                            465   1.6146
         c0115a40 __wake_up                                   470   2.4479
         c01fa720 __scsi_end_request                          509   1.7674
         c01fae00 scsi_request_fn                             605   0.7002
         c013cab0 end_buffer_io_kiobuf                        675  10.5469
         c01154e0 schedule                                    849   0.6170
         c0131a40 rmqueue                                     868   1.5069
         c025ede0 raid0_make_request                          871   2.5923
         c0225ee0 qla2x00_done                                973   1.6436
         c013cb60 brw_kiovec                                 1053   1.0446
         c01ce400 __make_request                             1831   1.1110
         c01f30e0 scsi_dispatch_cmd                          1854   2.0692
         c011d010 do_softirq                                 2183   9.7455
         c0136c30 bounce_end_io_read                        13947  39.6222
         c0105230 default_idle                             231472 3616.7500
         00000000 total                                    266665   0.1425

contrast this to the profile where we're not using O_DIRECT:
         [root@mel-stglab-host1 src]# cat /tmp/profile3_base.txt | sort -n 
-k3 | tail -20
         c012fdc0 kmem_cache_reap                             369   0.4707
         c013b330 set_bh_page                                 397   4.9625
         c011d010 do_softirq                                  419   1.8705
         c0131a40 rmqueue                                     466   0.8090
         c01fa720 __scsi_end_request                          484   1.6806
         c012fa60 kmem_cache_free                             496   3.8750
         c013bd00 block_read_full_page                        523   0.7783
         c012f7d0 kmem_cache_alloc                            571   1.9826
         c013db39 _text_lock_buffer                           729   0.9812
         c0130ca0 shrink_cache                                747   0.7781
         c01cea70 generic_make_request                        833   2.8924
         c025ede0 raid0_make_request                          930   2.7679
         c013b280 get_unused_buffer_head                      975   5.5398
         c01fc8c0 scsi_init_io_vc                            1003   2.7255
         c013d490 try_to_free_buffers                        1757   4.7745
         c013a9d0 end_buffer_io_async                        2482  14.1023
         c01ce400 __make_request                             2687   1.6305
         c012a6e0 file_read_actor                            6951  27.1523
         c0105230 default_idle                              15227 237.9219
         00000000 total                                     45048   0.0241

the biggest difference here is bounce_end_io_read in O_DIRECT.
given there's still lots of idle-time, i'll file up lockmeter on here and 
see if theres any gremlins there.


cheers,

lincoln.

