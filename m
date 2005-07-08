Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVGHIBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVGHIBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVGHIBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:01:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5851 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262101AbVGHIBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:01:06 -0400
Date: Fri, 8 Jul 2005 10:00:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
Message-ID: <20050708080056.GA31381@elte.hu>
References: <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu> <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain> <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707175115.GA28772@elte.hu> <Pine.LNX.4.63.0507071402410.6952@ghostwheel.llnl.gov> <20050708054129.GA26208@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708054129.GA26208@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> tried it and cannot reproduce it, so i'll need the full backtrace of 
> all tasks in your system, whenever sox gets stuck, via:

managed to reproduce it via your script - and with RT_DEADLOCK_DETECT 
turned on the circular deadlock was immediately detected (see the trace 
below). It turns out this is an upstream locking bug in the sound 
subsystem, which has been fixed already - i've merged the upstream fix 
to -51-14. Could you check whether sox works for you now?

	Ingo

============================================
[ BUG: circular locking deadlock detected! ]
--------------------------------------------
sox/1828 is deadlocking current task sox/1824


1) sox/1824 is trying to acquire this lock:
 [cf073eac] {(struct semaphore *)(&card->power_lock)}
.. held by:               sox: 1828 [c901f9d0, 119]
... acquired at:          snd_pcm_prepare+0x22/0x6d
... trying at:            snd_pcm_drain+0x187/0x3a2

2) sox/1828 is blocked on this lock:
 [c04e4240] {snd_pcm_link_rwsem.lock}
.. held by:               sox: 1824 [ca3fc9d0, 115]
... acquired at:  snd_pcm_drain+0x37/0x3a2
------------------------------
| showing all locks held by: |  (sox/1824 [ca3fc9d0, 115]):
------------------------------

#001:             [c04e4240] {snd_pcm_link_rwsem.lock}
... acquired at:          snd_pcm_drain+0x37/0x3a2

------------------------------
| showing all locks held by: |  (sox/1828 [c901f9d0, 119]):
------------------------------

#001:             [cf073eac] {(struct semaphore *)(&card->power_lock)}
... acquired at:          snd_pcm_prepare+0x22/0x6d


sox/1828's [blocked] stackdump:

c9038d98 00000082 c05ae8cc c05ae420 0000000a 00000000 c9038dec 00000000 
       c9ac89d0 00011080 926e71c9 00000029 c9ac89d0 c901f9d0 c901faf8 c9038000 
       00000000 c9eef000 c9038db4 c0441321 c013c236 c9038db4 c013e9ab c9038000 
Call Trace:
 [<c0441321>] schedule+0x47/0x124 (28)
 [<c044289c>] __down+0x2f5/0x653 (108)
 [<c04433fc>] rt_down_read+0x26/0x2e (16)
 [<c030273f>] snd_pcm_action_nonatomic+0x21/0x83 (36)
 [<c0303263>] snd_pcm_prepare+0x5a/0x6d (32)
 [<c0305869>] snd_pcm_playback_ioctl1+0x4c/0x2a1 (68)
 [<c0305db9>] snd_pcm_kernel_playback_ioctl+0x36/0x40 (28)
 [<c0312953>] snd_pcm_oss_prepare+0x2a/0x5b (24)
 [<c03129bd>] snd_pcm_oss_make_ready+0x39/0x58 (20)
 [<c0313572>] snd_pcm_oss_sync+0x37/0x2b0 (64)
 [<c017dc2d>] do_ioctl+0x7d/0x8c (36)
 [<c017ddc4>] vfs_ioctl+0x61/0x1c2 (40)
 [<c017df96>] sys_ioctl+0x71/0x7f (40)
 [<c01030e8>] sysenter_past_esp+0x61/0x89 (-4020)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013e852>] .... add_preempt_count+0x1a/0x1c
.....[<c0440c1f>] ..   ( <= __schedule+0x4f/0x70a)
.. [<c013e852>] .... add_preempt_count+0x1a/0x1c
.....[<c0440cb1>] ..   ( <= __schedule+0xe1/0x70a)

------------------------------
| showing all locks held by: |  (sox/1828 [c901f9d0, 119]):
------------------------------

#001:             [cf073eac] {(struct semaphore *)(&card->power_lock)}
... acquired at:         snd_pcm_prepare+0x22/0x6d


sox/1824's [current] stackdump:

 [<c0104082>] dump_stack+0x1f/0x21 (20)
 [<c0138206>] check_deadlock+0x20f/0x32e (48)
 [<c0138f7c>] task_blocks_on_lock+0x3a/0xe1 (44)
 [<c04427ee>] __down+0x247/0x653 (108)
 [<c013af13>] rt_down+0x29/0x45d (44)
 [<c030352d>] snd_pcm_drain+0x187/0x3a2 (96)
 [<c0305869>] snd_pcm_playback_ioctl1+0x4c/0x2a1 (68)
 [<c0305db9>] snd_pcm_kernel_playback_ioctl+0x36/0x40 (28)
 [<c031361a>] snd_pcm_oss_sync+0xdf/0x2b0 (64)
 [<c0314b25>] snd_pcm_oss_release+0x2b/0xd8 (28)
 [<c016b511>] __fput+0x13d/0x181 (36)
 [<c0169d43>] filp_close+0x4f/0x83 (28)
 [<c0169ddd>] sys_close+0x66/0x81 (32)
 [<c01030e8>] sysenter_past_esp+0x61/0x89 (-4020)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013e852>] .... add_preempt_count+0x1a/0x1c
.....[<c013f969>] ..   ( <= print_traces+0x1b/0x50)

------------------------------
| showing all locks held by: |  (sox/1824 [ca3fc9d0, 116]):
------------------------------

#001:             [c04e4240] {snd_pcm_link_rwsem.lock}
... acquired at:  snd_pcm_drain+0x37/0x3a2


showing all tasks:
S            init:    1 [cff1c9d0, 116] (not blocked)
S  softirq-high/0:    2 [cff209d0, 110] (not blocked)
S softirq-timer/0:    3 [cff249d0, 105] (not blocked)
S softirq-net-tx/:    4 [cff289d0, 110] (not blocked)
S softirq-net-rx/:    5 [cff2c9d0, 105] (not blocked)
S  softirq-scsi/0:    6 [cff309d0, 110] (not blocked)
S softirq-tasklet:    7 [cff349d0, 105] (not blocked)
S       desched/0:    8 [cff389d0, 105] (not blocked)
S      watchdog/0:    9 [cff3c9d0,   0] (not blocked)
S        events/0:   10 [cff5d9d0,  98] (not blocked)
S         khelper:   11 [cff619d0, 111] (not blocked)
S         kthread:   12 [cfe789d0, 110] (not blocked)
S       kblockd/0:   14 [cfea39d0, 110] (not blocked)
S           khubd:   17 [cfa039d0, 125] (not blocked)
S         pdflush:  133 [cfa0e9d0, 120] (not blocked)
S         pdflush:  134 [cf4929d0, 115] (not blocked)
S           aio/0:  136 [cf4a29d0, 112] (not blocked)
S         kswapd0:  135 [cf4969d0, 125] (not blocked)
S           IRQ 8:  207 [cf54e9d0,  50] (not blocked)
S          IRQ 12:  217 [cf6c49d0,  51] (not blocked)
S         kseriod:  214 [cf69f9d0, 115] (not blocked)
S          IRQ 14:  255 [cf6d89d0,  52] (not blocked)
S          IRQ 15:  257 [cf7149d0,  53] (not blocked)
S           IRQ 1:  279 [cf0849d0,  54] (not blocked)
S          IRQ 17:  297 [cf0b29d0,  55] (not blocked)
S       kjournald:  336 [cf16e9d0, 115] (not blocked)
S           udevd: 1055 [ceb7c9d0, 110] (not blocked)
S          IRQ 16: 1230 [ce1199d0,  56] (not blocked)
S         syslogd: 1284 [ceba39d0, 117] (not blocked)
S           klogd: 1286 [cf0d39d0, 116] (not blocked)
S            sshd: 1306 [ce7759d0, 116] (not blocked)
S             gpm: 1316 [ce7fc9d0, 115] (not blocked)
S           crond: 1404 [ce4b89d0, 118] (not blocked)
S             xfs: 1428 [ce75e9d0, 118] (not blocked)
S             atd: 1443 [ce4949d0, 119] (not blocked)
S     dbus-daemon: 1451 [ce9dc9d0, 116] (not blocked)
S     dbus-daemon: 1452 [ce1a59d0, 121] (not blocked)
S        mingetty: 1532 [cda6f9d0, 118] (not blocked)
S        mingetty: 1533 [caaf29d0, 116] (not blocked)
S        mingetty: 1534 [ce9af9d0, 119] (not blocked)
S        mingetty: 1548 [caa979d0, 120] (not blocked)
S        mingetty: 1549 [ca2d89d0, 121] (not blocked)
S        mingetty: 1582 [c9e449d0, 120] (not blocked)
S            sshd: 1605 [ca3149d0, 116] (not blocked)
S            sshd: 1701 [c9e2b9d0, 116] (not blocked)
S            bash: 1722 [ca2729d0, 116] (not blocked)
S              su: 1792 [ceb1c9d0, 117] (not blocked)
S            bash: 1793 [c9e019d0, 116] (not blocked)
R            bash: 1809 [ca3d89d0, 119] (not blocked)
S            play: 1811 [ca8269d0, 117] (not blocked)
S            play: 1813 [c9e159d0, 118] (not blocked)
R            play: 1815 [ca2ea9d0, 118] (not blocked)
R            play: 1817 [c9ac89d0, 118] (not blocked)
S            play: 1819 [caa319d0, 122] (not blocked)
S            play: 1821 [ca08a9d0, 123] (not blocked)
D             sox: 1824 [ca3fc9d0, 116] (not blocked)
D             sox: 1828 [c901f9d0, 119] blocked on: [c04e4240] {snd_pcm_link_rwsem.lock}
.. held by:               sox: 1824 [ca3fc9d0, 116]
... acquired at:  snd_pcm_drain+0x37/0x3a2
R             sox: 1832 [ca0d79d0, 125] (not blocked)
D            bash: 1833 [c9c389d0, 120] blocked on: [c04cb004] {kernel_sem.lock}
.. held by:              play: 1817 [c9ac89d0, 118]
... acquired at:  lock_kernel+0x25/0x38
S             sox: 1835 [c96669d0, 118] blocked on: [c9efbcd0] {(struct semaphore *)(&tty->atomic_write)}
.. held by:              bash: 1809 [ca3d89d0, 119]
... acquired at:  tty_write+0xb6/0x20d
D            play: 1837 [c9b749d0, 120] blocked on: [c04cb004] {kernel_sem.lock}
.. held by:              play: 1817 [c9ac89d0, 118]
... acquired at:  lock_kernel+0x25/0x38
R            bash: 1839 [c9b819d0, 121] (not blocked)

---------------------------
| showing all locks held: |
---------------------------

#001:             [c07aaa80] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#002:             [c07aa6ac] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#003:             [c07aa87c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#004:             [c07ab0c0] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#005:             [c07aacec] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#006:             [c07aaebc] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#007:             [c07ab700] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#008:             [c07ab32c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#009:             [c07ab4fc] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#010:             [c07abd40] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#011:             [c07ab96c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#012:             [c07abb3c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#013:             [c07ac380] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#014:             [c07abfac] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#015:             [c07ac17c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#016:             [c07ac9c0] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#017:             [c07ac5ec] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#018:             [c07ac7bc] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#019:             [c07ad000] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#020:             [c07acc2c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#021:             [c07acdfc] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#022:             [c07ad640] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#023:             [c07ad26c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#024:             [c07ad43c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#025:             [c07adc80] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#026:             [c07ad8ac] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#027:             [c07ada7c] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#028:             [c07ae2c0] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x93/0x162

#029:             [c07adeec] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#030:             [c07ae0bc] {(struct semaphore *)(&drive->gendev_rel_sem)}
.. held by:              init:    1 [cff1c9d0, 116]
... acquired at:  init_hwif_data+0x151/0x162

#031:             [ceb0bc98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1532 [cda6f9d0, 118]
... acquired at:  read_chan+0x3d2/0x632

#032:             [c9ac9c98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1533 [caaf29d0, 116]
... acquired at:  read_chan+0x3d2/0x632

#033:             [cba8cc98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1534 [ce9af9d0, 119]
... acquired at:  read_chan+0x3d2/0x632

#034:             [c9ed3c98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1548 [caa979d0, 120]
... acquired at:  read_chan+0x3d2/0x632

#035:             [c9f02c98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1582 [c9e449d0, 120]
... acquired at:  read_chan+0x3d2/0x632

#036:             [cba50c98] {(struct semaphore *)(&tty->atomic_read)}
.. held by:          mingetty: 1549 [ca2d89d0, 121]
... acquired at:  read_chan+0x3d2/0x632

#037:             [c04e4240] {snd_pcm_link_rwsem.lock}
.. held by:               sox: 1824 [ca3fc9d0, 117]
... acquired at:  snd_pcm_drain+0x37/0x3a2

#038:             [cf073eac] {(struct semaphore *)(&card->power_lock)}
.. held by:               sox: 1828 [c901f9d0, 119]
... acquired at:  snd_pcm_prepare+0x22/0x6d

#039:             [c9efbcd0] {(struct semaphore *)(&tty->atomic_write)}
.. held by:              bash: 1809 [ca3d89d0, 119]
... acquired at:  tty_write+0xb6/0x20d

#040:             [c04cb004] {kernel_sem.lock}
.. held by:              play: 1817 [c9ac89d0, 118]
... acquired at:  lock_kernel+0x25/0x38

#041:             [c0565a00] {tasklist_lock}
.. held by:               sox: 1824 [ca3fc9d0, 117]
... acquired at:  _read_trylock+0x13/0x15

=============================================

[ turning off deadlock detection. Please report this trace. ]

