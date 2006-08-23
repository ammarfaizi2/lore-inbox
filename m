Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWHWIKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWHWIKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWHWIKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:10:00 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:19869 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932380AbWHWIJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:09:59 -0400
Message-ID: <44EC0C6C.80502@s5r6.in-berlin.de>
Date: Wed, 23 Aug 2006 10:06:04 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.28-rc2
References: <20060822230102.GC19896@stusta.de>
In-Reply-To: <20060822230102.GC19896@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------030709080406070303060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709080406070303060402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> There are still several patches pending - they will go into 2.6.16.29.
[...]
> Robert Hancock:
>       Fix broken suspend/resume in ohci1394
[...]

Alas this patch is a regression for PPC. Please apply patch "1394: fix
for recently added firewire patch that breaks things on ppc" by Danny
Tholen too. The latter patch is enqueued for 2.6.17.y and (so I hope)
for 2.6.18-rc which both contain Robert's patch. I attached Danny's
patch as I cannot safely send it inline right now.

_If_ you don't want to add Danny's patch until it actually appeared in
2.6.18-rc, please revert Robert's patch for the time being.

Thanks, and sorry for the mess.
-- 
Stefan Richter
-=====-=-==- =--- =-===
http://arcgraph.de/sr/

--------------030709080406070303060402
Content-Type: text/plain;
 name*0="fix-for-recently-added-firewire-patch-that-breaks-things-on-ppc.";
 name*1="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="fix-for-recently-added-firewire-patch-that-breaks-things-on-";
 filename*1="ppc.patch"

Subject: 1394: fix for recently added firewire patch that breaks things on ppc
From: Danny Tholen <obiwan@mailmij.org>

Recently a patch was added for preliminary suspend/resume handling on
!PPC_PMAC.  However, this broke both suspend and firewire on powerpc
because it saves the pci state after the device has already been disabled.

This moves the save state to before the pmac specific code.

Signed-off-by: Danny Tholen <obiwan@mailmij.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

 drivers/ieee1394/ohci1394.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ieee1394/ohci1394.c~fix-for-recently-added-firewire-patch-that-breaks-things-on-ppc drivers/ieee1394/ohci1394.c
--- a/drivers/ieee1394/ohci1394.c~fix-for-recently-added-firewire-patch-that-breaks-things-on-ppc
+++ a/drivers/ieee1394/ohci1394.c
@@ -3552,6 +3552,8 @@ static int ohci1394_pci_resume (struct p
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
+	pci_save_state(pdev);
+
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3563,8 +3565,6 @@ static int ohci1394_pci_suspend (struct 
 	}
 #endif
 
-	pci_save_state(pdev);
-
 	return 0;
 }
 
_


--------------030709080406070303060402--
