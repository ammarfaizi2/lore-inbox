Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbUKDTco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUKDTco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUKDTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:32:41 -0500
Received: from peabody.ximian.com ([130.57.169.10]:36284 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262651AbUKDTbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:31:24 -0500
Subject: Re: [patch] kobject_uevent: fix init ordering
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, herbert@gondor.apana.org.au,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1099592851.31022.145.camel@betsy.boston.ximian.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	 <20041104180550.GA16744@kroah.com>
	 <1099592851.31022.145.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 14:28:52 -0500
Message-Id: <1099596532.31022.151.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 13:27 -0500, Robert Love wrote:

> Looks like kobject_uevent_init is executed before netlink_proto_init and
> consequently always fails.  Not cool.
> 
> Attached patch switches the initialization over from core_initcall (init
> level 1) to postcore_initcall (init level 2).  Netlink's initialization
> is done in core_initcall, so this should fix the problem.  We should be
> fine waiting until postcore_initcall.
> 
> Also a couple white space changes mixed in, because I am anal.

Greg, sir, here is a patch rediff'ed off current BK.

	Robert Love


fix init call ordering for kobject_uevent

Signed-Off-By: Robert Love <rml@novell.com>

 lib/kobject_uevent.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -urN linux-2.6.10-rc1-bk14/lib/kobject_uevent.c linux/lib/kobject_uevent.c
--- linux-2.6.10-rc1-bk14/lib/kobject_uevent.c	2004-11-04 14:20:10.431943792 -0500
+++ linux/lib/kobject_uevent.c	2004-11-04 14:26:54.056583520 -0500
@@ -120,9 +120,8 @@
 		sprintf(attrpath, "%s/%s", path, attr->name);
 		rc = send_uevent(signal, attrpath, NULL, gfp_mask);
 		kfree(attrpath);
-	} else {
+	} else
 		rc = send_uevent(signal, path, NULL, gfp_mask);
-	}
 
 exit:
 	kfree(path);
@@ -148,7 +147,6 @@
 {
 	return do_kobject_uevent(kobj, action, attr, GFP_ATOMIC);
 }
-
 EXPORT_SYMBOL_GPL(kobject_uevent_atomic);
 
 static int __init kobject_uevent_init(void)
@@ -164,7 +162,7 @@
 	return 0;
 }
 
-core_initcall(kobject_uevent_init);
+postcore_initcall(kobject_uevent_init);
 
 #else
 static inline int send_uevent(const char *signal, const char *obj,


