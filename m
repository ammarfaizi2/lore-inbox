Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVKEQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVKEQdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKEQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:33:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:34501 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751264AbVKEQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:26 -0500
Message-Id: <20051105162711.030288000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:53 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/25] net: improve ioctl32 dev_ioctl handling
Content-Disposition: inline; filename=compat-dev-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to be a bit smarter about net device ioctl
emulation. In particular, the wireless extensions are treated
as a group in order to make the switch list a little shorter.

CC: netdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/net/compat.c
===================================================================
--- linux-cg.orig/net/compat.c	2005-11-05 03:17:30.000000000 +0100
+++ linux-cg/net/compat.c	2005-11-05 03:24:16.000000000 +0100
@@ -854,7 +854,7 @@
 	if (__put_user(data64, &u_ifreq64->ifr_ifru.ifru_data))
 		return -EFAULT;
 
-	return sock_ioctl(file, cmd, (unsigned long) u_ifreq64);
+	return dev_ioctl(cmd, u_ifreq64);
 }
 
 static int dev_ifsioc(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1302,13 +1302,14 @@
 	return err;
 }
 
+#ifdef WIRELESS_EXT
 struct compat_iw_point {
 	compat_caddr_t pointer;
 	__u16 length;
 	__u16 flags;
 };
 
-static int do_wireless_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static int do_wireless_ioctl(unsigned int cmd, unsigned long arg)
 {
 	struct iwreq __user *iwr;
 	struct iwreq __user *iwr_u;
@@ -1343,8 +1344,9 @@
 	    __put_user(flags, &iwp->flags))
 		return -EFAULT;
 
-	return sock_ioctl(file, cmd, (unsigned long) iwr);
+	return dev_ioctl(cmd, iwr);
 }
+#endif /* WIRELESS_EXT */
 
 /* Since old style bridge ioctl's endup using SIOCDEVPRIVATE
  * for some operations; this forces use of the newer bridge-utils that
@@ -1363,16 +1365,43 @@
 
 long compat_sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))
-		return siocdevprivate_ioctl(file, cmd, arg);
+	struct socket *sock;
+	int ret = -ENOIOCTLCMD;
 
-	switch (cmd) {
+	sock = file->private_data;
+	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15))
+		ret = siocdevprivate_ioctl(file, cmd, arg);
+#ifdef WIRELESS_EXT
+	else if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST)
+		ret = do_wireless_ioctl(cmd, arg);
+#endif
+	else switch (cmd) {
 #define HANDLE_IOCTL(type, handler) \
-	case type: return handler(file, cmd, arg);
+	case type: ret = handler(file, cmd, arg); break;
 #define COMPATIBLE_IOCTL(type) \
-	case type: return sock_ioctl(file, cmd, arg);
+	case type: ret = sock_ioctl(file, cmd, arg); break;
 #define INVAL_IOCTL(type) \
-	case type: return -EINVAL;
+	case type: ret = -EINVAL; break;
+/* these are handled in sock_ioctl */
+COMPATIBLE_IOCTL(FIOSETOWN)
+COMPATIBLE_IOCTL(SIOCSPGRP)
+COMPATIBLE_IOCTL(FIOGETOWN)
+COMPATIBLE_IOCTL(SIOCGPGRP)
+HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
+HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
+COMPATIBLE_IOCTL(SIOCBRADDBR)
+COMPATIBLE_IOCTL(SIOCBRDELBR)
+COMPATIBLE_IOCTL(SIOCGIFVLAN)
+COMPATIBLE_IOCTL(SIOCSIFVLAN)
+COMPATIBLE_IOCTL(SIOCADDDLCI)
+COMPATIBLE_IOCTL(SIOCDELDLCI)
+	default:
+		if (sock->ops->compat_ioctl)
+			ret = sock->ops->compat_ioctl(sock, cmd, arg);
+	}
+
+	if (ret == -ENOIOCTLCMD)
+		switch (cmd) {
 HANDLE_IOCTL(SIOCGIFNAME, dev_ifname32)
 HANDLE_IOCTL(SIOCGIFCONF, dev_ifconf)
 HANDLE_IOCTL(SIOCGIFFLAGS, dev_ifsioc)
@@ -1393,10 +1422,6 @@
 HANDLE_IOCTL(SIOCGIFADDR, dev_ifsioc)
 HANDLE_IOCTL(SIOCSIFADDR, dev_ifsioc)
 
-/* ioctls used by appletalk ddp.c */
-HANDLE_IOCTL(SIOCATALKDIFADDR, dev_ifsioc)
-HANDLE_IOCTL(SIOCDIFADDR, dev_ifsioc)
-
 HANDLE_IOCTL(SIOCSARP, dev_ifsioc)
 HANDLE_IOCTL(SIOCDARP, dev_ifsioc)
 
@@ -1456,79 +1481,6 @@
 HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSACTIVE32, ppp_sock_fprog_ioctl_trans)
-/* wireless */
-HANDLE_IOCTL(SIOCGIWRANGE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWTHRSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWTHRSPY, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWAPLIST, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWSCAN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWESSID, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWESSID, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWNICKN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWNICKN, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIWENCODE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCGIWENCODE, do_wireless_ioctl)
-HANDLE_IOCTL(SIOCSIFBR, old_bridge_ioctl)
-HANDLE_IOCTL(SIOCGIFBR, old_bridge_ioctl)
-
-COMPATIBLE_IOCTL(FIOSETOWN)
-COMPATIBLE_IOCTL(SIOCSPGRP)
-COMPATIBLE_IOCTL(FIOGETOWN)
-COMPATIBLE_IOCTL(SIOCGPGRP)
-COMPATIBLE_IOCTL(SIOCATMARK)
-COMPATIBLE_IOCTL(SIOCSIFLINK)
-COMPATIBLE_IOCTL(SIOCSIFENCAP)
-COMPATIBLE_IOCTL(SIOCGIFENCAP)
-COMPATIBLE_IOCTL(SIOCSIFNAME)
-//COMPATIBLE_IOCTL(SIOCSARP)
-COMPATIBLE_IOCTL(SIOCGARP)
-//COMPATIBLE_IOCTL(SIOCDARP)
-COMPATIBLE_IOCTL(SIOCSRARP)
-COMPATIBLE_IOCTL(SIOCGRARP)
-COMPATIBLE_IOCTL(SIOCDRARP)
-COMPATIBLE_IOCTL(SIOCADDDLCI)
-COMPATIBLE_IOCTL(SIOCDELDLCI)
-COMPATIBLE_IOCTL(SIOCGMIIPHY)
-COMPATIBLE_IOCTL(SIOCGMIIREG)
-COMPATIBLE_IOCTL(SIOCSMIIREG)
-COMPATIBLE_IOCTL(SIOCGIFVLAN)
-COMPATIBLE_IOCTL(SIOCSIFVLAN)
-COMPATIBLE_IOCTL(SIOCBRADDBR)
-COMPATIBLE_IOCTL(SIOCBRDELBR)
-/* wireless */
-COMPATIBLE_IOCTL(SIOCSIWCOMMIT)
-COMPATIBLE_IOCTL(SIOCGIWNAME)
-COMPATIBLE_IOCTL(SIOCSIWNWID)
-COMPATIBLE_IOCTL(SIOCGIWNWID)
-COMPATIBLE_IOCTL(SIOCSIWFREQ)
-COMPATIBLE_IOCTL(SIOCGIWFREQ)
-COMPATIBLE_IOCTL(SIOCSIWMODE)
-COMPATIBLE_IOCTL(SIOCGIWMODE)
-COMPATIBLE_IOCTL(SIOCSIWSENS)
-COMPATIBLE_IOCTL(SIOCGIWSENS)
-COMPATIBLE_IOCTL(SIOCSIWRANGE)
-COMPATIBLE_IOCTL(SIOCSIWPRIV)
-COMPATIBLE_IOCTL(SIOCGIWPRIV)
-COMPATIBLE_IOCTL(SIOCSIWSTATS)
-COMPATIBLE_IOCTL(SIOCGIWSTATS)
-COMPATIBLE_IOCTL(SIOCSIWAP)
-COMPATIBLE_IOCTL(SIOCGIWAP)
-COMPATIBLE_IOCTL(SIOCSIWSCAN)
-COMPATIBLE_IOCTL(SIOCSIWRATE)
-COMPATIBLE_IOCTL(SIOCGIWRATE)
-COMPATIBLE_IOCTL(SIOCSIWRTS)
-COMPATIBLE_IOCTL(SIOCGIWRTS)
-COMPATIBLE_IOCTL(SIOCSIWFRAG)
-COMPATIBLE_IOCTL(SIOCGIWFRAG)
-COMPATIBLE_IOCTL(SIOCSIWTXPOW)
-COMPATIBLE_IOCTL(SIOCGIWTXPOW)
-COMPATIBLE_IOCTL(SIOCSIWRETRY)
-COMPATIBLE_IOCTL(SIOCGIWRETRY)
-COMPATIBLE_IOCTL(SIOCSIWPOWER)
-COMPATIBLE_IOCTL(SIOCGIWPOWER)
-/* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGFLAGS)
 COMPATIBLE_IOCTL(PPPIOCSFLAGS)
 COMPATIBLE_IOCTL(PPPIOCGASYNCMAP)
@@ -1561,6 +1513,25 @@
 /* PPPOX */
 COMPATIBLE_IOCTL(PPPOEIOCSFWD)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
+
+/* ioctls used by appletalk ddp.c */
+HANDLE_IOCTL(SIOCATALKDIFADDR, dev_ifsioc)
+HANDLE_IOCTL(SIOCDIFADDR, dev_ifsioc)
+
+COMPATIBLE_IOCTL(SIOCATMARK)
+COMPATIBLE_IOCTL(SIOCSIFLINK)
+COMPATIBLE_IOCTL(SIOCSIFENCAP)
+COMPATIBLE_IOCTL(SIOCGIFENCAP)
+COMPATIBLE_IOCTL(SIOCSIFNAME)
+//COMPATIBLE_IOCTL(SIOCSARP)
+COMPATIBLE_IOCTL(SIOCGARP)
+//COMPATIBLE_IOCTL(SIOCDARP)
+COMPATIBLE_IOCTL(SIOCSRARP)
+COMPATIBLE_IOCTL(SIOCGRARP)
+COMPATIBLE_IOCTL(SIOCDRARP)
+COMPATIBLE_IOCTL(SIOCGMIIPHY)
+COMPATIBLE_IOCTL(SIOCGMIIREG)
+COMPATIBLE_IOCTL(SIOCSMIIREG)
 	}
-	return -ENOIOCTLCMD;
+	return ret;
 }

--

