Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSHOKeW>; Thu, 15 Aug 2002 06:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHOKeW>; Thu, 15 Aug 2002 06:34:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37036 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316682AbSHOKeV>;
	Thu, 15 Aug 2002 06:34:21 -0400
Date: Thu, 15 Aug 2002 12:38:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208150836120.2197-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151235560.3306-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +		childregs->esp -= sizeof(0UL);
> > +		p->user_vm_lock = (long *) childregs->esp;
> 
> you are right. Fix against BK-curr attached.

in fact testing these changes in glibc revealed another thing - the top of
the thread's stack has to be 16-byte aligned (for SSE2 support), so the
attached patch ontop of BK-curr would be a better solution, it does not
modify the thread's stack alignment but simply writes to the top of the
stack. (which is the first word of the thread control block.) This removes
a few instructions both from glibc and from the kernel.

	Ingo

--- arch/i386/kernel/process.c.orig	Thu Aug 15 08:37:52 2002
+++ arch/i386/kernel/process.c	Thu Aug 15 12:36:57 2002
@@ -625,10 +625,8 @@
 	/*
 	 * Does the userspace VM want any unlock on mm_release()?
 	 */
-	if (clone_flags & CLONE_RELEASE_VM) {
-		childregs->esp -= sizeof(0UL);
-		p->user_vm_lock = (long *) esp;
-	}
+	if (clone_flags & CLONE_RELEASE_VM)
+		p->user_vm_lock = (long *) childregs->esp;
 	return 0;
 }
 

