Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267557AbSKQStd>; Sun, 17 Nov 2002 13:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbSKQStc>; Sun, 17 Nov 2002 13:49:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:56494 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267557AbSKQStb>;
	Sun, 17 Nov 2002 13:49:31 -0500
Date: Sun, 17 Nov 2002 21:13:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211171023060.4425-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211172111030.12699-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the first patch, the introduction of the sys_set_thread_address()  
syscall. It returns the PID so that the newly initialized 'initial thread'
does not have to do an additional sys_gettid() call.

	Ingo

--- linux/arch/i386/kernel/entry.S.orig	2002-11-17 20:53:52.000000000 +0100
+++ linux/arch/i386/kernel/entry.S	2002-11-17 20:54:55.000000000 +0100
@@ -767,6 +767,7 @@
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
+ 	.long sys_set_tid_address
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
--- linux/kernel/fork.c.orig	2002-11-17 20:53:52.000000000 +0100
+++ linux/kernel/fork.c	2002-11-17 20:54:55.000000000 +0100
@@ -676,6 +676,13 @@
 	p->flags = new_flags;
 }
 
+asmlinkage int sys_set_tid_address(int *user_tid)
+{
+	current->user_tid = user_tid;
+
+	return current->pid;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.

