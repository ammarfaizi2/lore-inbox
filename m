Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUBQAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUBQAU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:20:28 -0500
Received: from q.bofh.de ([212.126.220.202]:64007 "EHLO q.bofh.de")
	by vger.kernel.org with ESMTP id S261872AbUBQAUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:20:19 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] HiSax I-Talk/I-Surf doesn't configure card properly
 using kernel isapnp
Mail-Copies-To: nobody
From: Hilko Bengen <bengen@hilluzination.de>
Date: Tue, 17 Feb 2004 01:04:46 +0100
Message-ID: <87isi6woyp.fsf@hilluzination.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is still needed as of 2.4.25-rc3. Please apply.

-Hilko

Subject: [patch] 2.4 HiSax I-Talk/I-Surf doesn't work together with kernel
 isapnp
From:	Hilko Bengen <bengen@hilluzination.de>
To:	marcelo.tosatti@cyclades.com
Cc:	linux-kernel@vger.kernel.org, keil@isdn4linux.de,
	kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
	perex@suse.cz
Date:	Thu, 05 Feb 2004 23:16:39 +0100
Message-ID: <87isiluq7s.fsf@hilluzination.de>

In 2.4, the HiSax I-Talk/I-Surf driver can only be initialized
successfully if the card has been activated using the isapnp userspace
tools. Automatic configuration using the isa-pnp module in the kernel
fails with messages such as:

Feb  4 00:28:19 paranoia kernel: ISurfPnP:some resources are missing 5/100/0
Feb  4 00:28:19 paranoia kernel: HiSax: Card Siemens I-Surf not installed !

There are two reasons for this failure:
(1) The isapnp code correctly builds the data structures, but the code
    in isurf.c looks in the wrong place for the mem parameter.
(2) The IO memory upper limit address is not set by isapnp code. I'm
    unsure whether this is a bug in isapnp.c or a hardware bug. I
    assumed the latter and did the fix in the I-Surf initialization
    routine.

The attached patch fixes the two issues. Please apply it to the 2.4
tree. I have successfully tested it on the two of my systems that have
an I-Surf.

Greetings,
-Hilko

diff -uir orig/linux-2.4.24/drivers/isdn/hisax/isurf.c linux-2.4.24/drivers/isdn/hisax/isurf.c
--- orig/linux-2.4.24/drivers/isdn/hisax/isurf.c	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.24/drivers/isdn/hisax/isurf.c	2004-02-05 15:44:20.000000000 +0100
@@ -235,8 +235,18 @@
 				pd->prepare(pd);
 				pd->deactivate(pd);
 				pd->activate(pd);
+				/* The ISA-PnP logic apparently
+				 * expects upper limit address to be
+				 * set. Since the isa-pnp module
+				 * doesn't do this, so we have to make
+				 * up for it.
+				 */
+				isapnp_cfg_begin(pd->bus->number, pd->devfn);
+				isapnp_write_word(ISAPNP_CFG_MEM+3, 
+					pd->resource[8].end >> 8);
+				isapnp_cfg_end();
 				cs->hw.isurf.reset = pd->resource[0].start;
-				cs->hw.isurf.phymem = pd->resource[1].start;
+				cs->hw.isurf.phymem = pd->resource[8].start;
 				cs->irq = pd->irq_resource[0].start;
 				if (!cs->irq || !cs->hw.isurf.reset || !cs->hw.isurf.phymem) {
 					printk(KERN_ERR "ISurfPnP:some resources are missing %d/%x/%lx\n",

