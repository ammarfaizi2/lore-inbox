Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131514AbRCSSAt>; Mon, 19 Mar 2001 13:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRCSSAk>; Mon, 19 Mar 2001 13:00:40 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:47863 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131514AbRCSSAX>; Mon, 19 Mar 2001 13:00:23 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103191624.f2JGOmo16559@webber.adilger.int>
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors 
 forlinux 2.4.1
In-Reply-To: <3AB49C2E.4792071B@mandrakesoft.com> from Jeff Garzik at "Mar 18,
 2001 06:29:50 am"
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Mon, 19 Mar 2001 09:24:48 -0700 (MST)
CC: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
        mc@cs.stanford.edu, Andrew Morton <andrewm@uow.edu.au>,
        netdev@oss.sgi.com, dahinds@users.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzic writes:
> > [BUG] init_etherdev could return NULL
> > /u2/acc/oses/linux/2.4.1/drivers/net/3c515.c:604:corkscrew_found_device: ERROR:NULL:603:604: Using unknown ptr "dev" illegally! set by 'init_etherdev':603
> > 
> > Start --->
> >         dev = init_etherdev(dev, sizeof(struct corkscrew_private));
> > Error --->
> >         dev->base_addr = ioaddr;
> >         dev->irq = irq;
> 
> init_etherdev is a special case -- It can conditionally take NULL as its
> first argument.  If that is the case, when an allocation is performed,
> and the return val needed to be checked for NULL.  If init_etherdev's
> first arg is guaranteed to be non-NULL, you do not need to check its
> return value.  3c515 is one such case.

If this is the case, why not change it to look like:

	init_etherdev(dev, sizeof(struct corkscrew_private));

so it doesn't appear that you are setting "dev" again?

> >         dev = init_trdev(dev,0);

Ditto, don't make it look like "dev" is getting set on the return value,
when it is already set when calling the function.

> > /u2/acc/oses/linux/2.4.1/drivers/pcmcia/bulkmem.c:231:setup_erase_request: ERROR:NULL:230:231: Using unknown ptr "busy" illegally! set by 'kmalloc':230
> > 
> > Start --->
> >             busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
> > Error --->
> 
> This sizeof() construct may be a special case for your checker, but it's
> a common one for the kernel...  It definitely doesn't de-reference a
> pointer.

It is the "busy" pointer that appears to be dereferenced, not the sizeof.
We need something like (ERASE_BAD_KMALLOC doesn't yet exist):

	else if ((busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL)) == NULL)
		erase->State = ERASE_BAD_KMALLOC;
	else {
		erase->State = 1;
		...
	}

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
