Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWBOWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWBOWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWBOWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:23:27 -0500
Received: from [203.2.177.25] ([203.2.177.25]:26682 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751331AbWBOWXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:23:25 -0500
Subject: [PATCH 3/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
       x25 maintainer <eis@baty.hanse.de>,
       linux-kenel <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andre Hendry <ahendry@tusc.com.au>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:19:32 +1100
Message-Id: <1140041972.8745.27.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows 32 bit x25 module structures to be passed to
a 64 bit kernel via ioctl using the new compat_sock_ioctl registration
mechanism instead of the obsolete 'register_ioctl32_conversion into hash
table'  mechanism. 
  
Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>

diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c
linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-15
10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-15 11:12:30.000000000
+1100
@@ -55,6 +55,8 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <net/x25.h>
+#include <linux/compat.h>
+#include <net/compat.h>
 
 int sysctl_x25_restart_request_timeout = X25_DEFAULT_T20;
 int sysctl_x25_call_request_timeout    = X25_DEFAULT_T21;
@@ -69,6 +71,14 @@ static const struct proto_ops x25_proto_
 
 static struct x25_address null_x25_address = {"               "};
 
+#ifdef CONFIG_COMPAT
+struct compat_x25_subscrip_struct {
+	char device[200-sizeof(compat_ulong_t)];
+	compat_ulong_t global_facil_mask;
+	compat_uint_t extended;
+};
+#endif
+
 int x25_addr_ntoa(unsigned char *p, struct x25_address *called_addr,
 		  struct x25_address *calling_addr)
 {
@@ -1387,6 +1397,115 @@ static struct net_proto_family x25_famil
 	.owner	=	THIS_MODULE,
 };
 
+#ifdef CONFIG_COMPAT
+static int compat_x25_subscr_ioctl(unsigned int cmd,
+	struct compat_x25_subscrip_struct __user *x25_subscr32)
+{
+	struct compat_x25_subscrip_struct x25_subscr;
+	struct x25_neigh *nb;
+	struct net_device *dev;
+	int rc = -EINVAL;
+
+	rc = -EFAULT;
+	if(copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32)))
+		goto out;
+
+	rc = -EINVAL;
+	if ((dev = x25_dev_get(x25_subscr.device)) == NULL)
+		goto out;
+
+	if ((nb = x25_get_neigh(dev)) == NULL)
+		goto out_dev_put;
+
+	dev_put(dev);
+
+	if(cmd == SIOCX25GSUBSCRIP) {
+		x25_subscr.extended             = nb->extended;
+		x25_subscr.global_facil_mask     = nb->global_facil_mask;
+		rc = copy_to_user(x25_subscr32, &x25_subscr,
+			sizeof(*x25_subscr32)) ? -EFAULT : 0;
+	} else {
+		rc = -EINVAL;
+		if (!(x25_subscr.extended && x25_subscr.extended != 1)) {
+			rc = 0;
+			nb->extended            = x25_subscr.extended;
+			nb->global_facil_mask   = x25_subscr.global_facil_mask;
+		}
+	}
+	x25_neigh_put(nb);
+out:
+	return rc;
+out_dev_put:
+	dev_put(dev);
+	goto out;
+}
+
+static int compat_x25_ioctl(struct socket *sock, unsigned int cmd,
unsigned long arg)
+{
+	void __user *argp = compat_ptr(arg);
+	struct sock *sk = sock->sk;
+
+	int rc = -ENOIOCTLCMD;
+
+	switch(cmd) {
+		case TIOCOUTQ:
+		case TIOCINQ:
+			rc = x25_ioctl(sock, cmd, (unsigned long)argp);
+			break;
+		case SIOCGSTAMP:
+			rc = -EINVAL;
+			if (sk)
+				rc = compat_sock_get_timestamp(sk,
+					(struct timeval __user*)argp);
+			break;
+		case SIOCGIFADDR:
+		case SIOCSIFADDR:
+		case SIOCGIFDSTADDR:
+		case SIOCSIFDSTADDR:
+		case SIOCGIFBRDADDR:
+		case SIOCSIFBRDADDR:
+		case SIOCGIFNETMASK:
+		case SIOCSIFNETMASK:
+		case SIOCGIFMETRIC:
+		case SIOCSIFMETRIC:
+			rc = -EINVAL;
+			break;
+		case SIOCADDRT:
+		case SIOCDELRT:
+			rc = -EPERM;
+			if(!capable(CAP_NET_ADMIN))
+				break;
+			rc = x25_route_ioctl(cmd, argp);
+			break;
+		case SIOCX25GSUBSCRIP:
+			rc = compat_x25_subscr_ioctl(cmd, argp);
+			break;
+		case SIOCX25SSUBSCRIP:
+			rc = -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+			break;
+			rc = compat_x25_subscr_ioctl(cmd, argp);
+			break;
+		case SIOCX25GFACILITIES:
+		case SIOCX25SFACILITIES:
+		case SIOCX25GCALLUSERDATA:
+		case SIOCX25SCALLUSERDATA:
+		case SIOCX25GCAUSEDIAG:
+		case SIOCX25SCUDMATCHLEN:
+		case SIOCX25CALLACCPTAPPRV:
+		case SIOCX25SENDCALLACCPT:
+			rc = x25_ioctl(sock, cmd, (unsigned long)argp);
+			break;
+		default:
+			rc = -ENOIOCTLCMD;
+			break;
+	}
+
+	return rc;
+}
+
+#endif
+
 static const struct proto_ops SOCKOPS_WRAPPED(x25_proto_ops) = {
 	.family =	AF_X25,
 	.owner =	THIS_MODULE,
@@ -1398,6 +1517,9 @@ static const struct proto_ops SOCKOPS_WR
 	.getname =	x25_getname,
 	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_x25_ioctl,
+#endif
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,

