Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVFIXbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVFIXbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVFIXbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:31:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45042 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262427AbVFIXbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:31:46 -0400
Message-ID: <42A8D12C.7080308@mvista.com>
Date: Thu, 09 Jun 2005 16:30:52 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: RT and timers
References: <Pine.LNX.4.44.0506091520210.11001-100000@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506091520210.11001-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> George, 
> 
> 	I wanted to show you the code below, from the RT patch. I think 
> it's possible that, if the code isn't changed in the way below, the 
> while() loop could run forever. If jiffies is very fast moving , and the 
> softirqd is low priority. Do you have any comments on this?

What you are saying is that it is possible that the kernel will not be able to 
keep up the timer list if we lower its priority.  Making this change just allows 
softirqd to do other things and come right back to this code.  If we care at all 
about timers, we should do a better job of setting priorities.

In the end, I think we will want to go to a system where timers are just moved 
to an expired list on the jiffie interrupt (this is very fast except for the 
cascade, as the whole list is moved in one operation).  The expired list would 
then be processed by a dedicated timer delivery thread that shifts its priority 
to match the priority of the highest priority pending timer.

Thomas Gleixner (added to the cc) is currently working on just such a change.

So, in short, I don't see the point to the suggested change.  If the kernel is 
late, it is best to let it catch up as fast as it can by looping here.  The only 
counter argument that makes sense to me it that in this case we are starving 
other softirqd driven tasks, but that should, if any thing, lighten the timer 
load and let this complete faster.

George
-- 


> 
> Daniel
> 
> 
> @@ -436,13 +437,30 @@ static int cascade(tvec_base_t *base, tv
>  static inline void __run_timers(tvec_base_t *base)
>  {
>         struct timer_list *timer;
> +       unsigned long jiffies_sample = jiffies;
> 
>         spin_lock_irq(&base->lock);
> -       while (time_after_eq(jiffies, base->timer_jiffies)) {
> +       while (time_after_eq(jiffies_sample, base->timer_jiffies)) {
>                 struct list_head work_list = LIST_HEAD_INIT(work_list);
>                 struct list_head *head = &work_list;
>                 int index = base->timer_jiffies & TVR_MASK;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
