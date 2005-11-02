Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVKBPKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVKBPKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVKBPKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:10:54 -0500
Received: from outgoing.smtp.agnat.pl ([193.239.44.83]:39173 "EHLO
	outgoing.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S965073AbVKBPKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:10:54 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: mxser driver in 2.6.14: kernel BUG at drivers/char/mxser.c:1004!
Date: Wed, 2 Nov 2005 16:10:41 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511021610.41900.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have MOXA CP-168U V2. setserial /dev/ttyM0-7 works fine. As soon as I try to 
do setserial /dev/ttyM8 (or higher) kernel hits BUG() in driver.

mxser_open is called, it sets tts->driver_data to something existing (added 
BUG() in mxser_open to check if info is valid)

        info = mxvar_table + line;
        if (!info)
                BUG();

        if (!info->base)
                return (-ENODEV);

        tty->driver_data = info;

but later
mxser_close() fails on second BUG() call

	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
[...]
        if (tty->index == MXSER_PORTS)
                return;
        printk("1\n");

        if (!info)
                BUG();



MOXA Smartio/Industio family driver version 1.8
Found MOXA CP-168U series board(BusNo=0,DevNo=9)
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 169
        ttyM0 - ttyM7  max. baud rate = 921600 bps.
mxser_open go1
1
------------[ cut here ]------------
kernel BUG at drivers/char/mxser.c:1006!
invalid operand: 0000 [#1]
Modules linked in: mxser ipv6 nfnetlink crc32c libcrc32c tsdev psmouse 8139too 
mii realtime ide_cd cdrom xfs exportfs ide_disk sis5513 ide_core
CPU:    0
EIP:    0060:[<dc9732ec>]    Not tainted VLI
EFLAGS: 00010246   (2.6.14-0.2)
EIP is at mxser_close+0x34c/0x360 [mxser]
eax: 00000002   ebx: 00000000   ecx: 00000000   edx: c030c66c
esi: 00000000   edi: d827f000   ebp: d8327de4   esp: d8327dc8
ds: 007b   es: 007b   ss: 0068
Process setserial (pid: 4267, threadinfo=d8326000 task=d82ad5c0)
Stack: dc9764c3 db66e120 00000000 d827f0d0 d827f000 00000000 db66e120 d8327e9c
       c020ea50 d827f000 db66e120 00000000 d8327e70 00000000 00000008 00000400
       dc97649f 00000000 00000000 00000296 c02122f0 00000011 00000246 c03181ac
Call Trace:
 [<c0103e1f>] show_stack+0x7f/0xa0
 [<c0103fb9>] show_registers+0x159/0x1c0
 [<c010418e>] die+0xce/0x170
 [<c02c2f6e>] do_trap+0xae/0xb0
 [<c0104569>] do_invalid_op+0xb9/0xd0
 [<c0103aeb>] error_code+0x4f/0x54
 [<c020ea50>] release_dev+0x6d0/0x6e0
 [<c020eb95>] tty_open+0x135/0x2d0
 [<c016403b>] chrdev_open+0x9b/0x140
 [<c015a18a>] __dentry_open+0x10a/0x1b0
 [<c015a2a4>] filp_open+0x74/0x90
 [<c015a487>] do_sys_open+0x57/0xf0
 [<c015a53f>] sys_open+0x1f/0x30
 [<c0102f83>] sysenter_past_esp+0x54/0x75
Code: 58 83 f8 01 0f 84 5a fd ff ff 89 44 24 04 c7 04 24 80 68 97 dc e8 55 8c 
7a e3 b8 01 00 00 00 c7 43 58 01 00 00 00 e9 39 fd ff ff <0f> 0b ee 03 ae 64 
97 dc e9 d9 fc ff ff 8d b4 26 00 00 00 00 55

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
