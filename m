Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWF0UR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWF0UR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWF0UR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:17:59 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45443 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161277AbWF0UR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:17:57 -0400
Message-Id: <20060627201539.350588000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Robert Hancock <hancockr@shaw.ca>, Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>
Subject: [PATCH 18/25] ohci1394: Fix broken suspend/resume in ohci1394
Content-Disposition: inline; filename=ohci1394-fix-broken-suspend-resume-in-ohci1394.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Robert Hancock <hancockr@shaw.ca>

I've been experimenting to track down the cause of suspend/resume
problems on my Compaq Presario X1050 laptop:

http://bugzilla.kernel.org/show_bug.cgi?id=6075

Essentially the ACPI Embedded Controller and keyboard controller would
get into a bizarre, confused state after resume.

I found that unloading the ohci1394 module before suspend and reloading
it after resume made the problem go away. Diffing the dmesg output from
resume, with and without the module loaded, I found that with the module
loaded I was missing these:

PM: Writing back config space on device 0000:02:00.0 at offset 1. (Was
2100080, writing 2100007)
PM: Writing back config space on device 0000:02:00.0 at offset 3. (Was
0, writing 8008)
PM: Writing back config space on device 0000:02:00.0 at offset 4. (Was
0, writing 90200000)
PM: Writing back config space on device 0000:02:00.0 at offset 5. (Was
1, writing 2401)
PM: Writing back config space on device 0000:02:00.0 at offset f. (Was
20000100, writing 2000010a)

The default PCI driver performs the pci_restore_state when no driver is
loaded for the device. When the ohci1394 driver is loaded, it is
supposed to do this, however it appears not to do so.

I created the patch below and tested it, and it appears to resolve the
suspend problems I was having with the module loaded. I only added in
the pci_save_state and pci_restore_state - however, though I know little
of this hardware, surely the driver should really be doing more than
this when suspending and resuming? Currently it does almost nothing,
what if there are commands in progress, etc?

Signed-off-by: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/ieee1394/ohci1394.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.17.1.orig/drivers/ieee1394/ohci1394.c
+++ linux-2.6.17.1/drivers/ieee1394/ohci1394.c
@@ -3539,6 +3539,7 @@ static int ohci1394_pci_resume (struct p
 	}
 #endif /* CONFIG_PPC_PMAC */
 
+	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 
 	return 0;
@@ -3558,6 +3559,8 @@ static int ohci1394_pci_suspend (struct 
 	}
 #endif
 
+	pci_save_state(pdev);
+
 	return 0;
 }
 

--
