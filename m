Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVA1TMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVA1TMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVA1TK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:10:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:40391 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262698AbVA1TFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:05:45 -0500
Date: Fri, 28 Jan 2005 12:06:19 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] OProfile: Fix oops on undetected CPU type
Message-ID: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running opcontrol --reset on an em64t P4 yields the following (clearly 
there must be a reason why it's disabled but i'll address that  
seperately);

Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c0562cf4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c0562cf4>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11-rc2)
EIP is at oprofilefs_str_to_user+0x24/0x50
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ffffffff
esi: 00001000   edi: 00000000   ebp: ec477f78   esp: ec477f60
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 2810, threadinfo=ec476000 task=f739ead0)
Stack: 00000000 c016806a 0804d858 c072aa00 ec9eff58 00001000 ec477f9c c015e1e7
       ec477fa8 00000000 00000000 0804d858 ec9eff58 fffffff7 0804d858 ec477fbc
       c015e50d ec477fa8 00000000 00000000 00000000 00000003 00001000 ec476000
Call Trace:
 [<c0103fea>] show_stack+0x7a/0x90
 [<c0104176>] show_registers+0x156/0x1d0
 [<c01043a0>] die+0x100/0x190
 [<c01170be>] do_page_fault+0x45e/0x644
 [<c0103c77>] error_code+0x2b/0x30
 [<c015e1e7>] vfs_read+0xc7/0x160
 [<c015e50d>] sys_read+0x3d/0x70
 [<c0103105>] sysenter_past_esp+0x52/0x75
Code: 90 90 90 90 90 90 90 55 89 e5 83 ec 18 89 5d f4 31 db 89 55 f0 ba ff 
ff ff ff 89 75 f8 89 ce 89 d1 89 7d fc 89 c7 89 04 24 89 d8 <f2> ae f7 d1 
49 89 4c 24 04 8b 45 f0 89 f2 8b 4d 08 e8 66 e4 c1

->cpu_type is NULL since p4_init skipped this specific processor.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

===== drivers/oprofile/oprofile_files.c 1.7 vs edited =====
--- 1.7/drivers/oprofile/oprofile_files.c	2005-01-04 19:48:23 -07:00
+++ edited/drivers/oprofile/oprofile_files.c	2005-01-28 11:36:25 -07:00
@@ -63,7 +63,9 @@ static struct file_operations pointer_si
 
 static ssize_t cpu_type_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
 {
-	return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
+	if (oprofile_ops.cpu_type)
+		return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
+	return -EIO;
 }
  
  
