Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWG0LRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWG0LRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWG0LRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:17:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56245 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751133AbWG0LRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:17:09 -0400
Date: Thu, 27 Jul 2006 13:16:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Make suspend possible with a traced process at a breakpoint
Message-ID: <20060727111655.GB1762@elf.ucw.cz>
References: <200607270914.08774.rjw@sisk.pl> <200607270941.45876.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607270941.45876.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It should be possible to suspend, either to RAM or to disk, if there's a
> traced process that has just reached a breakpoint.  However, this is a special
> case, because its parent process might have been frozen already and then
> we are unable to deliver the "freeze" signal to the traced process.  If this
> happens, it's better to cancel the freezing of the traced process.

Thanks for debugging this.

> @@ -85,6 +97,10 @@ int freeze_processes(void)
>  				continue;
>  			if (frozen(p))
>  				continue;
> +			if (p->state == TASK_TRACED && frozen(p->parent)) {
> +				cancel_freezing(p);
> +				continue;
> +			}

Could we just add line to freezeable, like this?

...no, this is probably racy, because freezeable() should not change
while we are thawing other processes... I was hoping for one-liner...

diff --git a/kernel/power/process.c b/kernel/power/process.c
index b2a5f67..13dceb8 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -26,6 +26,7 @@ static inline int freezeable(struct task
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
+	    ((p->exit_state == TASK_TRACED) && frozen(p->parent)) ||
 	    (p->state == TASK_STOPPED))
 		return 0;
 	return 1;

...okay, so ACK on your patch.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
