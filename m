Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSFRREX>; Tue, 18 Jun 2002 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSFRREW>; Tue, 18 Jun 2002 13:04:22 -0400
Received: from robur.slu.se ([130.238.98.12]:17414 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S317498AbSFRREU>;
	Tue, 18 Jun 2002 13:04:20 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15631.26842.867674.437939@robur.slu.se>
Date: Tue, 18 Jun 2002 19:07:38 +0200
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, Paul <xerox@foonet.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: NAPI eepro100 bug fixed
In-Reply-To: <3D0EA83A.50606@ict.ac.cn>
References: <15624.57000.928651.530593@robur.slu.se>
	<JBEKKKICLLIJKLIGCCKLCEAJCCAA.xerox@foonet.net>
	<15624.63280.379421.369909@robur.slu.se>
	<3D0EA83A.50606@ict.ac.cn>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zhang Fuxin writes:

 >       My first NAPI eepro100 contains a subtle but fatal race,which will 
 > lead
 > to lockup(of the whole machine here,but of ether interface for paul). This
 > version should be ok, Paul, would you like to have a try? I've tested it 
 > in my


 > will meet it,so it is listed here.
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

 Thanks!

 Yes as far as I see this correct... and this race and others is mentioned
 in NAPI_HOWTO.txt and yes the spinlock can help for the drivers that uses
 this type interrupt acking. And tulip is a candidate for this as well. Let 
 see if it solves Paul's problem to start with.

 Cheers.
						--ro

