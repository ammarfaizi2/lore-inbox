Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUESCMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUESCMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 22:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUESCMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 22:12:01 -0400
Received: from ns2.undead.cc ([216.126.84.18]:13697 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263766AbUESCL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 22:11:57 -0400
Message-ID: <40AAC26C.2080803@undead.cc>
Date: Tue, 18 May 2004 22:11:56 -0400
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] sysfs kobject that doesn't trigger hotplug events
Content-Type: multipart/mixed;
 boundary="------------090206080906030701040608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206080906030701040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm adding some data structures to a device and want them to appear 
under that device in sysfs in subdirectories.  These data structures are 
linked together in a tree like layout so it would make sense to have 
them have a subdirectory tree representing them.  These data structures 
have a kobject for reference counting and I can use kobject_add and 
kobject_del to add them to the sysfs tree.

Looking through the kobject.c code I noticed that this would create a 
lot of hotplug events which would burn up a bit of processor time.  
These events are not necessary as these are not device kobjects.  I've 
enclosed a patch to my solution for this.  I'd like to know if there are 
any side effects with this method.

John



--------------090206080906030701040608
Content-Type: text/plain;
 name="kobject_no_hotplug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_no_hotplug"

diff -urNX dontdiff linux-2.6.6/include/linux/kobject.h linux/include/linux/kobject.h
--- linux-2.6.6/include/linux/kobject.h	2004-05-09 22:31:59.000000000 -0400
+++ linux/include/linux/kobject.h	2004-05-18 20:29:43.000000000 -0400
@@ -62,6 +62,7 @@
 	void (*release)(struct kobject *);
 	struct sysfs_ops	* sysfs_ops;
 	struct attribute	** default_attrs;
+	int			no_hotplug;
 };
 
 
diff -urNX dontdiff linux-2.6.6/lib/kobject.c linux/lib/kobject.c
--- linux-2.6.6/lib/kobject.c	2004-05-09 22:33:19.000000000 -0400
+++ linux/lib/kobject.c	2004-05-18 20:50:42.000000000 -0400
@@ -203,6 +203,9 @@
 {
 	struct kobject * top_kobj = kobj;
 
+	if (kobj->ktype && kobj->ktype->no_hotplug)
+		return;
+
 	/* If this kobj does not belong to a kset,
 	   try to find a parent that does. */
 	if (!top_kobj->kset && top_kobj->parent) {

--------------090206080906030701040608--

