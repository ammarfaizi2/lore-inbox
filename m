Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSJWVrE>; Wed, 23 Oct 2002 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSJWVrD>; Wed, 23 Oct 2002 17:47:03 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:20499 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265246AbSJWVrC>;
	Wed, 23 Oct 2002 17:47:02 -0400
Message-ID: <3DB71A5E.5010907@mvista.com>
Date: Wed, 23 Oct 2002 16:53:34 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 4
References: <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024022026.D27739@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>Well, I haven't looked at the whole patch yet, but some quick
>responses -
>
>On Wed, Oct 23, 2002 at 03:14:52PM -0500, Corey Minyard wrote:
>  
>
>>I have noticed that the rcu callback can be delayed a long time, 
>>sometimes up to 3 seconds.  That seems odd.  I have verified that the 
>>delay happens there.
>>    
>>
>
>That kind of latency is really bad. Could you please check the latency 
>with this change in kernel/rcupdate.c -
>
> void rcu_check_callbacks(int cpu, int user)
> {
>        if (user ||
>-           (idle_cpu(cpu) && !in_softirq() && hardirq_count() <= 1))
>+           (idle_cpu(cpu) && !in_softirq() &&
>+                               hardirq_count() <= (1 << HARDIRQ_SHIFT)))
>                RCU_qsctr(cpu)++;
>        tasklet_schedule(&RCU_tasklet(cpu));
>
>After local_irq_count() went away, the idle CPU check was broken
>and that meant that if you had an idle CPU, it could hold up RCU
>grace period completion.
>
Ah, much better.  That seems to fix it.

>It might just be simpler to use completions instead -
>
>	call_rcu(&(handler->rcu), free_nmi_handler, handler);
>	init_completion(&handler->completion);
>	spin_unlock_irqrestore(&nmi_handler_lock, flags);
>	wait_for_completion(&handler->completion);
>
>and do
>
>	complete(&handler->completion);
>
>in the  the RCU callback.
>
I was working under the assumption that the spinlocks were needed.  But 
now I see that there are spinlocks in wait_for_completion.  You did get 
init_completion() and call_rcu() backwards, they would need to be the 
opposite order, I think.

>Also, now I think your original idea of "Don't do this!" :) was right.
>Waiting until an nmi handler is seen unlinked could make a task
>block for a long time if another task re-installs it. You should
>probably just fail installation of a busy handler (checked under
>lock).
>
Since just about all of these will be in modules at unload time, I'm 
thinking that the way it is now is better.  Otherwise, someone will mess 
it up.  IMHO, it's much more likely that someone doesn't handle the 
callback correctly than someone reused the value before the call that 
releases it returns.  I'd prefer to leave it the way it is now.

-Corey

