Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbVKXVNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVKXVNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVKXVNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:13:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:8929 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161046AbVKXVNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:13:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Date: Thu, 24 Nov 2005 22:14:15 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
References: <1132715288.26560.262.camel@gaston> <200511242150.23205.rjw@sisk.pl> <1132866088.26560.455.camel@gaston>
In-Reply-To: <1132866088.26560.455.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242214.16365.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24 of November 2005 22:01, Benjamin Herrenschmidt wrote:
> 
> > 
> > Well, it's there (actually the problem occurs in vanilla 2.6.15-rc2-mm1 that
> > contains the patch).  Do you mean it should go before the
> > 
> > if (readl(&ehci->regs->configured_flag) != FLAG_CF)
> > 		goto restart;
> > 
> > thing?
> 
> Yes.
> 
> > > It may be worth following it with a memory barrier actually... just in case
> > > (due to the absence of locks in that area).
> > 
> > wmb()?
> 
> Yup.
> 
> I wrote that patch against a tree that had different things in that
> function, Greg merged it by hand but he got that little bit wrong
> unfortunately. I'll send a new patch later today.

Thanks.

FWIW, does the appended change look reasonable to you?  (It apparently
helps. ;-))

Rafael


Index: linux-2.6.15-rc2-mm1/drivers/usb/host/ehci-pci.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/drivers/usb/host/ehci-pci.c	2005-11-24 21:42:34.000000000 +0100
+++ linux-2.6.15-rc2-mm1/drivers/usb/host/ehci-pci.c	2005-11-24 21:50:38.000000000 +0100
@@ -281,12 +281,13 @@
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	wmb();
+
 	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
 	if (readl(&ehci->regs->configured_flag) != FLAG_CF)
 		goto restart;
 
-	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
-
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 * We just defer that to the root hub code.
