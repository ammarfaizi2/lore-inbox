Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSFREoI>; Tue, 18 Jun 2002 00:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSFREoH>; Tue, 18 Jun 2002 00:44:07 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:20180 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317315AbSFREoG>;
	Tue, 18 Jun 2002 00:44:06 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206180443.IAA11516@sex.inr.ac.ru>
Subject: Re: NAPI eepro100 bug fixed
To: fxzhang@ict.ac.CN (Zhang Fuxin)
Date: Tue, 18 Jun 2002 08:43:18 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D0EA83A.50606@ict.ac.cn> from "Zhang Fuxin" at Jun 18, 2 07:45:02 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>      /* disable interrupts here is necessary!
>          * We need to ensure Rx/RxNobuf ints are disabled if in poll
>          * flag is set. If interrupt comes bwteen netif_rx_complete
>          * and enable_rx_and_rxnobuf_ints, the following will happen:
>          *         netif_rx_complete --> clear RX_SCHED flag
>          *           -> ints(e.g. TxDone)
>          *                  speedo_interrupt
>          *                       if (netif_rx_schedule_prep(dev))
>          *                          disable_rx_and_rxnobuf_ints
>          *                  return
>          *           <-
>          *         enable_rx_and_rxnobuf_ints
>          *  then we will have Rx&RxNoBuf ints enable while in polling!
>          *  it may lead to endless interrupts and effective lockup of
>          *  the whole machine.
>          */
>         spin_lock_irqsave(&sp->lock,flags);
>         netif_rx_complete(dev);
>         enable_rx_and_rxnobuf_ints(dev);
>         spin_unlock_irqrestore(&sp->lock,flags);

You mixed two different driver models, that's reason of lockup.

You must ACK irq in interrupt handler in some way.
Tulip really does trick with deferring ack to poll routine,
but it pays for this _masking_ irq each interrupt instead, which also
drops irq line. See?

Alexey
