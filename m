Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKIDUK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 22:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKIDUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 22:20:10 -0500
Received: from netrider.rowland.org ([192.131.102.5]:32529 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262114AbTKIDUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 22:20:05 -0500
Date: Sat, 8 Nov 2003 22:20:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Bug (?) in subsystem kset refcounts
Message-ID: <Pine.LNX.4.44L0.0311082209330.7127-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hesitate to say this is definitely a bug, since it might be intended 
behavior.  But it is rather strange.

Subsystems included an embedded kset, which itself includes an embedded 
kobject and so is subject to reference counting.  Whenever a kobject 
belonging to the kset is destroyed, the kset's reference count is 
decremented.  However, kobjects can be added to a kset via the three 
macros

	kobj_set_kset_s, kset_set_kset_s, and subsys_set_kset

and these do _not_ increment the kset's reference count.  As a result, the 
reference count only goes down, not up, quickly becoming negative.

Now maybe this doesn't matter -- if subsystems are intended to be
permanent (i.e., never released), for example.  But it provokes a warning
message from kernels that check for reference counts going below zero,
appears to be unintended, and may cause other problems as well.

The patch below is offered as a possible solution.  I don't know that it's 
the right one, but at least it prevents the unwanted warning messages.

Alan Stern


--- a/include/linux/kobject.h.orig	Thu Sep 11 09:46:38 2003
+++ a/include/linux/kobject.h	Sat Nov  8 17:57:35 2003
@@ -168,7 +168,7 @@
  */
 
 #define kobj_set_kset_s(obj,subsys) \
-	(obj)->kobj.kset = &(subsys).kset
+	(obj)->kobj.kset = kset_get(&(subsys).kset)
 
 /**
  *	kset_set_kset_s(obj,subsys) - set kset for embedded kset.
@@ -182,7 +182,7 @@
  */
 
 #define kset_set_kset_s(obj,subsys) \
-	(obj)->kset.kobj.kset = &(subsys).kset
+	(obj)->kset.kobj.kset = kset_get(&(subsys).kset)
 
 /**
  *	subsys_set_kset(obj,subsys) - set kset for subsystem
@@ -195,7 +195,7 @@
  */
 
 #define subsys_set_kset(obj,_subsys) \
-	(obj)->subsys.kset.kobj.kset = &(_subsys).kset
+	(obj)->subsys.kset.kobj.kset = kset_get(&(_subsys).kset)
 
 extern void subsystem_init(struct subsystem *);
 extern int subsystem_register(struct subsystem *);

