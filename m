Return-Path: <linux-kernel-owner+w=401wt.eu-S1751059AbXAPMKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXAPMKn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbXAPMKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 07:10:43 -0500
Received: from doppler.zen.co.uk ([212.23.3.27]:55417 "EHLO doppler.zen.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXAPMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 07:10:42 -0500
X-Greylist: delayed 14290 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 07:10:42 EST
From: Giuliano Procida <giuliano.procida@googlemail.com>
Subject: [PATCH]: MTRR: fix 32-bit ioctls on x64_32
To: rgooch@atnf.csiro.au
CC: linux-kernel@vger.kernel.org, giuliano.procida@googlemail.com
Message-Id: <E1H6jSg-0003zB-Ht@hilfy.n22.homeunix.net>
Date: Tue, 16 Jan 2007 08:14:30 +0000
X-Originating-Heisenberg-IP: [217.155.41.211]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[MTRR] fix 32-bit ioctls on x64_32

Signed-off-by: Giuliano Procida <giuliano.procida@googlemail.com>

---

Fixed incomplete support for 32-bit compatibility ioctls in
2.6.19.1. They were unhandled in one of three case-statements.
Testing using X server before and after change.

--- linux-source-2.6.19.1.orig/arch/i386/kernel/cpu/mtrr/if.c	2006-12-11 19:32:53.000000000 +0000
+++ linux-source-2.6.19.1/arch/i386/kernel/cpu/mtrr/if.c	2007-01-16 07:31:06.000000000 +0000
@@ -211,6 +211,9 @@ mtrr_ioctl(struct file *file, unsigned i
 	default:
 		return -ENOTTY;
 	case MTRRIOC_ADD_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_ADD_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err =
@@ -218,21 +221,33 @@ mtrr_ioctl(struct file *file, unsigned i
 				  file, 0);
 		break;
 	case MTRRIOC_SET_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_SET_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, 0);
 		break;
 	case MTRRIOC_DEL_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_DEL_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
 	case MTRRIOC_KILL_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_KILL_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_GET_ENTRY:
+#endif
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
 		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);
@@ -249,6 +264,9 @@ mtrr_ioctl(struct file *file, unsigned i
 
 		break;
 	case MTRRIOC_ADD_PAGE_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_ADD_PAGE_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err =
@@ -256,21 +274,33 @@ mtrr_ioctl(struct file *file, unsigned i
 				  file, 1);
 		break;
 	case MTRRIOC_SET_PAGE_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_SET_PAGE_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_add_page(sentry.base, sentry.size, sentry.type, 0);
 		break;
 	case MTRRIOC_DEL_PAGE_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_DEL_PAGE_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_KILL_PAGE_ENTRY:
+#endif
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
+#ifdef CONFIG_COMPAT
+	case MTRRIOC32_GET_PAGE_ENTRY:
+#endif
 		if (gentry.regnum >= num_var_ranges)
 			return -EINVAL;
 		mtrr_if->get(gentry.regnum, &gentry.base, &gentry.size, &type);


