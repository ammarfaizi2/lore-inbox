Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbTCRBnZ>; Mon, 17 Mar 2003 20:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbTCRBnZ>; Mon, 17 Mar 2003 20:43:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56495 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262118AbTCRBnW>;
	Mon, 17 Mar 2003 20:43:22 -0500
Message-ID: <3E767A36.5020300@us.ibm.com>
Date: Mon, 17 Mar 2003 17:45:26 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: [patch] Fix error handling in sysfs registration
Content-Type: multipart/mixed;
 boundary="------------070903020902050608050208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070903020902050608050208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The cpu, memblk, and node driver/device registration should be a little 
more clean in the way it handles registration failures.  Or at least 
*consistent* amongst the topology elements.  Right now, failures are 
either silent, obscure, or leave things in an inconsistent state.

Cheers!

-Matt

--------------070903020902050608050208
Content-Type: text/plain;
 name="sysfs_topo_cleanup-2.5.65.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_topo_cleanup-2.5.65.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/drivers/base/cpu.c linux-2.5.64-sysfs_cleanup/drivers/base/cpu.c
--- linux-2.5.64-vanilla/drivers/base/cpu.c	Tue Mar  4 19:29:15 2003
+++ linux-2.5.64-sysfs_cleanup/drivers/base/cpu.c	Mon Mar 17 14:08:59 2003
@@ -48,6 +48,9 @@
 
 int __init cpu_dev_init(void)
 {
-	devclass_register(&cpu_devclass);
-	return driver_register(&cpu_driver);
+	int error;
+	if (!(error = devclass_register(&cpu_devclass)))
+		if (error = driver_register(&cpu_driver))
+			devclass_unregister(&cpu_devclass);
+	return error;
 }
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/drivers/base/memblk.c linux-2.5.64-sysfs_cleanup/drivers/base/memblk.c
--- linux-2.5.64-vanilla/drivers/base/memblk.c	Tue Mar  4 19:29:54 2003
+++ linux-2.5.64-sysfs_cleanup/drivers/base/memblk.c	Mon Mar 17 14:09:42 2003
@@ -47,9 +47,12 @@
 }
 
 
-static int __init register_memblk_type(void)
+int __init register_memblk_type(void)
 {
-	int error = devclass_register(&memblk_devclass);
-	return error ? error : driver_register(&memblk_driver);
+	int error;
+	if (!(error = devclass_register(&memblk_devclass)))
+		if (error = driver_register(&memblk_driver))
+			devclass_unregister(&memblk_devclass);
+	return error;
 }
 postcore_initcall(register_memblk_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/drivers/base/node.c linux-2.5.64-sysfs_cleanup/drivers/base/node.c
--- linux-2.5.64-vanilla/drivers/base/node.c	Tue Mar  4 19:29:00 2003
+++ linux-2.5.64-sysfs_cleanup/drivers/base/node.c	Mon Mar 17 14:09:52 2003
@@ -89,9 +89,12 @@
 }
 
 
-static int __init register_node_type(void)
+int __init register_node_type(void)
 {
-	int error = devclass_register(&node_devclass);
-	return error ? error : driver_register(&node_driver);
+	int error;
+	if (!(error = devclass_register(&node_devclass)))
+		if (error = driver_register(&node_driver))
+			devclass_unregister(&node_devclass);
+	return error;
 }
 postcore_initcall(register_node_type);

--------------070903020902050608050208--

