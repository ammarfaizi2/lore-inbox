Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVBIDuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVBIDuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVBIDuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:50:11 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:17725 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261772AbVBIDuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 22:50:02 -0500
Message-ID: <42098812.9010409@spirentcom.com>
Date: Tue, 08 Feb 2005 19:48:34 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chrisw@osdl.org
CC: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
Content-Type: multipart/mixed;
 boundary="------------010608090003060303070201"
X-OriginalArrivalTime: 09 Feb 2005 03:50:00.0294 (UTC) FILETIME=[6DDC8060:01C50E5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010608090003060303070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


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


--------------010608090003060303070201
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

--------------010608090003060303070201--
