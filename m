Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEXAXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEXAXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVEXAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:23:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:8851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVEXAXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:23:35 -0400
Date: Mon, 23 May 2005 17:24:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
Message-Id: <20050523172421.75e33b04.akpm@osdl.org>
In-Reply-To: <1116892690.30513.13.camel@gaston>
References: <200505232300.j4NN07lE012726@hera.kernel.org>
	<20050523162806.0e70ae4f.akpm@osdl.org>
	<1116892690.30513.13.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Mon, 2005-05-23 at 16:28 -0700, Andrew Morton wrote:
> 
> > This code can cause deadlocks on CONFIG_SMP && !CONFIG_PREEMPT kernels.
> > 
> > Please see http://lkml.org/lkml/2005/3/10/358
> > 
> > You (the programmer) *have* to know what context you're running in before
> > doing a voluntary yield.  There is simply no way to work this out at
> > runtime.
> 
> Hrm... Linus just merged it though...
> 

The old version was:

	if (!in_softirq())
		cond_resched();

Which I guess is OK if the programmer knows that this code is only ever called

a) from softirq context or

b) from process context with no locks/smp_processor_id/etc held.

The new version is:

	if (!in_atomic())
		cond_resched();

which happens to still be correct as long as a) and b) still hold, which I
assume they do.

Both versions are deadlocky if b) is violated.

So.  It sucks before and it sucks after, but we might not be deadlocky. 
Problem is, !CONFIG_PREEMPT also disable the beancounting which
might_sleep() depends upon, so it's harder to tell whether all callers are
correct.
