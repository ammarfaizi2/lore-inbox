Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUEKIq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUEKIq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEKIq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:46:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:7554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbUEKIqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:46:43 -0400
Date: Tue, 11 May 2004 01:46:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 2/11] add sigpending field to user_struct
Message-ID: <20040511014639.A21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511014524.Z21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:45:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sigpending field to user_struct, and make sure it's properly
initialized.

===== include/linux/sched.h 1.210 vs edited =====
--- 1.210/include/linux/sched.h	Mon May 10 04:25:34 2004
+++ edited/include/linux/sched.h	Mon May 10 18:22:10 2004
@@ -314,6 +314,7 @@
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t sigpending;	/* How many pending signals does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
===== kernel/user.c 1.9 vs edited =====
--- 1.9/kernel/user.c	Mon May 10 04:25:43 2004
+++ edited/kernel/user.c	Mon May 10 18:22:10 2004
@@ -30,7 +30,8 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.sigpending	= ATOMIC_INIT(0),
 };
 
 /*
@@ -108,6 +109,7 @@
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->sigpending, 0);
 
 		/*
 		 * Before adding this, check whether we raced
