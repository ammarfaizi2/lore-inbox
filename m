Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWEaV4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWEaV4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWEaV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:56:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965186AbWEaV4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:56:32 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531214729.GA4059@elte.hu>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 23:56:22 +0200
Message-Id: <1149112582.3114.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 23:47 +0200, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > On Wed, 2006-05-31 at 17:41 -0400, Alan Cox wrote:
> > > On Wed, May 31, 2006 at 10:31:40PM +0200, Arjan van de Ven wrote:
> > > > > 8390.c knows that ei_local->page_lock can only be used by an irq
> > > > > context that it disabled -
> > > > 
> > > > btw I think this is no longer correct with the irq polling stuff Alan
> > > > added to the kernel recently...
> > > 
> > > We could make the misrouted IRQ logic skip all handlers on a disabled IRQ
> > > but that might actually be worse than the disease we are trying to cure by
> > > doing so.
> > 
> > yeah since misrouted irqs will cause the kernel do disable irqs 'at 
> > random' more or less .. for which the handlers now would become 
> > unreachable which isn't good.
> 
> couldnt most of these problems be avoided by tracking whether a handler 
> _ever_ returned a success status? That means that irqpoll could safely 
> poll handlers for which we know that they somehow arent yet matched up 
> to any IRQ line?

I suspect the real solution is to have a

disable_irq_handler(irq, handler) 

function which does 2 things
1) disable the irq at the hardware level
2) mark the handler as "don't call me"

it matches the semantics here; what these drivers want is 1) not get an
irq handler called and 2) not get an irq flood


