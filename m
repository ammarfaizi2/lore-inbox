Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275065AbTHNSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275077AbTHNSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:33:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:43442 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275065AbTHNSdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:33:22 -0400
Date: Thu, 14 Aug 2003 11:33:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD
 without CLONE_DETACHED
In-Reply-To: <20030814182757.GA11623@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0308141130300.1692-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Aug 2003, Jamie Lokier wrote:
> 
> I'm thinking of programs that don't use Glibc, but do use these features.
> Perhaps I'm the only person who writes such code :)

Sure, there have always been projects out there that have used the
"native" clone() interfaces, but they're fairly rare, and CLONE_THREAD
being a new addition makes it less likely to show up as a problem.

> > But yes, there will be a warning, at least for a time (and eventually 
> > we'll just return -EINVAL silently - ie the program will _fail_ the 
> > clone(), it won't just act strangely).
> 
> -EINVAL would be great.

I've pushed the change to the BK trees, and if you're not a BK user you
can just test the attached patch directly to see if it affects you..

		Linus

----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1149  -> 1.1150 
#	include/linux/sched.h	1.159   -> 1.160  
#	       kernel/fork.c	1.134   -> 1.135  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/14	torvalds@home.osdl.org	1.1150
# Mark CLONE_DETACHED as being irrelevant: it must match CLONE_THREAD.
# 
# CLONE_THREAD without CLONE_DETACHED will now return -EINVAL, and
# for a while we will warn about anything that uses it (there are no
# known users, but this will help pinpoint any problems if somebody
# used to care about the invalid combination).
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Aug 14 11:32:19 2003
+++ b/include/linux/sched.h	Thu Aug 14 11:32:19 2003
@@ -49,7 +49,7 @@
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
 #define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
 #define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
-#define CLONE_DETACHED		0x00400000	/* parent wants no child-exit signal */
+#define CLONE_DETACHED		0x00400000	/* Not used - CLONE_THREAD implies detached uniquely */
 #define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Aug 14 11:32:19 2003
+++ b/kernel/fork.c	Thu Aug 14 11:32:19 2003
@@ -746,8 +746,22 @@
 	 */
 	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
 		return ERR_PTR(-EINVAL);
-	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
+
+	/*
+	 * CLONE_DETACHED must match CLONE_THREAD: it's a historical
+	 * thing.
+	 */
+	if (!(clone_flags & CLONE_DETACHED) != !(clone_flags & CLONE_THREAD)) {
+		/* Warn about the old no longer supported case so that we see it */
+		if (clone_flags & CLONE_THREAD) {
+			static int count;
+			if (count < 5) {
+				count++;
+				printk(KERN_WARNING "%s trying to use CLONE_THREAD without CLONE_DETACH\n", current->comm);
+			}
+		}
 		return ERR_PTR(-EINVAL);
+	}
 
 	retval = security_task_create(clone_flags);
 	if (retval)
@@ -877,10 +891,7 @@
 	p->parent_exec_id = p->self_exec_id;
 
 	/* ok, now we should be set up.. */
-	if (clone_flags & CLONE_DETACHED)
-		p->exit_signal = -1;
-	else
-		p->exit_signal = clone_flags & CSIGNAL;
+	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
 
 	/*

