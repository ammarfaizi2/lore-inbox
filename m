Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUKHTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUKHTId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUKHRDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:03:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:11683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261871AbUKHQBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:01:46 -0500
Date: Mon, 8 Nov 2004 08:01:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dino@in.ibm.com
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
In-Reply-To: <418F826C.2060500@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
 <418F826C.2060500@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Sripathi Kodi wrote:
> 
> Thanks for your suggestions. I have attached the re-done patch. I have 
> implemented your first suggestion because it was much easier. I hope it 
> looks better now.

Hmm.. I'm a grumpy old man, and I'm not happy yet. Feel free to explain to 
me why I'm wrong, though - I don't mind.

> --- linux-2.6.10-rc1/kernel/exit.c	2004-11-08 23:38:17.358375128 +0530
> +++ /home/sripathi/12013/patch/take2/exit.c	2004-11-08 23:33:44.973783880 +0530
> @@ -1345,8 +1345,10 @@ repeat:
>  				break;
>  			default:
>  			// case EXIT_DEAD:
> -				if (p->exit_state == EXIT_DEAD)
> -					continue;
> +				if (p->exit_state == EXIT_DEAD) {
> +					current->state = TASK_RUNNING;
> +					break;
> +				}

Why here? We haven't actually released the lock, so I don't see why we'd 
consider this a special case..

That said, I wonder if we should consider this kind of task non-eligible. 
It may well be a bug to consider a EXIT_DEAD child to be eligible for 
waiting, since we can't actually ever reap it any more. So maybe you found 
a bug, but the fix might be to check this case in "eligible_child()"?

Roland?

>  			// case EXIT_ZOMBIE:
>  				if (p->exit_state == EXIT_ZOMBIE) {
>  					/*
> @@ -1363,6 +1365,7 @@ repeat:
>  					/* He released the lock.  */
>  					if (retval != 0)
>  						goto end;
> +					current->state = TASK_RUNNING;
>  					break;
>  				}

There are cases where 'wait_task_zombie()' will return 0 _without_ 
releasing the lock, and you now made those be busy-loops (with a 
"schedule()", so the machine still works, it just eats CPU time like mad).

I think the _real_ case is the "wait_noreap_copyout()", case, but that 
already returns non-zero in case it released the lock, so it looks all 
good already.

In fact, I think the only case we care about is actually in 
wait_task_stopped(), in the "bail_ref:" case. That's where we have 
released the lock and potentially another process came in and reaped it, 
but we still return zero.

That case should set itself to running, so that we don't sleep forever.

In fact, it looks like the "bail_ref" case has _another_ bug: since it 
returns zero, we may still be _using_ the task pointer (to get to the next 
task), so we must NOT do a "put_task_struct()" intil we've re-acquired the 
tasklist_lock.

And I think _those_ two things were the real bugs. Does this patch fix it 
for you?

Roland, I'd still love to hear your input on the EXIT_DEAD case. Is it 
reapable?

		Linus

-----
===== kernel/exit.c 1.166 vs edited =====
--- 1.166/kernel/exit.c	2004-11-04 11:13:19 -08:00
+++ edited/kernel/exit.c	2004-11-08 08:00:12 -08:00
@@ -1200,8 +1200,10 @@
 		 */
 		write_unlock_irq(&tasklist_lock);
 bail_ref:
-		put_task_struct(p);
 		read_lock(&tasklist_lock);
+		put_task_struct(p);
+		/* When the waiter does a sched(), we need to re-start the loop! */
+		current->state = TASK_RUNNING;
 		return 0;
 	}
 
