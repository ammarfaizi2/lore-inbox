Return-Path: <linux-kernel-owner+w=401wt.eu-S1030493AbXALVBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXALVBK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbXALVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:01:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49828 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030499AbXALVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:01:08 -0500
Message-ID: <45A7F70E.80507@us.ibm.com>
Date: Fri, 12 Jan 2007 13:01:02 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] NMI watchdog lockups caused by mwait_idle
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkatesh,

I have an IBM IntelliStation Z30 with two Dempsey CPUs.  When I try to
boot 2.6.20-rc4 on it, the system prints messages about NMI watchdog
lockups.  git-bisect determined that the patch "[PATCH] x86-64: Fix
interrupt race in idle callback (3rd try)" was the source of these
problems, and I can work around the problem either by passing
"idle=poll" to get avoid mwait_idle or by reverting the patch.

Other non-Dempsey Xeon machines with mwait support do not exhibit these
symptoms.  I will try to determine if this is a bug specific to Dempsey
CPUs or this particular type of machine.  I suspect the latter, but I
don't know enough about monitor/mwait to pursue this much further.

What else can I do to diagnose this?

--D

-----------------

[   81.794792] Parsing all Control Methods:
[   81.798710] Table [SSDT](id 002F) - 5 Objects with 0 Devices 2 Methods 0 Regions
[   81.806410] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   81.815967] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   81.821837] ACPI: Processor [CPU0] (supports 8 throttling states)
[   81.831290] Parsing all Control Methods:
[   81.835283] Table [SSDT](id 0032) - 3 Objects with 0 Devices 2 Methods 0 Regions
[   81.842988] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   87.276183] NMI Watchdog detected LOCKUP on CPU 3
[   87.280944] CPU 3 
[   87.283081] Modules linked in: processor fan unix
[   87.288109] Pid: 0, comm: swapper Not tainted 2.6.20-rc4-dic64 #0
[   87.294253] RIP: 0010:[<ffffffff80149c75>]  [<ffffffff80149c75>] cpu_idle+0x61/0xc7
[   87.302039] RSP: 0018:ffff8100059ebed8  EFLAGS: 00000086
[   87.307398] RAX: 00000000ffffffff RBX: ffffffff88015daf RCX: ffffffff80156564
[   87.314574] RDX: ffff8100059ebec8 RSI: 0000000000000002 RDI: 0000000000000001
[   87.321760] RBP: ffff8100059ebee8 R08: 0000000000000001 R09: 0000000000000001
[   87.328942] R10: ffffffff80160cff R11: 0000000000000246 R12: fffffffffffffff7
[   87.336125] R13: 0000000000000040 R14: 0000000000000246 R15: 0000000000000000
[   87.343309] FS:  0000000000000000(0000) GS:ffff8100059970a0(0000) knlGS:0000000000000000
[   87.351453] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   87.357249] CR2: 0000000000602148 CR3: 0000000000101000 CR4: 00000000000006e0
[   87.364435] Process swapper (pid: 0, threadinfo ffff8100059ea000, task ffff8100059a7040)
[   87.372577] Stack:  ffff8100059ebee8 ffff8100052a5600 ffff8100059ebf48 ffffffff80174dc2
[   87.380966]  0000000000000000 ffffffff80502e38 ffffffff80503038 000000000000037d
[   87.388684]  00000000000006e8 0000000000000000 0000000000000000 0000000000000000
[   87.396148] Call Trace:
[   87.398896]  [<ffffffff80174dc2>] start_secondary+0x46f/0x47e
[   87.404695] 
[   87.406245] 
[   87.406247] Code: 75 25 e8 dc 06 04 00 0f 09 0f ae f0 65 48 8b 14 25 08 00 00 
[   87.416355]  <3>BUG: sleeping function called from invalid context at /home/djwong/linux-2.6.20-rc4-dic94xx/kernel/rwsem.c:20
[   87.427809] in_atomic():1, irqs_disabled():0
[   87.432130] no locks held by swapper/0.
[   87.436015] 
[   87.436017] Call Trace:
[   87.440072]  <NMI>  [<ffffffff8019f84e>] debug_show_held_locks+0x9/0xb
[   87.446718]  [<ffffffff8010ba32>] __might_sleep+0xc6/0xc8
[   87.452170]  [<ffffffff8019da22>] down_read+0x1d/0x45
[   87.457276]  [<ffffffff8019556d>] blocking_notifier_call_chain+0x1b/0x41
[   87.464029]  [<ffffffff8018cabc>] profile_task_exit+0x15/0x17
[   87.469824]  [<ffffffff80114b87>] do_exit+0x25/0x870
[   87.474844]  [<ffffffff801646ff>] oops_end+0x42/0x62
[   87.479863]  [<ffffffff80164a05>] sync_regs+0x0/0x71
[   87.484883]  [<ffffffff801650ac>] nmi_watchdog_tick+0x156/0x240
[   87.490856]  [<ffffffff80164c07>] default_do_nmi+0x81/0x1c6
[   87.496480]  [<ffffffff801651c2>] do_nmi+0x2c/0x40
[   87.501326]  [<ffffffff801645ef>] nmi+0x7f/0x90
[   87.505920]  [<ffffffff88015daf>] :processor:acpi_processor_idle+0x0/0x4ad
[   87.512852]  [<ffffffff80160cff>] __sched_text_start+0xa7f/0xaba
[   87.518905]  [<ffffffff80156564>] mwait_idle+0x47/0x4c
[   87.524097]  [<ffffffff80149c75>] cpu_idle+0x61/0xc7
[   87.529116]  <<EOE>>  [<ffffffff80174dc2>] start_secondary+0x46f/0x47e
[   87.535770] 
[   87.537315] Kernel panic - not syncing: Attempted to kill the idle task!
[   87.537315] Kernel panic - not syncing: Attempted to kill the idle task!
[   87.544064]  NMI Watchdog detected LOCKUP on CPU 2
[   92.609986] CPU 2 
[   92.612110] Modules linked in: processor fan unix
[   92.617096] Pid: 0, comm: swapper Not tainted 2.6.20-rc4-dic64 #0
[   92.623230] RIP: 0010:[<ffffffff80149ca9>]  [<ffffffff80149ca9>] cpu_idle+0x95/0xc7
[   92.630998] RSP: 0018:ffff8100059b9ed8  EFLAGS: 00000046
[   92.636358] RAX: 0000000000000000 RBX: ffffffff88015daf RCX: ffffffff80156564
[   92.643533] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
[   92.650708] RBP: ffff8100059b9ee8 R08: 0000000000000001 R09: 0000000000000001
[   92.657883] R10: ffffffff80166fbd R11: 0000000000000070 R12: ffffffffffffffe6
[   92.665057] R13: 0000000000000040 R14: 0000000000000246 R15: 0000000000000000
[   92.672233] FS:  0000000000000000(0000) GS:ffff810005997858(0000) knlGS:0000000000000000
[   92.680368] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   92.686156] CR2: 000000000060c270 CR3: 0000000000101000 CR4: 00000000000006e0
[   92.693334] Process swapper (pid: 0, threadinfo ffff8100059b8000, task ffff81000599c080)
[   92.701467] Stack:  ffff8100059b9ee8 ffff81000529b100 ffff8100059b9f48 ffffffff80174dc2
[   92.709813]  0000000000000000 ffffffff80502e30 ffffffff80503030 00000000000002d8
[   92.717490]  000000000000057c 0000000000000000 0000000000000000 0000000000000000
[   92.724926] Call Trace:
[   92.727668]  [<ffffffff80174dc2>] start_secondary+0x46f/0x47e
[   92.733457] 
[   92.735000] 
[   92.735000] Code: 65 48 8b 04 25 10 00 00 00 8b 80 38 e0 ff ff a8 08 0f 84 6f 
[   92.745073]  NMI Watchdog detected LOCKUP on CPU 7
[   98.269459] CPU 7 
[   98.271582] Modules linked in: processor fan unix
[   98.276578] Pid: 0, comm: swapper Not tainted 2.6.20-rc4-dic64 #0
[   98.282719] RIP: 0010:[<ffffffff80149c50>]  [<ffffffff80149c50>] cpu_idle+0x3c/0xc7
[   98.290487] RSP: 0018:ffff8100bf8f7ed8  EFLAGS: 00000046
[   98.295846] RAX: ffff8100052ce400 RBX: ffffffff88015daf RCX: ffffffff80156564
[   98.303023] RDX: ffff810084d78200 RSI: 0000000000000002 RDI: 0000000000000001
[   98.310207] RBP: ffff8100bf8f7ee8 R08: 0000000000000001 R09: 0000000000000001
[   98.317392] R10: ffffffff80166fbd R11: ffff8100052d0fe0 R12: ffffffffffffffc8
[   98.324573] R13: 0000000000000040 R14: 0000000000000246 R15: 0000000000000000
[   98.331748] FS:  0000000000000000(0000) GS:ffff8100bf82ee48(0000) knlGS:0000000000000000
[   98.339893] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   98.345689] CR2: 000000000043d360 CR3: 0000000000101000 CR4: 00000000000006e0
[   98.352866] Process swapper (pid: 0, threadinfo ffff8100bf8f6000, task ffff8100bf8d6080)
[   98.361007] Stack:  ffff8100bf8f7ee8 ffff8100052cea00 ffff8100bf8f7f48 ffffffff80174dc2
[   98.369396]  0000000000000000 ffffffff80502e58 ffffffff80503058 0000000000000398
[   98.377108]  00000000000006c1 0000000000000000 0000000000000000 0000000000000000
[   98.384579] Call Trace:
[   98.387326]  [<ffffffff80174dc2>] start_secondary+0x46f/0x47e
[   98.393117] 
[   98.394660] 
[   98.394661] Code: 48 8b 1d b1 03 42 00 48 c7 c0 1b a6 16 80 48 85 db 48 0f 44 

(repeat until the machine reboots)
