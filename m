Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTFKDCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 23:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTFKDCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 23:02:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:59030 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264043AbTFKDCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 23:02:15 -0400
Date: Tue, 10 Jun 2003 20:16:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: Simon Fowler <simon@himi.org>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-Id: <20030610201641.220a4927.akpm@digeo.com>
In-Reply-To: <20030611021926.GA2241@himi.org>
References: <20030610061654.GB25390@himi.org>
	<20030610130204.GC27768@himi.org>
	<20030610141440.26fad221.akpm@digeo.com>
	<20030611021926.GA2241@himi.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 03:15:57.0465 (UTC) FILETIME=[C6ABC890:01C32FC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler <simon@himi.org> wrote:
>
> On Tue, Jun 10, 2003 at 02:14:40PM -0700, Andrew Morton wrote:
> > Simon Fowler <simon@himi.org> wrote:
> > >
> > > On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> > > > I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> > > > p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> > > > kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> > > > tested is bk as of 2003-06-04). lspci lists this hardware:
> > > > 
> > > I've narrowed the start of the problem down: 2.5.70-bk13 works,
> > > -bk14 oopses. 
> > 
> > That's funny.  bk13->bk14 was almost all arm stuff.  diffstat below.
> > 
> > It might be worth reverting this chunk, see if that fixes it:
> > 
> > --- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
> > +++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
> > @@ -716 +716 @@
> > -__initcall(chr_dev_init);
> > +subsys_initcall(chr_dev_init);
> > 
> And we have a winner . . . Reverting this hunk fixes the oops.
> 

So it's another initcall problem in the PCI layer.

pci_enable_device_bars() is needing things which are not yet set up.  A lot
of the PCI initialisation is at subsys_initcall() as well, and you got
unlucky with link order.

I expect the below patch will fix this as well.  Could you please put the
above change back to normal and see if this one fixes it?


diff -puN arch/i386/pci/irq.c~pci-init-ordering-fix arch/i386/pci/irq.c
--- 25/arch/i386/pci/irq.c~pci-init-ordering-fix	Tue Jun 10 15:40:19 2003
+++ 25-akpm/arch/i386/pci/irq.c	Tue Jun 10 15:40:19 2003
@@ -791,7 +791,7 @@ static int __init pcibios_irq_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+arch_initcall(pcibios_irq_init);
 
 
 void pcibios_penalize_isa_irq(int irq)
diff -puN arch/i386/pci/legacy.c~pci-init-ordering-fix arch/i386/pci/legacy.c
--- 25/arch/i386/pci/legacy.c~pci-init-ordering-fix	Tue Jun 10 15:46:35 2003
+++ 25-akpm/arch/i386/pci/legacy.c	Tue Jun 10 15:46:47 2003
@@ -65,4 +65,4 @@ static int __init pci_legacy_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_legacy_init);
+arch_initcall(pci_legacy_init);

_

