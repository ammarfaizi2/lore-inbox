Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbULQXxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbULQXxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbULQXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:52:52 -0500
Received: from gprs215-176.eurotel.cz ([160.218.215.176]:37773 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262231AbULQXvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:51:11 -0500
Date: Sat, 18 Dec 2004 00:50:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, torvalds@osdl.org
Subject: Re: Cleanup PCI power states
Message-ID: <20041217235051.GC29084@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217220208.GA22752@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, here it is, slightly expanded version. It actually makes use of
> > newly defined type for type-checking purposes; still no code changes.
> 
> Alright, I've applied this, and it will show up in the next -mm release.
> I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> functions.
> 
> Now, care to send patches to fix up all of the new sparse warnings in
> the drivers/pci/* directory?

This should reduce number of warnings in pci.c. It will still warn on
comparison (because we are using __bitwise, but in fact we want
something like "this is unique but arithmetic is still ok"), but that
probably needs to be fixed in sparse.

Also killed "function does not return anything" warning.

Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux.middle//drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
+++ linux/drivers/pci/pci.c	2004-12-18 00:47:53.000000000 +0100
@@ -248,13 +248,13 @@
 	u16 pmcsr;
 
 	/* bound the state we're entering */
-	if (state > 3) state = 3;
+	if (state > PCI_D3hot) state = PCI_D3hot;
 
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (state > 0 && dev->current_state > state)
+	if (state != PCI_D0 && dev->current_state > state)
 		return -EINVAL;
 	else if (dev->current_state == state) 
 		return 0;        /* we're already there */
@@ -266,18 +266,18 @@
 	if (!pm) return -EIO; 
 
 	/* check if this device supports the desired state */
-	if (state == 1 || state == 2) {
+	if (state == PCI_D1 || state == PCI_D2) {
 		u16 pmc;
 		pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
-		if (state == 1 && !(pmc & PCI_PM_CAP_D1)) return -EIO;
-		else if (state == 2 && !(pmc & PCI_PM_CAP_D2)) return -EIO;
+		if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1)) return -EIO;
+		else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2)) return -EIO;
 	}
 
 	/* If we're in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= 3)
+	if (dev->current_state >= PCI_D3hot)
 		pmcsr = 0;
 	else {
 		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
@@ -290,9 +290,9 @@
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
-	if(state == 3 || dev->current_state == 3)
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
 		msleep(10);
-	else if(state == 2 || dev->current_state == 2)
+	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 	dev->current_state = state;
 
@@ -319,6 +319,7 @@
 	case 3: return PCI_D3hot;
 	default: BUG();
 	}
+	return PCI_D0;
 }
 
 EXPORT_SYMBOL(pci_choose_state);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
