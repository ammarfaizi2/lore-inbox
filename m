Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWG0PHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWG0PHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWG0PHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:07:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18766 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750787AbWG0PHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:07:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y1moOWxSgZJO0tgn8HsJc0X0U+mh0x5sYjZEKGLSxbxWLX+1y7IGiz8WrU9XvgpP4c1siQRuim5J4TkQ0KgrnbS7RRUmP6d3UhmVELFoiXBXT/p8n6tjaLRjLdOH73zFjTVpHAsO427jjxnoJ0YT4Z5uuqeV4LWuhOi0bly/qdk=
Message-ID: <f96157c40607270807t381dff91h83b3685fcedfdbaf@mail.gmail.com>
Date: Thu, 27 Jul 2006 15:07:35 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200607271632.12682.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725222209.0048ed15.akpm@osdl.org>
	 <200607271529.39549.mb@bu3sch.de>
	 <f96157c40607270720n1dd5443avfdb53641a1cdad6f@mail.gmail.com>
	 <200607271632.12682.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Michael Buesch <mb@bu3sch.de> wrote:
> On Thursday 27 July 2006 16:20, gmu 2k6 wrote:
> > On 7/27/06, Michael Buesch <mb@bu3sch.de> wrote:
> > > On Wednesday 26 July 2006 21:44, gmu 2k6 wrote:
> > > > > But could you try the following patch on top of latest git?
> > > > > It's just a random test, but I think it's worth trying.
> > > > > Let's see if it works around the issue.
> > > > >
> > > > > Index: linux-2.6/drivers/char/hw_random/intel-rng.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/drivers/char/hw_random/intel-rng.c   2006-06-27 17:48:13.000000000 +0200
> > > > > +++ linux-2.6/drivers/char/hw_random/intel-rng.c        2006-07-26 17:27:03.000000000 +0200
> > > > > @@ -104,9 +104,14 @@
> > > > >         int err = -EIO;
> > > > >
> > > > >         hw_status = hwstatus_get(mem);
> > > > > +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> > > > > +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > > > +#if 0
> > > > > +       hw_status = hwstatus_get(mem);
> > > > >         /* turn RNG h/w on, if it's off */
> > > > >         if ((hw_status & INTEL_RNG_ENABLED) == 0)
> > > > >                 hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > > > +#endif
> > > > >         if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> > > > >                 printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> > > > >                 goto out;
> > > >
> > > > well as it didn't work, are you sure it was not intended to be more like this:
> > > > @@ -104,9 +104,14 @@
> > > >        int err = -EIO;
> > > >
> > > >        hw_status = hwstatus_get(mem);
> > > > +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> > > > +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > > +#if 0
> > > >        /* turn RNG h/w on, if it's off */
> > > >        if ((hw_status & INTEL_RNG_ENABLED) == 0)
> > > >                hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > > +#endif
> > > >        if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> > > >                printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> > > >                goto out;
> > > >
> > > > ?
> > >
> > > I don't think that makes a difference to the generated code, does it?
> >
> > I will test it now as you seem to be interested in the results.
> >
> > actually I was just curious what sense it made to do
> > hw_status = hwstatus_get(mem);
> > twice, though I'm not informed about the semantics there so I could be wrong
> > in interpreting the API on that level.
>
> Look at the #if 0. The second hwstatus_get is not going to be compiled, anyway.

yep you're right, originally I caught it as because it won't be
included in the gcc output at all and later on false thought it would
be called twice after a long day of work. maybe I should take more
time when replying to mails :D

> But Jan Beulich posted an interresting patch to lkml.
> Please test it.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115399953714650&q=raw

I saw that too and was thinking about trying it out, will do so now.
