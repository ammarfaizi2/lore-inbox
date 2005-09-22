Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVIVEui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVIVEui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVIVEui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:50:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58619 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750909AbVIVEuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:50:37 -0400
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1127345874.19506.43.camel@dhcp153.mvista.com>
	 <433201FC.8040004@yahoo.com.au>
	 <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 21:50:28 -0700
Message-Id: <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Checks for cmpxchg in get_task_struct_rcu() . No race version.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/linux/sched.h
===================================================================
--- linux-2.6.13.orig/include/linux/sched.h
+++ linux-2.6.13/include/linux/sched.h
@@ -1026,13 +1026,24 @@ static inline int get_task_struct_rcu(st
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
+	raw_local_irq_disable();
+	oldusage = atomic_read(&t->usage);
+	if (oldusage == 0) {
+		raw_local_irq_enable();
+		return 0;
+	}
+	atomic_inc(&t->usage);
+	raw_local_irq_enable();
+#endif
 	return 1;
 }
 


