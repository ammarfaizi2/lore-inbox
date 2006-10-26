Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWJZWv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWJZWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945972AbWJZWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:51:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6530 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161465AbWJZWv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:51:58 -0400
Date: Thu, 26 Oct 2006 17:51:55 -0500
To: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] s2io: add PCI error recovery support
Message-ID: <20061026225155.GH6360@austin.ibm.com>
References: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1ED7@nekter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1ED7@nekter>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, Oct 26, 2006 at 05:56:34AM -0400, Ananda Raju wrote:
> Hi, 
> Can you try attached patch. The attached patch is simple. We set card
> state as down in error_detecct() so that all entry points return error
> and don't proceed further.
> 
> In slot_reset() we do s2io_card_down() will reset adapter. 
> In io_resume() we bringup the driver. 

Simplicity is always better. However, some questions/comments:

> @@ -4175,6 +4186,10 @@ static irqreturn_t s2io_isr(int irq, voi
>  	mac_info_t *mac_control;
>  	struct config_param *config;
>  
> +	if (atomic_read(&sp->card_state) == CARD_DOWN) {
> +		return IRQ_NONE;
> +	}

I used 

    if ((sp->pdev->error_state != pci_channel_io_normal)

here for a reason: the pdev->error_state is set even in an interrupt
context, that is, it gets set even if interrups are disabled, and
so it represents the actual state immediately. By contrast, the
error callbacks do not get called until possibly much later, 
and so sp->card_state = CARD_DOWN might not get set for a while.

If, for any reason, e.g. some obscure corner case, the s2io 
generates zillions of interupts, this could result in a soft-lockup.
I actually saw this in the symbios device driver, which will
regenerate an interrupt until its acknowledged -- and so it 
sat there, spinning. :-(

I was returning IRQ_HANDLED instead of IRQ_NONE, so as to avoid
falling into handle_bad_irq() or report_bad_irq(). I haven't 
seen this happen on s2io, but thought it would still be wise.

If this can't happen, then there's no problem here.

> +/**
> + * s2io_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
> +static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev)
> +{

At this point, the card has just experienced a hardware reset,
(the #RST wire was held low for 250 millisecs, followed by
a settle time of 2 seconds, followed by whatever BIOS thinks
it needed to do, followed by a restore of the pci config space
to what it was after a cold boot. So the card is in a "fresh"
state; in theory its identitcal to a cold boot. So ... 
are you sure you want to "down" at this point? 

> +		s2io_card_down(sp);
> +		sp->device_close_flag = TRUE;	/* Device is shut down. */


One problem I'm having is that the watchdog timer sometimes
pops and tries to reset the card before s2io_card_down()
has a chance to run. I fixed this ... 

======================
So -- just for grins, I thought to myself, "Maybe I can make 
s2io be the first adapter ever to fully recover without 
a hard reset of the card."

The idea is simple: 

1) enable MMIO,
2) call s2io_card_down()
3) enable DMA
4) cal s2io_card_up()

I have a patch that does this, but then hit a few more snags.
I haven't yet nailed down all the trouble spots, maybe tommorrow.

--linas

