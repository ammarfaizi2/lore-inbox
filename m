Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWIUXfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWIUXfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWIUXfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:35:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46282 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932109AbWIUXfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:35:13 -0400
Subject: Re: [2.6.18-rc7] printk output delay in syslog wrt dmesg still
	unfixed
From: john stultz <johnstul@us.ibm.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <45132018.8070501@imap.cc>
References: <450BF1CC.2070309@imap.cc> <1158691933.18546.3.camel@localhost>
	 <45132018.8070501@imap.cc>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 16:35:11 -0700
Message-Id: <1158881711.1134.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 01:28 +0200, Tilman Schmidt wrote:
> On 19.09.2006 20:52, john stultz wrote:
> > You might try git-bisect to find the offending patch.
> 
> This turned out to be easier than I expected.
> The patch which introduces the problem is:
> 
> [a0f1ccfd8d37457a6d8a9e01acebeefcdfcc306e] lockdep: do not recurse in printk

When you've narrow down a patch, be sure to CC the author (in this case
Ingo).

> Reverting that patch makes the problem disappear in 2.6.18, too.
> In fact, it suffices to revert just the last chunk:
> 
> @@ -809,8 +815,15 @@ void release_console_sem(void)
>         console_may_schedule = 0;
>         up(&console_sem);
>         spin_unlock_irqrestore(&logbuf_lock, flags);
> -       if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
> -               wake_up_interruptible(&log_wait);
> +       if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait)) {
> +               /*
> +                * If we printk from within the lock dependency code,
> +                * from within the scheduler code, then do not lock
> +                * up due to self-recursion:
> +                */
> +               if (!lockdep_internal())
> +                       wake_up_interruptible(&log_wait);
> +       }
>  }
>  EXPORT_SYMBOL(release_console_sem);

Ingo, your thoughts?

thanks
-john

