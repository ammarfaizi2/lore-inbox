Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWHNUT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWHNUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWHNUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:19:59 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:27785 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932709AbWHNUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:19:57 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Date: Mon, 14 Aug 2006 22:19:26 +0200
User-Agent: KMail/1.7.2
Cc: Marcus Better <marcus@better.se>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, ak@suse.de
References: <1155334308.7574.50.camel@localhost.localdomain> <200608142021.18551.daniel.ritz-ml@swissonline.ch> <1155585403.12700.10.camel@localhost.localdomain>
In-Reply-To: <1155585403.12700.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608142219.27950.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 1378;
	Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 21.56, Dave Hansen wrote:
> On Mon, 2006-08-14 at 20:21 +0200, Daniel Ritz wrote:
> > errm...sorry, i didn't mean that patch but the alternative i sent later. attached.
> > it should use direct access while not breaking legacy PCI probing. in theory..
> > 
> > thanks,
> > -daniel
> > 
> > diff --git a/arch/i386/pci/init.c b/arch/i386/pci/init.c
> > index c7650a7..51087a9 100644
> > --- a/arch/i386/pci/init.c
> > +++ b/arch/i386/pci/init.c
> > @@ -14,8 +14,12 @@ #endif
> >  #ifdef CONFIG_PCI_BIOS
> >  	pci_pcbios_init();
> >  #endif
> > -	if (raw_pci_ops)
> > -		return 0;
> > +	/*
> > +	 * don't check for raw_pci_ops here because we want pcbios as last
> > +	 * fallback, yet it's needed to run first to set pcibios_last_bus
> > +	 * in case legacy PCI probing is used. otherwise detecting peer busses
> > +	 * fails.
> > +	 */
> >  #ifdef CONFIG_PCI_DIRECT
> >  	pci_direct_init();
> >  #endif
> 
> That one works on my box without any issues.  Thanks!

nice! thanks for testing. 

Andrew/Greg could you add the patch to your trees? attached again with a better
description.

rgds
-daniel

-----

[PATCH] PCI: use PCBIOS as last fallback

there was a change in 2.6.17 which affected the order in which the PCI access
methods are probed. this gives regressions on some machines with broken BIOS.
the problem is that PCBIOS sometimes reports last bus wrong, leaving cardbus
non-funcational. previously those system worked fine with direct access.

the patch changes the PCI init code to have PCBIOS as last fallback, yet
the PCBIOS code still has to run first to set pcibios_last_bus to the value
reported by the BIOS. this is needed in case legacy PCI probing
(arch/i386/pci/legacy.c) is used to detect peer busses. using direct access
if available fixes the cardbus problems.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/arch/i386/pci/init.c b/arch/i386/pci/init.c
index c7650a7..51087a9 100644
--- a/arch/i386/pci/init.c
+++ b/arch/i386/pci/init.c
@@ -14,8 +14,12 @@ #endif
 #ifdef CONFIG_PCI_BIOS
 	pci_pcbios_init();
 #endif
-	if (raw_pci_ops)
-		return 0;
+	/*
+	 * don't check for raw_pci_ops here because we want pcbios as last
+	 * fallback, yet it's needed to run first to set pcibios_last_bus
+	 * in case legacy PCI probing is used. otherwise detecting peer busses
+	 * fails.
+	 */
 #ifdef CONFIG_PCI_DIRECT
 	pci_direct_init();
 #endif

