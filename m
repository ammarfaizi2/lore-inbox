Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932982AbWFZTwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWFZTwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932985AbWFZTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:52:24 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:35535 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932982AbWFZTwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:52:23 -0400
Message-ID: <44A03B0C.90101@acm.org>
Date: Mon, 26 Jun 2006 14:52:44 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, peter@palfrader.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] IPMI: use schedule in kthread
References: <20060626140819.GA17804@localdomain> <20060626120048.cff87fac.akpm@osdl.org>
In-Reply-To: <20060626120048.cff87fac.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 26 Jun 2006 09:08:19 -0500
> MAILER-DAEMON@osdl.org wrote:
>
>   
>> The kthread used to speed up polling for IPMI was using udelay
>> when the lower-level state machine told it to do a short delay.
>> This just used CPU and didn't help scheduling, thus causing bad
>> problems with other tasks.  Call schedule() instead.
>>
>> Signed-off-by: Corey Minyard <minyard@acm.org>
>>
>> Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
>> ===================================================================
>> --- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
>> +++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -809,7 +809,7 @@ static int ipmi_thread(void *data)
>>  			/* do nothing */
>>  		}
>>  		else if (smi_result == SI_SM_CALL_WITH_DELAY)
>> -			udelay(1);
>> +			schedule();
>>  		else
>>  			schedule_timeout_interruptible(1);
>>  	}
>>     
>
> calling schedule() isn't a lot of use either.
>
> If CONFIG_PREEMPT it's of no benefit and will just chew CPU.
>
> If !CONFIG_PREEMPT && !need_resched() then it's a no-op and will chew CPU.
>
> If !CONFIG_PREEMPT && need_resched() then yes, it'll schedule away.  This
> is pretty much the only time that a simple schedule() is useful.
>
>
>
> What are we actually trying to do in here?
>   
The IPMI physical interfaces in generally really suck.  The most common
are byte at a time interfaces without interrupts that generally take in
the 500 microsecond per byte range.

This thread is an attempt to improve the performance of these
interfaces.  It is very low priority and wakes up when the IPMI
interface is doing something.  It basically spins looking for IPMI
activity at nice level 19 to help improve the performance of the
interface.  So basically, it chews CPU, but should be preempted by
anything else that is scheduled to run.  However, just calling udelay(1)
caused scheduling problems; users were reporting soft lockups, jerky
mouse movement, and keyboard problems if the IPMI interface was very
busy.  Adding a schedule here seems to fix those problems, and I'm
assuming they are falling into your third scenario above.

Any suggestions on better ways to fix this?

Thanks,

-Corey
