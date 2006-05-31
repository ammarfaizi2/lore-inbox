Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWEaIc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWEaIc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEaIc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:32:28 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:34052 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S964863AbWEaIc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:32:27 -0400
In-Reply-To: <1149031517.20582.55.camel@localhost.localdomain>
Subject: Re: RT_PREEMPT problem with cascaded irqchip
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Sven-Thorsten Dietrich <sven@mvista.com>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF49239F9D.1A12D030-ONC125717F.002D1B60-C125717F.002EE8FD@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Wed, 31 May 2006 10:26:18 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/31/2006
 10:26:21 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yann,
>
> Can you please use a sane mail client ? There is no point to have the
> headers of the previous mail inserted in some fancy way. Also please
> answer inline and not on top of the reply.
>
> Thanks.

      Sorry for the behavior of my mail client, I have unfortunately no
chance to change it.
      However, I think you'll prefer this format.

>
> On Tue, 2006-05-30 at 16:44 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> > Well, in fact the issue doesn't come neither from the mask/unmask
procedure
> > nor from the set_irq calls.
> > Correct gpio mask/unmask are called before the gpio_irq_handler.
> >
> > However, there is an issue in gpio_irq_handler (specific to generic_irq
and
> > AT91RM9200, i think) concerning desc->chip->chip_data.
> > The following change has to be applied :
> >
> >  --    pio = (void __force __iomem *) desc->chip->chip_data;
> > ++   pio = (void __force __iomem *) desc->chip_data;
>
> Hmm. Is that part of your code or is it related to code in mainline ?

      This is currently part of the 2.6.16 mainline! However, I have seen
that this line has been replaced
      by "pio = get_irq_chip_data(irq);" in 2.6.17-rc4-genirq4 which access
desc->chip_data. So this problem
      has been solved by genirq4...
>
> > Moreover, I think that the call to redirect_hardirq have to be insered
in
> > gpio_irq_handler but I don't know how to do that.
>
> Why should that be done. The gpio_irq_handler should be called from the
> demultiplexing handler, via desc->handler(..). ARM has a conversion
> macro - desc_handle_irq() for that.
>

      Yep, I misunderstood the role of gpio_irq_handler...

> Anyway, the ARM code in 2.6.16-rtXX is lacking some of the changes we
> did in the genirq patchset. Sorry: - ENOTENOUGHINSTANCES
>
> I'm in the progress to update that.
>
>    tglx
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

