Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbTA2SSS>; Wed, 29 Jan 2003 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTA2SSR>; Wed, 29 Jan 2003 13:18:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51077 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266456AbTA2SSQ>;
	Wed, 29 Jan 2003 13:18:16 -0500
Message-ID: <3E381B3D.4030302@us.ibm.com>
Date: Wed, 29 Jan 2003 10:19:41 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch][trivial] fix drivers/base/cpu.c
References: <3E2F2EC1.4090606@us.ibm.com> <20030129050522.316E32C63F@lists.samba.org> <20030129055547.GL780@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------030100010102090409020809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100010102090409020809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> In message <3E2F2EC1.4090606@us.ibm.com> Matt Dobson (?) wrote:
> 
>>>Both drivers/base/node.c & memblk.c check the return values of the 
>>>devclass_register & driver_register calls.  cpu.c doesn't.  This little 
>>>patch remedies that omission.
>>
> 
> On Wed, Jan 29, 2003 at 03:51:04PM +1100, Rusty Russell wrote:
> 
>>You'd want to to undo the devclass_register() on failure, too, I
>>imagine.
> 
> 
> Ow, I forgot about that. Someone grind this out quick and take care of
> the other oopsing thingies. You know what I'm preoccupied with.
> 
> -- wli

Good point Rusty, cleanup attatched...

Cheers!

-Matt

--------------030100010102090409020809
Content-Type: text/plain;
 name="sysfs_topo_cleanup-2.5.59.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs_topo_cleanup-2.5.59.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/cpu.c linux-2.5.59-driver_base_cleanup/drivers/base/cpu.c
--- linux-2.5.59-vanilla/drivers/base/cpu.c	Thu Jan 16 18:21:51 2003
+++ linux-2.5.59-driver_base_cleanup/drivers/base/cpu.c	Wed Jan 29 10:16:26 2003
@@ -48,7 +48,10 @@
 
 static int __init register_cpu_type(void)
 {
-	devclass_register(&cpu_devclass);
-	return driver_register(&cpu_driver);
+	int error;
+	if (!(error = devclass_register(&cpu_devclass)))
+		if (error = driver_register(&cpu_driver))
+			devclass_unregister(&cpu_devclass);
+	return error;
 }
 postcore_initcall(register_cpu_type);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/memblk.c linux-2.5.59-driver_base_cleanup/drivers/base/memblk.c
--- linux-2.5.59-vanilla/drivers/base/memblk.c	Thu Jan 16 18:22:57 2003
+++ linux-2.5.59-driver_base_cleanup/drivers/base/memblk.c	Wed Jan 29 10:16:08 2003
@@ -49,7 +49,10 @@
 
 static int __init register_memblk_type(void)
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/node.c linux-2.5.59-driver_base_cleanup/drivers/base/node.c
--- linux-2.5.59-vanilla/drivers/base/node.c	Thu Jan 16 18:21:40 2003
+++ linux-2.5.59-driver_base_cleanup/drivers/base/node.c	Wed Jan 29 10:15:12 2003
@@ -91,7 +91,10 @@
 
 static int __init register_node_type(void)
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

--------------030100010102090409020809--

