Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbRFEQ7y>; Tue, 5 Jun 2001 12:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264043AbRFEQ7p>; Tue, 5 Jun 2001 12:59:45 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:9108 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id <S264037AbRFEQ72>;
	Tue, 5 Jun 2001 12:59:28 -0400
Date: Tue, 5 Jun 2001 11:59:24 -0500
Message-Id: <200106051659.LAA20094@em.cig.mot.com>
From: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the register/unregister inet[6]_create() table patch revised
for 2.4.5.  We thank Dave Miller for his helpful feedback on earlier
versions of this patch.

DESCRIPTION
This patch adds a mechanism for registering new IP transport protocols
for the socket() system call.  It replaces the hard-coded switch
tables in inet_create() and inet6_create() with explicit data
structures.

The new calls are:
void    inet_register_protosw(struct inet_protosw *p);
void    inet_unregister_protosw(struct inet_protosw *p);
void    inet6_register_protosw(struct inet_protosw *p);
void    inet6_unregister_protosw(struct inet_protosw *p);

This is the first of a series of proposed changes to support IP
transport modules.

MOTIVATION
As part of the effort to create the Linux Kernel implementation of
SCTP <www.sourceforge.net/projects/lksctp>, we seek to make it
possible to load a new IP transport protocol as a kernel module.

It is already possible to register new address families.  It is even
possible to register new transport protocols with IP.  However, in
order to be able to open a socket with a new transport protocol, you
must replace the whole AF_INET address family.

In addition to SCTP, there are other protocols which could find it
useful to be in a kernel module. For example, TCP extensions like TCP
framing and TCP over satellite, multicast protocols, and RTP/ROHC
(robust header compression). In general, support for IP transport
modules makes transport layer experimentation easier.

CHANGES SINCE sockreg2.4.3-04
We noticed that inet6_protocol_base went away in 2.4.5, so we changed
our v6 initialization to parallel the inet6_protocol initialization.
We now call inet6_register_protosw() from *v6_init() instead of having
a static array of struct protosw's.  Since other protocols depend on
raw sockets (e.g. ICMP, IGMP, NDISC) we still register rawv6_protosw
in inet6_init().

piggy (La Monte H.P. Yarroll)
Karl O. Knutson

PATCH FOLLOWS
diff -u -r linux-2.4.5/include/asm-alpha/socket.h linux/include/asm-alpha/socket.h
--- linux-2.4.5/include/asm-alpha/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-alpha/socket.h	Mon Jun  4 11:11:30 2001
@@ -66,6 +66,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-arm/socket.h linux/include/asm-arm/socket.h
--- linux-2.4.5/include/asm-arm/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-arm/socket.h	Mon Jun  4 11:11:30 2001
@@ -58,6 +58,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-cris/socket.h linux/include/asm-cris/socket.h
--- linux-2.4.5/include/asm-cris/socket.h	Fri Apr  6 12:51:19 2001
+++ linux/include/asm-cris/socket.h	Mon Jun  4 11:11:30 2001
@@ -59,6 +59,7 @@
                                         /* level.  For writing rarp and */
                                         /* other similar things on the  */
                                         /* user level.                  */
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-i386/socket.h linux/include/asm-i386/socket.h
--- linux-2.4.5/include/asm-i386/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-i386/socket.h	Mon Jun  4 11:11:30 2001
@@ -58,6 +58,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-ia64/socket.h linux/include/asm-ia64/socket.h
--- linux-2.4.5/include/asm-ia64/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-ia64/socket.h	Mon Jun  4 11:11:30 2001
@@ -65,6 +65,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_IA64_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-m68k/socket.h linux/include/asm-m68k/socket.h
--- linux-2.4.5/include/asm-m68k/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-m68k/socket.h	Mon Jun  4 11:11:30 2001
@@ -58,6 +58,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-mips/socket.h linux/include/asm-mips/socket.h
--- linux-2.4.5/include/asm-mips/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-mips/socket.h	Mon Jun  4 11:11:30 2001
@@ -71,6 +71,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-mips64/socket.h linux/include/asm-mips64/socket.h
--- linux-2.4.5/include/asm-mips64/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-mips64/socket.h	Mon Jun  4 11:11:30 2001
@@ -79,6 +79,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-parisc/socket.h linux/include/asm-parisc/socket.h
--- linux-2.4.5/include/asm-parisc/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-parisc/socket.h	Mon Jun  4 11:11:30 2001
@@ -56,6 +56,7 @@
 				/* level.  For writing rarp and	*/
 				/* other similar things on the	*/
 				/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-ppc/socket.h linux/include/asm-ppc/socket.h
--- linux-2.4.5/include/asm-ppc/socket.h	Mon May 21 17:02:06 2001
+++ linux/include/asm-ppc/socket.h	Mon Jun  4 11:11:30 2001
@@ -67,6 +67,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-s390/socket.h linux/include/asm-s390/socket.h
--- linux-2.4.5/include/asm-s390/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-s390/socket.h	Mon Jun  4 11:11:30 2001
@@ -66,6 +66,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-s390x/socket.h linux/include/asm-s390x/socket.h
--- linux-2.4.5/include/asm-s390x/socket.h	Fri Mar  2 13:12:06 2001
+++ linux/include/asm-s390x/socket.h	Mon Jun  4 11:11:30 2001
@@ -65,6 +65,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-sh/socket.h linux/include/asm-sh/socket.h
--- linux-2.4.5/include/asm-sh/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-sh/socket.h	Mon Jun  4 11:11:30 2001
@@ -58,6 +58,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* __ASM_SH_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-sparc/socket.h linux/include/asm-sparc/socket.h
--- linux-2.4.5/include/asm-sparc/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-sparc/socket.h	Mon Jun  4 11:11:30 2001
@@ -63,6 +63,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/asm-sparc64/socket.h linux/include/asm-sparc64/socket.h
--- linux-2.4.5/include/asm-sparc64/socket.h	Sat Feb  3 13:26:44 2001
+++ linux/include/asm-sparc64/socket.h	Mon Jun  4 11:11:30 2001
@@ -63,6 +63,7 @@
 					/* level.  For writing rarp and	*/
 					/* other similar things on the	*/
 					/* user level.			*/
+#define	SOCK_MAX	(SOCK_PACKET+1)
 #endif
 
 #endif /* _ASM_SOCKET_H */
diff -u -r linux-2.4.5/include/net/protocol.h linux/include/net/protocol.h
--- linux-2.4.5/include/net/protocol.h	Fri May 25 20:01:27 2001
+++ linux/include/net/protocol.h	Mon Jun  4 18:28:00 2001
@@ -63,19 +63,45 @@
 
 #endif
 
+/* This is used to register socket interfaces for IP protocols.  */
+struct inet_protosw {
+	struct list_head list;
+
+        /* These two fields form the lookup key.  */
+	unsigned short	 type;	   /* This is the 2nd argument to socket(2). */
+	int		 protocol; /* This is the L4 protocol number.  */
+
+	struct proto	 *prot;
+	struct proto_ops *ops;
+  
+	char             no_check;   /* checksum on rcv/xmit/none? */
+	unsigned char	 reuse;	     /* Are ports automatically reusable? */
+	int              capability; /* Which (if any) capability do
+				      * we need to use this socket
+				      * interface?
+				      */
+};
+
+
 extern struct inet_protocol *inet_protocol_base;
 extern struct inet_protocol *inet_protos[MAX_INET_PROTOS];
+extern struct list_head inetsw[SOCK_MAX];
 
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
 extern struct inet6_protocol *inet6_protos[MAX_INET_PROTOS];
+extern struct list_head inetsw6[SOCK_MAX];
 #endif
 
 extern void	inet_add_protocol(struct inet_protocol *prot);
 extern int	inet_del_protocol(struct inet_protocol *prot);
+extern void	inet_register_protosw(struct inet_protosw *p);
+extern void	inet_unregister_protosw(struct inet_protosw *p);
 
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
 extern void	inet6_add_protocol(struct inet6_protocol *prot);
 extern int	inet6_del_protocol(struct inet6_protocol *prot);
+extern void	inet6_register_protosw(struct inet_protosw *p);
+extern void	inet6_unregister_protosw(struct inet_protosw *p);
 #endif
 
 #endif	/* _PROTOCOL_H */
diff -u -r linux-2.4.5/net/ipv4/af_inet.c linux/net/ipv4/af_inet.c
--- linux-2.4.5/net/ipv4/af_inet.c	Tue May  1 22:59:24 2001
+++ linux/net/ipv4/af_inet.c	Mon Jun  4 11:16:27 2001
@@ -14,6 +14,8 @@
  *
  * Changes (see also sock.c)
  *
+ *		piggy,
+ *		Karl Knutson	:	Socket protocol table
  *		A.N.Kuznetsov	:	Socket death error in accept().
  *		John Richardson :	Fix non blocking error in connect()
  *					so sockets that fail to connect
@@ -88,6 +90,7 @@
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
+#include <linux/brlock.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/arp.h>
@@ -142,6 +145,11 @@
 int (*br_ioctl_hook)(unsigned long);
 #endif
 
+/* The inetsw table contains everything that inet_create needs to
+ * build a new socket.
+ */
+struct list_head inetsw[SOCK_MAX];
+
 /* New destruction routine */
 
 void inet_sock_destruct(struct sock *sk)
@@ -309,46 +317,56 @@
 static int inet_create(struct socket *sock, int protocol)
 {
 	struct sock *sk;
-	struct proto *prot;
+        struct list_head *p;
+        struct inet_protosw *answer;
 
 	sock->state = SS_UNCONNECTED;
 	sk = sk_alloc(PF_INET, GFP_KERNEL, 1);
 	if (sk == NULL) 
 		goto do_oom;
-
-	switch (sock->type) {
-	case SOCK_STREAM:
-		if (protocol && protocol != IPPROTO_TCP)
-			goto free_and_noproto;
-		protocol = IPPROTO_TCP;
-		prot = &tcp_prot;
-		sock->ops = &inet_stream_ops;
-		break;
-	case SOCK_SEQPACKET:
-		goto free_and_badtype;
-	case SOCK_DGRAM:
-		if (protocol && protocol != IPPROTO_UDP)
-			goto free_and_noproto;
-		protocol = IPPROTO_UDP;
-		sk->no_check = UDP_CSUM_DEFAULT;
-		prot=&udp_prot;
-		sock->ops = &inet_dgram_ops;
-		break;
-	case SOCK_RAW:
-		if (!capable(CAP_NET_RAW))
-			goto free_and_badperm;
-		if (!protocol)
-			goto free_and_noproto;
-		prot = &raw_prot;
-		sk->reuse = 1;
-		sk->num = protocol;
-		sock->ops = &inet_dgram_ops;
-		if (protocol == IPPROTO_RAW)
-			sk->protinfo.af_inet.hdrincl = 1;
-		break;
-	default:
-		goto free_and_badtype;
-	}
+  
+        /* Look for the requested type/protocol pair.  */
+        answer = NULL;
+  	br_read_lock_bh(BR_NETPROTO_LOCK);
+        list_for_each(p, &inetsw[sock->type]) {
+                answer = list_entry(p, struct inet_protosw, list);
+                /* Check the non-wild match.  */
+                if (protocol == answer->protocol) {
+                        if (protocol != IPPROTO_IP) {
+                                break;
+                        }
+                } else {
+                        /* Check for the two wild cases. */
+                        if (IPPROTO_IP == protocol) {
+                                protocol = answer->protocol;
+                                break;
+                        }
+                        if (IPPROTO_IP == answer->protocol) {
+                                break;
+                        }
+                }
+                answer = NULL;
+        }
+  	br_read_unlock_bh(BR_NETPROTO_LOCK);
+
+        if (!answer)
+                goto free_and_badtype;
+        if (answer->capability > 0 && !capable(answer->capability))
+                goto free_and_badperm;
+        if (!protocol)
+                goto free_and_noproto;
+
+        sock->ops = answer->ops;
+        sk->prot = answer->prot;
+        sk->no_check = answer->no_check;
+        if (answer->reuse)
+                sk->reuse = answer->reuse;
+
+        if (SOCK_RAW == sock->type) {
+                sk->num = protocol;
+                if (IPPROTO_RAW == protocol)
+                        sk->protinfo.af_inet.hdrincl = 1;
+        }
 
 	if (ipv4_config.no_pmtu_disc)
 		sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_DONT;
@@ -365,8 +383,7 @@
 	sk->family	= PF_INET;
 	sk->protocol	= protocol;
 
-	sk->prot	= prot;
-	sk->backlog_rcv = prot->backlog_rcv;
+	sk->backlog_rcv = sk->prot->backlog_rcv;
 
 	sk->protinfo.af_inet.ttl	= sysctl_ip_default_ttl;
 
@@ -969,6 +986,70 @@
 extern void tcp_init(void);
 extern void tcp_v4_init(struct net_proto_family *);
 
+/* Upon startup we insert all the elements in inetsw_array[] into
+ * the linked list inetsw.
+ */
+static struct inet_protosw inetsw_array[] =
+{
+        {
+                type:        SOCK_STREAM,
+                protocol:    IPPROTO_TCP,
+                prot:        &tcp_prot,
+                ops:         &inet_stream_ops,
+                no_check:     0,
+                reuse:        0,
+                capability:  -1,
+        },
+
+        {
+                type:        SOCK_DGRAM,
+                protocol:    IPPROTO_UDP,
+                prot:        &udp_prot,
+                ops:         &inet_dgram_ops,
+                no_check:    UDP_CSUM_DEFAULT,
+                reuse:       0,
+                capability:  -1,
+       },
+        
+
+       {
+               type:        SOCK_RAW,
+               protocol:    IPPROTO_IP,	/* wild card */
+               prot:        &raw_prot,
+               ops:         &inet_dgram_ops,
+               no_check:    UDP_CSUM_DEFAULT,
+               reuse:       1,
+               capability:  CAP_NET_RAW,
+       }
+}; /* struct inet_protosw inetsw_array[] */
+
+#define INETSW_ARRAY_LEN (sizeof(inetsw_array) / sizeof(struct inet_protosw))
+
+void
+inet_register_protosw(struct inet_protosw *p)
+{
+	/* Add to the BEGINNING so that we override any existing
+	 * entry.  This means that when we remove this entry, the
+	 * system automatically returns to the old behavior.
+	 */
+        if (p->type < SOCK_MAX) {
+                br_write_lock_bh(BR_NETPROTO_LOCK);
+                list_add(&p->list, &inetsw[p->type]);
+                br_write_unlock_bh(BR_NETPROTO_LOCK);
+        } else {
+                printk(KERN_DEBUG "Ignoring attempt to register illegal socket type %d.\n",
+                       p->type);
+        }
+} /* inet_protosw_register() */
+
+void
+inet_unregister_protosw(struct inet_protosw *p)
+{
+        br_write_lock_bh(BR_NETPROTO_LOCK);
+	list_del(&p->list);
+  	br_write_unlock_bh(BR_NETPROTO_LOCK);
+} /* inet_protosw_unregister() */
+
 
 /*
  *	Called by socket.c on kernel startup.  
@@ -978,6 +1059,8 @@
 {
 	struct sk_buff *dummy_skb;
 	struct inet_protocol *p;
+	struct inet_protosw *q;
+        struct list_head *r;
 
 	printk(KERN_INFO "NET4: Linux TCP/IP 1.0 for NET4.0\n");
 
@@ -1003,6 +1086,14 @@
 		printk("%s%s",p->name,tmp?", ":"\n");
 		p = tmp;
 	}
+
+        /* Register the socket-side information for inet_create.  */
+        for(r = &inetsw[0]; r < &inetsw[SOCK_MAX]; ++r) {
+                INIT_LIST_HEAD(r);
+        }
+        for(q = inetsw_array; q < &inetsw_array[INETSW_ARRAY_LEN]; ++q) {
+                inet_register_protosw(q);
+        }
 
 	/*
 	 *	Set the ARP module up
diff -u -r linux-2.4.5/net/ipv6/af_inet6.c linux/net/ipv6/af_inet6.c
--- linux-2.4.5/net/ipv6/af_inet6.c	Thu Apr 12 14:11:39 2001
+++ linux/net/ipv6/af_inet6.c	Mon Jun  4 18:39:53 2001
@@ -10,6 +10,7 @@
  *	$Id: af_inet6.c,v 1.63 2001/03/02 03:13:05 davem Exp $
  *
  * 	Fixes:
+ *	piggy, Karl Knutson	:	Socket protocol table
  * 	Hideaki YOSHIFUJI	:	sin6_scope_id support
  * 	Arnaldo Melo		: 	check proc_net_create return, cleanups
  *
@@ -44,6 +45,7 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/icmpv6.h>
+#include <linux/brlock.h>
 #include <linux/smp_lock.h>
 
 #include <net/ip.h>
@@ -71,9 +73,6 @@
 MODULE_PARM(unloadable, "i");
 #endif
 
-extern struct proto_ops inet6_stream_ops;
-extern struct proto_ops inet6_dgram_ops;
-
 /* IPv6 procfs goodies... */
 
 #ifdef CONFIG_PROC_FS
@@ -93,6 +92,11 @@
 atomic_t inet6_sock_nr;
 #endif
 
+/* The inetsw table contains everything that inet_create needs to
+ * build a new socket.
+ */
+struct list_head inetsw6[SOCK_MAX];
+
 static void inet6_sock_destruct(struct sock *sk)
 {
 	inet_sock_destruct(sk);
@@ -106,47 +110,64 @@
 static int inet6_create(struct socket *sock, int protocol)
 {
 	struct sock *sk;
-	struct proto *prot;
+        struct list_head *p;
+        struct inet_protosw *answer;
 
 	sk = sk_alloc(PF_INET6, GFP_KERNEL, 1);
 	if (sk == NULL) 
 		goto do_oom;
 
-	if(sock->type == SOCK_STREAM || sock->type == SOCK_SEQPACKET) {
-		if (protocol && protocol != IPPROTO_TCP) 
-			goto free_and_noproto;
-		protocol = IPPROTO_TCP;
-		prot = &tcpv6_prot;
-		sock->ops = &inet6_stream_ops;
-	} else if(sock->type == SOCK_DGRAM) {
-		if (protocol && protocol != IPPROTO_UDP) 
-			goto free_and_noproto;
-		protocol = IPPROTO_UDP;
-		sk->no_check = UDP_CSUM_DEFAULT;
-		prot=&udpv6_prot;
-		sock->ops = &inet6_dgram_ops;
-	} else if(sock->type == SOCK_RAW) {
-		if (!capable(CAP_NET_RAW))
-			goto free_and_badperm;
-		if (!protocol) 
-			goto free_and_noproto;
-		prot = &rawv6_prot;
-		sock->ops = &inet6_dgram_ops;
-		sk->reuse = 1;
-		sk->num = protocol;
-	} else {
-		goto free_and_badtype;
-	}
-	
+        /* Look for the requested type/protocol pair.  */
+        answer = NULL;
+	br_read_lock_bh(BR_NETPROTO_LOCK);
+        list_for_each(p, &inetsw6[sock->type]) {
+                answer = list_entry(p, struct inet_protosw, list);
+                /* Check the non-wild match.  */
+                if (protocol == answer->protocol) {
+                        if (protocol != IPPROTO_IP) {
+                                break;
+                        }
+                } else {
+                        /* Check for the two wild cases. */
+                        if (IPPROTO_IP == protocol) {
+                                protocol = answer->protocol;
+                                break;
+                        }
+                        if (IPPROTO_IP == answer->protocol) {
+                                break;
+                        }
+                }
+                answer = NULL;
+        }
+	br_read_unlock_bh(BR_NETPROTO_LOCK);
+
+        if (!answer)
+                goto free_and_badtype;
+        if (answer->capability > 0 && !capable(answer->capability))
+                goto free_and_badperm;
+        if (!protocol)
+                goto free_and_noproto;
+
+        sock->ops = answer->ops;
 	sock_init_data(sock, sk);
 
+	sk->prot		= answer->prot;
+        sk->no_check = answer->no_check;
+        if (answer->reuse)
+                sk->reuse = answer->reuse;
+
+        if (SOCK_RAW == sock->type) {
+                sk->num = protocol;
+                if (IPPROTO_RAW == protocol)
+                        sk->protinfo.af_inet.hdrincl = 1;
+        }
+
 	sk->destruct            = inet6_sock_destruct;
 	sk->zapped		= 0;
 	sk->family		= PF_INET6;
 	sk->protocol		= protocol;
 
-	sk->prot		= prot;
-	sk->backlog_rcv		= prot->backlog_rcv;
+	sk->backlog_rcv		= answer->prot->backlog_rcv;
 
 	sk->net_pinfo.af_inet6.hop_limit  = -1;
 	sk->net_pinfo.af_inet6.mcast_hops = -1;
@@ -175,9 +196,6 @@
 #endif
 	MOD_INC_USE_COUNT;
 
-	if (sk->type==SOCK_RAW && protocol==IPPROTO_RAW)
-		sk->protinfo.af_inet.hdrincl=1;
-
 	if (sk->num) {
 		/* It assumes that any protocol which allows
 		 * the user to assign a number at socket
@@ -186,7 +204,6 @@
 		sk->sport = ntohs(sk->num);
 		sk->prot->hash(sk);
 	}
-
 	if (sk->prot->init) {
 		int err = sk->prot->init(sk);
 		if (err != 0) {
@@ -504,9 +521,47 @@
 extern void ipv6_sysctl_unregister(void);
 #endif
 
+static struct inet_protosw rawv6_protosw = {
+        type:        SOCK_RAW,
+        protocol:    IPPROTO_IP,	/* wild card */
+        prot:        &rawv6_prot,
+        ops:         &inet6_dgram_ops,
+        no_check:    UDP_CSUM_DEFAULT,
+        reuse:       1,
+        capability:  CAP_NET_RAW,
+};
+
+#define INETSW6_ARRAY_LEN (sizeof(inetsw6_array) / sizeof(struct inet_protosw))
+
+void
+inet6_register_protosw(struct inet_protosw *p)
+{
+	/* Add to the BEGINNING so that we override any existing
+	 * entry.  This means that when we remove this entry, the
+	 * system automatically returns to the old behavior.
+	 */
+        if (p->type < SOCK_MAX) {
+                br_write_lock_bh(BR_NETPROTO_LOCK);
+                list_add(&p->list, &inetsw6[p->type]);
+                br_write_unlock_bh(BR_NETPROTO_LOCK);
+        } else {
+                printk(KERN_DEBUG "Ignoring attempt to register illegal socket type %d.\n",
+                       p->type);
+        }
+} /* inet_protosw_register() */
+
+void
+inet6_unregister_protosw(struct inet_protosw *p)
+{
+        br_write_lock_bh(BR_NETPROTO_LOCK);
+	list_del(&p->list);
+        br_write_unlock_bh(BR_NETPROTO_LOCK);
+} /* inet_protosw_unregister() */
+
 static int __init inet6_init(void)
 {
 	struct sk_buff *dummy_skb;
+        struct list_head *r;
 	int err;
 
 #ifdef MODULE
@@ -523,6 +578,16 @@
 		printk(KERN_CRIT "inet6_proto_init: size fault\n");
 		return -EINVAL;
 	}
+
+        /* Register the socket-side information for inet6_create.  */
+        for(r = &inetsw6[0]; r < &inetsw6[SOCK_MAX]; ++r) {
+                INIT_LIST_HEAD(r);
+        }
+
+        /* We MUST register RAW sockets before we create the ICMP6,
+         * IGMP6, or NDISC control sockets.
+         */
+        inet6_register_protosw(&rawv6_protosw);
 
 	/*
 	 *	ipngwg API draft makes clear that the correct semantics
diff -u -r linux-2.4.5/net/ipv6/tcp_ipv6.c linux/net/ipv6/tcp_ipv6.c
--- linux-2.4.5/net/ipv6/tcp_ipv6.c	Wed Apr 25 16:57:39 2001
+++ linux/net/ipv6/tcp_ipv6.c	Mon Jun  4 18:35:31 2001
@@ -2125,8 +2125,21 @@
 	"TCPv6"			/* name			*/
 };
 
+extern struct proto_ops inet6_stream_ops;
+
+static struct inet_protosw tcpv6_protosw = {
+        type:        SOCK_STREAM,
+        protocol:    IPPROTO_TCP,
+        prot:        &tcpv6_prot,
+        ops:         &inet6_stream_ops,
+        no_check:     0,
+        reuse:        0,
+        capability:  -1,
+};
+
 void __init tcpv6_init(void)
 {
 	/* register inet6 protocol */
 	inet6_add_protocol(&tcpv6_protocol);
+        inet6_register_protosw(&tcpv6_protosw);
 }
diff -u -r linux-2.4.5/net/ipv6/udp.c linux/net/ipv6/udp.c
--- linux-2.4.5/net/ipv6/udp.c	Thu Apr 12 14:11:39 2001
+++ linux/net/ipv6/udp.c	Mon Jun  4 18:36:03 2001
@@ -992,7 +992,21 @@
 	get_port:	udp_v6_get_port,
 };
 
+extern struct proto_ops inet6_dgram_ops;
+
+static struct inet_protosw udpv6_protosw = {
+        type:        SOCK_DGRAM,
+        protocol:    IPPROTO_UDP,
+        prot:        &udpv6_prot,
+        ops:         &inet6_dgram_ops,
+        no_check:    UDP_CSUM_DEFAULT,
+        reuse:        0,
+        capability:  -1,
+};
+
+
 void __init udpv6_init(void)
 {
 	inet6_add_protocol(&udpv6_protocol);
+        inet6_register_protosw(&udpv6_protosw);
 }
diff -u -r linux-2.4.5/net/netsyms.c linux/net/netsyms.c
--- linux-2.4.5/net/netsyms.c	Fri Apr 27 16:15:01 2001
+++ linux/net/netsyms.c	Mon Jun  4 11:11:30 2001
@@ -234,6 +234,8 @@
 EXPORT_SYMBOL(inetdev_lock);
 EXPORT_SYMBOL(inet_add_protocol);
 EXPORT_SYMBOL(inet_del_protocol);
+EXPORT_SYMBOL(inet_register_protosw);
+EXPORT_SYMBOL(inet_unregister_protosw);
 EXPORT_SYMBOL(ip_route_output_key);
 EXPORT_SYMBOL(ip_route_input);
 EXPORT_SYMBOL(icmp_send);
