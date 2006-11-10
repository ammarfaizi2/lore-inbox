Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946153AbWKJJXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946153AbWKJJXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWKJJXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:23:38 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:15056 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946153AbWKJJXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:23:36 -0500
Subject: Patch to fixe Data Acess error in dup_fd
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: linux-kernel@vger.kernel.org
Cc: Pavel Emelianov <xemul@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-tSo7IkTnNSkCJQnJ8qtV"
Organization: IBM
Date: Fri, 10 Nov 2006 15:02:01 +0530
Message-Id: <1163151121.3539.15.camel@legolas.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tSo7IkTnNSkCJQnJ8qtV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On running the Stress Test on machine for more than 72 hours following
error message was observed.

0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c00000007ce2f7f0]
    pc: c000000000060d90: .dup_fd+0x240/0x39c
    lr: c000000000060d6c: .dup_fd+0x21c/0x39c
    sp: c00000007ce2fa70
   msr: 800000000000b032
   dar: ffffffff00000028
 dsisr: 40000000
  current = 0xc000000074950980
  paca    = 0xc000000000454500
    pid   = 27330, comm = bash

0:mon> t
[c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
[c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
[c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
[c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
[c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
[c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc
--- Exception: c00 (System Call) at 000000000fee9c60
SP (fcb2e770) is in userspace

---------------------------
The problem is because of race window. When if(expand) block is executed in dup_fd 
unlocking of oldf->file_lock give a window for fdtable in oldf to be
modified. So actual open_files in oldf may not match with open_files
variable.
This is the debug patch to fix the problem
  Please let me know of your opinion. It is generated on:2.6.19-rc1

--=-tSo7IkTnNSkCJQnJ8qtV
Content-Disposition: attachment; filename=dup_fd.patch
Content-Type: text/x-patch; name=dup_fd.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- kernel/fork.c.orig	2006-11-10 14:42:02.000000000 +0530
+++ kernel/fork.c	2006-11-10 14:42:30.000000000 +0530
@@ -687,6 +687,7 @@ static struct files_struct *dup_fd(struc
 		 * the latest pointer.
 		 */
 		spin_lock(&oldf->file_lock);
+		open_files = count_open_files(old_fdt);
 		old_fdt = files_fdtable(oldf);
 	}
 

--=-tSo7IkTnNSkCJQnJ8qtV--

