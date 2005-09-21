Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVIUXiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVIUXiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVIUXiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 19:38:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3827 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750773AbVIUXh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 19:37:59 -0400
Subject: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 21 Sep 2005 16:37:53 -0700
Message-Id: <1127345874.19506.43.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds a check for cmpxchg in get_task_struct_rcu(), and implements the
case when it doesn't exist.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/linux/sched.h
===================================================================
--- linux-2.6.13.orig/include/linux/sched.h
+++ linux-2.6.13/include/linux/sched.h
@@ -1026,13 +1026,21 @@ static inline int get_task_struct_rcu(st
 {
 	int oldusage;
 
+#ifdef __HAVE_ARCH_CMPXCHG
 	do {
 		oldusage = atomic_read(&t->usage);
 		if (oldusage == 0) {
 			return 0;
 		}
 	} while (cmpxchg(&t->usage.counter,
-		 oldusage, oldusage + 1) != oldusage);
+				oldusage, oldusage + 1) != oldusage);
+#else
+	oldusage = atomic_read(&t->usage);
+	if (oldusage == 0) {
+		return 0;
+	}
+	atomic_inc(&t->usage);
+#endif
 	return 1;
 }
 


