Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbUKDSgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUKDSgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUKDSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:34:42 -0500
Received: from peabody.ximian.com ([130.57.169.10]:38075 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262363AbUKDSaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:30:00 -0500
Subject: [patch] kobject_uevent: fix init ordering
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, herbert@gondor.apana.org.au,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20041104180550.GA16744@kroah.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	 <20041104180550.GA16744@kroah.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 13:27:31 -0500
Message-Id: <1099592851.31022.145.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg!

Looks like kobject_uevent_init is executed before netlink_proto_init and
consequently always fails.  Not cool.

Attached patch switches the initialization over from core_initcall (init
level 1) to postcore_initcall (init level 2).  Netlink's initialization
is done in core_initcall, so this should fix the problem.  We should be
fine waiting until postcore_initcall.

Also a couple white space changes mixed in, because I am anal.

	Robert Love


fix kobject_uevent init ordering

 lib/kobject_uevent.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -urN linux-2.6.10-rc1/lib/kobject_uevent.c linux/lib/kobject_uevent.c
--- linux-2.6.10-rc1/lib/kobject_uevent.c	2004-10-25 16:17:09.000000000 -0400
+++ linux/lib/kobject_uevent.c	2004-11-04 13:20:32.731836880 -0500
@@ -54,7 +54,7 @@
  * gfp_mask:
  */
 static int send_uevent(const char *signal, const char *obj, const void *buf,
-			int buflen, int gfp_mask)
+		       int buflen, int gfp_mask)
 {
 	struct sk_buff *skb;
 	char *pos;
@@ -105,9 +105,8 @@
 		sprintf(attrpath, "%s/%s", path, attr->name);
 		rc = send_uevent(signal, attrpath, NULL, 0, gfp_mask);
 		kfree(attrpath);
-	} else {
+	} else
 		rc = send_uevent(signal, path, NULL, 0, gfp_mask);
-	}
 
 exit:
 	kfree(path);
@@ -133,7 +132,6 @@
 {
 	return do_kobject_uevent(kobj, action, attr, GFP_ATOMIC);
 }
-
 EXPORT_SYMBOL_GPL(kobject_uevent_atomic);
 
 static int __init kobject_uevent_init(void)
@@ -149,7 +147,7 @@
 	return 0;
 }
 
-core_initcall(kobject_uevent_init);
+postcore_initcall(kobject_uevent_init);
 
 #else
 static inline int send_uevent(const char *signal, const char *obj,


