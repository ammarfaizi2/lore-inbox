Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVDXJq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDXJq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 05:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVDXJqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 05:46:25 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:42663 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261535AbVDXJqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 05:46:20 -0400
Message-ID: <426B6C84.E8D41D57@tv-sign.ru>
Date: Sun, 24 Apr 2005 13:53:08 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Juergen Kreileder <jk@blackdown.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
		 <87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
		 <1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
		 <20050423170152.6b308c74.akpm@osdl.org>  <87fyxhj5p1.fsf@blackdown.de> <1114308928.5443.13.camel@gaston>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>
> I'll have a look at the timer patch next week, they might have some
> subtle race caused by a lack of memory barrier. I've had to debug some
> of those in early timer code, and those are really nasty, they usually
> only trigger under some subtle conditions, like ... heavy networking.

Before this timer patch del_timer(pending_timer) worked as
a memory barrier for the caller, now it does not.

For example, sk_stop_timer() does:

	if (del_timer(timer))
		// no more wmb() here
		atomic_dec(&sk->sk_refcnt);

I think that this particular case is ok, but may be there is
some user of timers which lacks the memory barrier?

Juergen Kreileder wrote:
>
> It only happens when running Azareus with IBM's Java (our's isn't ready yet).
> So far I was able to reproduce the problem on all -mm versions within
> one hour.  Otherwise the kernels seem to work fine -- no lockup unless
> I run Azareus.

By any chance, could you please try this patch?
It restores "deleting timer acts as a barrier" behaviour.

--- 2.6.12-rc2+timer_patches/kernel/timer.c~	Sun Apr 24 11:59:31 2005
+++ 2.6.12-rc2+timer_patches/kernel/timer.c	Sun Apr 24 13:35:01 2005
@@ -341,6 +341,9 @@ int del_timer(struct timer_list *timer)
 		spin_unlock_irqrestore(&base->lock, flags);
 	}
 
+	if (ret)
+		smp_wmb();
+
 	return ret;
 }
 
@@ -387,6 +390,10 @@ unlock:
 		spin_unlock_irqrestore(&base->lock, flags);
 	} while (ret < 0);
 
+	if (ret)
+		smp_wmb();
+	smp_rmb();
+
 	return ret;
 }
 
@@ -457,6 +464,7 @@ repeat:
 
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
+			smp_wmb();
 			spin_unlock_irq(&base->t_base.lock);
 			{
 				u32 preempt_count = preempt_count();
