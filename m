Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbTIUEU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 00:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTIUEU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 00:20:29 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:5770 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262326AbTIUEU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 00:20:27 -0400
Message-ID: <3F6D2832.8040609@terra.com.br>
Date: Sun, 21 Sep 2003 01:25:22 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Using possibly corrupted structure in atm/he.c
Content-Type: multipart/mixed;
 boundary="------------070503080608020407050300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503080608020407050300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Chas,

	Patch against 2.6-test5.

	If copy_from_user returns != 0, it means the the regs structure wasn't 
filled correctly, and since its fields are used to determine which ioctl 
the user is requesting the kernel could oops.

	And as long as we're covering the subject, the patch also audits 
copy_to_user on the same function to check a possible failure to copy 
the result back to userspace.

	These bugs were found by smatch.

	Please consider applying.

	Cheers,

Felipe
-- 
It's most certainly GNU/Linux, not Linux. Read more at
http://www.gnu.org/gnu/why-gnu-linux.html

--------------070503080608020407050300
Content-Type: text/plain;
 name="atm_he-copy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atm_he-copy.patch"

--- linux-2.6.0-test5/drivers/atm/he.c	Mon Sep  8 16:49:54 2003
+++ linux-2.6.0-test5-fwd/drivers/atm/he.c	Sun Sep 21 01:13:39 2003
@@ -2860,8 +2860,10 @@
 			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
 
-			copy_from_user(&reg, (struct he_ioctl_reg *) arg,
-						sizeof(struct he_ioctl_reg));
+			if (copy_from_user(&reg, (struct he_ioctl_reg *) arg,
+						sizeof(struct he_ioctl_reg)))
+				return -EFAULT;
+			
 			spin_lock_irqsave(&he_dev->global_lock, flags);
 			switch (reg.type) {
 				case HE_REGTYPE_PCI:
@@ -2885,8 +2887,9 @@
 			}
 			spin_unlock_irqrestore(&he_dev->global_lock, flags);
 			if (err == 0)
-				copy_to_user((struct he_ioctl_reg *) arg, &reg,
-							sizeof(struct he_ioctl_reg));
+				if (copy_to_user((struct he_ioctl_reg *) arg, &reg,
+							sizeof(struct he_ioctl_reg)))
+					return -EFAULT;
 			break;
 		default:
 #ifdef CONFIG_ATM_HE_USE_SUNI

--------------070503080608020407050300--

