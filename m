Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUKBXWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUKBXWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUKBXOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:14:15 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:10111 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262708AbUKBXIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:08:41 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Wed, 3 Nov 2004 00:09:52 +0100
User-Agent: KMail/1.6.2
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
References: <1099227269.1459.45.camel@krustophenia.net> <1099324040.3337.32.camel@thomas> <20041102150634.GA24871@elte.hu>
In-Reply-To: <20041102150634.GA24871@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_APBiBv0YwDXJdKB"
Message-Id: <200411030009.53343.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_APBiBv0YwDXJdKB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag 02 November 2004 16:06 schrieb Ingo Molnar:
> i've uploaded a fixed kernel (-V0.6.8) to:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> (this kernel also has the module-put-unlock-kernel fix that should solve
> the other warning reported by Thomas and Bill.)
>
> 	Ingo

Fixed a deadlock in snd-es1968 with attached patch.

Just for information, the error messages on V0.6.9 were:
===============================================
[ BUG: semaphore recursion deadlock detected! |
-----------------------------------------------
already locked:  [c91ea080] {r:0,a:-1,&chip->reg_lock}
.. held by:            insmod/ 3185 [cf6c2750, 118]
... acquired at:  es1968_measure_clock+0x3b6/0x640 [snd_es1968]

------------------------------
| showing all locks held by: |  (insmod/3185 [cf6c2750, 118]):
------------------------------

#001:             [c036a4ec] {r:0,a:-1,&s->rwsem}
... acquired at:  bus_add_driver+0x8a/0xc0

#002:             [c91ea080] {r:0,a:-1,&chip->reg_lock}
... acquired at:  es1968_measure_clock+0x3b6/0x640 [snd_es1968]

-{current task's backtrace}----------------->
 [<c0107923>] dump_stack+0x23/0x30 (20)
 [<c01bae36>] check_deadlock+0x276/0x2a0 (44)
 [<c01bb455>] task_blocks_on_sem+0x195/0x1d0 (56)
 [<c02de4d3>] down_write_mutex+0x283/0x3c0 (88)
 [<c0134bc4>] __mutex_lock+0x44/0x60 (24)
 [<c0134c8d>] _mutex_lock_irqsave+0x1d/0x30 (16)
 [<d099266e>] snd_es1968_bob_start+0xbe/0x160 [snd_es1968] (44)
 [<d0994a1a>] es1968_measure_clock+0x3ca/0x640 [snd_es1968] (72)
 [<d0996318>] snd_es1968_probe+0x1f8/0x340 [snd_es1968] (60)
 [<c01ca5b2>] pci_device_probe_static+0x52/0x70 (28)
 [<c01ca60d>] __pci_device_probe+0x3d/0x50 (24)
 [<c01ca651>] pci_device_probe+0x31/0x50 (24)
 [<c021c1b5>] bus_match+0x45/0x80 (28)
 [<c021c31c>] driver_attach+0x6c/0xb0 (36)
 [<c021c802>] bus_add_driver+0x92/0xc0 (36)
 [<c01ca969>] pci_register_driver+0x99/0xc0 (36)
 [<d0861017>] alsa_card_es1968_init+0x17/0x1b [snd_es1968] (12)
 [<c013ab29>] sys_init_module+0x169/0x220 (28)
 [<c01072ed>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02de604>] .... down_write_mutex+0x3b4/0x3c0
.....[<c0134bc4>] ..   ( <= __mutex_lock+0x44/0x60)
.. [<c01368dd>] .... print_traces+0x1d/0x60
.....[<c0107923>] ..   ( <= dump_stack+0x23/0x30)


showing all tasks:
s            init/    1 [c1271370, 116] (not blocked)
s     ksoftirqd/0/    2 [c1270d00, 105] (not blocked)
s       desched/0/    3 [c1270690, 105] (not blocked)
s        events/0/    4 [c1270020,  98] (not blocked)
s         khelper/    5 [cff27390, 105] (not blocked)
s         kthread/   10 [cff26d20, 105] (not blocked)
s          kacpid/   18 [cff266b0, 105] (not blocked)
s           IRQ 9/   19 [cff26040,  50] (not blocked)
s       kblockd/0/   86 [cfec93b0, 105] (not blocked)
s           khubd/   94 [cfec8d40, 115] (not blocked)
s         pdflush/  141 [cfec86d0, 120] (not blocked)
s         pdflush/  142 [cfec8060, 116] (not blocked)
s           aio/0/  144 [c1304d60, 110] (not blocked)
s         kswapd0/  143 [c13053d0, 125] (not blocked)
s           IRQ 8/  732 [c13046f0,  56] (not blocked)
s          IRQ 12/  740 [c13cf3f0,  54] (not blocked)
s           IRQ 6/  753 [c13ced80,  51] (not blocked)
s         kseriod/  734 [c1304080, 124] (not blocked)
s          IRQ 14/  776 [c13ce710,  53] (not blocked)
s          IRQ 15/  778 [c13ce0a0,  52] (not blocked)
s           IRQ 1/  796 [c13fd410,  55] (not blocked)
s       kjournald/  838 [c13fc730, 116] (not blocked)
s         portmap/ 2013 [c13fcda0, 116] (not blocked)
s            sshd/ 2074 [ceac2970, 124] (not blocked)
s             xfs/ 2343 [ceed03e0, 119] (not blocked)
s           IRQ 5/ 2411 [cefa6220, 106] (not blocked)
s        mingetty/ 2485 [ce88a8d0, 118] (not blocked)
s        mingetty/ 2498 [cebfa5a0, 118] (not blocked)
s        mingetty/ 2499 [ce6298b0, 118] (not blocked)
s        mingetty/ 2500 [cebfb280, 118] (not blocked)
s        mingetty/ 2501 [cea8afc0, 122] (not blocked)
s        mingetty/ 2610 [cebfb8f0, 122] (not blocked)
s             kdm/ 2611 [ce88b5b0, 117] (not blocked)
s               X/ 2698 [ce628bd0, 115] (not blocked)
s             kdm/ 2699 [cf6c2dc0, 121] (not blocked)
s          IRQ 11/ 2792 [ceac2fe0,  57] (not blocked)
s        startkde/ 2796 [ceac2300, 117] (not blocked)
s       ssh-agent/ 2855 [cea8a950, 116] (not blocked)
s         kdeinit/ 2889 [cddd8c30, 117] (not blocked)
s         kdeinit/ 2892 [cefa7570, 116] (not blocked)
s         kdeinit/ 2894 [cea8a2e0, 116] (not blocked)
s         kdeinit/ 2897 [ce88af40, 115] (not blocked)
s         kdeinit/ 2908 [ce88a260, 116] (not blocked)
s         kdeinit/ 2982 [ceed10c0, 117] (not blocked)
s        kwrapper/ 2985 [ceed1730, 116] (not blocked)
s         kdeinit/ 2987 [ceed0a50, 115] (not blocked)
s         kdeinit/ 2989 [cddd85c0, 116] (not blocked)
s         kdeinit/ 2993 [ce629240, 116] (not blocked)
s         kdeinit/ 2995 [cebfac10, 116] (not blocked)
s         kdeinit/ 2997 [cefa6890, 116] (not blocked)
s         kdeinit/ 3004 [c13fc0c0, 116] (not blocked)
s         kdeinit/ 3007 [ce628560, 116] (not blocked)
s         kdeinit/ 3009 [cddd9910, 116] (not blocked)
s         kdeinit/ 3011 [cf6c20e0, 116] (not blocked)
s            bash/ 3080 [cddd92a0, 117] (not blocked)
s              su/ 3136 [cefa6f00, 119] (not blocked)
s            bash/ 3139 [cea8b630, 118] (not blocked)
R          insmod/ 3185 [cf6c2750, 118] (not blocked)

---------------------------
| showing all locks held: |
---------------------------

#001:             [c04445c0] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#002:             [c04441b8] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#003:             [c04443a0] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#004:             [c0444c64] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#005:             [c044485c] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#006:             [c0444a44] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#007:             [c0445308] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#008:             [c0444f00] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#009:             [c04450e8] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#010:             [c04459ac] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#011:             [c04455a4] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#012:             [c044578c] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#013:             [c0446050] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#014:             [c0445c48] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#015:             [c0445e30] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#016:             [c04466f4] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#017:             [c04462ec] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#018:             [c04464d4] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#019:             [c0446d98] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#020:             [c0446990] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#021:             [c0446b78] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#022:             [c044743c] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#023:             [c0447034] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#024:             [c044721c] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#025:             [c0447ae0] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#026:             [c04476d8] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#027:             [c04478c0] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#028:             [c0448184] {r:0,a:-1,&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x9d/0x190

#029:             [c0447d7c] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#030:             [c0447f64] {r:0,a:-1,&drive->gendev_rel_sem}
.. held by:              init/    1 [c1271370, 116]
... acquired at:  init_hwif_data+0x172/0x190

#031:             [cfc24d20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2485 [ce88a8d0, 118]
... acquired at:  read_chan+0x716/0x770

#032:             [cf624d20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2499 [ce6298b0, 118]
... acquired at:  read_chan+0x716/0x770

#033:             [cefe2d20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2498 [cebfa5a0, 118]
... acquired at:  read_chan+0x716/0x770

#034:             [ce0bcd20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2500 [cebfb280, 118]
... acquired at:  read_chan+0x716/0x770

#035:             [cfb26d20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2610 [cebfb8f0, 122]
... acquired at:  read_chan+0x716/0x770

#036:             [cfb2bd20] {r:0,a:-1,&tty->atomic_read}
.. held by:          mingetty/ 2501 [cea8afc0, 122]
... acquired at:  read_chan+0x716/0x770

#037:             [c036a4ec] {r:0,a:-1,&s->rwsem}
.. held by:            insmod/ 3185 [cf6c2750, 118]
... acquired at:  bus_add_driver+0x8a/0xc0

#038:             [c91ea080] {r:0,a:-1,&chip->reg_lock}
.. held by:            insmod/ 3185 [cf6c2750, 118]
... acquired at:  es1968_measure_clock+0x3b6/0x640 [snd_es1968]

#039:             [c032d360] {r:0,a:-1,tasklist_lock}
.. held by:            insmod/ 3185 [cf6c2750, 118]
... acquired at:  show_all_locks+0x30/0x130
=============================================

[ turning off deadlock detection. Please report this trace. ]

Karsten

--Boundary-00=_APBiBv0YwDXJdKB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="snd-es1968.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-es1968.patch"

--- sound/pci/es1968.c~	2004-11-02 23:51:56.504888304 +0100
+++ sound/pci/es1968.c	2004-11-02 23:51:12.375596976 +0100
@@ -837,23 +837,19 @@
 static void snd_es1968_bob_stop(es1968_t *chip)
 {
 	u16 reg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	reg = __maestro_read(chip, 0x11);
 	reg &= ~ESM_BOB_ENABLE;
 	__maestro_write(chip, 0x11, reg);
 	reg = __maestro_read(chip, 0x17);
 	reg &= ~ESM_BOB_START;
 	__maestro_write(chip, 0x17, reg);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 static void snd_es1968_bob_start(es1968_t *chip)
 {
 	int prescale;
 	int divide;
-	unsigned long flags;
 
 	/* compute ideal interrupt frequency for buffer size & play rate */
 	/* first, find best prescaler value to match freq */
@@ -882,13 +878,11 @@
 	} else if (divide > 1)
 		divide--;
 
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	__maestro_write(chip, 6, 0x9000 | (prescale << 5) | divide);	/* set reg */
 
 	/* Now set IDR 11/17 */
 	__maestro_write(chip, 0x11, __maestro_read(chip, 0x11) | 1);
 	__maestro_write(chip, 0x17, __maestro_read(chip, 0x17) | 1);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 /* call with substream spinlock */

--Boundary-00=_APBiBv0YwDXJdKB--
