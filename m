Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTJ1Kvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 05:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTJ1Kvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 05:51:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20238 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263927AbTJ1Kva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 05:51:30 -0500
Date: Tue, 28 Oct 2003 10:51:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Greg KH <greg@kroah.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent PCI driver registration failure oopsing
Message-ID: <20031028105126.I22424@flint.arm.linux.org.uk>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>, Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20031028100402.F22424@flint.arm.linux.org.uk> <jehe1tvdsq.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <jehe1tvdsq.fsf@sykes.suse.de>; from schwab@suse.de on Tue, Oct 28, 2003 at 11:48:05AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 11:48:05AM +0100, Andreas Schwab wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > +	return rc < 0 ? : 0;
> 
> Are you sure you want to return 1 if rc < 0?

Argh.  Definitely not.  Thanks for spotting that.

--- orig/include/linux/pci.h	Thu Mar 13 14:24:56 2003
+++ linux/include/linux/pci.h	Wed Mar 12 19:37:41 2003
@@ -768,26 +768,7 @@
 {
 	int rc = pci_register_driver (drv);
 
-	if (rc > 0)
-		return 0;
-
-	/* iff CONFIG_HOTPLUG and built into kernel, we should
-	 * leave the driver around for future hotplug events.
-	 * For the module case, a hotplug daemon of some sort
-	 * should load a module in response to an insert event. */
-#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
-	if (rc == 0)
-		return 0;
-#else
-	if (rc == 0)
-		rc = -ENODEV;		
-#endif
-
-	/* if we get here, we need to clean up pci driver instance
-	 * and return some sort of error */
-	pci_unregister_driver (drv);
-	
-	return rc;
+	return rc < 0 ? rc : 0;
 }
 
 /*



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
