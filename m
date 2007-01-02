Return-Path: <linux-kernel-owner+w=401wt.eu-S932839AbXABLsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbXABLsf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbXABLsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:48:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54605 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932839AbXABLse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:48:34 -0500
Date: Tue, 2 Jan 2007 11:58:34 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102115834.1e7644b2@localhost.localdomain>
In-Reply-To: <459973F6.2090201@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a slight variant on the patch I posted December 16th to fix
libata combined mode handling. The only real change is that we now
correctly also reserve BAR1,2,4. That is basically a neatness issue.

Jeff was unhappy about two things

1. That it didn't work in the case of one channel native one channel
legacy. 

This is a silly complaint because the SFF layer in libata doesn't handle
this case yet anyway.

2. The case where combined mode is in use and IDE=n. 

In this case the libata quirk code reserves the resources in question
correctly already.

Once the combined mode stuff is redone properly (2.6.21) then the entire
mess turns into a single pci_request_regions() for all cases and all the
ugly resource hackery goes away.

I'm sending this now rather than after running full test suites so that
it can get the maximal testing in a short time. I'll be running tests on
this after lunch. 

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc3/drivers/ata/libata-sff.c	2007-01-01 21:43:27.000000000 +0000
+++ linux-2.6.20-rc3/drivers/ata/libata-sff.c	2007-01-02 11:15:53.000000000 +0000
@@ -1027,13 +1027,15 @@
 #endif
 	}
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		disable_dev_on_err = 0;
-		goto err_out;
-	}
-
-	if (legacy_mode) {
+	if (!legacy_mode) {
+		rc = pci_request_regions(pdev, DRV_NAME);
+		if (rc) {
+			disable_dev_on_err = 0;
+			goto err_out;
+		}
+	} else {
+		/* Deal with combined mode hack. This side of the logic all
+		   goes away once the combined mode hack is killed in 2.6.21 */
 		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_PRIMARY_CMD;
@@ -1071,6 +1073,13 @@
 			}
 		} else
 			legacy_mode |= ATA_PORT_SECONDARY;
+
+		if (legacy_mode & ATA_PORT_PRIMARY)
+			pci_request_region(pdev, 1, DRV_NAME);
+		if (legacy_mode & ATA_PORT_SECONDARY)
+			pci_request_region(pdev, 3, DRV_NAME);
+		/* If there is a DMA resource, allocate it */
+		pci_request_region(pdev, 4, DRV_NAME);
 	}
 
 	/* we have legacy mode, but all ports are unavailable */
@@ -1114,11 +1123,20 @@
 err_out_ent:
 	kfree(probe_ent);
 err_out_regions:
-	if (legacy_mode & ATA_PORT_PRIMARY)
-		release_region(ATA_PRIMARY_CMD, 8);
-	if (legacy_mode & ATA_PORT_SECONDARY)
-		release_region(ATA_SECONDARY_CMD, 8);
-	pci_release_regions(pdev);
+	/* All this conditional stuff is needed for the combined mode hack
+	   until 2.6.21 when it can go */
+	if (legacy_mode) {
+		pci_release_region(pdev, 4);
+		if (legacy_mode & ATA_PORT_PRIMARY) {
+			release_region(ATA_PRIMARY_CMD, 8);
+			pci_release_region(pdev, 1);
+		}
+		if (legacy_mode & ATA_PORT_SECONDARY) {
+			release_region(ATA_SECONDARY_CMD, 8);
+			pci_release_region(pdev, 3);
+		}
+	} else
+		pci_release_regions(pdev);
 err_out:
 	if (disable_dev_on_err)
 		pci_disable_device(pdev);
