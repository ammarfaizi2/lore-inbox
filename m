Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSKTCol>; Tue, 19 Nov 2002 21:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSKTCol>; Tue, 19 Nov 2002 21:44:41 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:17406 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S265603AbSKTCoj>; Tue, 19 Nov 2002 21:44:39 -0500
Date: Tue, 19 Nov 2002 18:49:29 -0800
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove duplicated assignment from sys_capget.
Message-ID: <20021119184929.C5801@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
References: <20021010144715.A30806@figure1.int.wirex.com> <Pine.LNX.4.44.0210111954280.5671-100000@home.transmeta.com> <20021119211453.GA20562@nevyn.them.org> <20021119165556.A5806@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021119165556.A5806@figure1.int.wirex.com>; from chris@wirex.com on Tue, Nov 19, 2002 at 04:55:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chris@wirex.com) wrote:
> I'll follow up with the patch that removes the duplicate code.

This patch, relative to the last patch in this thread, removes the
code from cap_sysget that fills out the capability set being returned
to userspace.  The module handles this in a policy specific way.  This
updates the dummy.c module to fill in return data according to superuser
policy, and also disables setting capabilities in superuser policy.

[PATCH] remove duplicated assignment from sys_capget.

===== kernel/capability.c 1.6 vs edited =====
--- 1.6/kernel/capability.c	Tue Nov 19 15:57:15 2002
+++ edited/kernel/capability.c	Tue Nov 19 15:59:38 2002
@@ -63,9 +63,6 @@
      } else
 	     target = current;
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
===== security/dummy.c 1.4 vs edited =====
--- 1.4/security/dummy.c	Fri Oct 11 14:22:54 2002
+++ edited/security/dummy.c	Tue Nov 19 14:58:11 2002
@@ -27,6 +27,17 @@
 static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
 			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
 {
+	*effective = *inheritable = *permitted = 0;
+	if (!issecure(SECURE_NOROOT)) {
+		if (target->euid == 0) {
+			*permitted |= (~0 & ~CAP_FS_MASK);
+			*effective |= (~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
+		}
+		if (target->fsuid == 0) {
+			*permitted |= CAP_FS_MASK;
+			*effective |= CAP_FS_MASK;
+		}
+	}
 	return 0;
 }
 
@@ -35,7 +46,7 @@
 			       kernel_cap_t * inheritable,
 			       kernel_cap_t * permitted)
 {
-	return 0;
+	return -EPERM;
 }
 
 static void dummy_capset_set (struct task_struct *target,
