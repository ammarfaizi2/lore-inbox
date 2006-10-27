Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946442AbWJ0Li5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946442AbWJ0Li5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946438AbWJ0Li4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:38:56 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:15488 "EHLO
	barracuda.s2io.com") by vger.kernel.org with ESMTP id S1946434AbWJ0Liy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:38:54 -0400
X-ASG-Debug-ID: 1161949132-23207-18-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-ASG-Orig-Subj: RE: [PATCH] s2io: add PCI error recovery support
Subject: RE: [PATCH] s2io: add PCI error recovery support
Date: Fri, 27 Oct 2006 07:35:18 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD77DC20B7@nekter>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] s2io: add PCI error recovery support
Thread-Index: Acb5UPIk+FuEC99QSEiibrVgsuI1OQAam68g
From: "Ananda Raju" <Ananda.Raju@neterion.com>
To: "Linas Vepstas" <linas@austin.ibm.com>
Cc: "Wen Xiong" <wenxiong@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <netdev@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Andrew Morton" <akpm@osdl.org>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at all scenarios I feel the first patch is OK. Can you add the
watchdog timer fix to first initial patch and resubmit. 

-----Original Message-----
From: Linas Vepstas [mailto:linas@austin.ibm.com] 
Sent: Thursday, October 26, 2006 3:52 PM
To: Ananda Raju
Cc: Wen Xiong; linux-kernel@vger.kernel.org;
linux-pci@atrey.karlin.mff.cuni.cz; netdev@vger.kernel.org; Jeff Garzik;
Andrew Morton
Subject: Re: [PATCH] s2io: add PCI error recovery support

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
> +		sp->device_close_flag = TRUE;	/* Device is shut down.
*/


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


