Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVDJCbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDJCbr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDJCbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:31:47 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:58519 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S261266AbVDJCa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:30:59 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Sun, 10 Apr 2005 03:28:53 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <20050404191246.24b11158.akpm@osdl.org>
In-Reply-To: <20050404191246.24b11158.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504100328.53762.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 05 April 2005 03:12, Andrew Morton wrote:
> Claudio Martins <ctpm@rnl.ist.utl.pt> wrote:
> >    While stress testing 2.6.12-rc2 on an HP DL145 I get processes stuck
> > in D state after some time.
> >    This machine is a dual Opteron 248 with 2GB (ECC) on one node (the
> > other node has no RAM modules plugged in, since this board works only
> > with pairs).
> >
> >    I was using stress (http://weather.ou.edu/~apw/projects/stress/) with
> > the following command line:
> >
> >  stress -v -c 20 -i 12 -m 10 -d 20
> >
> >    This causes a constant load avg. of around 70, makes the machine go
> > into swap a little, and writes up to about 20GB of random data to disk
> > while eating up all CPU. After about half and hour random processes like
> > top, df, etc get stuck in D state. Half of the 60 or so stress processes
> > are also in D state. The machine keeps being responsive for maybe some 15
> > minutes but then the shells just hang and sshd stops responding to
> > connections, though the machine replies to pings (I don't have console
> > acess till tomorrow).
> >
> >    The system is using ext3 with md software Raid1.
> >
> >   I'm interested in knowing if anyone out there with dual Opterons can
> >  reproduce this or not. I also have access to an HP DL360 Dual Xeon, so I
> > will try to find out if this is AMD64 specific as soon as possible.
> > Please let me know if you want me to run some other tests or give some
> > more info to help solve this one.
>
> Can you capture the output from alt-sysrq-T?


     Hi Andrew,

  Due to other tasks, only now was I able to repeat the tests and capture the 
the output from alt-sysrq-T. I booted with serial console, put stress to work 
and when the processes started to get hung on D state I managed to capture 
the following:

 SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          D ffff81007fcfe0d8     0     1      0     2               
(NOTLB)
ffff810003253768 0000000000000082 ffff81007fd19170 0000007d00000000 
       ffff81007fd19170 ffff810003251470 000000000000271b ffff810074468e70 
       ffff810003251680 ffffffff8027a79a 
Call Trace:<ffffffff8027a79a>{__make_request+1274} 
<ffffffff8037ab68>{__down+152} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80158de4>{mempool_alloc+164} 
       <ffffffff8037c649>{__down_failed+53} 
<ffffffff802ed53d>{.text.lock.md+155} 
       <ffffffff802d8204>{make_request+868} 
<ffffffff8015db7d>{cache_alloc_refill+413} 
       <ffffffff8027abd1>{generic_make_request+545} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8027accf>{submit_bio+223} 
       <ffffffff8015c39b>{test_set_page_writeback+203} 
<ffffffff8016e9d8>{swap_writepage+184} 
       <ffffffff80161bc6>{shrink_zone+2678} 
<ffffffff8037b3e0>{thread_return+0} 
       <ffffffff8037b438>{thread_return+88} 
<ffffffff80162187>{try_to_free_pages+311} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8015a685>{__alloc_pages+533} 
       <ffffffff8015a88e>{__get_free_pages+14} 
<ffffffff8018c72a>{__pollwait+74} 
       <ffffffff80185c72>{pipe_poll+66} <ffffffff8018caa5>{do_select+725} 
       <ffffffff8018c6e0>{__pollwait+0} <ffffffff8018ceef>{sys_select+735} 
       <ffffffff8010db06>{system_call+126} 
migration/0   S ffff810002c12720     0     2      1             3       
(L-TLB)
ffff81007ff0fea8 0000000000000046 ffff810074806ef0 0000007500000001 
       ffff81007ff0fe58 ffff8100032506f0 0000000000000129 ffff810075281230 
       ffff810003250900 ffff810072ffde88 
Call Trace:<ffffffff80130a24>{migration_thread+532} 
<ffffffff80130810>{migration_thread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
ksoftirqd/0   S 0000000000000000     0     3      1             4     2 
(L-TLB)
ffff81007ff11f08 0000000000000046 ffff810072e00430 0000007d00000000 
       ffff810002c194e0 ffff810003250030 00000000000000d1 ffff810072f3a030 
       ffff810003250240 0000000000000000 
Call Trace:<ffffffff801393e1>{__do_softirq+113} 
<ffffffff801399c0>{ksoftirqd+0} 
       <ffffffff801399c0>{ksoftirqd+0} <ffffffff80139a23>{ksoftirqd+99} 
       <ffffffff801399c0>{ksoftirqd+0} <ffffffff80149c09>{kthread+217} 
       <ffffffff8010e6ef>{child_rip+8} <ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
migration/1   S ffff810002c1a720     0     4      1             5     3 
(L-TLB)
ffff81007ff15ea8 0000000000000046 ffff810072d1cff0 0000007300000001 
       ffff810079fe7e98 ffff81007ff134b0 00000000000000a3 ffff810075281230 
       ffff81007ff136c0 ffff81003381de88 
Call Trace:<ffffffff80130a24>{migration_thread+532} 
<ffffffff80130810>{migration_thread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
ksoftirqd/1   S 0000000000000001     0     5      1             6     4 
(L-TLB)
ffff81007ff19f08 0000000000000046 ffff810075376db0 00000077802b8e7e 
       ffff810002c114e0 ffff81007ff12df0 00000000000001b4 ffff810074125130 
       ffff81007ff13000 0000000000000000 
Call Trace:<ffffffff801393e1>{__do_softirq+113} 
<ffffffff801399c0>{ksoftirqd+0} 
       <ffffffff801399c0>{ksoftirqd+0} <ffffffff80139a23>{ksoftirqd+99} 
       <ffffffff801399c0>{ksoftirqd+0} <ffffffff80149c09>{kthread+217} 
       <ffffffff8010e6ef>{child_rip+8} <ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
events/0      S 0000094f2f7a804e     0     6      1             7     5 
(L-TLB)
ffff81007ff3be58 0000000000000046 0000000000000246 ffffffff8013d00d 
       000000007ffe0c00 ffff81007ff12730 0000000000000c80 ffffffff803f40c0 
       ffff81007ff12940 0000000000000000 
Call Trace:<ffffffff8013d00d>{__mod_timer+317} 
<ffffffff8015f470>{cache_reap+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
events/1      S 0000094ef3e03d58     0     7      1             8     6 
(L-TLB)
ffff81007ff3de58 0000000000000046 ffff810003250db0 0000000000000246 
       0000000000000246 ffff81007ff12070 00000000000000a4 ffff810003250db0 
       ffff81007ff12280 0000000000000000 
Call Trace:<ffffffff80252610>{flush_to_ldisc+0} 
<ffffffff80145331>{worker_thread+305} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff80145200>{worker_thread+0} <ffffffff80149c09>{kthread+217} 
       <ffffffff8010e6ef>{child_rip+8} <ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
khelper       S ffff810074815b18     0     8      1            13     7 
(L-TLB)
ffff81007ff43e58 0000000000000046 ffff810074815bc8 0000006f00000001 
       ffff810074815bc8 ffff81007ff414f0 000000000000006c ffff810074292f70 
       ffff81007ff41700 0000000000000001 
Call Trace:<ffffffff80144d50>{__call_usermodehelper+0} 
<ffffffff80145331>{worker_thread+305} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff80145200>{worker_thread+0} <ffffffff80149c09>{kthread+217} 
       <ffffffff8010e6ef>{child_rip+8} 
<ffffffff8011b0b0>{flat_send_IPI_mask+0} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
kthread       S ffff81002a48bd18     0    13      1    24     169     8 
(L-TLB)
ffff81007ff55e58 0000000000000046 ffffffff8012f4f0 0000006f00000000 
       0000000000000000 ffff81007ff40e30 00000000000000ac ffff8100745941b0 
       ffff81007ff41040 0000000000000001 
Call Trace:<ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
kacpid        S 000000000c378373     0    24     13           105       
(L-TLB)
ffff81000334be58 0000000000000046 0000000000000000 0000000000000000 
       ffff810002c114e0 ffff810003349530 0000000000000209 ffff810003250db0 
       ffff810003349740 0000000000000000 
Call Trace:<ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80145200>{worker_thread+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
kblockd/0     S ffff81007fd19830     0   105     13           106    24 
(L-TLB)
ffff8100033a1e58 0000000000000046 0000000000000001 0000007600000000 
       ffff810019992230 ffff810003348e70 0000000000000d97 ffff810074125130 
       ffff810003349080 0000000000000001 
Call Trace:<ffffffff80278f30>{blk_unplug_work+0} 
<ffffffff80145331>{worker_thread+305} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80149c09>{kthread+217} 
       <ffffffff8010e6ef>{child_rip+8} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80149b30>{kthread+0} <ffffffff8010e6e7>{child_rip+0} 
       
kblockd/1     S 000009309d720cf6     0   106     13           170   105 
(L-TLB)
ffff8100033a3e58 0000000000000046 ffff81007fcf8e00 ffffffff8027f2a6 
       ffff81007fcf6a00 ffff8100033487b0 0000000000000ae1 ffff810003250db0 
       ffff8100033489c0 0000000000000000 
Call Trace:<ffffffff8027f2a6>{as_move_to_dispatch+342} 
<ffffffff80280530>{as_work_handler+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80145200>{worker_thread+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
kswapd0       D ffff81007fcfe0d8     0   169      1           758    13 
(L-TLB)
ffff81007fc0d8e8 0000000000000046 ffff8100133b5900 0000007600000001 
       ffff81007fd19170 ffff81007ff400b0 0000000000003643 ffff810074193170 
       ffff81007ff402c0 ffffffff8027abd1 
Call Trace:<ffffffff8027abd1>{generic_make_request+545} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8037ab68>{__down+152} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff80158de4>{mempool_alloc+164} 
<ffffffff8037c649>{__down_failed+53} 
       <ffffffff802ed53d>{.text.lock.md+155} 
<ffffffff802d8204>{make_request+868} 
       <ffffffff8027abd1>{generic_make_request+545} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8027accf>{submit_bio+223} 
       <ffffffff8015c39b>{test_set_page_writeback+203} 
<ffffffff8016e9d8>{swap_writepage+184} 
       <ffffffff80161bc6>{shrink_zone+2678} 
<ffffffff8037b3e0>{thread_return+0} 
       <ffffffff8037b438>{thread_return+88} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff801624e9>{balance_pgdat+601} <ffffffff801627a7>{kswapd+327} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8012df70>{schedule_tail+64} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff8011b0b0>{flat_send_IPI_mask+0} <ffffffff80162660>{kswapd+0} 
       <ffffffff8010e6e7>{child_rip+0} 
aio/0         S ffff81000337d000     0   170     13           171   106 
(L-TLB)
ffff81007fc1fe58 0000000000000046 0000000000000000 0000007500000000 
       0000000000000000 ffff81007fc08eb0 000000000000011f ffff810003251470 
       ffff81007fc090c0 0000000000000000 
Call Trace:<ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80145200>{worker_thread+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
aio/1         S 0000000048dcc53f     0   171     13          2425   170 
(L-TLB)
ffff81007fc21e58 0000000000000046 0000000000000000 0000000000000000 
       ffff810002c114e0 ffff81007fc087f0 000000000000011e ffff810003250db0 
       ffff81007fc08a00 0000000000000000 
Call Trace:<ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80145200>{worker_thread+0} 
       <ffffffff80145331>{worker_thread+305} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80145200>{worker_thread+0} 
<ffffffff80149c50>{keventd_create_kthread+0} 
       <ffffffff80149c09>{kthread+217} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff80149c50>{keventd_create_kthread+0} 
<ffffffff80149b30>{kthread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
kseriod       S 00000007606f165c     0   758      1           825   169 
(L-TLB)
ffff81007fd05eb8 0000000000000046 0000000000000000 ffffffff801b1df9 
       0000000000000246 ffff81007ff40770 00000000000001f6 ffff810003250db0 
       ffff81007ff40980 0000000000000000 
Call Trace:<ffffffff801b1df9>{sysfs_make_dirent+41} 
<ffffffff8027288d>{driver_create_file+61} 
       <ffffffff80267b21>{serio_thread+689} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8012df70>{schedule_tail+64} 
       <ffffffff8010e6ef>{child_rip+8} <ffffffff80267870>{serio_thread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
scsi_eh_0     S ffff81007fd59ef8     0   825      1           826   758 
(L-TLB)
ffff81007fd59df8 0000000000000046 ffffffff80145f9f 00000075801461ba 
       ffff81007fc08130 ffff81007fc08130 00000000000003b1 ffff810003251470 
       ffff81007fc08340 0000000000000202 
Call Trace:<ffffffff80145f9f>{attach_pid+47} 
<ffffffff8012d5c3>{recalc_task_prio+323} 
       <ffffffff8037acad>{__down_interruptible+205} 
<ffffffff8012f4f0>{default_wake_function+0} 
       <ffffffff8037c683>{__down_failed_interruptible+53} 
       <ffffffff802a0be4>{.text.lock.scsi_error+45} 
<ffffffff8010e6ef>{child_rip+8} 
       <ffffffff802a0150>{scsi_error_handler+0} 
<ffffffff8010e6e7>{child_rip+0} 
       
ahc_dv_0      S 000000061ef1cc1c     0   826      1           845   825 
(L-TLB)
ffff81007fd5de08 0000000000000046 ffff81000327b400 000000867ff0da40 
       0000000000000000 ffff81007fd5b5b0 000000000000029f ffff81007ff12df0 
       ffff81007fd5b7c0 ffff81007fc6ac00 
Call Trace:<ffffffff80276ab5>{elv_next_request+261} 
<ffffffff8037acad>{__down_interruptible+205} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff8037c683>{__down_failed_interruptible+53} 
       <ffffffff80212e90>{kobject_release+0} 
<ffffffff802be9eb>{.text.lock.aic7xxx_osm+85} 
       <ffffffff8010e6ef>{child_rip+8} 
<ffffffff802bd340>{ahc_linux_dv_thread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
md3_raid1     S ffff81007fdb6b00     0   845      1           847   826 
(L-TLB)
ffff81007fddfeb8 0000000000000046 ffff810074534ef0 0000007d00000001 
       0000000002c114e0 ffff81007fd5a170 000000000000009f ffff810074534ef0 
       ffff81007fd5a380 0000000000000000 
Call Trace:<ffffffff802ea015>{md_thread+277} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8012df70>{schedule_tail+64} 
       <ffffffff802d8920>{raid1d+0} <ffffffff8010e6ef>{child_rip+8} 
       <ffffffff802d8920>{raid1d+0} <ffffffff802e9f00>{md_thread+0} 
       <ffffffff8010e6e7>{child_rip+0} 
md2_raid1     D ffff81007fcfe0d8     0   847      1           849   845 
(L-TLB)
ffff81007fdf1558 0000000000000046 ffff81000b4d9000 0000007d8015d9ad 
       ffff81007ffef4f8 ffff81007fd5a830 0000000000001a9e ffff810074ffa2f0 
       ffff81007fd5aa40 ffff81007ffef480 
Call Trace:<ffffffff8015db7d>{cache_alloc_refill+413} 
<ffffffff8037ab68>{__down+152} 
       <ffffffff8012f4f0>{default_wake_function+0} 
<ffffffff80158de4>{mempool_alloc+164} 
       <ffffffff8037c649>{__down_failed+53} 
<ffffffff802ed53d>{.text.lock.md+155} 
       <ffffffff802d8204>{make_request+868} 
<ffffffff8015db7d>{cache_alloc_refill+413} 
       <ffffffff8027abd1>{generic_make_request+545} 
<ffffffff8014a230>{autoremove_wake_function+0} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8027accf>{submit_bio+223} 
       <ffffffff8015c39b>{test_set_page_writeback+203} 
<ffffffff8016e9d8>{swap_writepage+184} 
       <ffffffff80161bc6>{shrink_zone+2678} 
<ffffffff80162187>{try_to_free_pages+311} 
       <ffffffff8014a230>{autoremove_wake_function+0} 
<ffffffff8015a685>{__alloc_pages+533} 
       <ffffffff80172633>{alloc_page_interleave+67} 
<ffffffff8015d74e>{cache_grow+270} 
       <ffffffff8015db95>{cache_alloc_refill+437} 
<ffffffff8015d636>{kmem_cache_alloc+54} 
       <ffffffff80158e1c>{mempoolNMI Watchdog detected LOCKUP on CPU1CPU 1 
Modules linked in: tg3 i2c_amd756 i2c_core ohci_hcd usbcore dm_mod
Pid: 0, comm: swapper Not tainted 2.6.12-rc2
RIP: 0010:[<ffffffff8026cfe7>] <ffffffff8026cfe7>{serial_in+87}
RSP: 0018:ffff81000325faf0  EFLAGS: 00000002
RAX: 00000000ffffff20 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff804f5120
RBP: 0000000000002463 R08: 000000000000006c R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000000 R12: ffffffff804f5120
R13: ffffffff804acc52 R14: 000000000000001a R15: 0000000000000025
FS:  00002aaaab3a34a0(0000) GS:ffffffff80510bc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaadc55c0 CR3: 0000000073456000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff810003256000, task ffff810003250db0)
Stack: ffffffff8026f42d 000000050325fd35 ffffffff8041a720 0000000000008378 
       0000000000000025 ffffffffffffbeca 0000000000000025 0000000000000046 
       ffffffff801342ac 000000000000839d 
Call Trace:<IRQ> <ffffffff8026f42d>{serial8250_console_write+125} 
<ffffffff801342ac>{__call_console_drivers+76} 
       <ffffffff801345aa>{release_console_sem+330} 
<ffffffff801348d0>{vprintk+656} 
       <ffffffff8026f54f>{serial8250_console_write+415} 
<ffffffff80158e1c>{mempool_alloc+220} 
       <ffffffff8013498d>{printk+141} <ffffffff80158e1c>{mempool_alloc+220} 
       <ffffffff801348d0>{vprintk+656} <ffffffff801517d8>{kallsyms_lookup+200} 
       <ffffffff8015d636>{kmem_cache_alloc+54} 
<ffffffff80158e1c>{mempool_alloc+220} 
       <ffffffff8010ed2c>{printk_address+140} 
<ffffffff80158e1c>{mempool_alloc+220} 
       <ffffffff8010ef2a>{show_trace+410} <ffffffff8010f07e>{show_stack+270} 
       <ffffffff80130732>{show_state+498} 
<ffffffff802611b0>{__handle_sysrq+144} 
       <ffffffff8026d658>{receive_chars+360} 
<ffffffff8026d9e7>{serial8250_interrupt+119} 
       <ffffffff8015461c>{handle_IRQ_event+44} 
<ffffffff80154749>{__do_IRQ+249} 
       <ffffffff80110a52>{do_IRQ+66} <ffffffff8010e0ad>{ret_from_intr+0} 
        <EOI> <ffffffff8010e1de>{retint_kernel+38} 
<ffffffff8010bb90>{default_idle+0} 
       <ffffffff8010bbb0>{default_idle+32} <ffffffff8010be1a>{cpu_idle+74} 
       <ffffffff8052291c>{start_secondary+476} 

Code: 0f b6 c0 c3 66 66 90 66 90 0f b6 4f 22 0f b6 47 23 41 89 d0 
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 

------------------------------------


  Unfortunately the system Oopsed in the middle of dumping the tasks, but from 
what I can see I'm tempted to think that this might be related to the MD 
code. md2_raid1 is blocked on D state and, although not shown on the dump, I 
know from ps command that md0_raid1 (the swap partition) was also on D state 
(along with the stress processes which are responsible for hogging memory, 
and top and df). There were about 200MB swapped out, but the swap partition 
size is 1GB.

  I repeated the test to try to get more output from alt-sysreq-T, but it 
oopsed again with even less output. 
  By the way, I have also tested 2.6.11.6 and I get stuck processes in the 
same way. With 2.6.9 I get a hard lockup with no working alt-sysrq, after 
about 30 to 60mins of stress.

  This is with preempt enabled (as well as BKL preempt). I want to test also 
without preempt and also without using MD Raid1, but I'll have to reach the 
machine and hit the power button, so not possible until tomorrow :-(

 The original original message in this thread containing the details of the 
setup and a .config is at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111266784320156&w=2

  I am happy to test any patches and also wonder if enabling any of the 
options in the kernel debugging section could help in trying to find where 
the deadlock is.

  Thanks

Claudio

