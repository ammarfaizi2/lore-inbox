Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWEJFhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWEJFhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 01:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWEJFhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 01:37:06 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:45282 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964822AbWEJFhC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 01:37:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQO0gucidyrpcJSRATvVnanFk/r4qS4SUvSrmICPTk/Ep755DerA2vEPd2YAWKhrHn3ANuAp5r7r31mejrZUAwy3bQpmCYnX3fAoHQ0wJkLn8i8MCjJkI80XZPIuWR2vCjkQxTbNITkX3oWLBAzI2cm0ueSy1uAw1gztqZivybE=
Message-ID: <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
Date: Tue, 9 May 2006 22:37:00 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605061232.52303.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <200605041922.52243.david-b@pacbell.net>
	 <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
	 <200605061232.52303.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like I said in my previous message, I am not a kernel developer.  I am
a programmer though, so I thought I'd give your suggestions a try.

I added 1 line to drivers/usb/host/ehci-pci.c which sets the DMA mask,
and now it seems to work with ehci loaded and with 4 GB of RAM.
Unfortunately, I don't really understand what I did.  Perhaps you have
a better idea what this is doing and if it is correct.

case PCI_VENDOR_ID_NVIDIA:
		/* NVidia reports that certain chips don't handle
		 * QH, ITD, or SITD addresses above 2GB.  (But TD,
		 * data buffer, and periodic schedule are normal.)
		 */
		
		dma_set_mask(hcd->self.controller, DMA_31BIT_MASK); /* I added this line */
		
		switch (pdev->device) {
		case 0x003c:	/* MCP04 */
		case 0x005b:	/* CK804 */
		case 0x00d8:	/* CK8 */
		case 0x00e8:	/* CK8S */
			if (pci_set_consistent_dma_mask(pdev,
						DMA_31BIT_MASK) < 0)
				ehci_warn(ehci, "can't enable NVidia "
					"workaround for >2GB RAM\n");
			break;
		}
		break;
	}
