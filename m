Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbSLRXV6>; Wed, 18 Dec 2002 18:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbSLRXV6>; Wed, 18 Dec 2002 18:21:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47377 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267438AbSLRXV4>;
	Wed, 18 Dec 2002 18:21:56 -0500
Date: Wed, 18 Dec 2002 15:27:15 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] LSM changes for 2.5.52
Message-ID: <20021218232714.GC1782@kroah.com>
References: <20021218231917.GA1782@kroah.com> <20021218232125.GB1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218232125.GB1782@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.899, 2002/12/18 14:58:27-08:00, wli@holomorphy.com

[PATCH] converting cap_set_pg() to for_each_task_pid()

cap_set_pg() wants to find all processes in a given process group. This
converts it to use for_each_task_pid().


diff -Nru a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c	Wed Dec 18 15:13:37 2002
+++ b/kernel/capability.c	Wed Dec 18 15:13:37 2002
@@ -84,13 +84,15 @@
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
-     task_t *g, *target;
+	task_t *g, *target;
+	struct list_head *l;
+	struct pid *pid;
 
-     do_each_thread(g, target) {
-             if (target->pgrp != pgrp)
-                     continue;
-	     security_capset_set(target, effective, inheritable, permitted);
-     } while_each_thread(g, target);
+	for_each_task_pid(pgrp, PIDTYPE_PGID, g, l, pid) {
+		target = g;
+		while_each_thread(g, target)
+			security_capset_set(target, effective, inheritable, permitted);
+	}
 }
 
 /*
