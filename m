Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWHVOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWHVOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWHVOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:10:25 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:8344 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932264AbWHVOKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:10:24 -0400
Date: Tue, 22 Aug 2006 22:34:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060822183431.GB469@oleg>
References: <20060821170604.GA1640@oleg> <20060822000110.GA31751@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822000110.GA31751@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Bill Huey wrote:
>
> On Mon, Aug 21, 2006 at 09:06:04PM +0400, Oleg Nesterov wrote:
> > (Compile tested).
> > 
> > futex_find_get_task:
> > 
> > 	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
> > 		return NULL;
> > 
> > I can't understand this. First, p->state can't be EXIT_ZOMBIE. The ->exit_state
> > check looks strange too. Sub-threads or tasks whose ->parent ignores SIGCHLD go
> > directly to EXIT_DEAD state (I am ignoring a ptrace case). Why EXIT_DEAD tasks
> > should be ok? Yes, EXIT_ZOMBIE is more important (a task may stay zombie for a
> > long time), but this doesn't mean we should explicitely ignore other EXIT_XXX
> > states.
> 
> The p->state variable for EXIT_ZOMBIE is only live for some mystery architecture
> in arch/xtensa/kernel/ptrace.c

Thanks. This

	case PTRACE_KILL:
		ret = 0;
		if (child->state == EXIT_ZOMBIE)	/* already dead */
			break;

is an obvious bug, I beleive. May I suggest you to make a patch?

Oleg.

