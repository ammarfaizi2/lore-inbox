Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVIFRF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVIFRF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIFRF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:05:59 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:58064 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVIFRF6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YYCUCoQS1U3zABevQp1UUzNT6b7aFZdqAskQT3SeIDQPscXoIieYDR513he5cnb/1DLFx6OQ8NOJAQLLQ31Ib9E9bjb94XdRq8qUGYkQzN1jtQndyUiRuk2VIfEL5NNiGAFnVhK/glEJ3iQK24LKTqN4qR2xVxoESuLSSuj8uqI=
Message-ID: <58d0dbf10509061005358dce91@mail.gmail.com>
Date: Tue, 6 Sep 2005 19:05:55 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfk5cp$19p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <1125854398.23858.51.camel@localhost.localdomain>
	 <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/6, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>:
> Andi Kleen wrote:
> 
> > AFAIK with interrupt stacks it shouldn't be a big issue to switch
> > to a private bigger stack. ndiswrapper just needs to have its own private
> > way to do "current" which accesses thread_info at the bottom of the stack.
> 
> I am developer of ndiswrapper and just caught up with this discussion. I am
> interested in providing private stack for ndiswrapper. I am not familiar
> with linux kernel internals to understand your proposal. Could you give me
> details please: If you can give a rough sketch of idea, I can implement it.
> Better yet, if you (or anyone else) can provide an implementation (not
> necessarily against ndsiwrapper, but a proof of concept), it will be
> greatly appreciated - this should also help any other projects that need
> more than 4k stack.
> 

You may take a look at how the IRQ stacks work on x86, e.g.
http://lxr.linux.no/source/arch/i386/kernel/irq.c#L48

The idea of switching stacks first sounds appealing, but it is not
that trivial. The tricky part comes with current/current_thread_info.
After you switched to a private stack and called some Windows driver
function, that code may call back to the ndiswrapper API which, in
turn, may jump into some kernel functions. If that kernel code calls
current_thread_info while your differently sized stack is active,
current_thread_info will not be able to evaluate a correct thread_info
address (see http://lxr.linux.no/source/include/asm-i386/thread_info.h#L88).

The only way I see is to switch stacks back on ndiswrapper API entry.
But managing all those stacks correctly is challenging, as you will
likely not want to create a new stack on each switching point. Rather,
maintaining them per context (IRQ, tasklet, kernel thread, user
process, <stuff I forgot>) is required in order to save memory and
avoid shortages in atomic contexts.

Jan
