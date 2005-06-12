Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVFLLxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVFLLxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVFLLxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:53:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30162 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262317AbVFLLxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:53:38 -0400
Date: Sun, 12 Jun 2005 13:52:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050612115249.GA12445@elte.hu>
References: <20050612065733.GA6997@elte.hu> <Pine.OSF.4.05.10506121250310.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506121250310.2917-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> [...] With your argument above ???_local_irq_disable() should really 
> be preempt_disable() as that is faster.

local_irq_disable() _is_ almost the same thing as preempt_disable():

 void local_irq_disable(void)
 {
         mask_preempt_count(IRQSOFF_MASK);
 }
 EXPORT_SYMBOL(local_irq_disable);

which compiles to just 4 instructions:

 c012f355 <local_irq_disable>:
 c012f355:       b8 00 e0 ff ff          mov    $0xffffe000,%eax
 c012f35a:       21 e0                   and    %esp,%eax
 c012f35c:       81 48 14 00 00 00 20    orl    $0x20000000,0x14(%eax)
 c012f363:       c3                      ret

we could inline it too, that would make it exactly the same cost as 
preempt_disable().

it cannot be equivalent to preempt_disable()/enable due to the semantics 
of the IRQ flag. But fortunately masking/unmasking a bit is just as fast 
as inc/dec.

	Ingo
