Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUHWTxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUHWTxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUHWTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:52:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:44995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266819AbUHWSgR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:17 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286089538@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <10932860893685@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.43, 2004/08/10 14:44:40-07:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: rpaphp_get_power_level bug fix

Recently I have run into the problem where I got the power-level "0"
while I was expecting "100" from a slot that had pwered on. The attached
patch fixes rpaphp_slot.c to use an int pointer(instead of an u8
pointer) when calling rtas_get_power_level routine.


Signed-off-by: Linda Xie <lxie@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp_slot.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- a/drivers/pci/hotplug/rpaphp_slot.c	2004-08-23 11:02:33 -07:00
+++ b/drivers/pci/hotplug/rpaphp_slot.c	2004-08-23 11:02:33 -07:00
@@ -244,7 +244,7 @@
 
 int rpaphp_get_power_status(struct slot *slot, u8 * value)
 {
-	int rc = 0;
+	int rc = 0, level;
 	
 	if (slot->type == EMBEDDED) {
 		dbg("%s set to POWER_ON for EMBEDDED slot %s\n",
@@ -252,10 +252,14 @@
 		*value = POWER_ON;
 	}
 	else {
-		rc = rtas_get_power_level(slot->power_domain, (int *) value);
-		if (rc)
+		rc = rtas_get_power_level(slot->power_domain, &level);
+		if (!rc) {
+			dbg("%s the power level of slot %s(pwd-domain:0x%x) is %d\n",
+				__FUNCTION__, slot->name, slot->power_domain, level);
+			*value = level;
+		} else
 			err("failed to get power-level for slot(%s), rc=0x%x\n",
-		    		slot->location, rc);
+				slot->location, rc);
 	}
 
 	return rc;

