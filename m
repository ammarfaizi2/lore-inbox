Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135241AbRDRSGS>; Wed, 18 Apr 2001 14:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbRDRSGI>; Wed, 18 Apr 2001 14:06:08 -0400
Received: from zmailer.org ([194.252.70.162]:26117 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135241AbRDRSGB>;
	Wed, 18 Apr 2001 14:06:01 -0400
Date: Wed, 18 Apr 2001 21:05:46 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dennis <dennis@etinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP in 2.4
Message-ID: <20010418210546.W805@mea-ext.zmailer.org>
In-Reply-To: <20010418211208.A1140@villain.home.ems.chel.su> <5.0.2.1.0.20010418110702.03850d20@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.0.2.1.0.20010418110702.03850d20@mail.etinc.com>; from dennis@etinc.com on Wed, Apr 18, 2001 at 11:08:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 11:08:22AM -0400, Dennis wrote:
> Does 2.4 have something similar to spl levels or does it still require the 
> ridiculous MS-DOSish spin-locks to protect every bit of code?

  Lets see -- (besides of MSDOS not having any sort of spinlocks), the
  spl() is something out of VAX series of machines, and it really works
  by presuming that there is some sort of priority leveling among irq
  sources.

  At i386 there is only one level of interrupt control, either you
  accept interrupts, or you don't.   It just doesn't scale very well.

  At FreeBSD site there is no documentation of how to handle interrupts,
  presumably that is "read the source, luke".

  Ah, found some man-page with its description..

  Essentially the supported function for  spl()  is:

	spin_lock_irqsave(&sp->lock, flags);

  along with its counterpart (  splx()  ):

	spin_unlock_irqrestore(&sp->lock, flags);

  These block interrupts at the LOCAL processor only (no interprocessor
  communication hazzle for it), and the spinlocks are for blocking
  interrupt processing by *other* processors at SMP systems.
  ( Linux does distribute interrupts these days to *all* processors
    when APIC is in use, and while it is fast and easy to block IRQ
    at local processor, getting other processors also to block IRQs
    is major slow thing...  )

  At UP systems the SAME functions are used, but their internal
  implementations are slightly different -- no SMP related spinlock
  is operated.

  For a model, see   drivers/net/eepro100.c

> DB
