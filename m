Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVBIDxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVBIDxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVBIDxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:53:17 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:18493 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261773AbVBIDww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 22:52:52 -0500
Message-ID: <420988C1.5030408@spirentcom.com>
Date: Tue, 08 Feb 2005 19:51:29 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chrisw@osdl.org
CC: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
Content-Type: multipart/mixed;
 boundary="------------000708060604090708080807"
X-OriginalArrivalTime: 09 Feb 2005 03:52:51.0136 (UTC) FILETIME=[D3B0EC00:01C50E5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708060604090708080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Aargh!  Missing Signed-off-by.]

Unless I'm missing something, in kernel/fork.c, dup_mmap():

			if (security_vm_enough_memory(len))
				goto fail_nomem;
/* ... */
fail_nomem:
	retval = -ENOMEM;
	vm_unacct_memory(charge);
/* ... */

If security_vm_enough_memory() fails there, then we vm_unacct_memory()
that we never accounted (if security_vm_enough_memory() fails, no memory
is accounted).

If it is in fact a bug, a simple but largely untested patch (against
2.6.11-rc3-bk5) is included.


Mark F. Haigh
Mark.Haigh@spirentcom.com

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>


--------------000708060604090708080807
Content-Type: text/plain;
 name="fork-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fork-patch"

--- linux-2.6.11-rc3-bk5/kernel/fork.c.orig	2005-02-08 19:12:26.254589504 -0800
+++ linux-2.6.11-rc3-bk5/kernel/fork.c	2005-02-08 19:16:30.756419576 -0800
@@ -193,8 +193,10 @@
 		charge = 0;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-			if (security_vm_enough_memory(len))
-				goto fail_nomem;
+			if (security_vm_enough_memory(len)) {
+				retval = -ENOMEM;
+				goto out;
+			}
 			charge = len;
 		}
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);


--------------000708060604090708080807--
