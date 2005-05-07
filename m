Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVEGBJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVEGBJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 21:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVEGBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 21:09:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:42219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261435AbVEGBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 21:09:22 -0400
Date: Fri, 6 May 2005 18:08:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, cw@f00f.org,
       andre@cachola.com.br
Subject: Re: A patch for the file kernel/fork.c
Message-Id: <20050506180836.2d431ab2.akpm@osdl.org>
In-Reply-To: <1115307176.3993.9.camel@localhost.localdomain>
References: <4278E03A.1000605@cachola.com.br>
	<20050504175457.GA31789@taniwha.stupidest.org>
	<427913E4.3070908@cachola.com.br>
	<20050504184318.GA644@taniwha.stupidest.org>
	<42791CD2.5070408@cachola.com.br>
	<1115234213.2562.28.camel@localhost.localdomain>
	<20050504124104.3573e7f3.akpm@osdl.org>
	<1115241687.2562.50.camel@localhost.localdomain>
	<1115300887.21180.14.camel@localhost.localdomain>
	<1115307176.3993.9.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> +	/* We're taking recursive faults here in do_exit. Safest 
>  +	 * is to just leave this task alone and wait for reboot. */

I find this comment-block style a bit hard to maintain, and am anal about
consistency.

>  +	if (unlikely(tsk->flags & PF_EXITING)) {
>  +		printk(KERN_ALERT "\nFixing recursive fault but reboot is needed!\n");
>  +		set_current_state(TASK_UNINTERRUPTIBLE);
>  +		schedule();
>  +	}
>  +

In the printk string, a \n will terminate the current facility level, so
your KERN_ALERT there is a no-op.  I simply removed it, which might cause
messy output sometimes but that seems better than always adding a newline.


--- 25/kernel/exit.c~avoid-recursive-oopses	2005-05-06 18:03:45.000000000 -0700
+++ 25-akpm/kernel/exit.c	2005-05-06 18:06:01.000000000 -0700
@@ -795,6 +795,17 @@ fastcall NORET_TYPE void do_exit(long co
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	/*
+	 * We're taking recursive faults here in do_exit. Safest is to just
+	 * leave this task alone and wait for reboot.
+	 */
+	if (unlikely(tsk->flags & PF_EXITING)) {
+		printk(KERN_ALERT
+			"Fixing recursive fault but reboot is needed!\n");
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule();
+	}
+
 	tsk->flags |= PF_EXITING;
 
 	/*
_

