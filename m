Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSLDXvk>; Wed, 4 Dec 2002 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbSLDXvk>; Wed, 4 Dec 2002 18:51:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36304 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267146AbSLDXvj>;
	Wed, 4 Dec 2002 18:51:39 -0500
Message-ID: <3DEE959F.7080600@us.ibm.com>
Date: Wed, 04 Dec 2002 15:54:07 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [patch] fix broken topology functions
Content-Type: multipart/mixed;
 boundary="------------080206050901010402080602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080206050901010402080602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	The register_(node|memblk)_driver functions are broken.  Pat Mochel 
recently updated sysfs to make sure that when you register a driver that 
it's associated devclass is already registered.  The way node/memblk 
registration is done now is backwards and causes panic's on NUMA 
systems.  Please apply this patch to fix it.

Cheers!

-Matt


--------------080206050901010402080602
Content-Type: text/plain;
 name="topo_ordering-2.5.50.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="topo_ordering-2.5.50.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.50-vanilla/drivers/base/memblk.c linux-2.5.50-topo_ordering/drivers/base/memblk.c
--- linux-2.5.50-vanilla/drivers/base/memblk.c	Wed Nov 27 14:36:23 2002
+++ linux-2.5.50-topo_ordering/drivers/base/memblk.c	Wed Dec  4 15:50:52 2002
@@ -49,7 +49,7 @@
 
 static int __init register_memblk_type(void)
 {
-	driver_register(&memblk_driver);
-	return devclass_register(&memblk_devclass);
+	devclass_register(&memblk_devclass);
+	return driver_register(&memblk_driver);
 }
 postcore_initcall(register_memblk_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.50-vanilla/drivers/base/node.c linux-2.5.50-topo_ordering/drivers/base/node.c
--- linux-2.5.50-vanilla/drivers/base/node.c	Wed Nov 27 14:35:50 2002
+++ linux-2.5.50-topo_ordering/drivers/base/node.c	Wed Dec  4 15:50:52 2002
@@ -93,7 +93,7 @@
 
 static int __init register_node_type(void)
 {
-	driver_register(&node_driver);
-	return devclass_register(&node_devclass);
+	devclass_register(&node_devclass);
+	return driver_register(&node_driver);
 }
 postcore_initcall(register_node_type);

--------------080206050901010402080602--

