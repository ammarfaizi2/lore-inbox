Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTJAUnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJAUnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:43:37 -0400
Received: from fmr03.intel.com ([143.183.121.5]:26498 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262536AbTJAUnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:43:33 -0400
Message-ID: <3F7B3C17.10909@intel.com>
Date: Wed, 01 Oct 2003 13:41:59 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>
Subject: [PATCH] ioctl32 fix for bond_ioctl
Content-Type: multipart/mixed;
 boundary="------------070406060006010109060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406060006010109060109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Problem: These four ioctls use ifreq32.ifr_ifru.ifru_data.

	case SIOCBONDENSLAVE:
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:

Whereas these use ifreq32.ifr_ifru.ifru_slave:

	case SIOCBONDSLAVEINFOQUERY:
        case SIOCBONDINFOQUERY:

The current code assumes ifru_data for all 6 ioctls. This fails with EFAULT for the last two. The attached patch fixes the problem and has been tested on ia64.

	-Arun



--------------070406060006010109060109
Content-Type: text/plain;
 name="bonding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bonding.patch"

Index: linux-2.6/fs/compat_ioctl.c
===================================================================
--- linux-2.6/fs/compat_ioctl.c	(revision 13715)
+++ linux-2.6/fs/compat_ioctl.c	(working copy)
@@ -576,54 +576,45 @@
 
 static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
 {
-	struct ifreq ifr;
+	struct ifreq kifr;
+	struct ifreq *uifr;
+	struct ifreq32 *ifr32 = (struct ifreq32 *) arg;
 	mm_segment_t old_fs;
-	int err, len;
+	int err;
 	u32 data;
-	
-	if (copy_from_user(&ifr, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
-		return -EFAULT;
-	ifr.ifr_data = (__kernel_caddr_t)get_zeroed_page(GFP_KERNEL);
-	if (!ifr.ifr_data)
-		return -EAGAIN;
+	void *datap;
 
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
-		len = IFNAMSIZ * sizeof(char);
-		break;
+		if (copy_from_user(&kifr, ifr32, sizeof(struct ifreq32)))
+			return -EFAULT;
+
+		old_fs = get_fs();
+		set_fs (KERNEL_DS);
+		err = sys_ioctl (fd, cmd, (unsigned long)&kifr);
+		set_fs (old_fs);
+
+		return err;
 	case SIOCBONDSLAVEINFOQUERY:
-		len = sizeof(struct ifslave);
-		break;
 	case SIOCBONDINFOQUERY:
-		len = sizeof(struct ifbond);
-		break;
-	default:
-		err = -EINVAL;
-		goto out;
-	};
+		uifr = compat_alloc_user_space(sizeof(*uifr));
+		if (copy_in_user(&uifr->ifr_name, &ifr32->ifr_name, IFNAMSIZ))
+			return -EFAULT;
 
-	__get_user(data, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_data));
-	if (copy_from_user(ifr.ifr_data, compat_ptr(data), len)) {
-		err = -EFAULT;
-		goto out;
-	}
+		if (get_user(data, &ifr32->ifr_ifru.ifru_data))	
+			return -EFAULT;
 
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long)&ifr);
-	set_fs (old_fs);
-	if (!err) {
-		len = copy_to_user(compat_ptr(data), ifr.ifr_data, len);
-		if (len)
-			err = -EFAULT;
-	}
+		datap = compat_ptr(data);
+		if (put_user(datap, &uifr->ifr_ifru.ifru_data))
+			return -EFAULT;
 
-out:
-	free_page((unsigned long)ifr.ifr_data);
-	return err;
+		return sys_ioctl (fd, cmd, (unsigned long)uifr);
+	default:
+		return -EINVAL;
+	};
 }
 
 int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)

--------------070406060006010109060109--

