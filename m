Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVBPXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVBPXyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVBPXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:54:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56272 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262128AbVBPXyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:54:33 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Wed, 16 Feb 2005 15:54:00 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <1108515817.13375.63.camel@gaston>
In-Reply-To: <1108515817.13375.63.camel@gaston>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a09ECd9wZMo9ttJ"
Message-Id: <200502161554.02110.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_a09ECd9wZMo9ttJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, February 15, 2005 5:03 pm, Benjamin Herrenschmidt wrote:
> What about printing "No PCI ROM detected" ? I like having that info when
> getting user reports, but I agree that a less worrying message would
> be good.

Ok, how about this then?  It changes the printks in both drivers to KERN_INFO 
and describes the situation a bit more accurately.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

P.S. Jon, I think the pci_map_rom code is buggy--if the option ROM signature 
is missing or indicates that there's no ROM, the routine still returns a 
valid pointer making the caller thing it succeeded.  If we fix that up we can 
fix up the callers.

--Boundary-00=_a09ECd9wZMo9ttJ
Content-Type: text/x-diff;
  charset="utf-8";
  name="aty-no-rom-present-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aty-no-rom-present-cleanup.patch"

===== drivers/video/aty/radeon_base.c 1.39 vs edited =====
--- 1.39/drivers/video/aty/radeon_base.c	2005-02-10 22:57:44 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2005-02-16 15:48:48 -08:00
@@ -330,8 +330,8 @@
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
-		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
+		printk(KERN_INFO "radeonfb (%s): no ROM present\n",
+		       pci_name(rinfo->pdev));
 		goto failed;
 	}
 	/* Look for the PCI data to check the ROM type */
===== drivers/video/aty/aty128fb.c 1.56 vs edited =====
--- 1.56/drivers/video/aty/aty128fb.c	2005-02-10 22:57:44 -08:00
+++ edited/drivers/video/aty/aty128fb.c	2005-02-16 15:50:12 -08:00
@@ -813,8 +813,8 @@
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
-		       BIOS_IN16(0));
+		printk(KERN_INFO "aty128fb (%s): no ROM present\n",
+		       pci_name(dev));
 		goto failed;
 	}
 

--Boundary-00=_a09ECd9wZMo9ttJ--
