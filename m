Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWHUSvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWHUSvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWHUSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:51:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:30653 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750805AbWHUSuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:50:12 -0400
Date: Mon, 21 Aug 2006 11:48:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, scjody@modernduck.com,
       bcollins@ubuntu.com, benh@kernel.crashing.org, obiwan@mailmij.org,
       stefanr@s5r6.in-berlin.de, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/20] 1394: fix for recently added firewire patch that breaks things on ppc
Message-ID: <20060821184831.GV21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="1394-fix-for-recently-added-firewire-patch-that-breaks-things-on-ppc.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Danny Tholen <obiwan@mailmij.org>

Recently a patch was added for preliminary suspend/resume handling on
!PPC_PMAC.  However, this broke both suspend and firewire on powerpc
because it saves the pci state after the device has already been disabled.

This moves the save state to before the pmac specific code.

Signed-off-by: Danny Tholen <obiwan@mailmij.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ben Collins <bcollins@ubuntu.com>
Cc: Jody McIntyre <scjody@modernduck.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ieee1394/ohci1394.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.9.orig/drivers/ieee1394/ohci1394.c
+++ linux-2.6.17.9/drivers/ieee1394/ohci1394.c
@@ -3548,6 +3548,8 @@ static int ohci1394_pci_resume (struct p
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
+	pci_save_state(pdev);
+
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3559,8 +3561,6 @@ static int ohci1394_pci_suspend (struct 
 	}
 #endif
 
-	pci_save_state(pdev);
-
 	return 0;
 }
 

--
