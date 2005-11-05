Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVKEQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVKEQjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVKEQiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:38:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:47854 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751282AbVKEQeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:10 -0500
Message-Id: <20051105162711.443083000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:54 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, chas@cmf.nrl.navy.mil,
       netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/25] net: move atm ioctl32 to net/atm/ioctl.c
Content-Disposition: inline; filename=atm-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all the ATM specific compat ioctls to net/atm.
The code is still the same as before, but it would probably
be a good idea to simplify this by getting rid of using
compat_alloc_user_space.

CC: chas@cmf.nrl.navy.mil
CC: netdev@vger.kernel.org
CC: linux-atm-general@lists.sourceforge.net
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/net/atm/common.h
===================================================================
--- linux-2.6.14-rc.orig/net/atm/common.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/atm/common.h	2005-11-05 02:41:28.000000000 +0100
@@ -19,6 +19,7 @@
 		size_t total_len);
 unsigned int vcc_poll(struct file *file, struct socket *sock, poll_table *wait);
 int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+int vcc_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
 		   char __user *optval, int optlen);
 int vcc_getsockopt(struct socket *sock, int level, int optname,
Index: linux-2.6.14-rc/net/atm/ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/net/atm/ioctl.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/atm/ioctl.c	2005-11-05 02:41:28.000000000 +0100
@@ -156,3 +156,170 @@
 done:
 	return error;
 }
+
+#ifdef CONFIG_COMPAT
+struct atmif_sioc32 {
+        compat_int_t	number;
+        compat_int_t	length;
+        compat_caddr_t	arg;
+};
+
+struct atm_iobuf32 {
+	compat_int_t	length;
+	compat_caddr_t	buffer;
+};
+
+#define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
+#define ATM_GETNAMES32    _IOW('a', ATMIOC_ITF+3, struct atm_iobuf32)
+#define ATM_GETTYPE32     _IOW('a', ATMIOC_ITF+4, struct atmif_sioc32)
+#define ATM_GETESI32	  _IOW('a', ATMIOC_ITF+5, struct atmif_sioc32)
+#define ATM_GETADDR32	  _IOW('a', ATMIOC_ITF+6, struct atmif_sioc32)
+#define ATM_RSTADDR32	  _IOW('a', ATMIOC_ITF+7, struct atmif_sioc32)
+#define ATM_ADDADDR32	  _IOW('a', ATMIOC_ITF+8, struct atmif_sioc32)
+#define ATM_DELADDR32	  _IOW('a', ATMIOC_ITF+9, struct atmif_sioc32)
+#define ATM_GETCIRANGE32  _IOW('a', ATMIOC_ITF+10, struct atmif_sioc32)
+#define ATM_SETCIRANGE32  _IOW('a', ATMIOC_ITF+11, struct atmif_sioc32)
+#define ATM_SETESI32      _IOW('a', ATMIOC_ITF+12, struct atmif_sioc32)
+#define ATM_SETESIF32     _IOW('a', ATMIOC_ITF+13, struct atmif_sioc32)
+#define ATM_GETSTAT32     _IOW('a', ATMIOC_SARCOM+0, struct atmif_sioc32)
+#define ATM_GETSTATZ32    _IOW('a', ATMIOC_SARCOM+1, struct atmif_sioc32)
+#define ATM_GETLOOP32	  _IOW('a', ATMIOC_SARCOM+2, struct atmif_sioc32)
+#define ATM_SETLOOP32	  _IOW('a', ATMIOC_SARCOM+3, struct atmif_sioc32)
+#define ATM_QUERYLOOP32	  _IOW('a', ATMIOC_SARCOM+4, struct atmif_sioc32)
+
+static struct {
+        unsigned int cmd32;
+        unsigned int cmd;
+} atm_ioctl_map[] = {
+	{ ATM_GETLINKRATE32, ATM_GETLINKRATE },
+	{ ATM_GETNAMES32,    ATM_GETNAMES },
+	{ ATM_GETTYPE32,     ATM_GETTYPE },
+	{ ATM_GETESI32,      ATM_GETESI },
+	{ ATM_GETADDR32,     ATM_GETADDR },
+	{ ATM_RSTADDR32,     ATM_RSTADDR },
+	{ ATM_ADDADDR32,     ATM_ADDADDR },
+	{ ATM_DELADDR32,     ATM_DELADDR },
+	{ ATM_GETCIRANGE32,  ATM_GETCIRANGE },
+	{ ATM_SETCIRANGE32,  ATM_SETCIRANGE },
+	{ ATM_SETESI32,      ATM_SETESI },
+	{ ATM_SETESIF32,     ATM_SETESIF },
+	{ ATM_GETSTAT32,     ATM_GETSTAT },
+	{ ATM_GETSTATZ32,    ATM_GETSTATZ },
+	{ ATM_GETLOOP32,     ATM_GETLOOP },
+	{ ATM_SETLOOP32,     ATM_SETLOOP },
+	{ ATM_QUERYLOOP32,   ATM_QUERYLOOP }
+};
+
+#define NR_ATM_IOCTL (sizeof(atm_ioctl_map)/sizeof(atm_ioctl_map[0]))
+
+
+static int do_atm_iobuf(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	struct atm_iobuf   __user *iobuf;
+	struct atm_iobuf32 __user *iobuf32;
+	u32 data;
+	void __user *datap;
+	int len, err;
+
+	iobuf = compat_alloc_user_space(sizeof(*iobuf));
+	iobuf32 = compat_ptr(arg);
+
+	if (get_user(len, &iobuf32->length) ||
+	    get_user(data, &iobuf32->buffer))
+		return -EFAULT;
+	datap = compat_ptr(data);
+	if (put_user(len, &iobuf->length) ||
+	    put_user(datap, &iobuf->buffer))
+		return -EFAULT;
+
+	err = vcc_ioctl(sock, cmd, (unsigned long)iobuf);
+
+	if (!err) {
+		if (copy_in_user(&iobuf32->length, &iobuf->length,
+				 sizeof(int)))
+			err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int do_atmif_sioc(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	struct atmif_sioc   __user *sioc;
+	struct atmif_sioc32 __user *sioc32;
+	u32 data;
+	void __user *datap;
+	int err;
+
+	sioc = compat_alloc_user_space(sizeof(*sioc));
+	sioc32 = compat_ptr(arg);
+
+	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
+	    get_user(data, &sioc32->arg))
+		return -EFAULT;
+	datap = compat_ptr(data);
+	if (put_user(datap, &sioc->arg))
+		return -EFAULT;
+
+	err = vcc_ioctl(sock, cmd, (unsigned long) sioc);
+
+	if (!err) {
+		if (copy_in_user(&sioc32->length, &sioc->length,
+				 sizeof(int)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+int vcc_compat_ioctl(struct socket *sock, unsigned int cmd32, unsigned long arg)
+{
+	int i;
+	unsigned int cmd = 0;
+
+	switch (cmd32) {
+	case SONET_GETSTAT:
+	case SONET_GETSTATZ:
+	case SONET_GETDIAG:
+	case SONET_SETDIAG:
+	case SONET_CLRDIAG:
+	case SONET_SETFRAMING:
+	case SONET_GETFRAMING:
+	case SONET_GETFRSENSE:
+		return do_atmif_sioc(sock, cmd32, arg);
+	}
+
+	for (i = 0; i < NR_ATM_IOCTL; i++) {
+		if (cmd32 == atm_ioctl_map[i].cmd32) {
+			cmd = atm_ioctl_map[i].cmd;
+			break;
+		}
+	}
+	if (i == NR_ATM_IOCTL)
+		return -EINVAL;
+
+        switch (cmd) {
+	case ATM_GETNAMES:
+		return do_atm_iobuf(sock, cmd, arg);
+
+	case ATM_GETLINKRATE:
+	case ATM_GETTYPE:
+	case ATM_GETESI:
+	case ATM_GETADDR:
+	case ATM_RSTADDR:
+	case ATM_ADDADDR:
+	case ATM_DELADDR:
+	case ATM_GETCIRANGE:
+	case ATM_SETCIRANGE:
+	case ATM_SETESI:
+	case ATM_SETESIF:
+	case ATM_GETSTAT:
+	case ATM_GETSTATZ:
+	case ATM_GETLOOP:
+	case ATM_SETLOOP:
+	case ATM_QUERYLOOP:
+		return do_atmif_sioc(sock, cmd, arg);
+	}
+
+	return -EINVAL;
+}
+#endif
Index: linux-2.6.14-rc/net/atm/pvc.c
===================================================================
--- linux-2.6.14-rc.orig/net/atm/pvc.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/atm/pvc.c	2005-11-05 02:41:28.000000000 +0100
@@ -114,6 +114,9 @@
 	.getname =	pvc_getname,
 	.poll =		vcc_poll,
 	.ioctl =	vcc_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	vcc_compat_ioctl,
+#endif
 	.listen =	sock_no_listen,
 	.shutdown =	pvc_shutdown,
 	.setsockopt =	pvc_setsockopt,
Index: linux-2.6.14-rc/net/atm/svc.c
===================================================================
--- linux-2.6.14-rc.orig/net/atm/svc.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/net/atm/svc.c	2005-11-05 02:41:28.000000000 +0100
@@ -625,6 +625,9 @@
 	.getname =	svc_getname,
 	.poll =		vcc_poll,
 	.ioctl =	svc_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = vcc_compat_ioctl,
+#endif
 	.listen =	svc_listen,
 	.shutdown =	svc_shutdown,
 	.setsockopt =	svc_setsockopt,
Index: linux-2.6.14-rc/net/compat.c
===================================================================
--- linux-2.6.14-rc.orig/net/compat.c	2005-11-05 02:41:20.000000000 +0100
+++ linux-2.6.14-rc/net/compat.c	2005-11-05 02:41:28.000000000 +0100
@@ -26,7 +26,6 @@
 
 /* these are all for ioctl */
 #include <linux/atalk.h>
-#include <linux/atmdev.h>
 #include <linux/ipv6_route.h>
 #include <linux/ppp_defs.h>
 #include <linux/route.h>
@@ -1017,171 +1016,6 @@
 	return ret;
 }
 
-struct atmif_sioc32 {
-        compat_int_t	number;
-        compat_int_t	length;
-        compat_caddr_t	arg;
-};
-
-struct atm_iobuf32 {
-	compat_int_t	length;
-	compat_caddr_t	buffer;
-};
-
-#define ATM_GETLINKRATE32 _IOW('a', ATMIOC_ITF+1, struct atmif_sioc32)
-#define ATM_GETNAMES32    _IOW('a', ATMIOC_ITF+3, struct atm_iobuf32)
-#define ATM_GETTYPE32     _IOW('a', ATMIOC_ITF+4, struct atmif_sioc32)
-#define ATM_GETESI32	  _IOW('a', ATMIOC_ITF+5, struct atmif_sioc32)
-#define ATM_GETADDR32	  _IOW('a', ATMIOC_ITF+6, struct atmif_sioc32)
-#define ATM_RSTADDR32	  _IOW('a', ATMIOC_ITF+7, struct atmif_sioc32)
-#define ATM_ADDADDR32	  _IOW('a', ATMIOC_ITF+8, struct atmif_sioc32)
-#define ATM_DELADDR32	  _IOW('a', ATMIOC_ITF+9, struct atmif_sioc32)
-#define ATM_GETCIRANGE32  _IOW('a', ATMIOC_ITF+10, struct atmif_sioc32)
-#define ATM_SETCIRANGE32  _IOW('a', ATMIOC_ITF+11, struct atmif_sioc32)
-#define ATM_SETESI32      _IOW('a', ATMIOC_ITF+12, struct atmif_sioc32)
-#define ATM_SETESIF32     _IOW('a', ATMIOC_ITF+13, struct atmif_sioc32)
-#define ATM_GETSTAT32     _IOW('a', ATMIOC_SARCOM+0, struct atmif_sioc32)
-#define ATM_GETSTATZ32    _IOW('a', ATMIOC_SARCOM+1, struct atmif_sioc32)
-#define ATM_GETLOOP32	  _IOW('a', ATMIOC_SARCOM+2, struct atmif_sioc32)
-#define ATM_SETLOOP32	  _IOW('a', ATMIOC_SARCOM+3, struct atmif_sioc32)
-#define ATM_QUERYLOOP32	  _IOW('a', ATMIOC_SARCOM+4, struct atmif_sioc32)
-
-static struct {
-        unsigned int cmd32;
-        unsigned int cmd;
-} atm_ioctl_map[] = {
-        { ATM_GETLINKRATE32, ATM_GETLINKRATE },
-	{ ATM_GETNAMES32,    ATM_GETNAMES },
-        { ATM_GETTYPE32,     ATM_GETTYPE },
-        { ATM_GETESI32,      ATM_GETESI },
-        { ATM_GETADDR32,     ATM_GETADDR },
-        { ATM_RSTADDR32,     ATM_RSTADDR },
-        { ATM_ADDADDR32,     ATM_ADDADDR },
-        { ATM_DELADDR32,     ATM_DELADDR },
-        { ATM_GETCIRANGE32,  ATM_GETCIRANGE },
-	{ ATM_SETCIRANGE32,  ATM_SETCIRANGE },
-	{ ATM_SETESI32,      ATM_SETESI },
-	{ ATM_SETESIF32,     ATM_SETESIF },
-	{ ATM_GETSTAT32,     ATM_GETSTAT },
-	{ ATM_GETSTATZ32,    ATM_GETSTATZ },
-	{ ATM_GETLOOP32,     ATM_GETLOOP },
-	{ ATM_SETLOOP32,     ATM_SETLOOP },
-	{ ATM_QUERYLOOP32,   ATM_QUERYLOOP }
-};
-
-#define NR_ATM_IOCTL (sizeof(atm_ioctl_map)/sizeof(atm_ioctl_map[0]))
-
-
-static int do_atm_iobuf(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct atm_iobuf   __user *iobuf;
-	struct atm_iobuf32 __user *iobuf32;
-	u32 data;
-	void __user *datap;
-	int len, err;
-
-	iobuf = compat_alloc_user_space(sizeof(*iobuf));
-	iobuf32 = compat_ptr(arg);
-
-	if (get_user(len, &iobuf32->length) ||
-	    get_user(data, &iobuf32->buffer))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(len, &iobuf->length) ||
-	    put_user(datap, &iobuf->buffer))
-		return -EFAULT;
-
-	err = sock_ioctl(file, cmd, (unsigned long)iobuf);
-
-	if (!err) {
-		if (copy_in_user(&iobuf32->length, &iobuf->length,
-				 sizeof(int)))
-			err = -EFAULT;
-	}
-
-	return err;
-}
-
-static int do_atmif_sioc(struct file *file, unsigned int cmd, unsigned long arg)
-{
-        struct atmif_sioc   __user *sioc;
-	struct atmif_sioc32 __user *sioc32;
-	u32 data;
-	void __user *datap;
-	int err;
-
-	sioc = compat_alloc_user_space(sizeof(*sioc));
-	sioc32 = compat_ptr(arg);
-
-	if (copy_in_user(&sioc->number, &sioc32->number, 2 * sizeof(int)) ||
-	    get_user(data, &sioc32->arg))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(datap, &sioc->arg))
-		return -EFAULT;
-
-	err = sock_ioctl(file, cmd, (unsigned long) sioc);
-
-	if (!err) {
-		if (copy_in_user(&sioc32->length, &sioc->length,
-				 sizeof(int)))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int do_atm_ioctl(struct file *file, unsigned int cmd32, unsigned long arg)
-{
-        int i;
-        unsigned int cmd = 0;
-
-	switch (cmd32) {
-	case SONET_GETSTAT:
-	case SONET_GETSTATZ:
-	case SONET_GETDIAG:
-	case SONET_SETDIAG:
-	case SONET_CLRDIAG:
-	case SONET_SETFRAMING:
-	case SONET_GETFRAMING:
-	case SONET_GETFRSENSE:
-		return do_atmif_sioc(file, cmd32, arg);
-	}
-
-	for (i = 0; i < NR_ATM_IOCTL; i++) {
-		if (cmd32 == atm_ioctl_map[i].cmd32) {
-			cmd = atm_ioctl_map[i].cmd;
-			break;
-		}
-	}
-	if (i == NR_ATM_IOCTL)
-	        return -EINVAL;
-
-        switch (cmd) {
-	case ATM_GETNAMES:
-		return do_atm_iobuf(file, cmd, arg);
-
-	case ATM_GETLINKRATE:
-        case ATM_GETTYPE:
-        case ATM_GETESI:
-        case ATM_GETADDR:
-        case ATM_RSTADDR:
-        case ATM_ADDADDR:
-        case ATM_DELADDR:
-        case ATM_GETCIRANGE:
-	case ATM_SETCIRANGE:
-	case ATM_SETESI:
-	case ATM_SETESIF:
-	case ATM_GETSTAT:
-	case ATM_GETSTATZ:
-	case ATM_GETLOOP:
-	case ATM_SETLOOP:
-	case ATM_QUERYLOOP:
-                return do_atmif_sioc(file, cmd, arg);
-        }
-
-        return -EINVAL;
-}
-
 struct sock_fprog32 {
 	unsigned short	len;
 	compat_caddr_t	filter;
@@ -1380,7 +1214,8 @@
 	case type: ret = sock_ioctl(file, cmd, arg); break;
 #define INVAL_IOCTL(type) \
 	case type: ret = -EINVAL; break;
-/* these are handled in sock_ioctl */
+
+/* these are handled directly in sock_ioctl */
 COMPATIBLE_IOCTL(FIOSETOWN)
 COMPATIBLE_IOCTL(SIOCSPGRP)
 COMPATIBLE_IOCTL(FIOGETOWN)
@@ -1448,32 +1283,6 @@
 /* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
 INVAL_IOCTL(SIOCRTMSG)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
-/* atm */
-HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETNAMES32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETTYPE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETESI32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_RSTADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_ADDADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_DELADDR32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETCIRANGE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETCIRANGE32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETESI32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETESIF32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETSTAT32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETSTATZ32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_GETLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_SETLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(ATM_QUERYLOOP32, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETSTAT, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETSTATZ, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_SETDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_CLRDIAG, do_atm_ioctl)
-HANDLE_IOCTL(SONET_SETFRAMING, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
-HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
 /* ppp */
 HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)

--

