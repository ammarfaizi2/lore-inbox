Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbSI0SvS>; Fri, 27 Sep 2002 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbSI0SvR>; Fri, 27 Sep 2002 14:51:17 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:42378 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262585AbSI0SvN>; Fri, 27 Sep 2002 14:51:13 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
References: <878z1rpfb4.fsf@goat.bogus.local>
	<20020926203716.GA7048@kroah.com>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 27 Sep 2002 20:55:52 +0200
Message-ID: <87adm3i7nr.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH <greg@kroah.com> writes:

> You might want to provide a patch against the development LSM tree
> (available at lsm.immunix.org) as that tree already has a lot of ip_*
> hooks that have not been submitted to the networking group yet.  If you
> do this, I would be glad to add this patch to the LSM tree, which will
> keep you from having to do the forward port for all new kernel versions
> that come out, if you want.  A number of other security related projects
> are already in this tree (SELinux, DTE, LIDS, and others.)

That would be great, thanks.
The patch against 2.5.35-lsm1 is below.

I'm not entirely sure about the other security modules. If this needs
tweaking, please let me know.

Do you want part 2 move below ./security?

Regards, Olaf.

diff -urN a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Fri Sep 27 17:10:26 2002
+++ b/include/linux/security.h	Fri Sep 27 17:55:55 2002
@@ -784,6 +784,13 @@
  *	A non-zero return value will cause an ICMP parameter problem message to
  *	be generated and transmitted to the sender.  The @pp_ptr parameter may
  *	be used to point to the offending option parameter.
+ * @ip_prot_sock:
+ *	Check, whether this is a protected port.
+ *	Security modules may use this hook to implement fine grained control
+ *	based on the port number.
+ *	@port contains the requested port
+ *	The module should return 0, if permission to access this port is
+ *	granted, -EACCES otherwise.
  *
  * Security hooks for network devices.
  * @netdev_unregister:
@@ -1351,6 +1358,7 @@
 	void (*ip_decapsulate) (struct sk_buff * skb);
 	int (*ip_decode_options) (struct sk_buff * skb,
 				  const char *optptr, unsigned char **pp_ptr);
+	int (*ip_prot_sock) (int port);
 
 	void (*netdev_unregister) (struct net_device * dev);
 
diff -urN a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Tue Sep 24 11:52:15 2002
+++ b/net/ipv4/af_inet.c	Fri Sep 27 17:55:55 2002
@@ -531,7 +531,7 @@
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum))
 		goto out;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
diff -urN a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Tue Sep 24 11:52:15 2002
+++ b/net/ipv6/af_inet6.c	Fri Sep 27 17:55:55 2002
@@ -313,7 +313,7 @@
 	}
 
 	snum = ntohs(addr->sin6_port);
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum))
 		return -EACCES;
 
 	lock_sock(sk);
diff -urN a/security/capability.c b/security/capability.c
--- a/security/capability.c	Fri Sep 27 17:10:26 2002
+++ b/security/capability.c	Fri Sep 27 17:55:55 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -773,6 +774,14 @@
 	return 0;
 }
 
+static int cap_ip_prot_sock (int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void cap_netdev_unregister (struct net_device *dev)
 {
 	return;
@@ -1189,6 +1198,7 @@
 	.ip_encapsulate =		cap_ip_encapsulate,
 	.ip_decapsulate =		cap_ip_decapsulate,
 	.ip_decode_options =		cap_ip_decode_options,
+	.ip_prot_sock =			cap_ip_prot_sock,
 
 	.netdev_unregister =		cap_netdev_unregister,
 
diff -urN a/security/dte/dte.c b/security/dte/dte.c
--- a/security/dte/dte.c	Fri Sep 27 17:10:27 2002
+++ b/security/dte/dte.c	Fri Sep 27 18:20:21 2002
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 
 extern int dte_initialized;
@@ -609,6 +610,14 @@
 	return 0;
 }
 
+static int dte_ip_prot_sock (int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void dte_netdev_unregister (struct net_device *dev)
 {
 	return;
@@ -1053,6 +1062,7 @@
 	ip_encapsulate:			dte_ip_encapsulate,
 	ip_decapsulate:			dte_ip_decapsulate,
 	ip_decode_options:		dte_ip_decode_options,
+	ip_prot_sock:			dte_ip_prot_sock,
 	
 	netdev_unregister:		dte_netdev_unregister,
 	
diff -urN a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Fri Sep 27 17:10:27 2002
+++ b/security/dummy.c	Fri Sep 27 17:55:55 2002
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 static int dummy_sethostname (char *hostname)
 {
@@ -590,6 +591,14 @@
 	return 0;
 }
 
+static int dummy_ip_prot_sock (int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void dummy_netdev_unregister (struct net_device *dev)
 {
 	return;
@@ -1009,6 +1018,7 @@
 	.ip_encapsulate =		dummy_ip_encapsulate,
 	.ip_decapsulate =		dummy_ip_decapsulate,
 	.ip_decode_options =		dummy_ip_decode_options,
+	.ip_prot_sock =			dummy_ip_prot_sock,
 
 	.ipc_permission =		dummy_ipc_permission,
 	.ipc_getinfo =			dummy_ipc_getinfo,
diff -urN a/security/lids/lids_lsm.c b/security/lids/lids_lsm.c
--- a/security/lids/lids_lsm.c	Fri Sep 27 17:10:27 2002
+++ b/security/lids/lids_lsm.c	Fri Sep 27 18:38:27 2002
@@ -22,6 +22,7 @@
 #include <linux/lids.h>
 #include <linux/lidsext.h>
 #include <linux/lidsif.h>
+#include <net/sock.h>
 
 struct security_operations *lids_secondary_ops;
 
@@ -767,6 +768,14 @@
 	return 0;
 }
 
+static int lids_ip_prot_sock (int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void lids_netdev_unregister (struct net_device *dev)
 {
 	return;
@@ -1208,6 +1217,7 @@
 	ip_encapsulate:			lids_ip_encapsulate,
 	ip_decapsulate:			lids_ip_decapsulate,
 	ip_decode_options:		lids_ip_decode_options,
+	ip_prot_sock:			lids_ip_prot_sock,
 	
 	ipc_permission:			lids_ipc_permission,
 	ipc_getinfo:			lids_ipc_getinfo,
diff -urN a/security/owlsm.c b/security/owlsm.c
--- a/security/owlsm.c	Fri Sep 27 17:10:27 2002
+++ b/security/owlsm.c	Fri Sep 27 18:19:44 2002
@@ -23,6 +23,7 @@
 #include <linux/netlink.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
+#include <net/sock.h>
 
 #include "owlsm.h"
 
@@ -607,6 +608,14 @@
 	return 0;
 }
 
+static int owlsm_ip_prot_sock (int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void owlsm_netdev_unregister (struct net_device *dev) 
 {
 	return;
@@ -1005,6 +1014,7 @@
 	ip_encapsulate:			owlsm_ip_encapsulate,
 	ip_decapsulate:			owlsm_ip_decapsulate,
 	ip_decode_options:		owlsm_decode_options,
+	ip_prot_sock:			owlsm_ip_prot_sock,
 
 	netdev_unregister:		owlsm_netdev_unregister,
 	
diff -urN a/security/selinux/hooks.c b/security/selinux/hooks.c
--- a/security/selinux/hooks.c	Fri Sep 27 17:10:27 2002
+++ b/security/selinux/hooks.c	Fri Sep 27 18:01:35 2002
@@ -3218,6 +3218,14 @@
 	return nsid_ip_decode_options(skb, optptr, pp_ptr);
 }
 
+static int selinux_ip_prot_sock(int port)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
 static void selinux_netdev_unregister(struct net_device *dev)
 {
 	netdev_free_security(dev);
@@ -4814,6 +4822,7 @@
 	ip_encapsulate:			selinux_ip_encapsulate,
 	ip_decapsulate:			selinux_ip_decapsulate,
 	ip_decode_options:		selinux_ip_decode_options,
+	ip_prot_sock:			selinux_ip_prot_sock,
 	
 	netdev_unregister:		selinux_netdev_unregister,
 	
