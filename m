Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTFAS1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264698AbTFAS1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:27:08 -0400
Received: from populo.vip.fi ([213.173.130.25]:51284 "EHLO populo.vip.fi")
	by vger.kernel.org with ESMTP id S264696AbTFAS1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:27:04 -0400
Message-ID: <000e01c3286d$45c26560$0a9fadd5@vortex>
From: "Jouni Viikari" <jouni.viikari@vip.fi>
To: <linux-kernel@vger.kernel.org>
Subject: serial line and kernel hang (RH 2.4.20-13.9)
Date: Sun, 1 Jun 2003 21:40:27 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing kernel hangs on my linux box which seem to be serial line
related.  Previously stable server started to have 3-5 hangs per 24h after I
added another daemon which reads serial lines.  Currently I have
continuously six serial lines opened on my box..

The hangs seemed to stop when I started to use BLOCKING read(2) from serial
line instead of my previous strategy of opening serial line NONBLOCKing and
using select(2) to inform when line is readable and then using read in a
loop until '\n' is read or errno == EWOULDBLOCK.   This program receives
about 120 bytes every minute.

Hangs are total.  Nothing happens on server - even alt-sysrq-what_ever does
not do anything.

Today I got a hang again when restarting my program (named ekowell below).
This time I was able to use sysrq for a while and to write following down
from the console:

(I started two processes called 'ekowell' which daemonize themselves by
'forking and exiting'...)

alt-sysrq-t
===========
ekowell S D7927000 4 2765 1 2769 19142 (NOTLB)
Call Trace [<c0125e1d>] schedule timeout [kernel] 0xad (0xcfa05ee0))
[<c018782d>] read_chan [kernel] 0x28d (0xcfa05f18))
[<c0183885>] tty_read [kernel] 0xd5 (0xcfa05f74))
[<c0146f83>] sys_read [kernel] 0xa3 (0xcfa05f94))
[<c010953f>] system_call [kernel] 0x33 (0xcfa05fc0))

initlog S 00000292 8 2767 2759 2768  (NOTLB)
Call Trace: [<c0125dcd>] schedule_timeput [kernel] 0x5d (oxd89ebf64))
[<c0125d60>] process_timeout [kernel] 0x0 (0xd89ebf64))
[<c0125f03>] sys_nanosleep [kernel] 0xd3 (0xd89ebf84))
[<c010953f>] system_call [kernel] 0x33 (0xd89ebfc0))

ekowell 2 00000000 1360 2768 2767 (L-TLB)
Call Trace: [<c011fa2e>] do_exit [kernel] 0x26e (oxde943f94))
[<c011fb54>] do_group_exit [kernel] 0x54 (0xde943fb0))
[<c010953f>] system_call [kernel] 0x33 (0xde943fc0))

ekowell R CAE87FC4 0 2769 1 2770 2765 (NOTLB)
Call Trace: [<c01095ed>] reschedule [kernel] 0x5 (0xcae87fc0))

ekowell R current 0 2770 2769 (NOTLB)
Call Trace:

***********************************************************


Alt-SysRq-P
===========
Call Trace [<c0197364>] rs_interrupt [kernel] 0xc4 (0xd3c53ce8))
[<c010aac5>] handle_IRQ_event [kernel] 0x45 (0xd3c53d14))
[<c010aa64>] do_IRQ [kernel] 0x84 (0xd3c53d34))
[<c010d778>] call_do_IRQ [kernel] 0x5 (0xd3c53d54))
[<c010aab0>] handle_IRQ_event [kernel] 0x30 (0xd3c53d80))
[<c010ac64>] do_IRQ [kernel] 0x84 (0xd3c53da8))
[<c010d778>] call_do_IRQ [kernel] 0x5 (0xd3c53dc8))
[<c01217ee>] do_softirq [kernel] 0x3e (0xd3c53df4))
[<c010ac9e>] do_IRQ [kernel] 0xbe (0xd3c53e14))
[<c010d778>] call_do_IRQ [kernel] 0x5 (0xd3c53e34))
[<c0190068>] con_clear_unimap [kernel] 0x78 (0xd3c53e58))
[<c0196b2e>] serial_out [kernel] 0x1e (0xd3c53e60))
[<c0198769>] change_speed [kernel] 0x2c9 (0xd3c53e70))
[<c019a12f>] rs_set_termios [kernel] 0x3f (0xd3c53ea4))
[<c0188be9>] change_termios [kernel] 0x1a9 (0xd3c53ec8))
[<c0188d62>] set_termios [kernel] 0x112 (0xd3c53f14))
[<c0189172>] n_tty_ioctl [kernel] 0x1e2 (0xd3c53f48))
[<c0185597>] tty_ioctl [kernel] 0x2e7 (0xd3c53f64))
[<c0156919>] sys_ioctl [kernel] 0xc9 (0xd3c53f94))
[<c010953f>] system_call [kernel] 0x33 (0xd3c53fc0))

After typing the above, the system did not respond to magic keys anymore...

I have filed this bug on:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91307

Server is UP, 2.8 GHz P4, 512 MB, average load maybe 0.1 and CPU 95% idle.
Asus P4PE, and LavaPort-Quad PCI card for the extra serial lines.  Kernel
2.4.20-13.9

Best regards,

Jouni

