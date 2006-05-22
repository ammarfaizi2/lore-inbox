Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWEVW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEVW5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWEVW5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:57:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28538 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750718AbWEVW5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:57:42 -0400
Date: Mon, 22 May 2006 16:57:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: [RFC PATCH] Fix broken suspend/resume in ohci1394 (Was: ACPI suspend
 problems revisited)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org, scjody@modernduck.com
Message-id: <447241CC.7010409@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------060404090803030003050401
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404090803030003050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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
what if there are commands in progress, etc? As such this is just an RFC.

Don't ask me why the failure to save/restore the state of the 1394
controller messes with the keyboard/EC controller, but it apparently does..

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

(Patch attached to stop Thunderbird from destroying it..)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/





--------------060404090803030003050401
Content-Type: text/plain;
 name="ohci1394-fix-suspend-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci1394-fix-suspend-resume.patch"

--- linux-2.6.16-1.2208_FC6/drivers/ieee1394/ohci1394.c	2006-05-22 12:34:30.000000000 -0600
+++ linux-2.6.16-1.2208_FC6ide/drivers/ieee1394/ohci1394.c	2006-05-22 14:56:53.000000000 -0600
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
 




--------------060404090803030003050401--

