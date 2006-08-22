Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHVWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHVWDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHVWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:03:38 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:55442
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750720AbWHVWDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:03:37 -0400
Date: Tue, 22 Aug 2006 15:03:20 -0700
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Joe Taylor <joe@tensilica.com>
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060822220320.GA8365@gnuppy.monkey.org>
References: <20060821170604.GA1640@oleg> <20060822000110.GA31751@gnuppy.monkey.org> <20060822183431.GB469@oleg>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20060822183431.GB469@oleg>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2006 at 10:34:31PM +0400, Oleg Nesterov wrote:
> On 08/21, Bill Huey wrote:
> > On Mon, Aug 21, 2006 at 09:06:04PM +0400, Oleg Nesterov wrote:
> > > (Compile tested).
> > > 
> > > futex_find_get_task:
> > > 
> > > 	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
> > > 		return NULL;
> > > 
> > > I can't understand this. First, p->state can't be EXIT_ZOMBIE. The ->exit_state
> > > check looks strange too. Sub-threads or tasks whose ->parent ignores SIGCHLD go
> > > directly to EXIT_DEAD state (I am ignoring a ptrace case). Why EXIT_DEAD tasks
> > > should be ok? Yes, EXIT_ZOMBIE is more important (a task may stay zombie for a
> > > long time), but this doesn't mean we should explicitely ignore other EXIT_XXX
> > > states.
> > 
> > The p->state variable for EXIT_ZOMBIE is only live for some mystery architecture
> > in arch/xtensa/kernel/ptrace.c
> 
> Thanks. This
> 
> 	case PTRACE_KILL:
> 		ret = 0;
> 		if (child->state == EXIT_ZOMBIE)	/* already dead */
> 			break;
> 
> is an obvious bug, I beleive. May I suggest you to make a patch?

Oleg,

Here is it. Maintainers CCed...

bill


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t.diff"

# 
# old_revision [d374cc860b7089468eb87b56425bb462a955b138]
# 
# patch "arch/xtensa/kernel/ptrace.c"
#  from [4ae4da59c97b72d41f6d2b38ef83f33ee8e5e3e3]
#    to [6be23f16368960b0da9f77911406e7c495396001]
# 
============================================================
--- arch/xtensa/kernel/ptrace.c	4ae4da59c97b72d41f6d2b38ef83f33ee8e5e3e3
+++ arch/xtensa/kernel/ptrace.c	6be23f16368960b0da9f77911406e7c495396001
@@ -212,7 +212,7 @@
 	 */
 	case PTRACE_KILL:
 		ret = 0;
-		if (child->state == EXIT_ZOMBIE)	/* already dead */
+		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
 			break;
 		child->exit_code = SIGKILL;
 		child->ptrace &= ~PT_SINGLESTEP;

--W/nzBZO5zC0uMSeA--
