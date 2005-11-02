Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVKBVbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVKBVbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbVKBVbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:31:39 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:14473 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S965253AbVKBVbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:31:38 -0500
Date: Wed, 2 Nov 2005 16:31:36 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
cc: breed@zuzulu.com, open1x-list <open1x-xsupplicant@lists.sourceforge.net>
Subject: Re: [PATCH 2.6.14] dynamic wep keys for airo.c
Message-ID: <Pine.LNX.4.51.0511021540510.9266@dylan.root.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELNK-Trace: a4c357c9134943511aa676d7e74259b7b3291a7d08dfec79e2a74071786eb7c723bf9513a68d00e8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.148.162.106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I know this thread is _long_ over (6 months...) but the airo driver still 
doesn't support setting only the temp WEP key.  I submitted a patch 
back at the end of 2004 (maybe to the wrong list...):
http://marc.theaimsgroup.com/?l=linux-net&m=110203363216571&w=2

My original patch is still (IMHO ;-) the correct solution.  The current
xsupplicant has default support for it (it uses IW_ENCODE_TEMP by
default).  And my patch does exactly what you (Jean) proposed, so I think
you hopefully agree it's the right thing to do :)

I've included the patch (re-diffed with 2.6.14) at the bottom of the 
email.  Is it possible to get this patch into the kernel?

Thanks!


>On Tue, May 03, 2005 at 05:34:31PM -0500, breed@zuzulu.com wrote:
>> Jean,
>> 
>> There is no patch to xsupplicant that will work without patching the
>> airo.c driver. The current airo.c driver always disables the MAC before
>> setting the WEP key whether it is temporary or permanent. This is
>> incorrect. When the MAC is disabled the card disassociates causing the
>> whole handshake to start over again.
>
>	Yes, I know perfectly. A patch is needed, however I don't
>think your current patch is the most appropriate solution.
>
>	The current solution is :
>	1) set perm key -> goes in the eeprom, reset MAC
>	2) set temp key -> not in the eeprom, reset MAC
>	o /proc can set (1) and (2)
>	o iwconfig can only set (1)
>	o xsupplicant always set (1) - broken
>
>	You solution is :
>	1) set temp key -> not in the eeprom, not reset MAC
>	2a) set perm key -> goes in the eeprom, reset MAC
>	2b) set perm key -> goes in the eeprom, not reset MAC
>	o module parameter select (2a) or (2b)
>	o iwconfig can set (2) {default} or (1) {temp keyword}
>	o old xsupplicant set (2) - may work, depend on module parameter
>	o new xsupplicant set (1) - always work
>
>	First, do we know for sure that all Aironet firmware will
>accept to change the perm WEP key without having to reset the MAC ?
>Maybe the Cisco driver does it this way, but it only target the latest
>firware rev, whereas up to know we have included in the driver code
>for very antique firmware rev. I don't have the answer to that one.
>	Second, I think that the module parameter is counter
>productive. What we want there is people migrating to the new
>xsupplicant that does the right thing. Also, module parameter is not
>something that can be changed on the fly, and is one more thing to
>configure. We want things to always work, all the time.
>
>	What I would think is better long term :
>	1) set temp key -> not in the eeprom, not reset MAC
>	2) set perm key -> goes in the eeprom, reset MAC
>	o iwconfig can set (2) {default} or (1) {temp keyword}
>	o old xsupplicant set (2) - always broken
>	o new xsupplicant set (1) - always work
>
>	But, that's only my personal opinion, and you may want to
>check what the new xsupplicant is doing before making the final
>decision.

Here's the patch:

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
