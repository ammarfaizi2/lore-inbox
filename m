Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVGYTGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVGYTGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVGYTEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:04:30 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:1191 "EHLO smtp15.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261431AbVGYTCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:02:23 -0400
X-ME-UUID: 20050725190218956.E97817000081@mwinf1504.wanadoo.fr
Message-ID: <25583653.1122318138931.JavaMail.www@wwinf1533>
From: Renaud LAURENCE <laurenaud@wanadoo.fr>
Reply-To: laurenaud@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: mm/slab.c bug on dual core amd ?
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.48.49.25]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-REPLYTO: |~|
Date: Mon, 25 Jul 2005 21:02:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"seems" there is a bug on "cache free" on dual core

i got problem on my linux dual core workstation. it seems to only appen when i use on dual core (smp enable) and with heavy load (well only in compile). i got 3 type problems, each time it append randonly on certain compilation (e.g. gcc, mozilla, open_ssl,xfree):
 - the compiler seems to be lock, one (and only one at a time, it change but only one) do "something" (lot of cpu usage) but it do no do anything
 - i got on dmesg "general protection rip" on various programmes (sed, grep, rm most of the time) and the compile halt with divers error (for exemple no a programe). i never (for now) have this on single processor (work)
 - a "swap error corrupted" (don't remenberd the exact word sorry)

i try a lot of kernel and option (various 2.6.12 and 2.6.13 rc and mm), with smp i got error. i got NO error with 2 x mprime test (9 hours) nor mem86 test (9 hour) nor in no smp mode. windows xp seems to work ok.

the last time i use a lot of kernel debug, the workstation become realy unstable (it sometime lock) but i could have this (with mozilla and lynx) :

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/slab.c":1934
invalid operand: 0000 [4] SMP
CPU 1
Modules linked in: i2c_dev it87 i2c_sensor i2c_isa uhci_hcd ehci_hcd parport_pc parport ohci1394 ieee1394 snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ak4114 snd_pcm snd_timer snd_page_alloc snd_ak4xxx_adda snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth ohci_hcd i2c_nforce2 i2c_core usbcore
Pid: 32305, comm: mozilla-bin Not tainted 2.6.13-rc3-opteron-v2
RIP: 0010:[<ffffffff80162ebc>] <ffffffff80162ebc>{cache_free_debugcheck+444}
RSP: 0018:ffff81003a799bc8  EFLAGS: 00010087
RAX: fff378ff3c944421 RBX: 0000000000000818 RCX: 0000000000052c00
RDX: fffffffffffffcb2 RSI: 0000000000000818 RDI: 65642f2e2e223d66
RBP: ffff81007ffed300 R08: 0000000000000033 R09: 0000000000000007
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81007e29a530
R13: ffff81007e29a500 R14: ffffffff8038efd9 R15: ffff81006ed8c198
FS:  0000000040800960(0063) GS:ffffffff80617880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000d9f000 CR3: 0000000030e8f000 CR4: 00000000000006e0
Process mozilla-bin (pid: 32305, threadinfo ffff81003a798000, task ffff8100404f71f0)
Stack: ffff810002c2a910 ffff81007ffed300 ffff81007e29a538 ffff81006ed8c590
       0000000000000a88 ffffffff80163b63 ffff81006e470528 0000000000000282
       ffff81006e470528 ffff81006e470528
Call Trace:<ffffffff80163b63>{kfree+147} <ffffffff8038efd9>{kfree_skbmem+9}
       <ffffffff803b2677>{tcp_recvmsg+1703} <ffffffff8038e013>{sock_common_recvmsg+51}
       <ffffffff8038a429>{sock_recvmsg+249} <ffffffff8012e995>{activate_task+149}
       <ffffffff8012f1be>{try_to_wake_up+830} <ffffffff80408109>{thread_return+89}
       <ffffffff8014b2e0>{autoremove_wake_function+0} <ffffffff8038a00a>{sockfd_lookup+26}
       <ffffffff8038b93c>{sys_recvfrom+220} <ffffffff8018fe23>{poll_freewait+67}       <ffffffff80190ae6>{sys_poll+806} <ffffffff8018fe30>{__pollwait+0}
       <ffffffff8010dc66>{system_call+126}

Code: 0f 0b ad d6 42 80 ff ff ff ff 8e 07 0f af c6 48 8d 04 07 4c
RIP <ffffffff80162ebc>{cache_free_debugcheck+444} RSP <ffff81003a799bc8>

-----------------------------
-----------------------------

slab error in cache_free_debugcheck(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff8015f817>{cache_free_debugcheck+295} <ffffffff80160553>{kfree+147}
       <ffffffff80387e79>{kfree_skbmem+9} <ffffffff803ab4b7>{tcp_recvmsg+1703}
       <ffffffff80386eb3>{sock_common_recvmsg+51} <ffffffff80383329>{sock_recvmsg+249}
       <ffffffff8012e955>{activate_task+149} <ffffffff80401009>{thread_return+89}
       <ffffffff8014b0d0>{autoremove_wake_function+0} <ffffffff80382f0a>{sockfd_lookup+26}
       <ffffffff8038483c>{sys_recvfrom+220} <ffffffff8018cc13>{poll_freewait+67}       <ffffffff8018d8c4>{sys_poll+804} <ffffffff8018cc20>{__pollwait+0}
       <ffffffff8010dc66>{system_call+126}
ffff81007cef0530: redzone 1: 0x37c390d10b723821, redzone 2: 0x170fc2a5.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/slab.c":1934
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: it87 i2c_sensor i2c_isa uhci_hcd ehci_hcd ohci1394 ieee1394 snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ak4114 snd_pcm snd_timer snd_page_alloc snd_ak4xxx_adda snd_mpu401_uart snd_rawmidi snd_seq_device snd usb_storage forcedeth ohci_hcd i2c_nforce2 i2c_core usbcore
Pid: 11253, comm: mozilla-bin Not tainted 2.6.13-rc3-x2-t2
RIP: 0010:[<ffffffff8015f8ac>] <ffffffff8015f8ac>{cache_free_debugcheck+444}
RSP: 0018:ffff8100714edbc8  EFLAGS: 00010013
RAX: fff83f44d22aa7af RBX: 0000000000000818 RCX: 0000000000052c00
RDX: fffffffffffff82d RSI: 0000000000000818 RDI: 3ebf6bfb73b1dc9b
RBP: ffff81007ffed300 R08: 0000000000000033 R09: 0000000000000007
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81007cef0530
R13: ffff81007cef0500 R14: ffffffff80387e79 R15: ffff81006f448d98
FS:  0000000040800960(0063) GS:ffffffff80598880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaae989244 CR3: 00000000731b2000 CR4: 00000000000006e0
Process mozilla-bin (pid: 11253, threadinfo ffff8100714ec000, task ffff81007329d810)
Stack: ffff810002c2a910 ffff81007ffed300 ffff81007cef0538 ffff81006f449190
       0000000000000a88 ffffffff80160553 ffff81007d354ed8 0000000000000282
       ffff81007d354ed8 ffff81007d354ed8
Call Trace:<ffffffff80160553>{kfree+147} <ffffffff80387e79>{kfree_skbmem+9}
       <ffffffff803ab4b7>{tcp_recvmsg+1703} <ffffffff80386eb3>{sock_common_recvmsg+51}
       <ffffffff80383329>{sock_recvmsg+249} <ffffffff8012e955>{activate_task+149}
       <ffffffff80401009>{thread_return+89} <ffffffff8014b0d0>{autoremove_wake_function+0}
       <ffffffff80382f0a>{sockfd_lookup+26} <ffffffff8038483c>{sys_recvfrom+220}       <ffffffff8018cc13>{poll_freewait+67} <ffffffff8018d8c4>{sys_poll+804}
       <ffffffff8018cc20>{__pollwait+0} <ffffffff8010dc66>{system_call+126}


Code: 0f 0b fd 59 42 80 ff ff ff ff 8e 07 0f af c6 48 8d 04 07 4c
RIP <ffffffff8015f8ac>{cache_free_debugcheck+444} RSP <ffff8100714edbc8>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/slab.c":1934
invalid operand: 0000 [2] SMP
CPU 1
Modules linked in: it87 i2c_sensor i2c_isa uhci_hcd ehci_hcd ohci1394 ieee1394 snd_ice1724 snd_ice17xx_ak4xxx snd_ac97_codec snd_ak4114 snd_pcm snd_timer snd_page_alloc snd_ak4xxx_adda snd_mpu401_uart snd_rawmidi snd_seq_device snd usb_storage forcedeth ohci_hcd i2c_nforce2 i2c_core usbcore
Pid: 11279, comm: lynx Not tainted 2.6.13-rc3-x2-t2
RIP: 0010:[<ffffffff8015f8ac>] <ffffffff8015f8ac>{cache_free_debugcheck+444}
RSP: 0018:ffff81006e5b7c38  EFLAGS: 00010097
RAX: fff167b14029448b RBX: 0000000000000818 RCX: 0000000000052c00
RDX: ffffffffffffff4c RSI: 0000000000000818 RDI: 76203e612f3c6574
RBP: ffff81007ffed300 R08: 0000000000000000 R09: 0000000000000578
R10: ffffffff805144a0 R11: 0000000000000246 R12: ffff81007d3f29c8
R13: ffff81007d3f2180 R14: ffffffff80387e79 R15: ffff81006f4487f8
FS:  00002aaaab4cd6d0(0000) GS:ffffffff80598880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000741000 CR3: 000000007180c000 CR4: 00000000000006e0
Process lynx (pid: 11279, threadinfo ffff81006e5b6000, task ffff81007fd44270)
Stack: ffff810002c2a910 ffff81007ffed300 ffff81007d3f29d0 ffff81006f448bf0
       000000000000046c ffffffff80160553 ffff81007d274af8 0000000000000282
       ffff81007d274af8 ffff81007d274af8
Call Trace:<ffffffff80160553>{kfree+147} <ffffffff80387e79>{kfree_skbmem+9}
       <ffffffff803ab4b7>{tcp_recvmsg+1703} <ffffffff80386eb3>{sock_common_recvmsg+51}
       <ffffffff803834c5>{sock_aio_read+277} <ffffffff80178f63>{do_sync_read+211}
       <ffffffff8015f176>{poison_obj+70} <ffffffff8015f935>{cache_free_debugcheck+581}
       <ffffffff8014b0d0>{autoremove_wake_function+0} <ffffffff8018d55e>{sys_select+1038}
       <ffffffff80179078>{vfs_read+216} <ffffffff80179403>{sys_read+83}
       <ffffffff8010dc66>{system_call+126}

Code: 0f 0b fd 59 42 80 ff ff ff ff 8e 07 0f af c6 48 8d 04 07 4c
RIP <ffffffff8015f8ac>{cache_free_debugcheck+444} RSP <ffff81006e5b7c38>

i too got this with mcelog another time (not with the same config):

MCE 0
CPU 0 0 data cache from boot or resume
ADDR 84000085 
       bit57 = processor context corrupt
       bit59 = misc error valid
       bit61 = error uncorrected
STATUS ae4300000000f066 MCGSTATUS 0
MCE 1
CPU 0 1 instruction cache from boot or resume
  Instruction cache ECC error
       bit32 = err cpu0
       bit33 = err cpu1
       bit35 = res3
       bit39 = res7
       bit40 = error found by scrub
       bit41 = res9
       bit43 = res11
       bit44 = res12
       bit45 = uncorrected ecc error
       bit46 = corrected ecc error
       bit55 = res23
       bit56 = res24
       bit59 = misc error valid
       bit61 = error uncorrected
       bit62 = error overflow (multiple errors)
STATUS f9e1fbcbfdd3fbfa MCGSTATUS 0
MCE 2
CPU 0 2 bus unit from boot or resume
ADDR 170aa0ddcf 
  Bus or cache array error
       bit57 = processor context corrupt
       bit62 = error overflow (multiple errors)
  memory/cache error 'snoop mem transaction, generic transaction, level 2'
STATUS c60000000000018a MCGSTATUS 0
MCE 3
CPU 0 3 load/store unit from boot or resume
ADDR 6000002011 
       bit59 = misc error valid
       bit61 = error uncorrected
STATUS bc0000000000e2f4 MCGSTATUS 0
MCE 0
CPU 0 0 data cache from boot or resume
ADDR a6009001 
       bit57 = processor context corrupt
       bit59 = misc error valid
       bit61 = error uncorrected
STATUS ae4100000000f066 MCGSTATUS 0
MCE 1
CPU 0 1 instruction cache from boot or resume
  Instruction cache ECC error
       bit32 = err cpu0
       bit33 = err cpu1
       bit35 = res3
       bit39 = res7
       bit40 = error found by scrub
       bit41 = res9
       bit43 = res11
       bit44 = res12
       bit45 = uncorrected ecc error
       bit46 = corrected ecc error
       bit55 = res23
       bit56 = res24
       bit59 = misc error valid
       bit61 = error uncorrected
       bit62 = error overflow (multiple errors)
STATUS f9f7fbdbfdf7fbfa MCGSTATUS 0
MCE 2
CPU 0 2 bus unit from boot or resume
ADDR 166880ddcf 
  Bus or cache array error
       bit57 = processor context corrupt
       bit62 = error overflow (multiple errors)
STATUS c600000000000082 MCGSTATUS 0
MCE 3
CPU 0 3 load/store unit from boot or resume
ADDR 6000a02010 
       bit59 = misc error valid
       bit61 = error uncorrected
STATUS bc0000000000a2f4 MCGSTATUS 0

may be you can do something with it. i'm not pretty sure i don't have a buggy bios (version 'o' on a shuttle sn25p) or other problems (hardware or other) but i think it make sence if these is a bug on cache-free (a bad lock/synchro ?) since i only got error on compile with lot of file (like xfree or gcc); not on mprime95 who intensly use the two cpu, not on mem86.

