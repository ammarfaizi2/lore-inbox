Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933880AbWKWT6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880AbWKWT6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbWKWT6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:58:09 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:57872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933889AbWKWT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:58:07 -0500
Date: Thu, 23 Nov 2006 19:57:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>, drzeus-mmc@drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix random SD/MMC card recognition failures on ARM Versatile
Message-ID: <20061123195757.GA25794@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>, drzeus-mmc@drzeus.cx,
	linux-kernel@vger.kernel.org
References: <20061123184606.bb203ae6.vitalywool@gmail.com> <20061123160335.GB8984@flint.arm.linux.org.uk> <acd2a5930611231129v3515022al931bec5b04ce27f@mail.gmail.com> <20061123194236.GD8984@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123194236.GD8984@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 07:42:36PM +0000, Russell King wrote:
> On Thu, Nov 23, 2006 at 10:29:30PM +0300, Vitaly Wool wrote:
> > On 11/23/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >Doubtful.  mmci_stop_data() already does this, which will be called
> > >immediately prior to mmci_request_end().  So you're doubling up the
> > >writes to registers again.
> > 
> > There's the case (mmci_cmd_irq) where mmc_stop_data is not called
> > prior to mmci_request_end(), so it's not that simple.
> 
> Ah, I see it.  In that case we need to call mmc_stop_data() when
> we're ending the initial command due to an error.  IOW, like this:

I'll also add that with the way we handle the MMCI, it is highly likely
that you _will_ see FIFO errors from time to time on this platform.

The problem is that we don't have DMA up and running on this platform,
so we are entirely at the mercy of interrupt-driven PIO.  In addition,
the MMCI FIFOs must be read _before_ they completely fill to avoid
overrun errors.  Coupling these two facts together, it's easy to see
that interrupt latency is _critical_ to avoiding FIFO overruns (error 3).

In general, if you do _anything_ with the board while it's trying to
access MMC cards, you will probably get some FIFO overruns.

There are three solutions:

1. Lower the maximum clock rate that the MMCI will allow, eg:
   insmod mmci fmax=257816

2. Avoid all other system activity while MMC is being accessed.

3. Someone needs to _sanely_ implement DMA on this platform.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
