Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVBFPGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVBFPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVBFPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:06:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45274 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261153AbVBFPGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:06:17 -0500
Date: Sun, 6 Feb 2005 15:06:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jean Delvare <khali@linux-fr.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>
Subject: Re: M7101
Message-ID: <20050206150611.GR20386@parcelfarce.linux.theplanet.co.uk>
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206152615.1ab7498c.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:26:15PM +0100, Jean Delvare wrote:
> Maarten Deprez then converted it to the proper kernel coding-style:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110726276414532
> 
> I invite you to test the new patch and confirm that it works for you.
> 
> Any chance we could get the PCI folks to review the code and push it
> upwards if it is OK?

Looks pretty good to me.  For clarity, I'd change:

-	m7101 = pci_scan_single_device(dev->bus, 0x18);
+	m7101 = pci_scan_single_device(dev->bus, PCI_DEVFN(3, 0));

and then test m7101 for being NULL -- if it fails, you'll get a NULL
ptr dereference from pci_read_config_byte():

-	if (pci_read_config_byte(m7101, 0x5B, &val)) {
+	if (!m7101 || pci_read_config_byte(m7101, 0x5B, &val)) {

I don't think you need to bother checking the subsequent write for failure:

 	if (val & 0x06) {
-		if (pci_write_config_byte(m7101, 0x5B, val & ~0x06)) {
-			printk(KERN_INFO "PCI: Failed to enable M7101 SMBus Controller\n");
-			return;
-		}
+		pci_write_config_byte(m7101, 0x5B, val & ~0x06);
 	}

So conceptually, I approve, just some details need fixing.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
