Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVCARTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVCARTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVCARTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:19:54 -0500
Received: from one.firstfloor.org ([213.235.205.2]:28318 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261986AbVCARTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:19:45 -0500
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com>
From: Andi Kleen <ak@muc.de>
Date: Tue, 01 Mar 2005 18:19:44 +0100
In-Reply-To: <422428EC.3090905@jp.fujitsu.com> (Hidetoshi Seto's message of
 "Tue, 01 Mar 2005 17:33:48 +0900")
Message-ID: <m1hdjvi8r3.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> writes:

>
> int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
> {
> 	unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
> 	int i;
>
> 	/* Create magical cookie on the stack */
> 	iocookie cookie;
>
> 	/* Critical section start */
> 	iochk_clear(&dev, &cookie);
> 	{
> 		/* Get the whole packet of data */
> 		for (i = 0; i < words; i++)
> 			*buf++ = ioread32(dev, ofs);
> 	}
> 	/* Critical section end. Did we have any trouble? */
> 	if ( iochk_read(&cookie) ) return -1;

Looks good for handling PCI-Express errors.

But what would the default handling be? It would be nice if there
was a simple way for a driver to say "just shut me down on an error"
without adding iochk_* to each function. Ideally this would be just
a standard callback that knows how to clean up the driver.

> +void iochk_clear(iocookie *cookie, struct pci_dev *dev)
> +{
> +       local_irq_save(*cookie);
> +}
> +
> +int iochk_read(iocookie *cookie)
> +{
> +       local_irq_restore(*cookie);
> +       return 0;
> +}

These should be inlined.

> +EXPORT_SYMBOL(iochk_init);

This doesn't need to be exported.

-Andi
