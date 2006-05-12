Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWELOwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWELOwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWELOwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:52:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751204AbWELOwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:52:40 -0400
Date: Fri, 12 May 2006 07:49:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, markh@compro.net, linux-kernel@vger.kernel.org,
       dwalker@mvista.com, tglx@linutronix.de
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
Message-Id: <20060512074929.031d4eaf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
References: <4460ADF8.4040301@compro.net>
	<Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
	<4461E53B.7050905@compro.net>
	<Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
	<446207D6.2030602@compro.net>
	<Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
	<44623157.9090105@compro.net>
	<Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
	<20060512081628.GA26736@elte.hu>
	<Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
	<20060512092159.GC18145@elte.hu>
	<Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
	<20060512071645.6b59e0a2.akpm@osdl.org>
	<Pine.LNX.4.58.0605121029540.30264@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605121036150.30264@gandalf.stny.rr.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  Use this patch instead.  It needs an irq disable.  But, believe it or not,
>  on SMP this is actually better.  If the irq is shared (as it is in Mark's
>  case), we don't stop the irq of other devices from being handled on
>  another CPU (unfortunately for Mark, he pinned all interrupts to one CPU).
> 
>  Andrew,
> 
>  should this be changed in mainline too?

I suppose so - we're taking the lock with spin_lock_bh(), but it can also
be taken by this CPU from the interrupt, so it'll deadlock.  But lo!  We've
done disable_irq(), so the interrupt won't be happening.

So yes, doing spin_lock_irq() (irqrestore isn't needed in a timer handler)
instead of disable_irq() in vortex_timer() looks OK.

One does wonder how long we'll hold off interrupts though.

