Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSHPUZb>; Fri, 16 Aug 2002 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHPUZb>; Fri, 16 Aug 2002 16:25:31 -0400
Received: from waste.org ([209.173.204.2]:28136 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316204AbSHPUZa>;
	Fri, 16 Aug 2002 16:25:30 -0400
Date: Fri, 16 Aug 2002 14:52:54 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: henrique@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020816195254.GL5418@waste.org>
References: <80256C17.00376E92.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80256C17.00376E92.00@notesmta.eur.3com.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 11:00:00AM +0100, Jon Burgess wrote:
> 
> 
> >BTW, does anyone know where I can found the patch to get randomness from the
> >network cards interrupt ?
> 
> Add the flag SA_SAMPLE_RANDOM into the request_irq() flags in the driver for
> whichever interrupt source you want to use
> e.g. from drivers/net/3c523.c
> 
>      ret = request_irq(dev->irq, &elmc_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM,
>                  dev->name, dev);

Don't do this. This is the Enron method of entropy accounting.

There is little to no reliably unpredictable data in network
interrupts and the current scheme does not include for the mixing of
untrusted sources. It's very likely that an attacker can measure,
model, and control such timings down to the resolution of the PCI bus
clock on a quiescent system. This is more than good enough to defeat
entropy generation on systems without a TSC and given that the bus
clock is a multiple of the processor clock, it's likely possible to
extend this to TSC-based systems as well.

Entropy accounting is very fickle - if you overestimate _at all_, your
secret state becomes theoretically predictable. I have some patches
that create an API for adding such hard to predict but potentially
observable data to the entropy pool without accounting it as actual
entropy, as well as cleaning up some other major accounting errors but
I'm not quite done testing them.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
