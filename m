Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbTI3Ne6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTI3Ne6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:34:58 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:2009 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261459AbTI3Nez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:34:55 -0400
Message-ID: <3F7986C2.1030101@terra.com.br>
Date: Tue, 30 Sep 2003 10:36:02 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com.br
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       chas@cmf.nrl.navy.mil
Subject: [PATCH 2.4] Fix bug in atm/he.c
Content-Type: multipart/mixed;
 boundary="------------080002020404020003070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080002020404020003070906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

	Patch against 2.4.23-pre5.

	Backport of the fix the Chas applied in 2.6 kernel.

	If copy_from_user returns != 0, it means the the regs structure 
wasn't filled correctly, and since its fields are used to determine 
which ioctl the user is requesting the kernel could oops.

	And as long as we're covering the subject, the patch also audits 
copy_to_user on the same function to check a possible failure to copy 
  the result back to userspace.

	These bugs were found by smatch.

	Please consider applying.

	Thanks,

Felipe

--------------080002020404020003070906
Content-Type: text/plain;
 name="atm_he-copy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atm_he-copy.patch"

--- linux-2.4.23-pre5/drivers/atm/he.c.orig	2003-09-22 11:41:20.000000000 -0300
+++ linux-2.4.23-pre5/drivers/atm/he.c	2003-09-22 11:44:50.000000000 -0300
@@ -2866,8 +2866,10 @@
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
@@ -2891,8 +2893,9 @@
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

--------------080002020404020003070906--

