Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVKKQls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKKQls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVKKQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:41:48 -0500
Received: from smtpauth09.mail.atl.earthlink.net ([209.86.89.69]:48782 "EHLO
	smtpauth09.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750867AbVKKQlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:41:47 -0500
Date: Fri, 11 Nov 2005 11:41:42 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Javier Achirica <achirica@gmail.com>, Jean Tourrilhes <jt@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14] airo.c: add support for IW_ENCODE_TEMP (i.e. xsupplicant)
Message-ID: <Pine.LNX.4.51.0511111128450.21146@dylan.root.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELNK-Trace: a4c357c9134943511aa676d7e74259b7b3291a7d08dfec793413d04b0c793b1bf0d528acc849b951350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.148.162.106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jeff,

this patch changes causes the airo driver to not reset the card when a
temporary WEP key is set, when the IW_ENCODE_TEMP flag is used.  This is
needed for xsupplicant as 802.1x, LEAP, etc. change WEP keys frequently
after authentication and resetting the card causes infinite
reauthentication.

Javier and Jean agree with the patch, Javier suggested I send this to 
you, can you apply this?

Thanks.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>




diff -urpN a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	2005-10-27 20:02:08.000000000 -0400
+++ b/drivers/net/wireless/airo.c	2005-11-02 10:32:25.000000000 -0500
@@ -4059,7 +4059,7 @@ static int PC4500_writerid(struct airo_i
 		Cmd cmd;
 		Resp rsp;
 
-		if (test_bit(FLAG_ENABLED, &ai->flags))
+		if (test_bit(FLAG_ENABLED, &ai->flags) && (RID_WEP_TEMP != rid))
 			printk(KERN_ERR
 				"%s: MAC should be disabled (rid=%04x)\n",
 				__FUNCTION__, rid);
@@ -5119,9 +5119,9 @@ static int set_wep_key(struct airo_info 
 		printk(KERN_INFO "Setting key %d\n", index);
 	}
 
-	disable_MAC(ai, lock);
+	if (perm) disable_MAC(ai, lock);
 	writeWepKeyRid(ai, &wkr, perm, lock);
-	enable_MAC(ai, &rsp, lock);
+	if (perm) enable_MAC(ai, &rsp, lock);
 	return 0;
 }
 
@@ -6202,6 +6202,8 @@ static int airo_set_encode(struct net_de
 {
 	struct airo_info *local = dev->priv;
 	CapabilityRid cap_rid;		/* Card capability info */
+	int perm = ( dwrq->flags & IW_ENCODE_TEMP ? 0 : 1 );
+	u16 currentAuthType = local->config.authType;
 
 	/* Is WEP supported ? */
 	readCapabilityRid(local, &cap_rid, 1);
@@ -6244,7 +6246,7 @@ static int airo_set_encode(struct net_de
 			/* Copy the key in the driver */
 			memcpy(key.key, extra, dwrq->length);
 			/* Send the key to the card */
-			set_wep_key(local, index, key.key, key.len, 1, 1);
+			set_wep_key(local, index, key.key, key.len, perm, 1);
 		}
 		/* WE specify that if a valid key is set, encryption
 		 * should be enabled (user may turn it off later)
@@ -6252,13 +6254,12 @@ static int airo_set_encode(struct net_de
 		if((index == current_index) && (key.len > 0) &&
 		   (local->config.authType == AUTH_OPEN)) {
 			local->config.authType = AUTH_ENCRYPT;
-			set_bit (FLAG_COMMIT, &local->flags);
 		}
 	} else {
 		/* Do we want to just set the transmit key index ? */
 		int index = (dwrq->flags & IW_ENCODE_INDEX) - 1;
 		if ((index >= 0) && (index < ((cap_rid.softCap & 0x80)?4:1))) {
-			set_wep_key(local, index, NULL, 0, 1, 1);
+			set_wep_key(local, index, NULL, 0, perm, 1);
 		} else
 			/* Don't complain if only change the mode */
 			if(!dwrq->flags & IW_ENCODE_MODE) {
@@ -6273,7 +6274,7 @@ static int airo_set_encode(struct net_de
 	if(dwrq->flags & IW_ENCODE_OPEN)
 		local->config.authType = AUTH_ENCRYPT;	// Only Wep
 	/* Commit the changes to flags if needed */
-	if(dwrq->flags & IW_ENCODE_MODE)
+	if (local->config.authType != currentAuthType)
 		set_bit (FLAG_COMMIT, &local->flags);
 	return -EINPROGRESS;		/* Call commit handler */
 }
