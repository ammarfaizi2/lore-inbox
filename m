Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267442AbUG3I0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267442AbUG3I0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUG3I0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:26:52 -0400
Received: from imap.gmx.net ([213.165.64.20]:43496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267442AbUG3I0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:26:49 -0400
X-Authenticated: #1725425
Date: Fri, 30 Jul 2004 10:27:26 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Roger Luethi <rl@hellgate.ch>
Cc: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-Id: <20040730102726.57519859.Ballarin.Marc@gmx.de>
In-Reply-To: <20040729235654.GA19664@k3.hellgate.ch>
References: <200407222204.46799.rob@landley.net>
	<20040729235654.GA19664@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 01:56:54 +0200
Roger Luethi <rl@hellgate.ch> wrote:

> If somebody posted a solution for this, I didn't see it. There's a race
> in the kernel, and considering the permissions on
> /proc/PID/{cmdline,environ} a security bug as well: If you win the race
> with a starting process, you can read its environment.
> 
> This should plug the hole. Can you give it a spin?
> 
> Roger
> 
> --- linux-2.6.8-rc2-bk1/fs/proc/base.c.orig	2004-07-30 01:43:23.535967505 +0200
> +++ linux-2.6.8-rc2-bk1/fs/proc/base.c	2004-07-30 01:43:27.428303752 +0200
> @@ -329,6 +329,8 @@ static int proc_pid_cmdline(struct task_
>  	struct mm_struct *mm = get_task_mm(task);
>  	if (!mm)
>  		goto out;
> +	if (!mm->arg_end)
> +		goto out;	/* Shh! No looking before we're done */
>  
>   	len = mm->arg_end - mm->arg_start;
>   

Yes, this seems to fix it. First I replaced "goto out" with a printk, and
the printks matched the occurence of the bug.
However, I got multiple printks per bug (between 2 and 7). Is that
supposed to happen?

Anyway, I've added back the "goto out" (after printk), and the bug no
longer
occurs. The printk still happens, so this code path does get hit.


Regards, and thanks for the fix
