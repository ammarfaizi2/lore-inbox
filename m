Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSHONUB>; Thu, 15 Aug 2002 09:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSHONUB>; Thu, 15 Aug 2002 09:20:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47592 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316887AbSHONUA>;
	Thu, 15 Aug 2002 09:20:00 -0400
Date: Thu, 15 Aug 2002 15:24:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151235560.3306-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151519330.8275-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doh, one more problem popped up while implementing support for this, which
needs a change in the interface again - this time it should be the final
solution. glibc does not pass in the true top of the stack to clone(), but
rather the address of the start function's parameter frame. So the
VM_RELEASE will overwrite the first parameter.

it is much cleaner anyway to pass in the address of the user-space VM lock
- this will also enable arbitrary implementations of the stack-unlock, as
the fifth clone() parameter. Patch against BK-curr attached.

with this it now works fine. (previously it only appeared to work fine -
but it leaked stackspace.)

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
+		p->user_vm_lock = (long *) childregs->edi;
 	return 0;
 }
 

