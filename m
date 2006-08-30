Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWH3I2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWH3I2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWH3I2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:28:13 -0400
Received: from ixion.tartarus.org ([82.211.108.121]:36620 "EHLO
	ixion.tartarus.org") by vger.kernel.org with ESMTP id S1751124AbWH3I2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:28:12 -0400
X-Mailer: Jed/Timber v0.2
From: Simon Tatham <anakin@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Magic SysRq SAK does nothing on serial consoles
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIME-Separator-Line"
Message-Id: <E1GILQi-0004QF-00@ixion.tartarus.org>
Date: Wed, 30 Aug 2006 09:28:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format. If your mailer does not
  support MIME, you may have trouble reading the attachments.

--MIME-Separator-Line
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: message body

The SAK subfunction of the `magic SysRq key' feature does not do
anything when invoked on a serial console. It should.

I am running Linux 2.6.17.6 on a Soekris net4501, which is a machine
with no graphics card and just a (normal 8250) serial port. I am
using the serial port as the kernel's console. I also have
CONFIG_MAGIC_SYSRQ enabled in my kernel configuration. When I
instruct my terminal to send a BREAK down the serial line and then
press Return, the kernel prints the SysRq menu, with one of the
options being `saK'. But if I send a BREAK and then press k, the
kernel prints `SysRq : SAK' and then does nothing further. No
processes are killed.

Investigation suggested that the problem might be that
sysrq_handle_SAK() in drivers/char/sysrq.c was not getting a tty
structure passed in, so that it did not know which tty to kill
processes associated with. So I traced the chain of calls leading to
that point, and ended up in include/linux/serial_core.h, where
uart_handle_sysrq_char() calls handle_sysrq() and does indeed pass
NULL as the third (struct tty *) parameter. The fix seemed simple:
instead of NULL it should pass the tty structure associated with the
serial port.

Applying the attached patch resolved the problem for me; now when I
send BREAK-k, the kernel prints `SysRq : SAK', then prints a couple
of lines indicating that some processes have been killed, and then
init spawns a new login process as I would expect.

(The patch is defensively coded, since I wasn't sure whether
port->info was guaranteeably non-NULL. If it is, the change can be
even simpler!)

This bug could be argued to have security implications. Suppose
somebody has written a program which imitates a login prompt, and
left it running on the serial port. I come along and send BREAK-k,
expecting it to kill any malicious programs and return me to a real
login prompt. The kernel prints `SysRq : SAK', indicating that it's
heard me and intends to perform the SAK function, and then I hit
Return and get what looks like a login prompt - but no processes
have been killed, so it's still the malicious imitation! I admit
that _now_ I wouldn't fall for this, since I've now seen the proper
SAK in action and I know that (a) it prints additional messages to
indicate what processes it's killing and (b) I would expect the
login prompt to return immediately afterwards without me having to
press Return; but I might have fallen for it if I'd tried this
before I knew there was a problem.

Some details of my hardware and software follow, as suggested in
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html . I
think this problem is simple enough that most of this should be
unnecessary, but here it is anyway just in case.

Output of linux-2.6.17.6/scripts/ver_linux, on the machine on which
I built the kernel (which is not the same machine I saw the problem
on, because the net4501 is too slow for me to want to build a kernel
on it at all):

| If some fields are empty or look unusual you may have an old version.
| Compare to the current minimal requirements in Documentation/Changes.
|
| Linux stormhawk 2.6.17.6 #11 Tue Aug 8 18:32:04 BST 2006 i686 GNU/Linux
|
| Gnu C                  3.3.5
| Gnu make               3.80
| binutils               2.15
| util-linux             2.12p
| mount                  2.12p
| module-init-tools      implemented
| e2fsprogs              1.37
| nfs-utils              1.0.6
| Linux C Library        2.3.2
| Dynamic linker (ldd)   2.3.2
| Procps                 3.2.1
| Net-tools              1.60
| Console-tools          0.2.3
| Sh-utils               5.2.1
| udev                   056
| Modules Loaded

Contents of /proc/cpuinfo on the machine which exhibits the problem:

| processor       : 0
| vendor_id       : AuthenticAMD
| cpu family      : 4
| model           : 15
| model name      : Am5x86-WB
| stepping        : 4
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 1
| wp              : yes
| flags           : fpu up
| bogomips        : 66.76

No kernel modules are loaded on the problem machine: /proc/modules
is completely empty.

Contents of /proc/ioports on the problem machine:

| 0000-001f : dma1
| 0020-0021 : pic1
| 0040-0043 : timer0
| 0050-0053 : timer1
| 0060-006f : keyboard
| 0070-0077 : rtc
| 0080-008f : dma page reg
| 00a0-00a1 : pic2
| 00c0-00df : dma2
| 00f0-00ff : fpu
| 01f0-01f7 : ide0
| 02f8-02ff : serial
| 03d4-03d5 : cga
| 03f6-03f6 : ide0
| 03f8-03ff : serial
| e000-e0ff : 0000:00:12.0
|   e000-e0ff : natsemi
| e100-e1ff : 0000:00:13.0
|   e100-e1ff : natsemi
| e200-e2ff : 0000:00:14.0
|   e200-e2ff : natsemi

Output of `lspci -vvv' on the problem machine:

| 0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] ELanSC520 Microcontroller
| 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
| 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
| 	Latency: 0
|
| 0000:00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
| 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 63 (2750ns min, 13000ns max)
| 	Interrupt: pin A routed to IRQ 10
| 	Region 0: I/O ports at e000 [size=256]
| 	Region 1: Memory at a0000000 (32-bit, non-prefetchable) [size=4K]
| 	Expansion ROM at 3f000000 [disabled] [size=64K]
| 	Capabilities: [40] Power Management version 2
| 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
| 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
|
| 0000:00:13.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
| 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 63 (2750ns min, 13000ns max)
| 	Interrupt: pin A routed to IRQ 11
| 	Region 0: I/O ports at e100 [size=256]
| 	Region 1: Memory at a0001000 (32-bit, non-prefetchable) [size=4K]
| 	Expansion ROM at 10000000 [disabled] [size=64K]
| 	Capabilities: [40] Power Management version 2
| 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
| 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
|
| 0000:00:14.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
| 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 63 (2750ns min, 13000ns max)
| 	Interrupt: pin A routed to IRQ 5
| 	Region 0: I/O ports at e200 [size=256]
| 	Region 1: Memory at a0002000 (32-bit, non-prefetchable) [size=4K]
| 	Expansion ROM at 10010000 [disabled] [size=64K]
| 	Capabilities: [40] Power Management version 2
| 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
| 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

There is no /proc/scsi at all on the problem machine.

I also attach /proc/config.gz from the problem machine, in case it
contains any other important clues.

Finally, I apologise for sending this to the central Linux kernel
address instead of a particular maintainer. I looked through the
MAINTAINERS file and found a variety of people responsible for
particular serial drivers, but couldn't find anyone specifically
responsible for general cross-driver serial functionality. I hope
this report can find its way to the right person.

Cheers,
Simon
-- 
Simon Tatham         "A defensive weapon is one with my finger on the
<anakin@pobox.com>    trigger. An offensive weapon is one with yours."

--MIME-Separator-Line
Content-Type: text/x-patch; name=linux-sak-serial.patch
Content-Transfer-Encoding: 7bit

--- linux-2.6.17.6.orig/include/linux/serial_core.h	2006-07-15 20:00:43.000000000 +0100
+++ linux-2.6.17.6/include/linux/serial_core.h	2006-08-30 07:55:00.000000000 +0100
@@ -411,7 +411,7 @@
 #ifdef SUPPORT_SYSRQ
 	if (port->sysrq) {
 		if (ch && time_before(jiffies, port->sysrq)) {
-			handle_sysrq(ch, regs, NULL);
+			handle_sysrq(ch, regs, port->info ? port->info->tty : NULL);
 			port->sysrq = 0;
 			return 1;
 		}

--MIME-Separator-Line
Content-Type: application/octet-stream; name=config.gz
Content-Transfer-Encoding: base64

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

--MIME-Separator-Line--
