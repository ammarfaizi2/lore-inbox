Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSIICfO>; Sun, 8 Sep 2002 22:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSIICfN>; Sun, 8 Sep 2002 22:35:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33445 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316213AbSIICfN>;
	Sun, 8 Sep 2002 22:35:13 -0400
Date: Mon, 9 Sep 2002 04:45:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: pinpointed: PANIC caused by dequeue_signal() in current Linus 
 BK tree
In-Reply-To: <Pine.LNX.4.44.0209081835260.1401-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209090405010.6603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the bootup crash. There were two initialization
bugs:

	- INIT_SIGNAL needs to set shared_pending.

	- exec() needs to set up newsig properly.

the second one caused the crash Anton saw.

	Ingo

--- linux/arch/i386/kernel/init_task.c.orig	Mon Sep  9 04:04:01 2002
+++ linux/arch/i386/kernel/init_task.c	Mon Sep  9 04:04:35 2002
@@ -10,7 +10,7 @@
 
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
-static struct signal_struct init_signals = INIT_SIGNALS;
+static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
--- linux/include/linux/init_task.h.orig	Mon Sep  9 04:02:19 2002
+++ linux/include/linux/init_task.h	Mon Sep  9 04:08:08 2002
@@ -29,10 +29,11 @@
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),	\
 }
 
-#define INIT_SIGNALS {	\
+#define INIT_SIGNALS(sig) {	\
 	.count		= ATOMIC_INIT(1), 		\
 	.action		= { {{0,}}, }, 			\
-	.siglock	= SPIN_LOCK_UNLOCKED 		\
+	.siglock	= SPIN_LOCK_UNLOCKED, 		\
+	.shared_pending	= { NULL, &sig.shared_pending.head, {{0}}}, \
 }
 
 /*
--- linux/fs/exec.c.orig	Mon Sep  9 04:40:49 2002
+++ linux/fs/exec.c	Mon Sep  9 04:41:28 2002
@@ -514,6 +514,8 @@
 	spin_lock_init(&newsig->siglock);
 	atomic_set(&newsig->count, 1);
 	memcpy(newsig->action, current->sig->action, sizeof(newsig->action));
+	init_sigpending(&newsig->shared_pending);
+
 	spin_lock_irq(&current->sigmask_lock);
 	current->sig = newsig;
 	spin_unlock_irq(&current->sigmask_lock);

