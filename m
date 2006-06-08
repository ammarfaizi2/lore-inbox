Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWFHIfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWFHIfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWFHIfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:35:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28572 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932561AbWFHIfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:35:00 -0400
Date: Thu, 8 Jun 2006 10:34:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Cc: linux-usb-devel@lists.sourceforge.net, Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
Subject: [PATCH] limit power budget on spitz
Message-ID: <20060608083412.GJ3688@elf.ucw.cz>
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz> <200606031129.54580.oliver@neukum.org> <200606050732.53496.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606050732.53496.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This limits power budget on spitz to 250mA. I'm not sure if it is the
right value, but it is certainly better than default 500mA, and
prevents nasty failure mode with zd1201.

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.17-rc6-git

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index acde886..1d8b58c 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -185,6 +185,13 @@ int usb_hcd_pxa27x_probe (const struct h
 	/* Select Power Management Mode */
 	pxa27x_ohci_select_pmm(inf->port_mode);
 
+	if (machine_is_spitz()) {
+		/* Warning, not coming from any official docs. But
+		 * spitz is unable to properly power wireless card
+		 * claiming 500mA -- usb interface work but wireless
+		 * does not. */
+		hcd->power_budget = 250;
+	}
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	retval = usb_add_hcd(hcd, pdev->resource[1].start, SA_INTERRUPT);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
