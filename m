Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268945AbRHBOhK>; Thu, 2 Aug 2001 10:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbRHBOhB>; Thu, 2 Aug 2001 10:37:01 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:10130 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S268945AbRHBOgu>; Thu, 2 Aug 2001 10:36:50 -0400
Date: Thu, 2 Aug 2001 10:42:17 -0400 (EDT)
From: <david@ultramaster.com>
To: <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: lowlatency patch testing results (< 2ms latency :-)
Message-ID: <Pine.LNX.4.33.0108021031530.10584-100000@mercury.ultramaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Thanks a lot for the latest iteration of the lowlatency patch.  I've done
a little testing with the rtc-debug and amlat and have triggered your
automatic stack tracing 'feature' a few times.  The actual rtc histogram
is at the very end.

For the record, all latencies are under 2ms, but on another system I think
I'm seeing a rare 7 or 8 ms bump.  I'll follow up on that.

My system is UP 700mhz athlon, SCSI system (aic7xxx), 256mb ram,  running
2.4.7 with lowlatency and rtc-debug.  To generate the load, I run amlat
with the 0% cpu consumption (default) and a disk I/O test that simulates a
hard disk recorder I/O load. (read and write to N files sequentially).

It seems like all of the traces are about the same, and come from two
places, kapmd and bdflush.

Here it is:

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471d48 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471dac c1471dac 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471dac cf556dc0 c14baa00 cff07198 c14bab04 cff07140
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c016268b>] [<c01892e8>] [<c0189514>]
       [<c0189772>] [<c0173a2e>] [<c019f374>] [<c0184032>] [<c0183e1a>] [<c0183e86>] [<c011816e>] [<c0118037>]
       [<c0117d5b>] [<c01080ec>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>] [<c0105000>]
       [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c016268b <add_timer_randomness+cb/e0>
Trace; c01892e8 <scsi_queue_next_request+38/110>
Trace; c0189514 <__scsi_end_request+154/160>
Trace; c0189772 <scsi_io_completion+182/360>
Trace; c0173a2e <attempt_merge+5e/170>
Trace; c019f374 <rw_intr+154/160>
Trace; c0184032 <scsi_finish_command+92/a0>
Trace; c0183e1a <scsi_done+7a/80>
Trace; c0183e86 <scsi_bottom_half_handler+66/100>
Trace; c011816e <bh_action+1e/40>
Trace; c0118037 <tasklet_hi_action+87/e0>
Trace; c0117d5b <do_softirq+4b/90>
Trace; c01080ec <do_IRQ+9c/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ea4 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f08 c1471f08 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f08 cf556dc0 ca69d140 c14bee00 c029c818 00000001
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c018ac91>] [<c01838ec>] [<c0189bc7>] [<c01736fe>]
       [<c0118229>] [<c01344a1>] [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c018ac91 <scsi_init_io_vc+e1/140>
Trace; c01838ec <scsi_dispatch_cmd+dc/160>
Trace; c0189bc7 <scsi_request_fn+227/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bcc00 cff07118 c14bcd04 cff070c0
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ce4 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471d48 c1471d48 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471d48 cf556dc0 00000015 c1466980 c1466980 00000202
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c018b2bd>] [<c018ac0f>] [<c01838ec>] [<c0189bc7>]
       [<c016268b>] [<c01892e8>] [<c0189514>] [<c0189772>] [<c013d928>] [<c019f374>] [<c0184032>] [<c0183e1a>]
       [<c0183e86>] [<c011816e>] [<c01080dc>] [<c0118037>] [<c0117d5b>] [<c01080ec>] [<c0106d54>] [<c0189ba3>]
       [<c01736fe>] [<c0118229>] [<c01344a1>] [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c018b2bd <scsi_malloc+9d/d0>
Trace; c018ac0f <scsi_init_io_vc+5f/140>
Trace; c01838ec <scsi_dispatch_cmd+dc/160>
Trace; c0189bc7 <scsi_request_fn+227/300>
Trace; c016268b <add_timer_randomness+cb/e0>
Trace; c01892e8 <scsi_queue_next_request+38/110>
Trace; c0189514 <__scsi_end_request+154/160>
Trace; c0189772 <scsi_io_completion+182/360>
Trace; c013d928 <send_sigio+48/90>
Trace; c019f374 <rw_intr+154/160>
Trace; c0184032 <scsi_finish_command+92/a0>
Trace; c0183e1a <scsi_done+7a/80>
Trace; c0183e86 <scsi_bottom_half_handler+66/100>
Trace; c011816e <bh_action+1e/40>
Trace; c01080dc <do_IRQ+8c/b0>
Trace; c0118037 <tasklet_hi_action+87/e0>
Trace; c0117d5b <do_softirq+4b/90>
Trace; c01080ec <do_IRQ+9c/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bc600 c14fc398 c14bc704 c14fc340
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bfa00 cff0c298 c14bfb04 cff0c240
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`kapm-idled'[3] is being piggy.  need_resched=1, orq=1

c1479e9c d48ba5e0 c1478232 00000003 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1479f00 c1479f00 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1479f00 cf556dc0 00000080 00000001 00000282 c1479f7c
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c010f8cd>] [<c010f96b>] [<c010ff72>] [<c0110148>]
       [<c01102be>] [<c0110beb>] [<c0105000>] [<c0105516>] [<c0110970>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c010f8cd <apm_bios_call+6d/80>
Trace; c010f96b <apm_get_event+2b/70>
Trace; c010ff72 <get_event+12/50>
Trace; c0110148 <check_events+198/1b0>
Trace; c01102be <apm_mainloop+de/120>
Trace; c0110beb <apm+27b/2a0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0110970 <apm+0/2a0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bc600 cff05998 c14bc704 cff05940
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14b9800 cff05698 c14b9904 cff05640
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1
c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bb000 cff06318 c14bb104 cff062c0
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ea4 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f08 c1471f08 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f08 cf556dc0 00000200 c14ba800 c029de80 00000200
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c018ac42>] [<c01838ec>] [<c0189bc7>] [<c01736fe>]
       [<c0118229>] [<c01344a1>] [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c018ac42 <scsi_init_io_vc+92/140>
Trace; c01838ec <scsi_dispatch_cmd+dc/160>
Trace; c0189bc7 <scsi_request_fn+227/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bda00 c14fec98 c14bdb04 c14fec40
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bb200 c14ffc98 c14bb304 c14ffc40
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---
`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bce00 cff02f18 c14bcf04 cff02ec0
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bba00 cff09398 c14bbb04 cff09340
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471d48 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471dac c1471dac 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471dac cf556dc0 c14bea00 cff04e98 c14beb04 cff04e40
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c016268b>] [<c01892e8>] [<c0189514>]
       [<c0189772>] [<c019f374>] [<c0184032>] [<c0183e1a>] [<c0183e86>] [<c011816e>] [<c01080dc>] [<c0118037>]
       [<c0117d5b>] [<c01080ec>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>] [<c0105000>]
       [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c016268b <add_timer_randomness+cb/e0>
Trace; c01892e8 <scsi_queue_next_request+38/110>
Trace; c0189514 <__scsi_end_request+154/160>
Trace; c0189772 <scsi_io_completion+182/360>
Trace; c019f374 <rw_intr+154/160>
Trace; c0184032 <scsi_finish_command+92/a0>
Trace; c0183e1a <scsi_done+7a/80>
Trace; c0183e86 <scsi_bottom_half_handler+66/100>
Trace; c011816e <bh_action+1e/40>
Trace; c01080dc <do_IRQ+8c/b0>
Trace; c0118037 <tasklet_hi_action+87/e0>
Trace; c0117d5b <do_softirq+4b/90>
Trace; c01080ec <do_IRQ+9c/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

`bdflush'[7] is being piggy.  need_resched=1, orq=1

c1471ee0 d48ba5e0 c1470232 00000007 00000001 00000001 20000001 00000008
       c0107f49 00000008 00000000 c1471f44 c1471f44 00000008 c0264b00 cf556dc0
       c01080b8 00000008 c1471f44 cf556dc0 c14bf800 cff0ea98 c14bf904 cff0ea40
Call Trace: [<c0107f49>] [<c01080b8>] [<c0106d54>] [<c0189ba3>] [<c01736fe>] [<c0118229>] [<c01344a1>]
       [<c0105000>] [<c0105000>] [<c0105516>] [<c0134400>]

Trace; c0107f49 <handle_IRQ_event+39/60>
Trace; c01080b8 <do_IRQ+68/b0>
Trace; c0106d54 <ret_from_intr+0/7>
Trace; c0189ba3 <scsi_request_fn+203/300>
Trace; c01736fe <generic_unplug_device+1e/30>
Trace; c0118229 <__run_task_queue+49/60>
Trace; c01344a1 <bdflush+a1/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0134400 <bdflush+0/c0>

---

rtc histogram:
0:175799 10:18757 20:8660 30:3859 40:1191
50:472 60:301 70:188 80:123 90:122
100:93 110:105 120:87 130:67 140:61
150:64 160:61 170:49 180:47 190:56
200:52 210:47 220:44 230:48 240:43
250:39 260:39 270:28 280:34 290:23
300:19 310:15 320:8 330:8 340:7
350:10 360:4 370:8 380:4 390:2
400:2 410:1 420:1 430:2 440:1
450:1 460:2 470:2 480:1 490:1
500:1 510:2 520:1 540:3 550:1
570:1 590:3 600:27 610:1 620:1
650:3 660:2 680:3 690:4 740:1
760:1 770:1 790:1 820:1 840:1
850:1 860:3 870:1 890:1 900:1
1080:1 1200:2 1220:1 1240:1 1290:1
1300:2 1350:1 1390:1 1490:1 1510:1
1530:1 1540:1 1680:1 1940:1 1960:1

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com

