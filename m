Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWAJFbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWAJFbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 00:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWAJFbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 00:31:05 -0500
Received: from [203.2.177.25] ([203.2.177.25]:11593 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1750843AbWAJFbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 00:31:00 -0500
Subject: [PATCH 2/2 - 2.6.15]net:32 bit (socket layer) ioctl emulation for
	64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Andi Kleen <ak@muc.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>
Cc: SP <pereira.shaun@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 16:31:23 +1100
Message-Id: <1136871083.5742.27.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x25 module patch

diff -uprN -X dontdiff linux-2.6.15-vanilla/include/net/x25.h
linux-2.6.15/include/net/x25.h
--- linux-2.6.15-vanilla/include/net/x25.h	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/include/net/x25.h	2006-01-10 16:15:16.000000000 +1100
@@ -223,6 +223,18 @@ extern struct x25_route *x25_get_route(s
 extern struct net_device *x25_dev_get(char *);
 extern void x25_route_device_down(struct net_device *dev);
 extern int  x25_route_ioctl(unsigned int, void __user *);
+
+#ifdef CONFIG_COMPAT
+#include <linux/compat.h>
+
+struct x25_route_struct32{
+	struct x25_address address;
+	compat_uint_t   sigdigits;
+	char    device[200];
+};
+extern int  compat_x25_route_ioctl(unsigned int, struct
x25_route_struct32 __user *);
+#endif
+
 extern void x25_route_free(void);
 
 static __inline__ void x25_route_hold(struct x25_route *rt)
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
linux-2.6.15/net/x25/af_x25.c
--- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-10 16:06:29.000000000
+1100
+++ linux-2.6.15/net/x25/af_x25.c	2006-01-10 16:15:16.000000000 +1100
@@ -475,6 +475,12 @@ out:
 
 void x25_init_timers(struct sock *sk);
 
+#ifdef CONFIG_COMPAT
+#include "x25_ioctl_compat.c"
+#else
+#define compat_x25_ioctl NULL
+#endif
+
 static int x25_create(struct socket *sock, int protocol)
 {
 	struct sock *sk;
@@ -1403,7 +1409,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
 	.getname =	x25_getname,
 	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
-	.compat_ioctl=  NULL,
+	.compat_ioctl=  compat_x25_ioctl,
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,
 	.setsockopt =	x25_setsockopt,
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/x25_ioctl_compat.c
linux-2.6.15/net/x25/x25_ioctl_compat.c
--- linux-2.6.15-vanilla/net/x25/x25_ioctl_compat.c	1970-01-01
10:00:00.000000000 +1000
+++ linux-2.6.15/net/x25/x25_ioctl_compat.c	2006-01-10
16:15:16.000000000 +1100
@@ -0,0 +1,264 @@
+#include <linux/compat.h>
+
+struct x25_subscrip_struct32{
+	char device[200-sizeof(compat_ulong_t)];
+	compat_ulong_t global_facil_mask;
+	compat_uint_t extended;
+};
+
+struct x25_facilities32{
+	compat_uint_t	winzize_in, winsize_out;
+	compat_uint_t	pacsize_in, packsize_out;
+	compat_uint_t	throughput;
+	compat_uint_t   reverse;
+};
+
+struct x25_calluserdata32 {
+	compat_uint_t 	cudlength;
+	unsigned char   cuddata[128];
+};
+
+struct x25_subaddr32 {
+	compat_uint_t 	cudmatchlength;
+};
+
+static int compat_x25_subscr_ioctl(unsigned int cmd,
+		struct x25_subscrip_struct32 __user *x25_subscr32)
+{
+	struct x25_subscrip_struct x25_subscr;
+	struct x25_neigh *nb;
+	struct net_device *dev;
+	int rc = -EINVAL;
+
+	if (cmd != SIOCX25GSUBSCRIP && cmd != SIOCX25SSUBSCRIP)
+		goto out;
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
+		x25_subscr.extended		= nb->extended;
+		x25_subscr.global_facil_mask	 = nb->global_facil_mask;
+		rc = copy_to_user(x25_subscr32, &x25_subscr,
+				sizeof(*x25_subscr32)) ? -EFAULT : 0;
+	} else {
+		rc = -EINVAL;
+		if (!(x25_subscr.extended && x25_subscr.extended != 1)) {
+			rc = 0;
+			nb->extended		= x25_subscr.extended;
+			nb->global_facil_mask 	= x25_subscr.global_facil_mask;
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
+static int compat_x25_facility_ioctl(struct socket *sock, struct
x25_facilities32 __user *facilities32)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	struct x25_facilities 	facilities;
+	int rc;
+	rc = -EFAULT;
+	if(copy_from_user(&facilities, facilities32, sizeof(*facilities32)))
+	       goto out;
+	rc = -EINVAL;
+	if (sk->sk_state != TCP_LISTEN &&
+		sk->sk_state != TCP_CLOSE)
+		goto out;
+	if (facilities.pacsize_in < X25_PS16 ||
+		facilities.pacsize_in > X25_PS4096)
+	       	goto out;
+	if (facilities.pacsize_out < X25_PS16 ||
+		facilities.pacsize_out > X25_PS4096)
+	       	goto out;
+	if (facilities.winsize_in < 1 ||
+		facilities.winsize_in > 127)
+	       	goto out;
+	if (facilities.throughput < 0x03 ||
+		facilities.throughput > 0xDD)
+	       	goto out;
+	if (facilities.reverse &&
+		(facilities.reverse | 0x81)!= 0x81)
+	       	goto out;
+       	x25->facilities = facilities;
+	rc = 0;
+out :
+	return rc;
+}
+
+static int compat_x25_get_facility_ioctl(struct socket *sock, struct
x25_facilities32 __user *facility32)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	struct x25_facilities fac = x25->facilities;
+	int rc;
+
+	rc = copy_to_user(facility32, &fac, sizeof(fac)) ? -EFAULT : 0;
+	return rc;
+}
+
+static int compat_x25_cud_ioctl(struct socket *sock, struct
x25_calluserdata32 __user *calluserdata32)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	struct x25_calluserdata calluserdata;
+	int rc;
+
+	rc = -EFAULT;
+	if(copy_from_user(&calluserdata, calluserdata32, sizeof
(*calluserdata32)))
+		goto out;
+
+	rc = -EINVAL;
+	if (calluserdata.cudlength > X25_MAX_CUD_LEN)
+		goto out;
+
+	x25->calluserdata = calluserdata;
+	rc = 0;
+out:
+	return rc;
+}
+
+static int compat_x25_get_cud_ioctl(struct socket *sock, struct
x25_calluserdata32 __user *calluserdata32)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	struct x25_calluserdata cud = x25->calluserdata;
+	int rc;
+
+	rc = copy_to_user(calluserdata32, &cud, sizeof(cud))? -EFAULT : 0;
+	return rc;
+}
+
+static int compat_x25_cud_match_ioctl(struct socket *sock, struct
x25_subaddr32 __user *sub_addr32)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	struct x25_subaddr sub_addr;
+	int rc;
+
+	rc = -EINVAL;
+	if(sk->sk_state != TCP_CLOSE)
+		goto out;
+	rc = -EFAULT;
+	if(copy_from_user(&sub_addr, sub_addr32, sizeof(*sub_addr32)))
+		goto out;
+	rc = -EINVAL;
+	if(sub_addr.cudmatchlength > X25_MAX_CUD_LEN)
+		goto out;
+	x25->cudmatchlength = sub_addr.cudmatchlength;
+	rc = 0;
+out:
+	return rc;
+}
+
+static int compat_x25_accept_ctrl(struct socket *sock, unsigned int
cmd)
+{
+	struct sock *sk = sock->sk;
+	struct x25_sock *x25 = x25_sk(sk);
+	int rc = -EINVAL;
+
+	switch(cmd){
+
+		case SIOCX25CALLACCPTAPPRV: {
+	    		rc = -EINVAL;
+			if (sk->sk_state != TCP_CLOSE)
+			       	break;
+		       	x25->accptapprv = X25_ALLOW_ACCPT_APPRV;
+		       	rc = 0;
+		       	break;
+		}
+
+		case SIOCX25SENDCALLACCPT: {
+			rc = -EINVAL;
+			if (sk->sk_state != TCP_ESTABLISHED)
+				break;
+			if (x25->accptapprv)
+				break;
+			x25_write_internal(sk, X25_CALL_ACCEPTED);
+			x25->state = X25_STATE_3;
+			rc = 0;
+			break;
+		}
+	}
+	return rc;
+}
+
+static int compat_x25_ioctl(struct socket *sock, unsigned int cmd,
unsigned long arg)
+{
+	void __user *argp = compat_ptr(arg);
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
+			rc = -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+				break;
+			rc = compat_x25_route_ioctl(cmd, argp);
+				break;
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
+			rc = compat_x25_get_facility_ioctl(sock, argp);
+			break;
+		case SIOCX25SFACILITIES:
+			rc = compat_x25_facility_ioctl(sock, argp);
+			break;
+		case SIOCX25GCALLUSERDATA:
+			rc = compat_x25_get_cud_ioctl(sock, argp);
+			break;
+		case SIOCX25SCALLUSERDATA:
+			rc = compat_x25_cud_ioctl(sock, argp);
+			break;
+		case SIOCX25GCAUSEDIAG:
+		case SIOCX25SCUDMATCHLEN:
+			rc = compat_x25_cud_match_ioctl(sock,argp);
+			break;
+		case SIOCX25CALLACCPTAPPRV:
+			rc = compat_x25_accept_ctrl(sock,SIOCX25CALLACCPTAPPRV);
+				break;
+		case SIOCX25SENDCALLACCPT:
+			rc = compat_x25_accept_ctrl(sock,SIOCX25SENDCALLACCPT);
+				break;
+		default:
+			rc = -ENOIOCTLCMD;
+			break;
+	}
+
+	return rc;
+}
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/x25_route.c
linux-2.6.15/net/x25/x25_route.c
--- linux-2.6.15-vanilla/net/x25/x25_route.c	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/net/x25/x25_route.c	2006-01-10 16:15:16.000000000 +1100
@@ -204,6 +204,36 @@ out:
 	return rc;
 }
 
+#ifdef CONFIG_COMPAT
+
+int compat_x25_route_ioctl(unsigned int cmd, struct x25_route_struct32
__user *rt32)
+{
+	struct x25_route_struct rt;
+	struct net_device *dev;
+       	int rc = -EINVAL;
+
+	if (cmd != SIOCADDRT && cmd != SIOCDELRT)
+	     	goto out;
+
+	rc = -EFAULT;
+       	if(copy_from_user(&rt, rt32, sizeof(*rt32)))
+	      	goto out;
+
+	dev = x25_dev_get(rt.device);
+	if (!dev)
+	     	goto out;
+
+	if (cmd == SIOCADDRT)
+	       	rc = x25_add_route(&rt.address, rt.sigdigits, dev);
+       	else
+	       	rc = x25_del_route(&rt.address, rt.sigdigits, dev);
+       	dev_put(dev);
+out:
+       	return rc;
+
+}
+#endif
+
 /*
  *	Release all memory associated with X.25 routing structures.
  */

