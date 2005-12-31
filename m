Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVLaRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVLaRPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVLaRPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:15:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11726 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965027AbVLaRPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:15:47 -0500
Date: Sat, 31 Dec 2005 18:15:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rc7-rt1
In-Reply-To: <20051228172643.GA26741@elte.hu>
Message-ID: <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
References: <20051228172643.GA26741@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


>i have released the 2.6.15-rc7-rt1 tree, which can be downloaded from 
>the usual place:
>[...]
>Please re-report any bugs that remain.
>
This happened upon starting mplayer for the first time:

BUG at include/linux/timer.h:83!
------------[ cut here ]------------
kernel BUG at include/linux/timer.h:83!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: thermal processor fan button battery ac af_packet pcmcia
firmware_class yenta_socket rsrc_nonstatic pcmcia_core rtc psmouse 8139too mii
crc32
CPU:    0
EIP:    0060:[<df111b02>]    Not tainted VLI
EFLAGS: 00010286   (2.6.15-rc7-rt1)
EIP is at rtc_do_ioctl+0x8a2/0x8e0 [rtc]
eax: 00000024   ebx: df1125f4   ecx: ddd8e000   edx: 00000000
esi: 00000053   edi: c038e070   ebp: dbafbf54   esp: dbafbed4
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mplayer (pid: 1728, threadinfo=dbafa000 task=de7a1100 stack_left=7840
worst_left=-1)
Stack: df11260a df1125f4 00000053 00000000 dded230c dbafbef8 da98a080 dded230c
       c0167640 00200246 c015d42a de6e7620 dd9c6264 00000000 dc7a0b2c da98a080
       dbafbf3c dd4d9000 dbafbf30 c015d6c5 da98a080 00000000 00008000 dbafbf88
Call Trace:
 [<c0104036>] show_stack+0xa6/0xe0 (32)
 [<c01041fe>] show_registers+0x16e/0x220 (56)
 [<c010443d>] die+0xdd/0x170 (56)
 [<c010454e>] do_trap+0x7e/0xe0 (28)
 [<c0104837>] do_invalid_op+0x97/0xb0 (180)
 [<c0103cc3>] error_code+0x4f/0x54 (188)
 [<df111b4f>] rtc_ioctl+0xf/0x20 [rtc] (8)
 [<c0170e68>] do_ioctl+0x78/0x90 (28)
 [<c0171017>] vfs_ioctl+0x57/0x1f0 (32)
 [<c01711e9>] sys_ioctl+0x39/0x60 (28)
 [<c01031b5>] syscall_call+0x7/0xb (-8116)
Code: 00 e9 30 ff ff ff e8 fe d7 19 e1 eb 8c be 53 00 00 00 bb f4 25 11 df 89
74 24 08 89 5c 24 04 c7 04 24 0a 26 11 df e8 de 9c 00 e1 <0f> 0b 53 00 f4 25 11
df e9 73 ff ff ff e8 cc d7 19 e1 e9 63 f9
 Segmentation fault

This looks like it's due to some timer - mplayer opens /dev/rtc if you want 
to know. A second invocation of mplayer went fine, I guess due to 
/dev/rtc still having a refcount of >0 and therefore not able to be opened 
again.

AFA-IIRC this did not happen with (my own portage of) 2.6.15-rc5-rt4 into 
2.6.15-rc7 (on the very day that rc7 was released).
If you need config.gz/.config or other info, please let me know.


I also notice that mplayer uses approximately a lot more CPU, as shown in 
top when CONFIG_HIGH_RES_TIMERS=y. That is, without highres timers, mplayer 
uses less than 1%, with hrt it's somewhere between 10% and 18%.
I practically just ran the decoding routine:
  `mplayer -ao null sometrack.ogg`.



Jan Engelhardt
-- 
