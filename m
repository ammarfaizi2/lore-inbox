Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbTCGRwP>; Fri, 7 Mar 2003 12:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbTCGRwP>; Fri, 7 Mar 2003 12:52:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261694AbTCGRwN>;
	Fri, 7 Mar 2003 12:52:13 -0500
Date: Fri, 7 Mar 2003 10:01:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: I2O on 2.5.64
Message-Id: <20030307100103.09d6381d.rddunlap@osdl.org>
In-Reply-To: <1047056563.11864.104.camel@dell_ss3.pdx.osdl.net>
References: <1047056563.11864.104.camel@dell_ss3.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2003 09:02:43 -0800 Stephen Hemminger <shemminger@osdl.org> wrote:

| Enabled I2O on a test machine running 2.5.64 and it hangs during boot.
| Don't think the machine has SCSI but doesn't have any I2O capable
| devices.
| 
| Last gasp:
| 
| Linux I2O PCI support (c) 1999-2002 Red Hat.
| i2o: Checking for PCI I2O controllers...
| I2O Core - (C) Copyright 1999 Red Hat Software
| I2O: Event thread created as pid 44
| I2O configuration manager v 0.04.
|   (C) Copyright 1999 Red Hat Software
| I2O Block Storage OSM v0.9
|    (c) Copyright 1999-2001 Red Hat Software.
| i2o_block: Checking for Boot device...
| i2o_block: Checking for I2O Block devices...
| i2o_scsi.c: Version 0.1.2
|   chain_pool: 0 bytes @ f7fe6ec0
|   (512 byte buffers X 4 can_queue X 0 i2o controllers)

More details:
kernel BUG at include/asm/spinlock.h:123!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0316594>]    Not tainted
EFLAGS: 00010046
EIP is at flush_pending+0x24/0xe0
eax: 0000000e   ebx: 0000001f   ecx: c0429c24   edx: 000037dd
esi: 00000000   edi: 00000246   ebp: c1aeff8c   esp: c1aeff78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1aee000 task=c1afc080)
Stack: c03baa94 c0316570 0000001f 00000000 f7cd2c4c c1aeffa4 c0316e81 00000000 
       c0316eb0 c0474380 00000000 c1aeffb8 c02b446b c0474380 c0474380 00000000 
       c1aeffc8 c04d1237 c0474380 c04d82b4 c1aeffd4 c04ba902 c1aee000 c1aeffec 
Call Trace:
 [<c0316570>] flush_pending+0x0/0xe0
 [<c0316e81>] i2o_scsi_detect+0x1d1/0x200
 [<c0316eb0>] i2o_scsi_release+0x0/0x50
 [<c02b446b>] scsi_register_host+0x3b/0x90
 [<c010511b>] init+0x8b/0x230
 [<c0105090>] init+0x0/0x230
 [<c0107399>] kernel_thread_helper+0x5/0xc


and the patch (WorksForMe: now boots):  Alan, please apply.

patch_name:	i2oscsi_spin.patch
patch_version:	2003-03-07.09:52:17
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	_
product:	Linux
product_versions: linux-2564
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 drivers/message/i2o/i2o_scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./drivers/message/i2o/i2o_scsi.c%SPIN ./drivers/message/i2o/i2o_scsi.c
--- ./drivers/message/i2o/i2o_scsi.c%SPIN	Tue Mar  4 19:29:33 2003
+++ ./drivers/message/i2o/i2o_scsi.c	Fri Mar  7 09:43:42 2003
@@ -85,7 +85,7 @@
 static u32 *retry[32];
 static struct i2o_controller *retry_ctrl[32];
 static struct timer_list retry_timer;
-static spinlock_t retry_lock;
+static spinlock_t retry_lock = SPIN_LOCK_UNLOCKED;
 static int retry_ct = 0;
 
 static atomic_t queue_depth;


--
~Randy
