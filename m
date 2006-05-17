Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWEQSfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWEQSfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWEQSfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:35:00 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:57531 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750886AbWEQSe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:34:59 -0400
From: Drew Moseley <dmoseley@mvista.com>
Organization: Monta Vista Software
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Unnecessary warnings in smp_send_stop on i386 arch.
Date: Wed, 17 May 2006 11:34:57 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <17725.1147841766@ocs3>
In-Reply-To: <17725.1147841766@ocs3>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605171134.57502.dmoseley@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 9:56 pm, Keith Owens wrote:
> Drew Moseley (on Tue, 16 May 2006 19:43:05 -0700) wrote:
...
> >
> >I modified the i386/kernel/smp.c file to be functionally equivalent to the
> >x86_64/kernel/smp.c file to address this issue.
> >
...
>
> NAK this patch.  There is a real potential deadlock if you call
> smp_call_function() with interrupts disabled, it has caused kernel
> hangs in the past.  This patch removes the check for the potential
> deadlock and will allow bad code to creep back into the kernel.  See
> http://lkml.org/lkml/2004/5/2/116.  I find it quite disturbing that
> x86_64 has removed that check :(

So presumably the warn_on() call should be added back to the x86_64 arch?
Does that mean that the comment in the current code 
	* You must not call this function with disabled interrupts or from a
	* hardware interrupt handler or from a bottom half handler.
	* Actually there are a few legal cases, like panic.
is incorrect?

I did manage to find this thread; http://lkml.org/lkml/2004/12/2/209; which 
seems related..

Does is sound reasonable then to call local_irq_enable() for the scenarios 
where this will occur?  Specifically, any call to smp_send_stop() where IRQ's 
might be disabled may need that call to eliminate the deadlock opportunity.  
Or am I just plain confused?

Drew
