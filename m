Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUIHM5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUIHM5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUIHM47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:56:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62215 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267514AbUIHMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:49:09 -0400
Date: Wed, 8 Sep 2004 13:49:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908134903.A31498@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908124547.GA19231@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 02:45:47PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:45:47PM +0200, Ingo Molnar wrote:
> some of the architectures dont want to (and cannot) use the generic
> functions for one reason or another. So the proper approach i believe is
> to provide these generic functions the architectures can plug in. I can
> do an asm-generic/hardirq.h that adds all the definitions, for
> architectures that dont need any special IRQ logic.

Some architectures definitly can't use it.  That's why the prototypes for
them arch in arch-headers.  No need to introduce totally useless wrappers.
The asm-generic one sounds like a good idea, but I'd wait with that one
until the consolidation is mostly finished, aka all architectures that
currently use more or less a copy of the i386 irq.c are migrated over so
we can see it's scope.

> > >  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
> > > -	    exit.o itimer.o time.o softirq.o resource.o \
> > > +	    exit.o itimer.o time.o softirq.o hardirq.o resource.o \
> > 
> > And make hardirq.o dependent on some symbols the architectures set.
> > Else arches that don't use it carry tons of useless baggage around
> > (and in fact I'm pretty sure it wouldn't even compie for many)
> 
> it compiles fine on x86, x64, ppc and ppc64. Why do you think it wont
> compile on others?

linux/irq.h is despite it's name _not_ a public header but a misnamed
asm-generic/hw_irq.h.  There's quite a few architectures with a completely
different interrupt architecture and for tose it won't compile.

> wrt. unused generic functions - why dont we drop them link-time?

make explicit what you can do easily instead of relying on the compiler.
It allows to get rid of your horrible generic_ hacks, cuts down compile
time and makes explicit to anyone looking at the code and Kconfig which
architectures use this.

