Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbRBHECB>; Wed, 7 Feb 2001 23:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbRBHEBw>; Wed, 7 Feb 2001 23:01:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35087 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129963AbRBHEBb>;
	Wed, 7 Feb 2001 23:01:31 -0500
Message-ID: <3A8219F9.C62F8759@mandrakesoft.com>
Date: Wed, 07 Feb 2001 23:00:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: davej@suse.de, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.31.0102071951060.17788-100000@athlon.local> <3A81A89C.DFD09434@mandrakesoft.com> <3A81B169.B4539406@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Jeff Garzik wrote:
> >
> > +       SET_MODULE_OWNER(dev);
> >
> >         irq = pdev->irq;
> >
> 
> One question:
> The code copies 'pdev->irq' into 'dev->irq'.
> 
> Is that required, who need 'dev->irq'?
> 
> > retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
> 
> Can't the driver use?
>  retval = request_irq(np->pci_dev->irq)

Sure it can.  A PCI driver can completely ignore dev->irq, if it so
desires.  However...

Setting dev->irq is really a courtesy, because while the net core code
doesn't use it at all, it is reported to userspace such as ifconfig. 
And because the netdev setup code could potentially assign a value to
dev->irq on its own, if the driver does -not- set dev->irq, the value
reported to userspace might incorrect instead of just being zero.

[side note - ifconfig only obtains the lower 16 bits of the
dev->base_addr value, grump grump]

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
