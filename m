Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbREIDOp>; Tue, 8 May 2001 23:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbREIDOf>; Tue, 8 May 2001 23:14:35 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:57836 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S132919AbREIDOa>; Tue, 8 May 2001 23:14:30 -0400
Date: Tue, 08 May 2001 20:09:46 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_pool_free from IRQ
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pete Zaitcev <zaitcev@redhat.com>, johannes@erdfelt.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Message-id: <059e01c0d835$819eace0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
 <E14xFD5-0000hh-00@the-village.bc.nu>
 <15096.27479.707679.544048@pizda.ninka.net>
 <050701c0d80f$8f876ca0$6800000a@brownell.org>
 <15096.38109.228916.621891@pizda.ninka.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Pete's patch to pci_pool_free() is fine with me, and I'd be glad
>  > to see that bit of pci interface cleaned up.  Any changes needed
>  > other than the pci.txt doc update?
> 
> Ummm... What Alan's saying is:

(consistent with what I said -- those are two separate issues!)

> 1) Whatever driver is trying to shut down from IRQ context
>    is broken must be fixed.  pci_pool is fine.

In _that_ respect, yes.  pci_pool_destroy() called in shutdown
context "should" be OK.  Getting rid of pages then is fine.

> 2) The Documentation/ files which suggest that such device
>    removal from IRQs is "OK" must be fixed because it is not
>    "OK" to handle device removal from IRQ context.

All agreed.

> So Pete's change is not needed.  A fix for the documentation and
> broken drivers is needed instead.

Two issues are mixed up there.  Doc should address both:

Documentation/pci.txt

    ... that remove() is never called in_interrupt
        point (2) above

Documentation/DMA-mapping.txt

    pci_free_consistent() -- do not call in_interrupt
        ... unless we bugfix the ARM behavior "soon"

    pci_pool_destroy() -- do not call in_interrupt
        ... normally called on device remove()
        
    pci_pool_free() -- may be called in_interrupt
        ... often called in device interrupt handling

Pete's patch deferred some pci_free_consistent calls from
pci_pool_free() where they're unsafe (on ARM) to where
they're safe (all architectures, as discussed above).

- Dave


