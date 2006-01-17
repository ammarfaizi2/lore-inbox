Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWAQE3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWAQE3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 23:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWAQE3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 23:29:11 -0500
Received: from [203.2.177.25] ([203.2.177.25]:64782 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1750841AbWAQE3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 23:29:10 -0500
Subject: [PATCH 3/4 -2.6.15- RESEND]:x25: 32 bit (socket layer) ioctl
	emulation for 64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>,
       acme@ghostprotocols.net, ak@muc.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, pereira.shaun@gmail.com
In-Reply-To: <200601170115.07019.arnd@arndb.de>
References: <1137122079.5589.34.camel@spereira05.tusc.com.au>
	 <200601161043.31742.arnd@arndb.de>
	 <1137453135.6553.19.camel@spereira05.tusc.com.au>
	 <200601170115.07019.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 15:20:48 +1100
Message-Id: <1137471648.8309.9.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd
 Here is the corrected version.
Using the x25_subscrip_struct structure (extend value = 1) set 
the following values in the kernel after copy_from_user

 global facility mask is F00000000
 Extended value is 1


Using the 32 bit compat_x25_subscrip_struct
set the following values in the struct after
copying from user.
global facility mask is 0000000F
Extended value is 1

The nb->global_facil_mask was then 
set to 0000000F when extended was 1

Thanks for this,

/Shaun

diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
linux-2.6.15/net/x25/af_x25.c
--- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/x25/af_x25.c	2006-01-17 15:08:30.000000000 +1100
@@ -54,6 +54,8 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <net/x25.h>
+#include <linux/compat.h>
+#include <net/compat.h>
 
 int sysctl_x25_restart_request_timeout = X25_DEFAULT_T20;
 int sysctl_x25_call_request_timeout    = X25_DEFAULT_T21;
@@ -68,6 +70,14 @@ static struct proto_ops x25_proto_ops;
 
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
@@ -1391,6 +1401,116 @@ static struct net_proto_family x25_famil
 	.owner	=	THIS_MODULE,
 };
 
+
+#ifdef CONFIG_COMPAT
+static int compat_x25_subscr_ioctl(unsigned int cmd,
+       	struct compat_x25_subscrip_struct __user *x25_subscr32)
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
+	    		sizeof(*x25_subscr32)) ? -EFAULT : 0;
+	} else {
+		rc = -EINVAL;
+		if (!(x25_subscr.extended && x25_subscr.extended != 1)) {
+			 rc = 0;
+			 nb->extended            = x25_subscr.extended;
+			 nb->global_facil_mask   = x25_subscr.global_facil_mask;
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
+						(struct timeval __user*)argp);
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
+				break;
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
 static struct proto_ops SOCKOPS_WRAPPED(x25_proto_ops) = {
 	.family =	AF_X25,
 	.owner =	THIS_MODULE,
@@ -1402,6 +1522,9 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	x25_getname,
 	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_x25_ioctl,
+#endif
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,

