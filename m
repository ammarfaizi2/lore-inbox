Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbWJCWmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbWJCWmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbWJCWmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:42:08 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:58917 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030638AbWJCWmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:42:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=soKd4CQCmN9jPU1jzU2FxpPqikIcjEtEZrYfSFqhwd2QNMnSQDy0KFNHIkKuWF44ikO7UcagR/gzBYZTtQWnHTi+y+m2Ha+o7jbK71D2gl0YeAoz843C1i7Wx0BN8KnE0zA8aKNiaTe4TQ3ZQafoqT/60apd5qz2RlbSYI9Qtoo=
Date: Tue, 3 Oct 2006 22:41:46 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061003224146.GK2785@slug>
References: <20061003220732.GE2785@slug> <20061003222223.GH2785@slug> <4522E637.9090103@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522E637.9090103@garzik.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 06:37:43PM -0400, Jeff Garzik wrote:
> Frederik Deweerdt wrote:
> >Hi,
> >This proof-of-concept patch converts the tg3 driver to use the
> >pci_request_irq() function.
> >Please note that I'm not submitting the driver changes, they're there
> >only for illustration purposes. I'll CC the appropriate maintainers
> >when/if an API is agreed upon.
> >Regards,
> >Frederik diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
> >index c25ba27..23660c6 100644
> >Index: 2.6.18-mm3/drivers/net/tg3.c
> >===================================================================
> >--- 2.6.18-mm3.orig/drivers/net/tg3.c
> >+++ 2.6.18-mm3/drivers/net/tg3.c
> >@@ -6853,7 +6853,7 @@ static int tg3_request_irq(struct tg3 *t
> > 			fn = tg3_interrupt_tagged;
> > 		flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
> > 	}
> >-	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
> >+	return pci_request_irq(tp->pdev, fn, flags, dev->name);
> > }
> >  static int tg3_test_interrupt(struct tg3 *tp)
> >@@ -6866,10 +6866,10 @@ static int tg3_test_interrupt(struct tg3
> >  	tg3_disable_ints(tp);
> > -	free_irq(tp->pdev->irq, dev);
> >+	pci_free_irq(tp->pdev);
> > -	err = request_irq(tp->pdev->irq, tg3_test_isr,
> >-			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
> >+	err = pci_request_irq(tp->pdev, tg3_test_isr,
> >+			      IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name);
> 
> IRQF_SHARED flags are still left hanging around...
I did it on purpose (see parent post): some parts of tg3 for example
don't pass IRQF_SHARED, so I though it wasn't a good idea to enforce
IRQF_SHARED in all cases. Did I miss something?

Frederik
