Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUEKI7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUEKI7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEKI7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:59:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:51336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUEKI6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:58:37 -0400
Date: Tue, 11 May 2004 01:58:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 8/11] add mq_bytes to user_struct
Message-ID: <20040511015833.G21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net> <20040511015357.E21045@build.pdx.osdl.net> <20040511015658.F21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511015658.F21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:56:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add mq_bytes field to user_struct, and make sure it's properly
initialized.

--- 2.6-rlimit/include/linux/sched.h~mqueue_rlimit	2004-05-10 22:29:32.558320808 -0700
+++ 2.6-rlimit/include/linux/sched.h	2004-05-10 22:30:44.527379848 -0700
@@ -315,6 +315,8 @@
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
+	/* protected by mq_lock	*/
+	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
--- 2.6-rlimit/kernel/user.c~mqueue_rlimit	2004-05-10 22:29:03.741701600 -0700
+++ 2.6-rlimit/kernel/user.c	2004-05-10 22:30:44.531379240 -0700
@@ -32,6 +32,7 @@
 	.processes	= ATOMIC_INIT(1),
 	.files		= ATOMIC_INIT(0),
 	.sigpending	= ATOMIC_INIT(0),
+	.mq_bytes	= 0
 };
 
 /*
@@ -111,6 +112,8 @@
 		atomic_set(&new->files, 0);
 		atomic_set(&new->sigpending, 0);
 
+		new->mq_bytes = 0;
+
 		/*
 		 * Before adding this, check whether we raced
 		 * on adding the same user already..
