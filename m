Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbSJJVwM>; Thu, 10 Oct 2002 17:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbSJJVuh>; Thu, 10 Oct 2002 17:50:37 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:4862 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262392AbSJJVtv>; Thu, 10 Oct 2002 17:49:51 -0400
Date: Thu, 10 Oct 2002 14:47:15 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 capget fix
Message-ID: <20021010144715.A30806@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20021009171500.B25393@figure1.int.wirex.com> <Pine.LNX.4.44.0210101235290.2750-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210101235290.2750-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 10, 2002 at 12:36:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@transmeta.com) wrote:
> On Wed, 9 Oct 2002, Chris Wright wrote:
> > 
> > Daniel Jacobowitz noticed that sys_capget is not behaving properly when
> > called with pid of 0.  It is supposed to return current capabilities,
> > not those of swapper.  Also cleaned up some duplicate code from a merge
> > error.  Patch is tested, please apply.
> 
> This is not correct. You drop the tasklist_lock before you actually set 
> read the capabilities, which means that by the time you read them, the 
> task you looked up may not be there any more.

Doh...feeling dumb...

The patch below fixes my oversight.  The locking is left the way it was,
and just the pid 0 part is fixed as well as the duplicate code removed.
This still applies against bk-curr and I tested it on 2.5.41.

thanks,
-chris

--- 2.5.41/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ 2.4.41-capget/kernel/capability.c	Thu Oct 10 14:36:29 2002
@@ -33,7 +33,7 @@
      int ret = 0;
      pid_t pid;
      __u32 version;
-     task_t *target;
+     task_t *target = current;
      struct __user_cap_data_struct data;
 
      if (get_user(version, &header->version))
@@ -54,15 +54,14 @@
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
-     target = find_task_by_pid(pid);
-     if (!target) {
-          ret = -ESRCH;
-          goto out;
+     if (pid && pid != current->pid) {
+	     target = find_task_by_pid(pid);
+	     if (!target) {
+	          ret = -ESRCH;
+	          goto out;
+	     }
      }
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
