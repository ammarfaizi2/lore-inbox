Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbSI3NJT>; Mon, 30 Sep 2002 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbSI3NJT>; Mon, 30 Sep 2002 09:09:19 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:44466 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262048AbSI3NJH>; Mon, 30 Sep 2002 09:09:07 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>, Chris Wright <chris@wirex.com>
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
References: <Mutt.LNX.4.44.0209292236200.27145-100000@blackbird.intercode.com.au>
	<87it0o4zrr.fsf@goat.bogus.local>
From: Olaf Dietsche 
	<olaf.dietsche--list.linux-security-module@exmail.de>
Date: Mon, 30 Sep 2002 15:14:01 +0200
Message-ID: <8765wn39ie.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche--list.linux-security-module@exmail.de> writes:

> James Morris <jmorris@intercode.com.au> writes:
>
>> On Fri, 27 Sep 2002, Greg KH wrote:
>>
>>> As for the ip_prot_sock hook in general, does it look ok to the other
>>> developers?
>>> 
>>
>> This hook is not necessary: any related access control decision can be
>> made via the more generic and flexible socket_bind() hook (like SELinux).
>
> AFAICS, it looks like you can make _additional_ checks only. You still
> have to grant CAP_NET_BIND_SERVICE for binding to ports below PROT_SOCK.
> So, this doesn't look like a viable solution for me.
>
> Anyway, thanks for this pointer, I'll look into socket_bind().

Seems like my first impression was correct. You can augment the
existing checks only.

For this particular case it means, without CAP_NET_BIND_SERVICE the
hook is effectively useless for ports below PROT_SOCK. Quite the
contrary, since you must grant this capability, it leaves the door
wide open to other net protocols.

Even SELinux would benefit from this new hook, since they could move
the protocol specific part away from socket_bind() to ip_prot_sock().
Thus, they could gain _real_ fine grained control over who has access
and who has not.

Regards, Olaf.

diff -urN a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Fri Sep 27 19:09:00 2002
+++ b/include/linux/security.h	Mon Sep 30 13:50:33 2002
@@ -784,6 +784,16 @@
  *	A non-zero return value will cause an ICMP parameter problem message to
  *	be generated and transmitted to the sender.  The @pp_ptr parameter may
  *	be used to point to the offending option parameter.
+ * @ip_prot_sock:
+ *	Check, whether this is a protected port.
+ *	Security modules may use this hook to implement fine grained control
+ *	based on the port number.
+ *	@port contains the requested port
+ *	@sock contains the socket structure.
+ *	@address contains the address to bind to.
+ *	@addrlen contains the length of address.
+ *	The module should return 0, if permission to access this port is
+ *	granted, -EACCES otherwise.
  *
  * Security hooks for network devices.
  * @netdev_unregister:
@@ -1351,6 +1361,8 @@
 	void (*ip_decapsulate) (struct sk_buff * skb);
 	int (*ip_decode_options) (struct sk_buff * skb,
 				  const char *optptr, unsigned char **pp_ptr);
+	int (*ip_prot_sock) (int port, struct socket *sock,
+			     struct sockaddr *address, int addrlen);
 
 	void (*netdev_unregister) (struct net_device * dev);
 
diff -urN a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Fri Sep 27 19:07:38 2002
+++ b/net/ipv4/af_inet.c	Mon Sep 30 13:50:33 2002
@@ -531,7 +531,7 @@
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum, sock, uaddr, addr_len))
 		goto out;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
diff -urN a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Fri Sep 27 19:07:38 2002
+++ b/net/ipv6/af_inet6.c	Mon Sep 30 13:50:33 2002
@@ -313,7 +313,7 @@
 	}
 
 	snum = ntohs(addr->sin6_port);
-	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+	if (security_ops->ip_prot_sock(snum, sock, uaddr, addr_len))
 		return -EACCES;
 
 	lock_sock(sk);
diff -urN a/security/capability.c b/security/capability.c
--- a/security/capability.c	Fri Sep 27 19:09:01 2002
+++ b/security/capability.c	Mon Sep 30 13:50:33 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -773,6 +774,15 @@
 	return 0;
 }
 
+static int cap_ip_prot_sock (int port, struct socket *sock,
+			     struct sockaddr *address, int addrlen)
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
@@ -1189,6 +1199,7 @@
 	.ip_encapsulate =		cap_ip_encapsulate,
 	.ip_decapsulate =		cap_ip_decapsulate,
 	.ip_decode_options =		cap_ip_decode_options,
+	.ip_prot_sock =			cap_ip_prot_sock,
 
 	.netdev_unregister =		cap_netdev_unregister,
 
diff -urN a/security/dte/dte.c b/security/dte/dte.c
--- a/security/dte/dte.c	Fri Sep 27 19:09:01 2002
+++ b/security/dte/dte.c	Mon Sep 30 13:50:33 2002
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 
 extern int dte_initialized;
@@ -609,6 +610,15 @@
 	return 0;
 }
 
+static int dte_ip_prot_sock (int port, struct socket *sock,
+			     struct sockaddr *address, int addrlen)
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
@@ -1053,6 +1063,7 @@
 	ip_encapsulate:			dte_ip_encapsulate,
 	ip_decapsulate:			dte_ip_decapsulate,
 	ip_decode_options:		dte_ip_decode_options,
+	ip_prot_sock:			dte_ip_prot_sock,
 	
 	netdev_unregister:		dte_netdev_unregister,
 	
diff -urN a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Fri Sep 27 19:09:01 2002
+++ b/security/dummy.c	Mon Sep 30 13:50:33 2002
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <net/sock.h>
 
 static int dummy_sethostname (char *hostname)
 {
@@ -590,6 +591,15 @@
 	return 0;
 }
 
+static int dummy_ip_prot_sock (int port, struct socket *sock,
+			       struct sockaddr *address, int addrlen)
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
@@ -1009,6 +1019,7 @@
 	.ip_encapsulate =		dummy_ip_encapsulate,
 	.ip_decapsulate =		dummy_ip_decapsulate,
 	.ip_decode_options =		dummy_ip_decode_options,
+	.ip_prot_sock =			dummy_ip_prot_sock,
 
 	.ipc_permission =		dummy_ipc_permission,
 	.ipc_getinfo =			dummy_ipc_getinfo,
diff -urN a/security/lids/lids_lsm.c b/security/lids/lids_lsm.c
--- a/security/lids/lids_lsm.c	Fri Sep 27 19:09:01 2002
+++ b/security/lids/lids_lsm.c	Mon Sep 30 13:50:33 2002
@@ -22,6 +22,7 @@
 #include <linux/lids.h>
 #include <linux/lidsext.h>
 #include <linux/lidsif.h>
+#include <net/sock.h>
 
 struct security_operations *lids_secondary_ops;
 
@@ -767,6 +768,15 @@
 	return 0;
 }
 
+static int lids_ip_prot_sock (int port, struct socket *sock,
+			      struct sockaddr *address, int addrlen)
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
@@ -1208,6 +1218,7 @@
 	ip_encapsulate:			lids_ip_encapsulate,
 	ip_decapsulate:			lids_ip_decapsulate,
 	ip_decode_options:		lids_ip_decode_options,
+	ip_prot_sock:			lids_ip_prot_sock,
 	
 	ipc_permission:			lids_ipc_permission,
 	ipc_getinfo:			lids_ipc_getinfo,
diff -urN a/security/owlsm.c b/security/owlsm.c
--- a/security/owlsm.c	Fri Sep 27 19:09:01 2002
+++ b/security/owlsm.c	Mon Sep 30 13:50:33 2002
@@ -23,6 +23,7 @@
 #include <linux/netlink.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
+#include <net/sock.h>
 
 #include "owlsm.h"
 
@@ -607,6 +608,15 @@
 	return 0;
 }
 
+static int owlsm_ip_prot_sock (int port, struct socket *sock,
+			       struct sockaddr *address, int addrlen)
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
@@ -1005,6 +1015,7 @@
 	ip_encapsulate:			owlsm_ip_encapsulate,
 	ip_decapsulate:			owlsm_ip_decapsulate,
 	ip_decode_options:		owlsm_decode_options,
+	ip_prot_sock:			owlsm_ip_prot_sock,
 
 	netdev_unregister:		owlsm_netdev_unregister,
 	
diff -urN a/security/selinux/hooks.c b/security/selinux/hooks.c
--- a/security/selinux/hooks.c	Fri Sep 27 19:09:01 2002
+++ b/security/selinux/hooks.c	Mon Sep 30 13:50:33 2002
@@ -3218,6 +3218,52 @@
 	return nsid_ip_decode_options(skb, optptr, pp_ptr);
 }
 
+static int selinux_ip_prot_sock(int port, struct socket *sock,
+				struct sockaddr *address, int addrlen)
+{
+	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	/*
+	 * If PF_INET, check name_bind permission for the port.
+	 */
+	if (sock->sk->family == PF_INET) {
+		struct inode_security_struct *isec;
+		struct task_security_struct *tsec;
+		avc_audit_data_t ad;
+		struct sockaddr_in *addr = (struct sockaddr_in *)address;
+		struct sock *sk = sock->sk;
+		security_id_t sid;
+		int err;
+
+		err = task_precondition(current);
+		if (err <= 0)
+			return err;
+		tsec = current->security;
+		err = inode_precondition(SOCK_INODE(sock));
+		if (err <= 0)
+			return err;
+		isec = SOCK_INODE(sock)->i_security;
+
+		if (port&&(port < max(PROT_SOCK,ip_local_port_range_0) ||
+			   port > ip_local_port_range_1)) {
+			err = security_port_sid(sk->family, sk->type,
+						sk->protocol, port, &sid);
+			if (err)
+				return err;
+			AVC_AUDIT_DATA_INIT(&ad,NET);
+			ad.u.net.port = port;
+			err = avc_has_perm_audit(isec->sid, sid,
+						 isec->sclass,
+						 SOCKET__NAME_BIND, &ad);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void selinux_netdev_unregister(struct net_device *dev)
 {
 	netdev_free_security(dev);
@@ -3313,43 +3359,6 @@
 	if (err)
 		return err;
 
-	/*
-	 * If PF_INET, check name_bind permission for the port.
-	 */
-	if (sock->sk->family == PF_INET) {
-		struct inode_security_struct *isec;
-		struct task_security_struct *tsec;
-		avc_audit_data_t ad;
-		struct sockaddr_in *addr = (struct sockaddr_in *)address;
-		unsigned short snum = ntohs(addr->sin_port);
-		struct sock *sk = sock->sk;
-		security_id_t sid;
-
-		err = task_precondition(current);
-		if (err <= 0)
-			return err;
-		tsec = current->security;
-		err = inode_precondition(SOCK_INODE(sock));
-		if (err <= 0)
-			return err;
-		isec = SOCK_INODE(sock)->i_security;
-
-		if (snum&&(snum < max(PROT_SOCK,ip_local_port_range_0) ||
-			   snum > ip_local_port_range_1)) {
-			err = security_port_sid(sk->family, sk->type,
-						sk->protocol, snum, &sid);
-			if (err)
-				return err;
-			AVC_AUDIT_DATA_INIT(&ad,NET);
-			ad.u.net.port = snum;
-			err = avc_has_perm_audit(isec->sid, sid,
-						 isec->sclass,
-						 SOCKET__NAME_BIND, &ad);
-			if (err)
-				return err;
-		}
-	}
-
 	return 0;
 }
 
@@ -4814,6 +4823,7 @@
 	ip_encapsulate:			selinux_ip_encapsulate,
 	ip_decapsulate:			selinux_ip_decapsulate,
 	ip_decode_options:		selinux_ip_decode_options,
+	ip_prot_sock:			selinux_ip_prot_sock,
 	
 	netdev_unregister:		selinux_netdev_unregister,
 	
