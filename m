Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUKHSHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUKHSHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUKHRE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:04:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:26795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261912AbUKHQNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:13:14 -0500
Date: Mon, 8 Nov 2004 08:13:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dino@in.ibm.com
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
In-Reply-To: <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org>
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
 <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Linus Torvalds wrote:
> 
> In fact, it looks like the "bail_ref" case has _another_ bug: since it 
> returns zero, we may still be _using_ the task pointer (to get to the next 
> task), so we must NOT do a "put_task_struct()" intil we've re-acquired the 
> tasklist_lock.

Actually, this part of the patch is bogus. If our "put_task_struct" is the
last one, it doesn't help at all that we're insidfe the tasklist_lock. 
We'll just release the task structure ourselves.

The problem remains, though: "do_wait()" does end up accessing "tsk" in

	tsk = next_thread(tsk);

and as far as I can see, "tsk" may be gone by then.

Is there anything else protecting us? This looks like a serious (if 
extremely unlikely) bug..

Anyway, here's an updated patch for Sripathi's original problem, with a 
better comment, and with the put_task_struct back where it was originally 
since it shouldn't matter.

Help me, Obi-Wan McGrath,

		Linus

----
===== kernel/exit.c 1.166 vs edited =====
--- 1.166/kernel/exit.c	2004-11-04 11:13:19 -08:00
+++ edited/kernel/exit.c	2004-11-08 08:08:18 -08:00
@@ -1202,6 +1202,18 @@
 bail_ref:
 		put_task_struct(p);
 		read_lock(&tasklist_lock);
+
+		/*
+		 * We are returning to the wait loop without having successfully
+		 * removed the process, and a zero value. That means that the wait
+		 * will continue - but somebody else might have reaped a child
+		 * (maybe this one) that we already decided was eligible.
+		 *
+		 * As a result, we need to make sure that we don't wait for
+		 * children forever - they might be all gone. So mark us
+		 * running, and the "schedule()" in do_wait() is fine.
+		 */
+		current->state = TASK_RUNNING;
 		return 0;
 	}
 
