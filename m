Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTDINmv (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 09:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTDINmu (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 09:42:50 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:58816 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S263309AbTDINmt (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 09:42:49 -0400
Date: Wed, 9 Apr 2003 09:51:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304090954_MC3-1-33A8-2B27@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately, as proven by i2c, kobjects infrastructure does not like if
> you reference non-existing bus type before it is registered.


  AFAICT sysfs itself sort of has this problem in 2.5.66 -- it tries
to register itself as a filesystem before the set 'fs' is registered.
It retries later and succeeds but I could never figure out if that was
by design or accident. 8)

  This patch helps find some of these problems but I don't think it will
help in this case:


diff -ur --exclude-from=/home/me/exclude linux-2.5.66-ref/lib/kobject.c linux-2.5.66-uni/lib/kobject.c
--- linux-2.5.66-ref/lib/kobject.c	Tue Mar  4 22:29:36 2003
+++ linux-2.5.66-uni/lib/kobject.c	Sat Mar 29 20:43:26 2003
@ -57,10 +57,15 @
 				sysfs_remove_dir(kobj);
 		}
 	}
+	if (error) {
+		printk("Badness name:%s, err:%d, set:%s\n",
+		       kobj->name, error,
+		       kobj->kset ? kobj->kset->kobj.name : "<NULL>");
+		WARN_ON(1);
+	}
 	return error;
 }
 
-
 static inline struct kobject * to_kobj(struct list_head * entry)
 {
 	return container_of(entry,struct kobject,entry);
@ -149,7 +154,6 @
 	if (kobj) {
 		kobject_init(kobj);
 		error = kobject_add(kobj);
-		WARN_ON(error);
 	} else
 		error = -EINVAL;
 	return error;

--
 Chuck
