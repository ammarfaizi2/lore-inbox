Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWHNSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWHNSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWHNSVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:21:55 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:43220 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1752042AbWHNSVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:21:54 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Date: Mon, 14 Aug 2006 20:21:17 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, Marcus Better <marcus@better.se>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, ak@suse.de
References: <1155334308.7574.50.camel@localhost.localdomain> <200608141858.37465.daniel.ritz-ml@swissonline.ch> <1155575804.7574.166.camel@localhost.localdomain>
In-Reply-To: <1155575804.7574.166.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608142021.18551.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1378;
	Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 19.16, Dave Hansen wrote:
> On Mon, 2006-08-14 at 18:58 +0200, Daniel Ritz wrote:
> > hmm..should be 2.6.16 behavior with this...
> > what kind of box is this?
> 
> I know my earlier description was vague.  Please let me know if there
> are any specifics you need.

thanks, for the info.

> 
> > could you give me dmesg output of plain 2.6.18-rc4
> 
> http://sr71.net/~dave/linux/daniel.ritz/dmesg-elm3b82-2.6.18-rc4.txt
> 
> > and a 2.6.18-rc4 with the patch (not -mm if possible)?
> 
> http://sr71.net/~dave/linux/daniel.ritz/dmesg-elm3b82-2.6.18-rc4-with-gregkh-pci-pci-use-pci_bios-as-last-fallback.txt
> 
> > oh...and a lspci -vvv please
> 
> http://sr71.net/~dave/linux/daniel.ritz/lspci-vvv-elm3b82.txt
> 
> (A reversed copy of) the patch I applied to 2.6.18-rc4 is in that
> directory, too:
> 
> http://sr71.net/~dave/linux/daniel.ritz/gregkh-pci-pci-use-pci_bios-as-last-fallback.patch

errm...sorry, i didn't mean that patch but the alternative i sent later. attached.
it should use direct access while not breaking legacy PCI probing. in theory..

thanks,
-daniel

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
