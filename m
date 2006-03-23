Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWCWE2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWCWE2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWCWE2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:28:47 -0500
Received: from stinky.trash.net ([213.144.137.162]:1511 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S965195AbWCWE2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:28:46 -0500
Message-ID: <442223FC.8090809@trash.net>
Date: Thu, 23 Mar 2006 05:28:44 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [CCISS]: Fix use-after-free in cciss_init_one
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050004070807050208000200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004070807050208000200
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

free_hba() sets hba[i] to NULL, the dereference afterwards results in
this crash. Setting busy_initializing to 0 actually looks unnecessary,
but I'm not entirely sure, which is why I left it in.

Signed-off-by: Patrick McHardy <kaber@trash.net>


cciss: controller appears to be disabled
Unable to handle kernel NULL pointer dereference at virtual address 00000370
 printing eip:
c1114d53
*pde = 00000000
Oops: 0002 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c1114d53>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16 #1)
EIP is at cciss_init_one+0x4e9/0x4fe
eax: 00000000   ebx: c132cd60   ecx: c13154e4   edx: c27d3c00
esi: 00000000   edi: c2748800   ebp: c2536ee4   esp: c2536eb8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c2536000 task=c2535a30)
Stack: <0>00000000 00000000 00000000 c13fdba0 c2536ee8 c13159c0 c2536f38
f7c74740
       c132cd60 c132cd60 ffffffed c2536ef0 c10c1d51 c2748800 c2536f04
c10c1d85
       c132cd60 c2748800 c132cd8c c2536f14 c10c1db8 c2748848 00000000
c2536f28
Call Trace:
 [<c10031d5>] show_stack_log_lvl+0xa8/0xb0
 [<c1003305>] show_registers+0x102/0x16a
 [<c10034a2>] die+0xc1/0x13c
 [<c1288160>] do_page_fault+0x38a/0x525
 [<c1002e9b>] error_code+0x4f/0x54
 [<c10c1d51>] pci_call_probe+0xd/0x10
 [<c10c1d85>] __pci_device_probe+0x31/0x43
 [<c10c1db8>] pci_device_probe+0x21/0x34
 [<c110a654>] driver_probe_device+0x44/0x99
 [<c110a73f>] __driver_attach+0x39/0x5d
 [<c1109e1c>] bus_for_each_dev+0x35/0x5a
 [<c110a777>] driver_attach+0x14/0x16
 [<c110a220>] bus_add_driver+0x5c/0x8f
 [<c110ab22>] driver_register+0x73/0x78
 [<c10c1f6d>] __pci_register_driver+0x5f/0x71
 [<c13bf935>] cciss_init+0x1a/0x1c
 [<c13aa718>] do_initcalls+0x4c/0x96
 [<c13aa77e>] do_basic_setup+0x1c/0x1e
 [<c10002b1>] init+0x35/0x118
 [<c1000cf5>] kernel_thread_helper+0x5/0xb
Code: 04 b5 e0 de 40 c1 8d 50 04 8b 40 34 e8 3f b7 f9 ff 8b 04 b5 e0 de
40 c1 e8 aa f3 ff ff 89 f0 e8 e8 fa ff ff 8b 04 b5 e0 de 40 c1 <c7> 80
70 03 00 00 00 00 00 00 83 c8 ff 8d 65 f4 5b 5e 5f 5d c3
 <0>Kernel panic - not syncing: Attempted to kill init!





--------------050004070807050208000200
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

--- a/drivers/block/cciss.c	2006-03-22 18:26:31.000000000 +0100
+++ b/drivers/block/cciss.c	2006-03-22 18:26:33.000000000 +0100
@@ -3269,8 +3269,8 @@
 	unregister_blkdev(hba[i]->major, hba[i]->devname);
 clean1:
 	release_io_mem(hba[i]);
-	free_hba(i);
 	hba[i]->busy_initializing = 0;
+	free_hba(i);
 	return(-1);
 }
 

--------------050004070807050208000200--
