Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTDRFr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 01:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTDRFr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 01:47:56 -0400
Received: from [202.109.126.231] ([202.109.126.231]:31027 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id S262872AbTDRFrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 01:47:55 -0400
Message-ID: <3E9F9440.7F7CBDC8@mic.com.tw>
Date: Fri, 18 Apr 2003 13:59:28 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.67-ac2: ide reset issue
References: <200304172319.h3HNJXJ31933@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------B10283FEC36DE7C1716ED255"
X-OriginalArrivalTime: 18 Apr 2003 05:55:26.0781 (UTC) FILETIME=[1C1F06D0:01C3056F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B10283FEC36DE7C1716ED255
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
    I tested 2.5.67-ac2 with two continuous drive reset call,
dmesged out oops messages as below. system didn't crash
like under 2.4.21-pre1-ac1, but that race still exist.
    oops message:

hda: DMA disabled
------------[ cut here ]------------
kernel BUG at drivers/ide/ide.c:1603!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0216ac1>]    Not tainted
EFLAGS: 00010082
EIP is at generic_ide_ioctl+0x471/0x860
eax: c7e8ee60   ebx: 00000202   ecx: c038be8c   edx: c0211d10
esi: c02ba3cb   edi: c038be8c   ebp: c781df58   esp: c781df0c
ds: 007b   es: 007b   ss: 0068
Process hdparm (pid: 203, threadinfo=c781c000 task=c7bd06a0)
Stack: c7dc21c0 c122f3e0 08049cf4 00000000 00000000 08049cf4 c122f3e0 c7dc6000
       3e9f6c00 00030002
Call Trace:
 [<c0201af2>] blkdev_ioctl+0x82/0x3cc
 [<c0151d41>] sys_ioctl+0x81/0x220
 [<c0142d13>] sys_write+0x33/0x40
 [<c01090e3>] syscall_call+0x7/0xb

Code: 0f 0b 43 06 0a a3 2b c0 c7 40 08 01 00 00 00 53 9d 57 e8 a8
 ide0: reset: success

    I don't know if there's enough reason to change reset semantics
now to wait for completion, so that the next call be free of race.
and  I once had a simpler fix to let it delay another 50ms, that works
on my box but seems not a thorough one. does it help?

Regards
rain.w

--------------B10283FEC36DE7C1716ED255
Content-Type: text/plain; charset=us-ascii;
 name="ide.c.diff.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.c.diff.3"

--- /usr/src/linux-2.5.67-ac2/drivers/ide/ide.c	Fri Apr 18 10:11:01 2003
+++ ide.c	Fri Apr 18 11:14:26 2003
@@ -1608,6 +1608,10 @@
 			HWGROUP(drive)->busy = 1;
 			spin_unlock_irqrestore(&ide_lock, flags);
 			(void) ide_do_reset(drive);
+
+			/* wait for another 50ms */
+			mdelay(50);
+
 			if (drive->suspend_reset) {
 /*
  *				APM WAKE UP todo !!

--------------B10283FEC36DE7C1716ED255--

