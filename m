Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTDPQsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDPQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:48:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264463AbTDPQsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:48:11 -0400
Date: Wed, 16 Apr 2003 09:58:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@digeo.com>,
       Philippe =?iso-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard
 freeze ( lockup on CPU0)
In-Reply-To: <20030416055402.GC15860@kroah.com>
Message-ID: <Pine.LNX.4.44.0304160951160.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hm yeah, this will fix the problem.  But is there anyway we can do this
> without a lock at all?  I think we wouldn't need the lock, if we didn't
> test the refcount for > 0, right?  Pat, that just keeps us from getting
> a reference count on a kobject that hasn't been initialized, right?
> That is a good idea to do, but is it really necessary?

Well, it also prevents us from getting a reference to an object that is 
being deleted. The chance of that happening is slim, and it indicates a 
need for synchronization at a higher level (if the kobject_get() on the 
object being deleted was to be delayed for some reason, they would likely 
be referencing freed memory anyway). 

And, in theory, an uninitialized object shouldn't be accessible, and any 
code doing that is buggy, and will have other problems. 

In short, I think we can remove the locks entirely. We can at least see 
what happens.. 


	-pat

===== lib/kobject.c 1.19 vs edited =====
--- 1.19/lib/kobject.c	Sat Apr 12 16:20:38 2003
+++ edited/lib/kobject.c	Wed Apr 16 09:57:15 2003
@@ -9,8 +9,6 @@
 #include <linux/module.h>
 #include <linux/stat.h>
 
-static spinlock_t kobj_lock = SPIN_LOCK_UNLOCKED;
-
 /**
  *	populate_dir - populate directory with attributes.
  *	@kobj:	object we're working on.
@@ -336,12 +334,10 @@
 struct kobject * kobject_get(struct kobject * kobj)
 {
 	struct kobject * ret = kobj;
-	spin_lock(&kobj_lock);
-	if (kobj && atomic_read(&kobj->refcount) > 0)
+	if (kobj)
 		atomic_inc(&kobj->refcount);
 	else
 		ret = NULL;
-	spin_unlock(&kobj_lock);
 	return ret;
 }
 
@@ -371,10 +367,8 @@
 
 void kobject_put(struct kobject * kobj)
 {
-	if (!atomic_dec_and_lock(&kobj->refcount, &kobj_lock))
-		return;
-	spin_unlock(&kobj_lock);
-	kobject_cleanup(kobj);
+	if (atomic_dec_and_test(&kobj->refcount))
+		kobject_cleanup(kobj);
 }
 
 

