Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbULOUs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbULOUs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbULOUs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:48:58 -0500
Received: from novell.stoldgods.nu ([193.45.238.241]:33513 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S262482AbULOUsh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:48:37 -0500
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Wed, 15 Dec 2004 21:52:30 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Steven Rostedt <rostedt@goodmis.org>
References: <20041116134027.GA13360@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
In-Reply-To: <20041214132834.GA32390@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412152152.32713.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Tuesday 14 December 2004 14.28, Ingo Molnar wrote:
> i have released the -V0.7.33-0 Real-Time Preemption patch, which
> can be downloaded from the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> this is mainly a port from -rc2-mm3 to -rc3-mm1. Changes:
>
> - due to 2.6.10 release work the -mm kernel now is in fixes-mostly
> mode, but there's one interesting new feature: -rc3-mm1 introduced
> the ->unlocked_ioctl method which is now an official way to do
> BKL-less ioctls. I changed the ALSA ->ioctl_bkl changes in -RT to
> use this facility. The ALSA/sound guys might be interested in these
> bits. Thus another chunk of -RT could go upstream.
>
> - IO-APIC/MSI fix from Steven Rostedt.
>
> - fixed a tracer bug which would produce a kernel warning and an
> empty /proc/latency_trace if the trace buffer overflows.

I got this deadlock with V0.7.33-2:

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------
already locked:  [c04d63e0] {rtc_task_lock}
.. held by:             IRQ 8:  305 [df45c030,  52]
... acquired at:  rtc_interrupt+0x137/0x230

------------------------------
| showing all locks held by: |  (IRQ 8/305 [df45c030,  52]):
------------------------------

#001:             [c04d63e0] {rtc_task_lock}
... acquired at:  rtc_interrupt+0x137/0x230

#002:             [df4f16f8] {&timer->lock}
... acquired at:  _snd_timer_stop+0x8f/0x180

-{current task's backtrace}----------------->
 [<c0104273>] dump_stack+0x23/0x30 (20)
 [<c013d011>] check_deadlock+0x141/0x2d0 (48)
 [<c013dc1a>] task_blocks_on_lock+0x7a/0x100 (36)
 [<c041a847>] __down_mutex+0x237/0x440 (88)
 [<c013f86b>] __spin_lock+0x4b/0x60 (24)
 [<c013f8dd>] _spin_lock_irq+0x1d/0x20 (16)
 [<c02b60d9>] rtc_control+0x29/0x80 (32)
 [<c034efef>] rtctimer_stop+0x2f/0x70 (28)
 [<c034c8fc>] snd_timer_interrupt+0x2fc/0x380 (64)
 [<c034f057>] rtctimer_interrupt+0x27/0x40 (20)
 [<c02b4f08>] rtc_interrupt+0x158/0x230 (32)
 [<c014f40a>] handle_IRQ_event+0x6a/0xf0 (52)
 [<c014fdcb>] do_hardirq+0xab/0x130 (40)
 [<c014fec0>] do_irqd+0x70/0xb0 (32)
 [<c013bcc6>] kthread+0xa6/0xf0 (48)
 [<c0101365>] kernel_thread_helper+0x5/0x10 (548970516)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c041a94a>] .... __down_mutex+0x33a/0x440
.....[<c013f86b>] ..   ( <= __spin_lock+0x4b/0x60)
.. [<c01435bb>] .... print_traces+0x1b/0x50
.....[<c0104273>] ..   ( <= dump_stack+0x23/0x30)


showing all tasks:
s            init:    1 [c1467970, 116] (not blocked)
s           IRQ 0:    2 [c1467320,  50] (not blocked)
s     ksoftirqd/0:    3 [c1466cd0, 105] (not blocked)
s       desched/0:    4 [c1466680, 105] (not blocked)
s        events/0:    5 [c1466030,  98] (not blocked)
s         khelper:    6 [df687970, 111] (not blocked)
s         kthread:   11 [df687320, 110] (not blocked)
s          kacpid:   20 [df686cd0, 110] (not blocked)
s           IRQ 9:   21 [df686680,  51] (not blocked)
s       kblockd/0:  117 [c15d4680, 110] (not blocked)
s           khubd:  125 [c15e9320, 115] (not blocked)
s         pdflush:  226 [c15e8680, 117] (not blocked)
s         pdflush:  227 [c15e9970, 116] (not blocked)
s         kswapd0:  228 [c15d4030, 117] (not blocked)
s           aio/0:  229 [df686030, 112] (not blocked)
s           IRQ 8:  305 [df45c030,  52] (not blocked)
s         kseriod:  309 [df45c680, 117] (not blocked)
s          IRQ 12:  315 [df45ccd0,  53] (not blocked)
s          IRQ 14:  405 [df45d320,  54] (not blocked)
s          IRQ 15:  407 [df46b970,  55] (not blocked)
s        khpsbpkt:  420 [df46b320, 115] blocked on: [c04ddfc4] {khpsbpkt_sig.lock}
.. held by:          khpsbpkt:  420 [df46b320, 115]
... acquired at:  dma_trm_tasklet+0x89/0x1a0
s          IRQ 10:  430 [c15d5970,  56] (not blocked)
s     knodemgrd_0:  431 [c15e8cd0, 116] blocked on: [df49bba8] {&hi->reset_sem}
.. held by:       knodemgrd_0:  431 [c15e8cd0, 116]
... acquired at:  highlevel_host_reset+0x4b/0x60
s          IRQ 11:  433 [df45d970,  57] (not blocked)
s           IRQ 1:  451 [c15e8030,  58] (not blocked)
s        krxtimod:  481 [c15fd970, 118] (not blocked)
s          krxiod:  482 [c15d4cd0, 117] (not blocked)
s         krxsecd:  483 [c15fd320, 117] (not blocked)
s       kafstimod:  487 [c15d5320, 120] (not blocked)
s      kafsasyncd:  488 [df46a680, 120] (not blocked)
s      reiserfs/0:  489 [df46acd0, 111] (not blocked)
s           udevd:  580 [de854030, 113] (not blocked)
s           IRQ 6: 4119 [dde00030,  59] (not blocked)
s       ipw2200/0: 4284 [dde01320, 110] (not blocked)
s       syslog-ng: 7503 [dcb30cd0, 115] (not blocked)
s             gpm: 7629 [dcb26cd0, 117] (not blocked)
s         portmap: 8374 [c15fc680, 116] (not blocked)
s        rpciod/0: 8386 [deefb970, 111] (not blocked)
s           lockd: 8387 [dde00cd0, 117] (not blocked)
s            sshd: 8439 [ddbbc680, 120] (not blocked)
s            cron: 8481 [ddbbc030, 116] (not blocked)
s           login: 8502 [c15fccd0, 117] (not blocked)
s          agetty: 8503 [ddb8e680, 116] (not blocked)
s          agetty: 8504 [ddbbd970, 116] (not blocked)
s          agetty: 8505 [deefa680, 116] (not blocked)
s          agetty: 8506 [dcb31320, 116] (not blocked)
s          agetty: 8507 [ddbbccd0, 116] (not blocked)
s            bash: 8588 [de855970, 117] (not blocked)
s             kdm: 8653 [deefb320, 116] (not blocked)
?               X: 8656 [deefacd0, 116] (not blocked)
s             kdm: 8657 [c15fc030, 117] (not blocked)
s        startkde: 8681 [ddbbd320, 118] (not blocked)
s         kdeinit: 8714 [dde01970, 116] (not blocked)
s         kdeinit: 8717 [de854680, 115] (not blocked)
s         kdeinit: 8719 [dcb26030, 116] (not blocked)
s         kdeinit: 8722 [df46a030, 116] (not blocked)
s         kdeinit: 8731 [de855320, 116] (not blocked)
s         kdeinit: 8735 [ddb8f970, 115] (not blocked)
s        kwrapper: 8736 [dde00680, 116] (not blocked)
s         kdeinit: 8738 [ddb8ecd0, 116] (not blocked)
s         kdeinit: 8739 [deefa030, 116] (not blocked)
s         kdeinit: 8741 [dcb30030, 115] (not blocked)
s         kdeinit: 8743 [dcb27320, 115] (not blocked)
s         kdeinit: 8745 [dcb30680, 116] (not blocked)
s         kdeinit: 8746 [dcb27970, 116] (not blocked)
s         kdeinit: 8748 [dcb26680, 115] (not blocked)
s         kdeinit: 8752 [ddb8f320, 115] (not blocked)
s          korgac: 8753 [dcb31970, 116] (not blocked)
s         kalarmd: 8755 [d7398cd0, 119] (not blocked)
s         kdeinit: 8756 [ddb8e030, 116] (not blocked)
s            bash: 8757 [de854cd0, 117] (not blocked)
s         firefox: 8765 [d7399320, 117] (not blocked)
s     firefox-bin: 8778 [d7399970, 115] (not blocked)
s     firefox-bin: 8782 [d5c53970, 116] (not blocked)
s     firefox-bin: 8784 [d7398680, 116] (not blocked)
X         netstat: 8790 [d5c52cd0, 118] (not blocked)
s             ssh: 8811 [d5c53320, 117] (not blocked)
s            bash: 8812 [d5c52680, 117] (not blocked)
s            bash: 8820 [d5c52030, 117] (not blocked)
s            bash: 8828 [d7398030, 117] (not blocked)
s            bash: 8836 [d3161970, 117] (not blocked)
s            bash: 8844 [d3160cd0, 116] (not blocked)
s            bash: 8852 [d3161320, 116] (not blocked)
s            bash: 8860 [d3160680, 116] (not blocked)
s            bash: 8868 [d3160030, 116] (not blocked)
s             ssh: 8876 [d328d320, 117] (not blocked)
s             ssh: 8877 [d328c030, 117] (not blocked)
s            bash: 8880 [d328c680, 119] (not blocked)
s           jackd: 8881 [d328ccd0, 120] (not blocked)
s           jackd: 8882 [d328d970, 116] (not blocked)
s           jackd: 8883 [d1f6f970,   0] (not blocked)
s           jackd: 8884 [d1f6f320,   9] (not blocked)
s          qsynth: 8887 [d1f6ecd0, 116] (not blocked)
s          qsynth: 8888 [c8095970,  10] (not blocked)
?          qsynth: 8889 [c8095320, 116] (not blocked)
s       ksnapshot: 8890 [d1f6e030, 116] (not blocked)
s         ladccad: 8908 [c8094cd0, 116] (not blocked)
s         ladccad: 8910 [c8094680,  10] (not blocked)
s         ladccad: 8911 [d1f6e680, 116] (not blocked)
s         ladccad: 8912 [c5769970, 116] (not blocked)
s         ladccad: 8919 [c5769320, 116] (not blocked)
s         ladccad: 8920 [c5768cd0, 123] (not blocked)
s         ladccad: 8909 [c8094030, 120] (not blocked)
D      rosegarden: 8923 [c5768030, 116] blocked on: [c3f12418] {&q->lock}
.. held by:                 X: 8656 [deefacd0, 116]
... acquired at:  __wake_up+0x51/0x60
R rosegardenseque: 8924 [c5768680, 116] (not blocked)
s rosegardenseque: 8925 [c30af970, 115] (not blocked)
s rosegardenseque: 8926 [c30af320,  10] (not blocked)

---------------------------
| showing all locks held: |
---------------------------

#001:             [c062af2c] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#002:             [c062ab50] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#003:             [c062ad24] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#004:             [c062b574] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#005:             [c062b198] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#006:             [c062b36c] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#007:             [c062bbbc] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#008:             [c062b7e0] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#009:             [c062b9b4] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#010:             [c062c204] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#011:             [c062be28] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#012:             [c062bffc] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#013:             [c062c84c] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#014:             [c062c470] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#015:             [c062c644] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#016:             [c062ce94] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#017:             [c062cab8] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#018:             [c062cc8c] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#019:             [c062d4dc] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#020:             [c062d100] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#021:             [c062d2d4] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#022:             [c062db24] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#023:             [c062d748] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#024:             [c062d91c] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#025:             [c062e16c] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#026:             [c062dd90] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#027:             [c062df64] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#028:             [c062e7b4] {&hwif->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x9d/0x180

#029:             [c062e3d8] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#030:             [c062e5ac] {&drive->gendev_rel_sem}
.. held by:              init:    1 [c1467970, 116]
... acquired at:  init_hwif_data+0x16f/0x180

#031:             [ded6fcf0] {&tty->atomic_read}
.. held by:            agetty: 8503 [ddb8e680, 116]
... acquired at:  read_chan+0x477/0x7c0

#032:             [dedb9cf0] {&tty->atomic_read}
.. held by:            agetty: 8505 [deefa680, 116]
... acquired at:  read_chan+0x477/0x7c0

#033:             [dd710cf0] {&tty->atomic_read}
.. held by:            agetty: 8506 [dcb31320, 116]
... acquired at:  read_chan+0x477/0x7c0

#034:             [dca2acf0] {&tty->atomic_read}
.. held by:            agetty: 8507 [ddbbccd0, 116]
... acquired at:  read_chan+0x477/0x7c0

#035:             [dd3bfcf0] {&tty->atomic_read}
.. held by:            agetty: 8504 [ddbbd970, 116]
... acquired at:  read_chan+0x477/0x7c0

#036:             [c1773cf0] {&tty->atomic_read}
.. held by:              bash: 8588 [de855970, 117]
... acquired at:  read_chan+0x477/0x7c0

#037:             [d35decf0] {&tty->atomic_read}
.. held by:              bash: 8868 [d3160030, 116]
... acquired at:  read_chan+0x477/0x7c0

#038:             [d30c4cf0] {&tty->atomic_read}
.. held by:              bash: 8860 [d3160680, 116]
... acquired at:  read_chan+0x477/0x7c0

#039:             [d306fcf0] {&tty->atomic_read}
.. held by:              bash: 8852 [d3161320, 116]
... acquired at:  read_chan+0x477/0x7c0

#040:             [d3ba3cf0] {&tty->atomic_read}
.. held by:              bash: 8844 [d3160cd0, 116]
... acquired at:  read_chan+0x477/0x7c0

#041:             [c3f12418] {&q->lock}
.. held by:                 X: 8656 [deefacd0, 116]
... acquired at:  __wake_up+0x51/0x60

#042:             [c3f135d8] {&sk->sk_callback_lock}
.. held by:        rosegarden: 8923 [c5768030, 116]
... acquired at:  sock_def_readable+0x25/0xb0

#043:             [d125631c] {&q->lock}
.. held by:            qsynth: 8889 [c8095320, 116]
... acquired at:  __wake_up+0x51/0x60

#044:             [c04d63e0] {rtc_task_lock}
.. held by:             IRQ 8:  305 [df45c030,  52]
... acquired at:  rtc_interrupt+0x137/0x230

#045:             [df4f16f8] {&timer->lock}
.. held by:             IRQ 8:  305 [df45c030,  52]
... acquired at:  _snd_timer_stop+0x8f/0x180
=============================================

[ turning off deadlock detection. Please report this trace. ]


Regards,
Magnus M‰‰tt‰

-- 
Pushing 40 is exercise enough.
