Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUG2Tcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUG2Tcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUG2Tcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:32:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262279AbUG2TcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:32:21 -0400
Date: Thu, 29 Jul 2004 21:33:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: linux-kernel@vger.kernel.org, "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040729193341.GA27057@elte.hu>
References: <20040727225040.GA4370@yoda.timesys> <20040728081005.GA20100@elte.hu> <20040728231241.GE6685@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728231241.GE6685@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > Also, why the enable_irq() change? 
> 
> If you mean the do_startup_irq() change, [...]

i mean the change below - why do irqthreads necessiate it?

	Ingo

@@ -395,7 +402,14 @@ void enable_irq(unsigned int irq)
 			desc->status = status | IRQ_REPLAY;
 			hw_resend_irq(desc->handler,irq);
 		}
-		desc->handler->enable(irq);
+		
+		/* Don't unmask the IRQ if it's in progress, or else you
+		   could re-enter the IRQ handler.  As it is now enabled,
+		   the IRQ will be unmasked when the handler is finished. */
+		
+		if (!(desc->status & (IRQ_INPROGRESS | IRQ_THREADRUNNING |
+		                      IRQ_THREADPENDING)))
+			desc->handler->enable(irq);
 		/* fall-through */
 	}
 	default:
