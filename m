Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTLHXBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTLHXBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:01:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:19343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262048AbTLHXA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:00:58 -0500
Date: Mon, 8 Dec 2003 14:58:40 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, mgorse@mgorse.dhs.org,
       linux-kernel@vger.kernel.org, Andrey Borzenkov <arvidjaar@mail.ru>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
Message-ID: <20031208225840.GA31245@kroah.com>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com> <20031208224810.GB31134@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208224810.GB31134@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 02:48:10PM -0800, Greg KH wrote:
> 
> Ok, here's how a parent can be removed from the system without the child
> going away:
> 	- create parent and register it successfully.
> 	- create child, call kobject_add() which increments the count of
> 	  the parent.
> 	- call kobject_get() on the child.
> 	- call kobject_del() on the parent.  This will keep the parent
> 	  around, as the child still has a reference on it.
> 	- call kobject_del() on the child.  This will decrement the
> 	  count on the parent due to the call in unlink().  That will
> 	  free the parent up from memory.  But this child still has a
> 	  incremented count (rightly, as it is in use).
> 	  
> 	- So the child now has a stale parent pointer, causing all sorts
> 	  of fun...
> 
> I'll work on a patch for kobject.c and post it in the next message, and
> include the original message and patch below for others to see.

Here's a patch for kobject.c that should fix this problem and keep
kobject parent's around until after the child is gone.  Please can
someone verify that I didn't get this wrong...

thanks,

greg k-h

--- a/lib/kobject.c	Mon Sep 29 15:13:44 2003
+++ b/lib/kobject.c	Mon Dec  8 14:56:32 2003
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
