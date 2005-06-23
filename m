Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVFWIsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVFWIsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVFWIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:45:28 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:25046 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S263053AbVFWIRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:17:25 -0400
Date: Thu, 23 Jun 2005 10:17:29 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
Message-ID: <20050623101729.0d89dff6@frecb000711.frec.bull.fr>
In-Reply-To: <20050621235144.15fc55c6.akpm@osdl.org>
References: <42B46C18.2030101@superbug.demon.co.uk>
	<20050621235144.15fc55c6.akpm@osdl.org>
Organization: BULL SA.
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/06/2005 10:28:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/06/2005 10:28:47,
	Serialize complete at 23/06/2005 10:28:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 23:51:44 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Someone does a call_usermodehelper() which uses CLONE_VFORK.  The new
> process at `p' exits quickly so when the parent returns from
> wait_for_completion() it is left with freed memory at *p.  When the parent
> tries to reference p->pid we oops due to the use-after-free bug.
> 
> Guillaume, I'll do this for now:
> 
> --- 25/kernel/fork.c~connector-add-a-fork-connector-use-after-free-fix	2005-06-21 23:46:35.000000000 -0700
> +++ 25-akpm/kernel/fork.c	2005-06-21 23:46:58.000000000 -0700
> @@ -1248,14 +1248,15 @@ long do_fork(unsigned long clone_flags,
>  			ptrace_notify ((trace << 8) | SIGTRAP);
>  		}
>  
> +		fork_connector(current->tgid, current->pid, p->tgid, p->pid);
> +
>  		if (clone_flags & CLONE_VFORK) {
> +
>  			wait_for_completion(&vfork);
>  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
> -				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
> +				ptrace_notify((PTRACE_EVENT_VFORK_DONE << 8) |
> +						SIGTRAP);
>  		}
> -
> -		fork_connector(current->tgid, current->pid,
> -		               p->tgid, p->pid);
>  	} else {
>  		free_pidmap(pid);
>  		pid = PTR_ERR(p);
> _
> 
> 
> But you need to work out what semantics you want for vfork()?

The information about the creation of a new process is sent through the
connector and it's available to every application that is connected to
the fork connector even if this new process is an "helper" program or
has the CLONE_VFORK flag set. The problem with "helper" program is that
we can not know if it is terminated but it's the problem of the
application that uses this kind of information. 

So I think the fix is correct and the application that uses the fork
connector will take the decision if the sending information is
interesting or not. To help the application in this choice it could be
interesting to add the 'clone_flags' in the fork_connector() parameters.
By doing this we could know if two processes run in the same memory
space or share other ressources. I'm working on this. 


Thank you for your help,

Guillaume
