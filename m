Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311294AbSCLRfW>; Tue, 12 Mar 2002 12:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311295AbSCLRfM>; Tue, 12 Mar 2002 12:35:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47820 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311294AbSCLRfE>;
	Tue, 12 Mar 2002 12:35:04 -0500
Date: Tue, 12 Mar 2002 09:31:34 -0800 (PST)
Message-Id: <20020312.093134.35196670.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015887102.2051.4.camel@monkey>
In-Reply-To: <1015881102.4312.10.camel@monkey>
	<1015881814.4315.12.camel@monkey>
	<1015887102.2051.4.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 11 Mar 2002 22:51:42 +0000

   Ok, I've been fiddling around with the driver tonight and have managed
   to get a little further by forcing the driver to do a full reset of the
   chip when the RX buffer over flows. I achieved this by sticking a return
   1; at the top of gem_rxmac_reset().
   
   I'm guessing this isn't an "optimal" reset for the situation but so far
   it's having /reasonable/ results (i.e. I don't have to bring the
   interface up and down every 30 seconds!).
 ...   
   Hope this helps,

I'll follow up on this and figure out why my RX reset code
isn't working after I finish up some 2.5.x work.

But looking quickly I think I see what is wrong.  Please give
this a try (and remember to remove your hacks before testing
this :-):

--- drivers/net/sungem.c.~1~	Mon Mar 11 04:24:13 2002
+++ drivers/net/sungem.c	Tue Mar 12 09:30:38 2002
@@ -357,6 +357,7 @@ static int gem_rxmac_reset(struct gem *g
 
 		rxd->status_word = cpu_to_le64(RXDCTRL_FRESH(gp));
 	}
+	gp->rx_new = gp->rx_old = 0;
 
 	/* Now we must reprogram the rest of RX unit. */
 	desc_dma = (u64) gp->gblock_dvma;
