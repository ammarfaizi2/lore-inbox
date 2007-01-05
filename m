Return-Path: <linux-kernel-owner+w=401wt.eu-S1750819AbXAEWdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbXAEWdp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXAEWdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:33:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53287 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbXAEWdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:33:45 -0500
Date: Fri, 5 Jan 2007 23:30:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070105223009.GA15369@elte.hu>
References: <20070105215223.GA5361@elte.hu> <459ECDF7.9040309@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459ECDF7.9040309@vmware.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> What you really want is more like 
> EXPORT_SYMBOL_READABLE_GPL(paravirt_ops);

yep. Not a big issue - what is important is to put the paravirt ops into 
the read-only section so that it's somewhat harder for rootkits to 
modify. (Also, it needs to be made clear that this is fundamental, 
lowlevel system functionality written by people under the GPLv2, so that 
if you utilize it beyond its original purpose, using its internals, you 
likely create a work derived from the kernel. Something simple as irq 
disabling probably doesnt qualify, and that we exported to modules for a 
long time, but lots of other details do. So the existence of 
paravirt_ops isnt a free-for all.)

> But I'm not sure that is technically feasible yet.
> 
> The kvm code should probably go in kvm.c instead of paravirt.c.

no. This is fundamental architecture boot code, not module code. kvm.c 
should eventually go into kernel/ and arch/*/kernel, not the other way 
around.

> Index: linux/drivers/serial/8250.c
> ===================================================================
> --- linux.orig/drivers/serial/8250.c
> +++ linux/drivers/serial/8250.c
> @@ -1371,7 +1371,7 @@ static irqreturn_t serial8250_interrupt(
> 
> 		l = l->next;
> 
> -		if (l == i->head && pass_counter++ > PASS_LIMIT) {
> +		if (!kvm_paravirt 
> 
> Is this a bug that might happen under other virtualizations as well, 
> not just kvm? Perhaps it deserves a disable feature instead of a kvm 
> specific check.

yes - this limit is easily triggered via the KVM/Qemu virtual serial 
drivers. You can think of "kvm_paravirt" as "Linux paravirt", it's just 
a flag.

	Ingo
