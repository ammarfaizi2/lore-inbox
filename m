Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTIVOtD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTIVOtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:49:03 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:42695 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S263178AbTIVOs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:48:59 -0400
Message-ID: <3F6F0C77.5070306@terra.com.br>
Date: Mon, 22 Sep 2003 11:51:35 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com.br, chas@cmf.nrl.navy.mil
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4]  Using possibly corrupted structure in atm/he.c
Content-Type: multipart/mixed;
 boundary="------------080302050808030203050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302050808030203050809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Marcelo/Chas,

	Patch against 2.4.23-pre5.

	If copy_from_user returns != 0, it means the the regs structure 
wasn't filled correctly, and since its fields are used to determine 
which ioctl the user is requesting the kernel could oops.

	And as long as we're covering the subject, the patch also audits 
copy_to_user on the same function to check a possible failure to copy 
the result back to userspace.

	These bugs were found by smatch in the 2.6 kernel, but I think it's 
worth fixing them in 2.4 too.

	Please consider applying.

	Cheers,

Felipe

--------------080302050808030203050809
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

--------------080302050808030203050809--

