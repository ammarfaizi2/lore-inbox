Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVAETeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVAETeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVAETeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:34:08 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:31496 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261734AbVAETdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:33:53 -0500
X-Ironport-AV: i="3.88,102,1102312800"; 
   d="scan'208"; a="157768386:sNHT77462682"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Date: Wed, 5 Jan 2005 13:33:51 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D2B@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Thread-Index: AcTzXXR6kDNn2VcnQX+vOLd1kBTcfw==
From: <Tim_T_Murphy@Dell.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jan 2005 19:33:52.0678 (UTC) FILETIME=[7CEF4460:01C4F35D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My app is receiving incomplete/corrupted reponse packets from the DRAC4 (using serial + DRAC4's virtual uart), but only when packet size > 512.  The app receives smaller responses properly.  The problem doesn't occur with a 2.4 kernel/serial driver (same h/w).

examining the corrupt message contents, a group of bytes is missing exactly at offset 512 in the message buffer.  Additional message bytes follow the gap, but the receiver's checksum doesn't match the sender's, so the whole message is dropped by the app.

I enabled debugging in 8250.c and serial_core.c.  Booting the 2.6 kernel, the log shows:

Jan  5 12:04:21 racrhel4 syslogd 1.4.1: restart.
Jan  5 12:04:21 racrhel4 syslog: syslogd startup succeeded
Jan  5 12:04:21 racrhel4 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jan  5 12:04:21 racrhel4 kernel: Linux version 2.6.10-bk8 (root@racrhel4) (gcc version 3.4.1 20040831 (Red Hat 3.4.1-10)) #1 SMP Wed Jan 5 11:36:57 CST 2005
	<snip>
Jan  5 12:04:30 racrhel4 kernel: ttyS0: autoconf (0x03f8, 0x00000000): iir=3 type=NS16550A
Jan  5 12:04:30 racrhel4 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Jan  5 12:04:30 racrhel4 kernel: ttyS1: autoconf (0x02f8, 0x00000000): IER test failed (ff, ff) type=unknown
Jan  5 12:04:30 racrhel4 kernel: ttyS2: autoconf (0x03e8, 0x00000000): IER test failed (ff, ff) type=unknown
Jan  5 12:04:30 racrhel4 kernel: ttyS3: autoconf (0x02e8, 0x00000000): IER test failed (ff, ff) type=unknown
Jan  5 12:04:30 racrhel4 kernel: ACPI: PCI interrupt 0000:0b:05.1[B] -> GSI 21 (level, low) -> IRQ 169
Jan  5 12:04:30 racrhel4 kernel: ttyS4: autoconf (0xbc80, 0x00000000): iir=3 iir1=6 iir2=6 type=16550A
Jan  5 12:04:30 racrhel4 kernel: ttyS4 at I/O 0xbc80 (irq = 169) is a 16550A
Jan  5 12:04:30 racrhel4 kernel: ttyS0: autoconf (0x03f8, 0x00000000): iir=3 type=NS16550A
Jan  5 12:04:30 racrhel4 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A


ttyS4 is ours. When I start the app "service" (serial port message mux for clients):

Jan  5 12:07:09 racrhel4 login(pam_unix)[3510]: session opened for user root by LOGIN(uid=0)
Jan  5 12:07:09 racrhel4  -- root[3510]: ROOT LOGIN ON tty1
Jan  5 12:07:36 racrhel4 kernel: uart_open(4) called
Jan  5 12:07:36 racrhel4 kernel: ttyS4: autoconf (0xbc80, 0x00000000): LOOP test failed (b0) type=16550A
Jan  5 12:07:36 racrhel4 kernel: uart_close(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913277, expire=4294913349...
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913279, expire=4294913315...
Jan  5 12:07:36 racrhel4 kernel: uart_flush_buffer(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_open(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_close(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913280, expire=4294913352...
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913282, expire=4294913318...
Jan  5 12:07:36 racrhel4 kernel: uart_flush_buffer(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_open(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913285, expire=4294913357...
Jan  5 12:07:36 racrhel4 kernel: uart_close(4) called
Jan  5 12:07:36 racrhel4 racsvc: racsvc start succeeded
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913285, expire=4294913357...
Jan  5 12:07:36 racrhel4 kernel: uart_wait_until_sent(4), jiffies=4294913285, expire=4294913321...
Jan  5 12:07:36 racrhel4 kernel: uart_flush_buffer(4) called
Jan  5 12:07:36 racrhel4 kernel: uart_open(4) called
Jan  5 12:07:36 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:36 racrhel4 last message repeated 2 times
Jan  5 12:07:36 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:36 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:36 racrhel4 last message repeated 4 times
Jan  5 12:07:36 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:36 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:37 racrhel4 last message repeated 3 times
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:37 racrhel4 last message repeated 3 times
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:37 racrhel4 last message repeated 11 times
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:37 racrhel4 last message repeated 4 times
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:37 racrhel4 last message repeated 3 times
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:37 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:54 racrhel4 last message repeated 4 times
Jan  5 12:07:54 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:54 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:54 racrhel4 last message repeated 3 times
Jan  5 12:07:54 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:07:54 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:07:54 racrhel4 last message repeated 12 times

all's well to this point.  Now, issuing an app "client" cmd that usually returns ~1K of data:

Jan  5 12:08:16 racrhel4 last message repeated 6 times
Jan  5 12:08:16 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:16 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:08:16 racrhel4 last message repeated 3 times
Jan  5 12:08:17 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:17 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:17 racrhel4 kernel: serial8250_interrupt(169)...status = 61...THRE...end.
Jan  5 12:08:17 racrhel4 kernel: serial8250_interrupt(169)...status = 1...THRE...end.
Jan  5 12:08:17 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:08:21 racrhel4 last message repeated 64 times
Jan  5 12:08:22 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:22 racrhel4 last message repeated 2 times
Jan  5 12:08:22 racrhel4 kernel: serial8250_interrupt(169)...status = 61...THRE...end.
Jan  5 12:08:22 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:08:27 racrhel4 last message repeated 47 times
Jan  5 12:08:27 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:27 racrhel4 last message repeated 2 times
Jan  5 12:08:27 racrhel4 kernel: serial8250_interrupt(169)...status = 61...THRE...end.
Jan  5 12:08:27 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:08:27 racrhel4 last message repeated 45 times
Jan  5 12:08:33 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:08:33 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:08:34 racrhel4 last message repeated 5 times
Jan  5 12:09:04 racrhel4 kernel: serial8250_interrupt(169)...status = 61...end.
Jan  5 12:09:04 racrhel4 kernel: serial8250_interrupt(169)...status = 60...THRE...end.
Jan  5 12:09:05 racrhel4 last message repeated 5 times

the cmd times out, and gives an error message.  

Can someone help me to resolve?
Thanks,
Tim




