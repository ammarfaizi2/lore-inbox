Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWIIH11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWIIH11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIIH11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 03:27:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:28814 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751370AbWIIH1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 03:27:25 -0400
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
In-Reply-To: <20060909051211.GA6922@elte.hu>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
	 <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
	 <20060909051211.GA6922@elte.hu>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 17:26:41 +1000
Message-Id: <1157786802.31071.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 07:12 +0200, Ingo Molnar wrote:
> * David Howells <dhowells@redhat.com> wrote:
> 
> > +#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
> 
> > +#ifdef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
> 
> > +#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
> 
> I think the myriad of arch switches and the resulting #ifdef noise, just 
> to get rid of a _single_ unused global function, is pretty lame. (and 
> that's of course not your fault)
> 
> The real solution would be to use gcc -ffunction-sections plus ld 
> --gc-sections to automatically get rid of unused global functions, at 
> link time. I'm wondering how hard it would be to enhance kbuild to do 
> that - x86_64 already uses -ffunction-sections (if CONFIG_REORDER), so 
> the big question is how usable is ld --gc-sections. Such a feature would 
> be quite important for embedded systems (and for RAM footprint in 
> general) as it would save a significant amount of .text and .data.

It can't optimize __do_IRQ() out in any case if one uses
generic_handle_irq() because of the test in there which can't be
predicted at compile time. My fault ... Maybe we should go back to
having generic_handle_irq() not do the NULL test and not call __do_IRQ()
and have another generic_handle_irq_compat() or some stupid name like
that do what the current generic_handle_irq() does. I added that to
handle the case of partial conversion (which we still have to deal with
on powerpc as arch/ppc hasn't been converted).

Ben.


