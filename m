Return-Path: <linux-kernel-owner+w=401wt.eu-S1753427AbWLWBfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbWLWBfr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbWLWBfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:35:46 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:40034 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbWLWBfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:35:46 -0500
Message-id: <552766292581216610@wsc.cz>
In-reply-to: <87r6urket6.fsf@javad.com>
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com>
Subject: Re: moxa serial driver testing
From: Jiri Slaby <jirislaby@gmail.com>
To: <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 23 Dec 2006 02:35:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

osv@javad.com wrote:
> Hi Jiri,
> 
> I've figured out that both old and new mxser drivers have two similar
> problems:
> 
> 1. When there are data coming to a port, sometimes opening of the port
>    entirely locks the box. This is quite reproducible. Any idea what's
>    wrong and how can I help to debug it?

Could you test the patch below, if something changes?

---

 drivers/char/mxser_new.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index a2bca5d..c0af201 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2268,6 +2268,8 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 			if (bits & irqbits)
 				continue;
 			port = &brd->ports[i];
+			if (!(port->flags & ASYNC_INITIALIZED))
+				continue;
 
 			int_cnt = 0;
 			do {
@@ -2320,9 +2322,9 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 					if (status & UART_LSR_THRE)
 						mxser_transmit_chars(port);
 				}
-			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
+			} while (int_cnt++ < 256);
 		}
-		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
+		if (pass_counter++ > 64)
 			break;	/* Prevent infinite loops */
 	}
 
