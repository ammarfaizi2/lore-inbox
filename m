Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVH1CQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVH1CQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 22:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVH1CQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 22:16:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49856 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750731AbVH1CQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 22:16:04 -0400
Date: Sun, 28 Aug 2005 03:19:14 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mod_devicetable.h fixes
Message-ID: <20050828021914.GE9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* ieee1394_device_id has kernel_ulong_t field after an odd number of
__u32 ones.  Since mod_devicetable.h is included both from kernel and from
host build helper, we may be in trouble if we are building on 32bit host for
64bit target - userland sees unsigned long long, kernel sees unsigned long
and while their sizes match, alignments might not.  Fixed by forcing alignment.
Fortunately, almost nobody else needs that - the rest of such fields is
naturally aligned as it is.
	* of_device_id has void * in it.  Host userland helpers need
kernel_ulong_t instead, since their void * might have nothing to do
with the kernel one.  Fixed in the same way it's done for similar problems
in pcmcia_device_id (ifdef __KERNEL__).
	* pcmcia_device_id has the same problem as ieee1394_device_id.
Fixed the same way.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-base/include/linux/mod_devicetable.h current/include/linux/mod_devicetable.h
--- RC13-rc7-base/include/linux/mod_devicetable.h	2005-08-24 01:56:43.000000000 -0400
+++ current/include/linux/mod_devicetable.h	2005-08-27 21:57:35.000000000 -0400
@@ -33,7 +33,8 @@
 	__u32 model_id;
 	__u32 specifier_id;
 	__u32 version;
-	kernel_ulong_t driver_data;
+	kernel_ulong_t driver_data
+		__attribute__((aligned(sizeof(kernel_ulong_t))));
 };
 
 
@@ -182,7 +183,11 @@
 	char	name[32];
 	char	type[32];
 	char	compatible[128];
+#if __KERNEL__
 	void	*data;
+#else
+	kernel_ulong_t data;
+#endif
 };
 
 
@@ -208,7 +213,8 @@
 #ifdef __KERNEL__
 	const char *	prod_id[4];
 #else
-	kernel_ulong_t	prod_id[4];
+	kernel_ulong_t	prod_id[4]
+		__attribute__((aligned(sizeof(kernel_ulong_t))));
 #endif
 
 	/* not matched against */
