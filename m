Return-Path: <linux-kernel-owner+w=401wt.eu-S1750709AbXACKnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXACKnK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 05:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXACKnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 05:43:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:43368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbXACKnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 05:43:09 -0500
X-Authenticated: #5039886
Date: Wed, 3 Jan 2007 11:43:05 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Zefang.Wang@nokia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any problem if softirq are done in a interrupt context (IRQ stack)?
Message-ID: <20070103104305.GA3100@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Zefang.Wang@nokia.com, linux-kernel@vger.kernel.org
References: <20070103092214.GA2628@atjola.homenet> <1E9D602D891FA142A769E9EF164712EC355CB0@beebe101.NOE.Nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1E9D602D891FA142A769E9EF164712EC355CB0@beebe101.NOE.Nokia.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Re-added lkml to the CC list, please don't drop anything from CC]

On 2007.01.03 17:39:48 +0800, Zefang.Wang@nokia.com wrote:
> Hi!
> 
> Thanks very much for your clear explanation !
> 
> I have another question about irq_exit(), hope you can help me.
> 
> void irq_exit(void)
> {
> 	account_system_vtime(current);          
> 	trace_hardirq_exit();
> 	sub_preempt_count(IRQ_EXIT_OFFSET);   
>            ====================================================================
> 		Here, IRQ_EXIT_OFFSET is defined as (HARDIRQ_OFFSET-1),
> 		so the purpose seems that it try to avoid the current process
> 		from being switched-out druing do_softirq()?
> 		And,  if the preempt_count is not zero,  then softirq for 
> 		timer interrupt can set  _TIF_NEED_RESCHED flag to current
> 		process?
> 		What happened if the above sentence is changed to
> 		sub_preept_count(HARDIRQ_OFFSET)?
> 
> 	if (!in_interrupt() && local_softirq_pending())
> 		invoke_softirq();
> 	preempt_enable_no_resched();
>              ==============================================
> 	 The remaining 1 is decremented here.
> }

I can't really help you with that one. I'd assume that you need to make
sure that the current process context is kept while the softirq is
running. Could be, that otherwise the process gets preempted and the
stored process context would be assigned to the new process or
something like that, but I'm just guessing wildly here.
Note that IRQ_EXIT_OFFSET is defined as HARDIRQ_OFFSET if preemption is
disabled, so that's probably key here, I just don't know what kind of
havoc preempting would cause here ;)

Björn
