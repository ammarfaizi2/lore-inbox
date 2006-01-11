Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWAKG1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWAKG1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWAKG1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:27:48 -0500
Received: from [203.2.177.25] ([203.2.177.25]:56866 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932591AbWAKG1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:27:47 -0500
Subject: Re: [PATCH] net: 32 bit (socket layer) ioctl emulation for 64 bit
	kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       SP <pereira.shaun@gmail.com>
In-Reply-To: <200601091054.35010.arnd@arndb.de>
References: <1136789216.6653.17.camel@spereira05.tusc.com.au>
	 <200601091054.35010.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:28:35 +1100
Message-Id: <1136960915.5347.10.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the correct x.25 patch, (will build a [PATCH] if this is ok).
Tested with with xot to a Cisco box. 
Thanks once again for your help 
/Shaun

Index: linux-2.6.15/net/x25/af_x25.c
===================================================================
--- linux-2.6.15.orig/net/x25/af_x25.c
+++ linux-2.6.15/net/x25/af_x25.c
@@ -54,6 +54,7 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <net/x25.h>
+#include <linux/compat.h>
 
 int sysctl_x25_restart_request_timeout = X25_DEFAULT_T20;
 int sysctl_x25_call_request_timeout    = X25_DEFAULT_T21;
@@ -68,6 +69,14 @@ static struct proto_ops x25_proto_ops;
 
 static struct x25_address null_x25_address = {"               "};
 
+#ifdef CONFIG_COMPAT
+struct compat_x25_subscrip_struct {
+    char device[200-sizeof(compat_ulong_t)];
+    compat_ulong_t global_facil_mask;
+    compat_uint_t extended;
+};
+#endif
+
 int x25_addr_ntoa(unsigned char *p, struct x25_address *called_addr,
 		  struct x25_address *calling_addr)
 {
@@ -1386,6 +1395,106 @@ static struct net_proto_family x25_famil
 	.owner	=	THIS_MODULE,
 };
 
+
+#ifdef CONFIG_COMPAT
+static int compat_x25_subscr_ioctl(unsigned int cmd,
+       	struct compat_x25_subscrip_struct __user *x25_subscr32)
+{
+	struct x25_subscrip_struct x25_subscr;
+	struct x25_neigh *nb;
+	struct net_device *dev;
+	int rc = -EINVAL;
+
+	if (cmd != SIOCX25GSUBSCRIP && cmd != SIOCX25SSUBSCRIP)
+   		goto out;
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
+
+	int rc = -ENOIOCTLCMD;
+
+	switch(cmd) {
+		case TIOCOUTQ:
+		case TIOCINQ:
+		case SIOCGSTAMP:
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
+		case SIOCADDRT:
+		case SIOCDELRT:
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
+			rc = x25_ioctl(sock, cmd, (unsigned long)argp);
+			break;
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
@@ -1397,6 +1506,9 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	x25_getname,
 	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_x25_ioctl,
+#endif
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,

