Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTEBRzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTEBRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:55:51 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:6407 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263026AbTEBRzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:55:47 -0400
Subject: Re: Aic7xxx and Aic79xx Driver Updates
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <2274070000.1051897888@aslan.btc.adaptec.com>
References: <1866260000.1051828092@aslan.btc.adaptec.com>
	<1051885837.1820.34.camel@mulgrave> 
	<2274070000.1051897888@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 May 2003 13:07:58 -0500
Message-Id: <1051898880.1819.63.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 12:51, Justin T. Gibbs wrote:
> > First off, could you take a look at
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=608
> > 
> > I thought it was an sr problem, but it doesn't seem to show up on
> > anything other than adaptec controllers?  Thanks.
> 
> I've just updated the bug.


Thanks.

> > On Thu, 2003-05-01 at 17:28, Justin T. Gibbs wrote:
> >> ChangeSet
> >>   1.1118.33.5 03/04/24 15:12:48 gibbs@overdrive.btc.adaptec.com +7 -0
> >>   Aic7xxx and Aic79xx Driver Updates
> >>    o Adapt to new IRQ handler declaration/behavior for 2.5.X
> > 
> > The changes for this:
> > 
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
> > +#define        AIC_LINUX_IRQRETURN_T irqreturn_t
> > +#define        AIC_LINUX_IRQRETURN(ours) return (IRQ_RETVAL(ours))
> > +#else
> > +#define        AIC_LINUX_IRQRETURN_T void
> > +#define        AIC_LINUX_IRQRETURN(ours)  return
> > +#endif
> > 
> > Are rather convoluted.  Could you just remove the wrappering for 2.5?
> 
> The answer to this and your other issues you raise about the driver are
> the same.  I do not want to fork the driver.  I still have to maintain
> support all the way back to 2.4.7 and branching the driver for every
> different supported kernel would be a nightmare to maintain.  As it stands
> now, other than the Makefile and kernel config files, there is just one
> set of files that supports all of these kernels.  It makes it much
> easier for everyone involved including the primary maintainer of the
> driver.

Well, you do keep a 2.4 and a 2.5 tree, so you still have to apply your
patches twice.  You also seem to have two drivers: aic7xxx and aic79xx
which seem to duplicate about 80% of the code between them, so you have
to further patch each of these drivers for each of your fixes.

I'm not asking for any changes to the way you do 2.4, just for 2.5 where
we have no vendor versions to support and there should only be a single
tree.

> Personally, I don't see how this:
> 
> AIC_LINUX_IRQRETURN_T
> ahd_linux_isr(int irq, void *dev_id, struct pt_regs * regs)
> {
>         struct  ahd_softc *ahd;
>         u_long  flags;
>         int     ours;
> 
> ...
> 
>         AIC_LINUX_IRQRETURN(ours);
> }
> 
> Is any harder to parse than:
> 
> irqreturn_t
> ahd_linux_isr(int irq, void *dev_id, struct pt_regs * regs)
> {
>         struct  ahd_softc *ahd;
>         u_long  flags;
>         int     ours;
> 
> ...
> 
>         return IRQ_RETVAL(ours);
> }

The latter requires fewer levels of indirection to understand what's
going on.

> I've tried hard to make most of the API differences similarly transparent
> within the driver to avoid messy ifdefs.  I haven't succeeded everywhere,
> but this is the price you pay when APIs change so often.  All of the code
> is also setup so that the backwards compatibility hooks have no impact on
> the driver's performance under any support kernel (i.e. each kernel is
> supported as best as it can be supported).

Well, for 2.4, where there are multiple vendor versions, I'm OK with
this.  For 2.5 it's not necessary (yet).

> Is there some new policy against having drivers that support multiple
> kernel versions?

Not as such.  There is a preference for clean additions, though.  Adding
code to drivers that is never used and will never be used does tend to
make them more obscure to the reader.

James


