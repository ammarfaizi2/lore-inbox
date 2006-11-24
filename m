Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935003AbWKXSsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935003AbWKXSsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935004AbWKXSsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:48:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:59915 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935003AbWKXSsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:48:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=djm4KXmTQNPkmn6IRy8s1NEsqApn8yNJggJfYZTi4ImXL+bN2leICJ6iTuVBCvgNttBOYJXTI2+/kPzhgzAL5je8x9XNMQNX/vDSVrd+Suj6DWx7XRB2XjKOnY+WSgJe0Ie4CVdBIRsr3gFkuu11vdmMu7k+Xja5atqOKL8KdBE=
Date: Fri, 24 Nov 2006 21:47:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ira Snyder <kernel@irasnyder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse fix: add many lock annotations
Message-ID: <20061124184758.GA4973@martell.zuzino.mipt.ru>
References: <20061122001146.95a56c72.kernel@irasnyder.com> <20061122183306.GA4970@martell.zuzino.mipt.ru> <20061123001842.f139ddaa.kernel@irasnyder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123001842.f139ddaa.kernel@irasnyder.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:18:42AM -0800, Ira Snyder wrote:
> On Wed, 22 Nov 2006 21:33:07 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Wed, Nov 22, 2006 at 12:11:46AM -0800, Ira Snyder wrote:
> > > This patch adds many lock annotations to the kernel source to quiet
> > > warnings from sparse. In almost every case, it quiets the warning caused
> > > by locks that are intentionally grabbed in one function and released in
> > > another.
> > >
> > > In the other cases, __acquire() and __release() are used to make sparse
> > > believe that a lock was grabbed (even though it was not), in order to
> > > make all exit points have equal lock counts. These follow the style in
> > > kernel/sched.c.
> >
> > > --- a/arch/i386/kernel/smp.c
> > > +++ b/arch/i386/kernel/smp.c
> > > @@ -507,11 +507,13 @@ struct call_data_struct {
> > >  };
> > >
> > >  void lock_ipi_call_lock(void)
> > > +__acquires(call_lock)
> > >  {
> > >  	spin_lock_irq(&call_lock);
> > >  }
> > >
> > >  void unlock_ipi_call_lock(void)
> > > +__releases(call_lock)
> > >  {
> > >  	spin_unlock_irq(&call_lock);
> > >  }
> >
> > Wrong place. Prototypes should be marked instead. How else would you
> > know about:
> >
> > 	lock_ipi_call_lock();
> > 	if (foo)
> > 		return -E;
> > 	lock_ipi_call_lock();
> >
> > on another compilation unit?
> >
>
> I've re-thought about this since my last email, and I see what you are
> saying now. Functions which are static shouldn't need the __releases()
> or __acquires() anywhere except the definition, since they cannot be
> used outside of the file in which they reside. Non-static functions do
> need to be marked in the prototypes (so all external uses see the
> marking, and therefore get the benefit of sparse's checking) as well as
> in the definition (to quiet sparse itself).

Yes, that's it.

