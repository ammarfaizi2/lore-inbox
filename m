Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288903AbSANH0r>; Mon, 14 Jan 2002 02:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288890AbSANH0j>; Mon, 14 Jan 2002 02:26:39 -0500
Received: from mailb.telia.com ([194.22.194.6]:32531 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S288903AbSANH00>;
	Mon, 14 Jan 2002 02:26:26 -0500
Message-Id: <200201140725.g0E7PkT22694@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl
Subject: Re: Alans example against preemtive kernel (Was: Re: [2.4.17/18pre] VM and swap - it's really unusable)
Date: Mon, 14 Jan 2002 08:22:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday den 12 January 2002 19.54, Alan Cox wrote:
> Another example is in the network drivers. The 8390 core for one example
> carefully disables an IRQ on the card so that it can avoid spinlocking on
> uniprocessor boxes.
>
> So with pre-empt this happens
>
> 	driver magic
> 	disable_irq(dev->irq)
> PRE-EMPT:
> 	[large periods of time running other code]
> PRE-EMPT:
> 	We get back and we've missed 300 packets, the serial port sharing
> 	the IRQ has dropped our internet connection completely.
>
> ["Don't do that then" isnt a valid answer here. If I did hold a lock
>  it would be for several milliseconds at a time anyway and would reliably
>  trash performance this time]
>

./drivers/net/8390.c
I checked the code ./drivers/net/8390.c - this is how it REALLY looks like...

	/* Ugly but a reset can be slow, yet must be protected */
		
	disable_irq_nosync(dev->irq);
	spin_lock(&ei_local->page_lock);
		
	/* Try to restart the card.  Perhaps the user has fixed something. */
	ei_reset_8390(dev);
	NS8390_init(dev, 1);
		
	spin_unlock(&ei_local->page_lock);
	enable_irq(dev->irq);

This should be mostly OK for the preemptive kernel. Swapping the irq and spin 
lock lines should be preferred. But I think that is the case in SMP too...

Suppose two processors does the disable_irq_nosync - unlikely but possible...
One gets the spinlock, the other waits
The first runs through the code, exits the spin lock, enables irq
The second starts running the code - without irq disabled!!!

This would work in both cases.
	/* Ugly but a reset can be slow, yet must be protected */
		
	spin_lock(&ei_local->page_lock);
	disable_irq_nosync(dev->irq);
		
	/* Try to restart the card.  Perhaps the user has fixed something. */
	ei_reset_8390(dev);
	NS8390_init(dev, 1);
		
	enable_irq(dev->irq);
	spin_unlock(&ei_local->page_lock);

/RogerL



-- 
Roger Larsson
Skellefteå
Sweden
