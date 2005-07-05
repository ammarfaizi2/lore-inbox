Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVGEPOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVGEPOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVGEPOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:14:50 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:9221 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261878AbVGEPAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:00:15 -0400
Message-ID: <42CAA075.4040406@rainbow-software.org>
Date: Tue, 05 Jul 2005 17:00:05 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-18115-1120575608-0001-2"
To: Jens Axboe <axboe@suse.de>
CC: "=?ISO-8859-1?Q?Andr=E9_Tomt?=" <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
In-Reply-To: <20050705142122.GY1444@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-18115-1120575608-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On Tue, Jul 05 2005, Ondrej Zary wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Tue, 2005-07-05 at 15:02 +0200, Ondrej Zary wrote:
>>>
>>>
>>>>>Ok, looks alright for both. Your machine is quite slow, perhaps that is
>>>>>showing the slower performance. Can you try and make HZ 100 in 2.6 and
>>>>>test again? 2.6.13-recent has it as a config option, otherwise edit
>>>>>include/asm/param.h appropriately.
>>>>>
>>>>
>>>>I forgot to write that my 2.6.12 kernel is already compiled with HZ 100 
>>>>(it makes the system more responsive).
>>>>I've just tried 2.6.8.1 with HZ 1000 and there is no difference in HDD 
>>>>performance comparing to 2.6.12.
>>>
>>>
>>>OK, interesting. You could try and boot with profile=2 and do
>>>
>>># readprofile -r
>>># dd if=/dev/hda of=/dev/null bs=128k 
>>># readprofile > prof_output
>>>
>>>for each kernel and post it here, so we can see if anything sticks out.
>>>
>>
>>Here are the profiles (used dd with count=4096) from 2.4.26 and 2.6.12 
>>(nothing from 2.6.8.1 because I don't have the .map file anymore).
> 
> 
> Looks interesting, 2.6 spends oodles of times copying to user space.
> Lets check if raw reads perform ok, please try and time this app in 2.4
> and 2.6 as well.
> 
> # gcc -Wall -O2 -o oread oread.c
> # time ./oread /dev/hda
> 
oread is faster than dd, but still not as fast as 2.4. In 2.6.12, HDD 
led is blinking, in 2.4 it's solid on during the read.

2.6.12:
root@pentium:/home/rainbow# time ./oread /dev/hda

real    0m25.082s
user    0m0.000s
sys     0m0.680s

2.4.26:
root@pentium:/home/rainbow# time ./oread /dev/hda

real    0m23.513s
user    0m0.000s
sys     0m2.360s

-- 
Ondrej Zary

--=_tic-18115-1120575608-0001-2
Content-Type: text/plain; name="profile-oread2426.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile-oread2426.txt"

  2016 default_idle                              25.2000
     1 system_call                                0.0156
     2 handle_IRQ_event                           0.0179
     1 schedule                                   0.0012
     1 __run_task_queue                           0.0104
     4 follow_page                                0.0312
     3 get_user_pages                             0.0063
     4 mark_dirty_kiobuf                          0.0357
     1 handle_mm_fault                            0.0048
     2 generic_file_direct_IO                     0.0026
     1 lru_cache_add                              0.0089
     2 init_buffer                                0.0625
    12 set_bh_page                                0.1071
     3 create_buffers                             0.0134
    30 generic_direct_IO                          0.0457
    17 brw_kiovec                                 0.0186
    11 max_block                                  0.0764
     9 blkdev_get_block                           0.1406
     2 blkdev_direct_IO                           0.0417
     1 write_profile                              0.0208
     2 generic_unplug_device                      0.0312
    93 __make_request                             0.0524
    25 generic_make_request                       0.0781
    20 submit_bh                                  0.0781
     5 ide_inb                                    0.3125
    12 ide_outb                                   0.7500
     1 ide_outl                                   0.0625
     1 ide_wait_stat                              0.0030
     4 ide_execute_command                        0.0312
     2 ide_do_request                             0.0050
     4 ide_get_queue                              0.0625
     2 ide_intr                                   0.0069
     2 ide_dma_intr                               0.0104
    10 ide_build_sglist                           0.0160
     1 ide_build_dmatable                         0.0024
     1 __ide_dma_read                             0.0042
     1 __constant_c_and_count_memset              0.0069
     1 __ide_do_rw_disk                           0.0007
    42 idedisk_end_request                        0.2188
     4 __rdtsc_delay                              0.1250
     0 *unknown*
  2356 total                                      0.0013

--=_tic-18115-1120575608-0001-2
Content-Type: text/plain; name="profile-oread2612.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile-oread2612.txt"

     1 sched_clock                                0.0057
     3 cond_resched_lock                          0.0312
     2 write_profile                              0.0312
     1 __wake_up_bit                              0.0208
     2 __generic_file_aio_read                    0.0038
     1 generic_file_read                          0.0052
     1 mempool_alloc                              0.0037
     1 set_page_dirty                             0.0125
     3 set_page_dirty_lock                        0.0625
     4 __follow_page                              0.0227
     7 get_user_pages                             0.0072
     2 do_wp_page                                 0.0025
     8 __bio_add_page                             0.0227
     5 bio_add_page                               0.1562
     1 bio_set_map_data                           0.0208
     1 update_atime                               0.0057
     1 dio_get_page                               0.0156
     1 dio_bio_submit                             0.0069
     2 dio_bio_complete                           0.0096
     5 submit_page_section                        0.0164
     1 dio_zero_block                             0.0078
    13 do_direct_IO                               0.0150
     2 direct_io_worker                           0.0014
     2 __copy_to_user_ll                          0.0312
  2428 acpi_processor_idle                        4.0000
     4 blk_rq_map_sg                              0.0114
    10 __make_request                             0.0086
     1 generic_make_request                       0.0022
     1 as_set_request                             0.0089
     4 ide_end_request                            0.0278
     6 ide_do_request                             0.0072
     1 ide_intr                                   0.0026
     5 ide_outb                                   0.3125
     1 ide_execute_command                        0.0063
     2 ide_build_sglist                           0.0139
     5 schedule                                   0.0033
     1 io_schedule                                0.0312
     0 *unknown*
  2539 total                                      0.0012

--=_tic-18115-1120575608-0001-2--
