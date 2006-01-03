Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWACPN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWACPN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWACPN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:13:59 -0500
Received: from mail.gmx.de ([213.165.64.21]:23472 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932392AbWACPN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:13:58 -0500
X-Authenticated: #4399952
Date: Tue, 3 Jan 2006 16:13:56 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
Message-ID: <20060103161356.4e1b47e0@mango.fruits.de>
In-Reply-To: <20060103153317.26a512fa@mango.fruits.de>
References: <20060103094720.GA16497@elte.hu>
	<20060103153317.26a512fa@mango.fruits.de>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 15:33:17 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> And indeed it does so for me. Thanks. The swapper BUG is still there,
> but i suppose that was expected?

Hi,

i rejoiced too early. It just took a while to show up:

==========================================
[ BUG: lock recursion deadlock detected! |
------------------------------------------
already locked:  [c0331b20] {rtc_task_lock}
.. held by:             IRQ 8:   18 [efd1ce90,   1]
... acquired at:               rtc_interrupt+0x79/0x130
-{current task's backtrace}----------------->
 [<c0130d07>] check_deadlock+0x307/0x340 (8)
 [<c02377e9>] rtc_interrupt+0x79/0x130 (8)
 [<c02d9b72>] __schedule+0x392/0x710 (4)
 [<c0238864>] rtc_control+0x24/0x80 (16)
 [<c0131af1>] task_blocks_on_lock+0x41/0x130 (12)
 [<c0238864>] rtc_control+0x24/0x80 (16)
 [<c02db2c8>] __down_mutex+0x498/0x910 (24)
 [<c0238864>] rtc_control+0x24/0x80 (16)
 [<c0238864>] rtc_control+0x24/0x80 (80)
 [<c0142380>] do_irqd+0x0/0xa0 (8)
 [<c02dd9e3>] _spin_lock_irq+0x23/0x50 (4)
 [<c0238864>] rtc_control+0x24/0x80 (8)
 [<c0238864>] rtc_control+0x24/0x80 (16)
 [<f09f70f9>] rtctimer_stop+0x29/0x60 [snd_rtctimer] (16)
 [<f081e20e>] snd_timer_interrupt+0x2ae/0x2f0 [snd_timer] (16)
 [<c0142380>] do_irqd+0x0/0xa0 (56)
 [<f09f7147>] rtctimer_interrupt+0x17/0x20 [snd_rtctimer] (4)
 [<c02377fc>] rtc_interrupt+0x8c/0x130 (12)
 [<c0141136>] handle_IRQ_event+0x76/0xf0 (20)
 [<c0142380>] do_irqd+0x0/0xa0 (44)
 [<c0142225>] thread_edge_irq+0x85/0x130 (4)
 [<c0142307>] do_hardirq+0x37/0xb0 (32)
 [<c01423e7>] do_irqd+0x67/0xa0 (16)
 [<c012c3e6>] kthread+0xb6/0xc0 (28)
 [<c012c330>] kthread+0x0/0xc0 (24)
 [<c0100ded>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c013949a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)
.. [<c013949a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)

showing all tasks:
S            init:    1 [c16fb500, 116] (not blocked)
S  softirq-high/0:    2 [c16fae10,   0] (not blocked)
S softirq-timer/0:    3 [c16fa720,   0] (not blocked)
S softirq-net-tx/:    4 [c16fa030,  98] (not blocked)
S softirq-net-rx/:    5 [c1709520,  98] (not blocked)
S  softirq-scsi/0:    6 [c1708e30,  98] (not blocked)
S softirq-tasklet:    7 [c1708740,  98] (not blocked)
S      watchdog/0:    8 [c1708050,   0] (not blocked)
S       desched/0:    9 [c1715540, 105] (not blocked)
S        events/0:   10 [c1714e50,  98] (not blocked)
S         khelper:   11 [c1714760, 110] (not blocked)
S         kthread:   12 [c1714070, 111] (not blocked)
S       kblockd/0:   13 [efcf9560, 110] (not blocked)
S         pdflush:   14 [efcf8e70, 125] (not blocked)
S         pdflush:   15 [efcf8780, 115] (not blocked)
S           aio/0:   17 [efd1d580, 120] (not blocked)
S         kswapd0:   16 [efcf8090, 125] (not blocked)
S           IRQ 8:   18 [efd1ce90,   1] (not blocked)
S         kseriod:   19 [efd1c7a0, 110] (not blocked)
S          IRQ 12:   20 [efd1c0b0,  51] (not blocked)
S          IRQ 14:   21 [efe235a0,  44] (not blocked)
S          IRQ 15:   22 [efe22eb0,  44] (not blocked)
S           IRQ 1:   23 [efe227c0,   0] (not blocked)
S       kjournald:   24 [efe220d0, 115] (not blocked)
S      kgameportd:  186 [ed9dd5e0, 111] (not blocked)
S           IRQ 4:  189 [ed211600,  17] (not blocked)
S           khubd:  209 [ed210f10, 110] (not blocked)
S           IRQ 5:  210 [edff40f0,  56] (not blocked)
S          IRQ 10:  211 [ed9dcef0,  89] (not blocked)
S       kjournald:  284 [edae3620, 115] (not blocked)
S       kjournald:  287 [ed210820, 119] (not blocked)
S       kjournald:  288 [ed210130, 119] (not blocked)
S       kjournald:  289 [edae2f30, 119] (not blocked)
S       kjournald:  290 [edae2840, 115] (not blocked)
S         portmap:  413 [edae2150, 116] (not blocked)
S         syslogd:  531 [edff47e0, 116] (not blocked)
S           klogd:  537 [edff4ed0, 116] (not blocked)
S            pppd:  547 [ec844860, 116] (not blocked)
S           pppoe:  551 [ed9dc110, 116] (not blocked)
S           IRQ 3:  554 [ec844170,  58] (not blocked)
S       automount:  649 [ec176880, 116] (not blocked)
S   dbus-daemon-1:  655 [ec177660, 115] (not blocked)
S            hald:  660 [ec844f50, 116] (not blocked)
S           exim4:  733 [ec2168a0, 116] (not blocked)
S             gpm:  741 [ec20f6a0, 115] (not blocked)
S            sshd:  753 [ec176f70, 118] (not blocked)
S             xfs:  762 [ec216f90, 116] (not blocked)
S            cron:  798 [ec217680, 116] (not blocked)
S     rt_watchdog:  854 [ec20e8c0,   1] (not blocked)
S     rt_watchdog:  855 [ec176190,  98] (not blocked)
S             gdm:  864 [ec2161b0, 115] (not blocked)
S             gdm:  865 [ec845640, 116] (not blocked)
S            Xorg:  875 [ec20efb0, 115] (not blocked)
S           getty:  886 [ed9dc800, 117] (not blocked)
S           getty:  887 [eb5aefd0, 117] (not blocked)
S           getty:  888 [eb5af6c0, 117] (not blocked)
S           getty:  889 [edff55c0, 117] (not blocked)
S           getty:  890 [ec20e1d0, 117] (not blocked)
S           getty:  891 [eb5ae8e0, 117] (not blocked)
S              sh:  930 [ea056ff0, 122] (not blocked)
S       ssh-agent: 1000 [ea0576e0, 116] (not blocked)
S       ssh-agent: 1001 [e8bad700, 116] (not blocked)
S              sh: 1005 [ea056900, 121] (not blocked)
S    xscreensaver: 1008 [ea056210, 115] (not blocked)
S   xfce4-session: 1010 [eb5ae1f0, 115] (not blocked)
S xfce-mcs-manage: 1015 [e8bad010, 115] (not blocked)
S           xfwm4: 1018 [e8bac230, 115] (not blocked)
S      xftaskbar4: 1020 [e7251720, 116] (not blocked)
S       xfdesktop: 1022 [e7251030, 116] (not blocked)
S     xfce4-panel: 1024 [e7250940, 115] (not blocked)
S         gkrellm: 1027 [e7250250, 115] (not blocked)
S       evolution: 1029 [e6657740, 116] (not blocked)
S       evolution: 1090 [e30bf090, 115] (not blocked)
S  sylpheed-claws: 1031 [e6657050, 115] (not blocked)
S            gaim: 1035 [e6656270, 115] (not blocked)
S            xmms: 1038 [e6f5b760, 115] (not blocked)
S            xmms: 1045 [e6f5b070, 115] (not blocked)
S            xmms: 1062 [e30be9a0, 115] (not blocked)
S        gconfd-2: 1057 [e8bac920, 116] (not blocked)
S bonobo-activati: 1065 [e6f5a290, 115] (not blocked)
S evolution-data-: 1077 [e108b7a0, 116] (not blocked)
S evolution-data-: 1082 [decc77c0, 116] (not blocked)
S evolution-data-: 1109 [decc69e0, 116] (not blocked)
S evolution-alarm: 1102 [e108a9c0, 116] (not blocked)
S evolution-alarm: 1103 [e108a2d0, 116] (not blocked)
S evolution-alarm: 1116 [dfa26a20, 122] (not blocked)
S           xterm: 1200 [dfa110f0, 116] (not blocked)
S            bash: 1201 [dfa117e0, 115] (not blocked)
S             ssh: 1223 [dfa10310, 116] (not blocked)
S        qjackctl: 1339 [dfa10a00, 115] (not blocked)
S        qjackctl: 2302 [dfefca40,  30] (not blocked)
S           xterm: 1351 [e30bf780, 115] (not blocked)
S            bash: 1352 [e6f5a980, 116] (not blocked)
R           xterm: 1368 [dfa27800, 116] (not blocked)
S            bash: 1369 [dfefd130, 116] (not blocked)
S            htop: 1480 [d14eaae0, 117] (not blocked)
S           xterm: 2206 [d94e1170, 116] (not blocked)
S            bash: 2207 [d94e1860, 115] (not blocked)
S           jackd: 2296 [d9a16a60, 121] (not blocked)
S           jackd: 2297 [e6656960, 116] (not blocked)
S           jackd: 2298 [d9a17840, 116] (not blocked)
S           jackd: 2299 [d9a16370,  19] (not blocked)
S           jackd: 2300 [dfefc350,  29] (not blocked)
S     firefox-bin: 3040 [d9a17150, 116] (not blocked)
S     firefox-bin: 3047 [d14eb1d0, 116] (not blocked)
S     firefox-bin: 3049 [dfefd820, 116] (not blocked)
S           xterm: 3193 [cf0ab520, 116] (not blocked)
S            bash: 3194 [e30be2b0, 116] (not blocked)
R     rosegarden4: 3416 [e108b0b0, 116] (not blocked)
S         kdeinit: 3418 [d14ea3f0, 116] (not blocked)
S      dcopserver: 3421 [cf0aa050, 115] (not blocked)
S       klauncher: 3423 [ce88c070, 115] (not blocked)
S            kded: 3425 [ce88d540, 116] (not blocked)
R rosegardenseque: 3429 [cf0aae30, 116] (not blocked)
S rosegardenseque: 3431 [decc70d0, 115] (not blocked)
S rosegardenseque: 3432 [cf0aa740,  30] (not blocked)

=============================================

[ turning off deadlock detection. Please report this trace. ]




-- 
Palimm Palimm!
http://tapas.affenbande.org
