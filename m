Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbUKEA7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbUKEA7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUKEA4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:56:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:9951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262534AbUKEAtc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:32 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157051968@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <10996157052061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.10, 2004/11/04 12:00:12-08:00, rml@novell.com

[PATCH] kobject_uevent: fix init ordering

Looks like kobject_uevent_init is executed before netlink_proto_init and
consequently always fails.  Not cool.

Attached patch switches the initialization over from core_initcall (init
level 1) to postcore_initcall (init level 2).  Netlink's initialization
is done in core_initcall, so this should fix the problem.  We should be
fine waiting until postcore_initcall.

Also a couple white space changes mixed in, because I am anal.

Signed-Off-By: Robert Love <rml@novell.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-04 16:30:09 -08:00
+++ b/lib/kobject_uevent.c	2004-11-04 16:30:09 -08:00
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

