Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbUJZBuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUJZBuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUJZBsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:48:01 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262009AbUJZBVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:21:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=quxHRFeoAfyKy3vfD1sR4eFJOkYdL8oGxM/K/qmzfFmv6BL0kMQpASx2hbwptlemIFV+QyCVOcntirq11CHBaG8puWyqDR22XGW4P3fQNeuQWDhqc4cofuwiRGtR61ynREBwJivWd143WjfomZHN2mbCX5rzSmjw9paaJ8LsaBk=
Message-ID: <a99a678a041025161160e25452@mail.gmail.com>
Date: Mon, 25 Oct 2004 19:11:04 -0400
From: George Glover <hyperborean@gmail.com>
Reply-To: George Glover <hyperborean@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 Oops in tcp_time_to_recover + 0x6d/0x1b0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've had this happen twice now with mostly the same Oops message. 
Maybe a third time, however the screen was blanked.  They occur at the
very same instruction pointer, and from the mprime process context.

Unable to handle kernel NULL pointer dereference at virtual address 00000050
printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMT SMP
Modules link in: sbp2 ohci1394 ieee1394
CPU: 1
EIP: 0060:[<c032c97d>] Not tainted : VLI
EFLAGS: 00210246 (2.6.9)
EIP is at tcp_time_to_recover+0x6d/0x1b0
eax: 19eeb26a  ebx: cc2d97f0  ecx: 00000001 edx: 00000000
esi: 00000006  edi: cc2d9600  ebp: 0000003 esp: c04c2d3c
ds: 007b  es: 007b  ss: 0068
Process mprime (pid: 2845, threadinfo=c04c2000 task=ee66a310)
Stack: cc2d97f0 00000000 00000000 00000003 c032d62f 00200002 c74fc00c 0000000
e2fca91c 00000000 00000006 00000003 a5861ecc cc2d9600 00000002 cc2d97f0
a58628d8 00000006 c032ea24 00000006 0000000 00000000 00200292 00000001
Call Trace:
Stack pointer is garbage, not printing trace
Code: 01 00 00 00 39 cd 0f 8f 00 01 00 00 8b 8b 98 00 00 00 85 c9 74 24 8b 57 64
0d 47 64 39 c2 b8 00 00 00 00 0f 44 d0 a1 e0 84 3e c0 <2b> 42 50 3b 83 94 00 00
00 0f 87 d5 00 00 00 89 f2 0f b6 c2 39


There may be numerous typos since it's typed from a poor digital camera image.

The code disassmbles to:
c032c951:       b9 01 00 00 00          mov    $0x1,%ecx
c032c956:       39 c2                   cmp    %eax,%edx
c032c958:       0f 8f 08 01 00 00       jg     c032ca66
<tcp_time_to_recover+0x156>
c032c95e:       8b 8b 98 00 00 00       mov    0x98(%ebx),%ecx
c032c964:       85 c9                   test   %ecx,%ecx
c032c966:       74 24                   je     c032c98c
<tcp_time_to_recover+0x7c>
c032c968:       8b 57 64                mov    0x64(%edi),%edx
c032c96b:       8d 47 64                lea    0x64(%edi),%eax
c032c96e:       39 c2                   cmp    %eax,%edx
c032c970:       b8 00 00 00 00          mov    $0x0,%eax
c032c975:       0f 44 d0                cmove  %eax,%edx
c032c978:       a1 e0 84 3e c0          mov    0xc03e84e0,%eax
c032c97d:       2b 42 50                sub    0x50(%edx),%eax  <-- Oops is here
c032c980:       3b 83 94 00 00 00       cmp    0x94(%ebx),%eax
c032c986:       0f 87 d5 00 00 00       ja     c032ca61
<tcp_time_to_recover+0x151>
c032c98c:       89 f2                   mov    %esi,%edx
c032c98e:       0f b6 c2                movzbl %dl,%eax
c032c991:       39 c1                   cmp    %eax,%ecx

Punching in the addresses I see on the stack gives a back trace of:
tcp_time_to_recover
tcp_fastretrans_alert
tcp_ack

gcc version 3.3.4
Hardware is a dual 1.2Ghz Athlon MP with 768MB of register ecc

lspci:
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 20)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010
Ultra3 SCSI Adapter (rev 01)
00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010
Ultra3 SCSI Adapter (rev 01)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07)
02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
02:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
02:06.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394
Controller (Link)
02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)


Hope any of this helps,

George
