Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVCAW2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVCAW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVCAW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:28:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:58562 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262101AbVCAW17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:27:59 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m1hdjvi8r3.fsf@muc.de>
References: <422428EC.3090905@jp.fujitsu.com>  <m1hdjvi8r3.fsf@muc.de>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:24:12 +1100
Message-Id: <1109715852.5680.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 18:19 +0100, Andi Kleen wrote:
> Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> writes:
> 
> >
> > int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
> > {
> > 	unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
> > 	int i;
> >
> > 	/* Create magical cookie on the stack */
> > 	iocookie cookie;
> >
> > 	/* Critical section start */
> > 	iochk_clear(&dev, &cookie);
> > 	{
> > 		/* Get the whole packet of data */
> > 		for (i = 0; i < words; i++)
> > 			*buf++ = ioread32(dev, ofs);
> > 	}
> > 	/* Critical section end. Did we have any trouble? */
> > 	if ( iochk_read(&cookie) ) return -1;
> 
> Looks good for handling PCI-Express errors.
> 
> But what would the default handling be? It would be nice if there
> was a simple way for a driver to say "just shut me down on an error"
> without adding iochk_* to each function. Ideally this would be just
> a standard callback that knows how to clean up the driver.

I think that would be the lack of a callback, see other messages.

> > +void iochk_clear(iocookie *cookie, struct pci_dev *dev)
> > +{
> > +       local_irq_save(*cookie);
> > +}
> > +
> > +int iochk_read(iocookie *cookie)
> > +{
> > +       local_irq_restore(*cookie);
> > +       return 0;
> > +}
> 
> These should be inlined.
> 
> > +EXPORT_SYMBOL(iochk_init);
> 
> This doesn't need to be exported.
> 
> -Andi
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

