Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWHJI3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWHJI3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWHJI3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:29:42 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:29961 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161129AbWHJI3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:29:41 -0400
Date: Thu, 10 Aug 2006 10:29:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-Id: <20060810102944.a12329b9.khali@linux-fr.org>
In-Reply-To: <20060807145832.GF10387@atomide.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com>
	<20060805103113.058ce8fe.khali@linux-fr.org>
	<20060807145832.GF10387@atomide.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony, Komal,

> Hmmm, this sounds like a bug somewhere. TRM for 5912 says the I2C clock
> must be prescaled to be between 7 - 12 MHz [1]. The XOR input clock is
> typically 12, 13 or 19.2 MHz. So we should have code that produces:
> 
> XOR Mhz	Divider	Prescaler
> 12		1	0
> 13		2	1
> 19.2		2	1

Not that 13 MHz cannot actually be prescaled between 7 and 12 MHz, no
matter how you look at it.

> Then again the original old code produces something different too [2]...
> 
> I suspect the original code had some hw workarounds and and later code
> may have a conversion bug somewhere :)
> 
> I suggest we keep the code as is for now since it's known to work on
> all omaps, and then submit a follow-up patch later once we have
> verified that that code based on the TRM works on all omaps.

I've now taken Komal's patch (#4). Here is a proposed patch which brings
the prescaler computation formula in line with your comment and table
above. It could be applied on top of Komal's patch unless it causes a
problem on some of the OMAP systems. For XOR = 13 MHz, it changes the
prescaler from 0 to 1. For XOR = 19.2 MHz it changes the prescaler from
2 to 1.

I don't have any hardware to test it, though. If it happens to be
better to be slightly over 12 MHz than slightly below 7 MHz, the
"> 12000000" condition below can be replaced with "> 14000000".


i2c: Fix OMAP clock prescaler to match the comment

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/i2c/busses/i2c-omap.c	2006-08-10 09:56:54.000000000 +0200
+++ linux-2.6.18-rc4/drivers/i2c/busses/i2c-omap.c	2006-08-10 10:12:03.000000000 +0200
@@ -231,8 +231,8 @@
 		 * 13		2		1
 		 * 19.2		2		1
 		 */
-		if (fclk_rate > 16000000)
-			psc = (fclk_rate + 8000000) / 12000000;
+		if (fclk_rate > 12000000)
+			psc = fclk_rate / 12000000;
 	}
 
 	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */


-- 
Jean Delvare
