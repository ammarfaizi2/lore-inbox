Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbTLKR6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbTLKR6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:58:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:14255 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265216AbTLKR6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:58:24 -0500
Date: Thu, 11 Dec 2003 09:56:59 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Kobject Fix for 2.6.0-test11
Message-ID: <20031211175659.GA7815@kroah.com>
References: <20031211012731.GA10632@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211012731.GA10632@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 05:27:31PM -0800, Greg KH wrote:
> 
> Here are some USB fixes for 2.6.0-test11.  They all fix real bugs, and
> are 1-4 line fixes with the exception of the usb-serial close() fix,
> which is a bit larger, but has been well tested by a number of different
> users.
> 
> Please pull from:  bk://linuxusb.bkbits.net/gregkh-2.6

I've added the following patch to this repository.  If you've already
pulled from here, feel free to just apply this single patch.  Or you can
pull from that tree again, which ever is easier for you.

It fixes a kobject bug where the parent could be deleted before the
child object, causing all sorts of badness later when we clean up the
child object.  It's been acked by Pat.

thanks,

greg k-h

 Subject: kobject: fix bug where a parent could be deleted before a child device.

diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Thu Dec 11 09:54:23 2003
+++ b/lib/kobject.c	Thu Dec 11 09:54:23 2003
@@ -236,8 +236,6 @@
 		list_del_init(&kobj->entry);
 		up_write(&kobj->kset->subsys->rwsem);
 	}
-	if (kobj->parent) 
-		kobject_put(kobj->parent);
 	kobject_put(kobj);
 }
 
@@ -274,9 +272,11 @@
 	kobj->parent = parent;
 
 	error = create_dir(kobj);
-	if (error)
+	if (error) {
 		unlink(kobj);
-	else {
+		if (parent)
+			kobject_put(parent);
+	} else {
 		/* If this kobj does not belong to a kset,
 		   try to find a parent that does. */
 		top_kobj = kobj;
@@ -452,6 +452,7 @@
 {
 	struct kobj_type * t = get_ktype(kobj);
 	struct kset * s = kobj->kset;
+	struct kobject * parent = kobj->parent;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
 	if (kobj->k_name != kobj->name)
@@ -461,6 +462,8 @@
 		t->release(kobj);
 	if (s)
 		kset_put(s);
+	if (parent) 
+		kobject_put(parent);
 }
 
 /**
