Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVECRU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVECRU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVECRU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:20:29 -0400
Received: from mail.aknet.ru ([82.179.72.26]:14093 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261419AbVECRUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:20:14 -0400
Message-ID: <4277B2EC.70605@aknet.ru>
Date: Tue, 03 May 2005 21:20:44 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Mateusz Berezecki <mateuszb@gmail.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.12-rc3 OOPS  in vanilla source (once more)
References: <42763388.1030008@gmail.com>	 <20050502200545.266b4e55.akpm@osdl.org> <1115120050.945.39.camel@localhost.localdomain>
In-Reply-To: <1115120050.945.39.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------070000010800090302090808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000010800090302090808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Alexander Nyberg wrote:
> So, my solution is to instead of just adjusting esp0 that creates an
> inconsitent state I adjust where the user-space registers are saved with
> -8 bytes.
When I did that offending patch,
I was thinking the following way:
- Do we need to adjust that initial
copy of child regs by the 8 bytes too?
- Well, we need that 8 bytes only
when the "struct pt_regs" is incomplete.
Here we copy the *complete* "struct pt_regs",
so shifting that here makes no sense.

And so I adjusted only esp0 and
nothing else. I think this may
actually still be valid.

> This gives us the wanted extra bytes on the start of the stack
> and esp0 is now correct.
Yes, it is now correct by the mean
that it points to the top of the
"struct pt_regs" on the thread startup.
However, it is not *always* points
to the top of the "struct pt_regs".
This -8 means exactly that esp0 can
also point 8 bytes below the top of
the "struct pt_regs" - that's what
we've seen on a sysenter path, and
that's what used crash either.
So I think using esp0 to locate the
top of the "struct pt_regs" is wrong.
It doesn't always point to the top
of that struct. Sometimes it does,
but sometimes points 8 bytes lower.
IMHO the ptrace.c have to be fixed
instead so to not use this wrong
assumption any more. What do you think?

Btw, I attached the slightly "optimized"
version of your patch (haven't tested).
Just to avoid a few assignments/typecasts.


--------------070000010800090302090808
Content-Type: text/x-patch;
 name="process.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="process.c.diff"

--- process.c.old	2005-05-03 20:15:39.000000000 +0400
+++ process.c	2005-05-03 20:41:25.000000000 +0400
@@ -399,12 +399,6 @@
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
-	*childregs = *regs;
-	childregs->eax = 0;
-	childregs->esp = esp;
-
-	p->thread.esp = (unsigned long) childregs;
 	/*
 	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
 	 * This is necessary to guarantee that the entire "struct pt_regs"
@@ -415,7 +409,13 @@
 	 * "struct pt_regs" is possible, but they may contain the
 	 * completely wrong values.
 	 */
-	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
+	childregs = ((struct pt_regs *) (THREAD_SIZE - 8 + (unsigned long)p->thread_info)) - 1;
+	*childregs = *regs;
+	childregs->eax = 0;
+	childregs->esp = esp;
+
+	p->thread.esp = (unsigned long) childregs;
+	p->thread.esp0 = (unsigned long) (childregs+1);
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 


--------------070000010800090302090808--
