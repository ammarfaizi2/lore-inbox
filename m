Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290500AbSAQW2Y>; Thu, 17 Jan 2002 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290502AbSAQW2P>; Thu, 17 Jan 2002 17:28:15 -0500
Received: from [63.204.6.12] ([63.204.6.12]:39385 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S290500AbSAQW1f>;
	Thu, 17 Jan 2002 17:27:35 -0500
Date: Thu, 17 Jan 2002 17:27:13 -0500
From: "Mark Frazer" <mark@somanetworks.com>
To: davem@redhat.com, ak@muc.de, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] new sysctl net/ipv4/ip_default_bind
Message-ID: <20020117172713.A1893@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch applies against 2.4.17 and creates a new sysctl
node /proc/sys/net/ipv4/ip_default_bind.  The purpose of the control
is to allow a default IP address to be selected by the sysadmin for
outgoing connections.  That is, for sockets which do not bind(2) the
local end of the socket before calling connect(2).

For high-availability, we have several numbered interfaces on the same
subnet.  There is a virtual interface which is expected to be highly
available.  In order for connections to survive the disconnection of one
or the physical interfaces, all connections should use the IP address
of the virtual interface.  We cannot use bonding as we have some cheezy
tulip chip without an input for the link state signal provided by the PHY.

This patch causes legacy applications such as telnet to behave the way
we like them to with no apparent adverse affects.

Does anyone find anything particularly offensive about this?

cheers
-mark

diff -Nur linux/include/linux/sysctl.h linux.mjf/include/linux/sysctl.h
--- linux/include/linux/sysctl.h	Mon Nov 26 09:55:36 2001
+++ linux.mjf/include/linux/sysctl.h	Wed Jan 16 22:47:06 2002
@@ -289,7 +289,8 @@
 	NET_TCP_ADV_WIN_SCALE=87,
 	NET_IPV4_NONLOCAL_BIND=88,
 	NET_IPV4_ICMP_RATELIMIT=89,
-	NET_IPV4_ICMP_RATEMASK=90
+	NET_IPV4_ICMP_RATEMASK=90,
+        NET_IPV4_DEFAULT_BIND=91
 };
 
 enum {
@@ -641,6 +642,8 @@
 			  void *buffer, size_t *lenp);
 
 extern int proc_dostring(ctl_table *, int, struct file *,
+			 void *, size_t *);
+extern int proc_doinaddr(ctl_table *, int, struct file *,
 			 void *, size_t *);
 extern int proc_dointvec(ctl_table *, int, struct file *,
 			 void *, size_t *);
diff -Nur linux/kernel/sysctl.c linux.mjf/kernel/sysctl.c
--- linux/kernel/sysctl.c	Wed Jan 16 22:34:43 2002
+++ linux.mjf/kernel/sysctl.c	Wed Jan 16 22:34:14 2002
@@ -806,6 +806,104 @@
 	return r;
 }
 
+/* parse an ipv4 addr, don't take no crap */
+#include <linux/in.h>
+static int proc_inet_aton (char const *c, int blen, struct in_addr *addr)
+{
+        unsigned int _n[4] = {0};
+        unsigned int *n = _n;
+
+        while (blen && isspace (*c)) {
+                ++c;
+                --blen;
+        }
+        while (blen) {
+                if (!isdigit (*c))
+                        return 1;
+                while (blen && isdigit (*c)) {
+                        *n = *n * 10 + *c++ - '0';
+                        --blen;
+                        if (*n > 255) /* error: stop */
+                                return 1;
+                }
+                if (blen && '.' == *c) {
+                        ++c;
+                        --blen;
+                        if (!blen) /* error: need more digits */
+                                return 1;
+                        if (n == &_n[3]) /* error: don't inc n */
+                                return 1;
+                        ++n;
+                        continue;
+                } else { /* should have been last char */
+                        if (blen && !isspace (*c))
+                                return 1;
+                        else
+                                break;
+                }
+        }
+        if (n != &_n[3])
+                return 1;
+
+        addr->s_addr = htonl (_n[0]<<24 | _n[1]<<16 | _n[2]<<8 | _n[3]);
+        return 0;
+}
+
+
+/**
+ * proc_doinaddr - read an ipv4 dotted-decimal network address
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes a single ip4v network address in dotted-decimal notation.
+ * The user buffer is an ASCII string.
+ *
+ * Returns: -EFAULT on kernel->user I/O error, 0 otherwise.
+ */
+int proc_doinaddr (ctl_table *table, int write, struct file *filp,
+                    void *buffer, size_t *lenp)
+{
+        #define TMPBUFLEN 20
+        char buf[TMPBUFLEN];
+        size_t len;
+
+        if (!table->data || table->maxlen != sizeof (struct in_addr) || !*lenp
+                        || (filp->f_pos && !write)) {
+                *lenp = 0;
+                return 0;
+        }
+
+        if (write) {
+                struct in_addr addr;
+                if (*lenp > TMPBUFLEN - 2)
+                        return 0;
+                len = *lenp;
+                if (copy_from_user (buf, buffer, len))
+                        return -EFAULT;
+                buf[len] = 0;
+                if (! proc_inet_aton (buf, len, &addr))
+                        ((struct in_addr*)table->data)->s_addr = addr.s_addr;
+                filp->f_pos += len;
+        } else {
+                uint32_t addr = ntohl (((struct in_addr*)table->data)->s_addr);
+                len = snprintf (buf, TMPBUFLEN - 2, "%d.%d.%d.%d\n",
+                                (addr >> 24) & 0xff, (addr >> 16) & 0xff,
+                                (addr >> 8) & 0xff, (addr) & 0xff);
+                buf[len] = 0;  /* kernel snprintf never returns -1 */
+                if (len > *lenp)
+                        len = *lenp;
+                if (copy_to_user (buffer, buf, len))
+                        return -EFAULT;
+                *lenp = len;
+                filp->f_pos += len;
+        }
+
+        return 0;
+}
+
 #define OP_SET	0
 #define OP_AND	1
 #define OP_OR	2
diff -Nur linux/net/ipv4/af_inet.c linux.mjf/net/ipv4/af_inet.c
--- linux/net/ipv4/af_inet.c	Wed Jan 16 22:34:43 2002
+++ linux.mjf/net/ipv4/af_inet.c	Thu Jan 17 16:16:03 2002
@@ -469,6 +469,8 @@
 
 /* It is off by default, see below. */
 int sysctl_ip_nonlocal_bind;
+/* Default local address to use. */
+struct in_addr sysctl_ip_default_bind;
 
 static int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
@@ -484,6 +486,11 @@
 
 	if (addr_len < sizeof(struct sockaddr_in))
 		return -EINVAL;
+
+        /* this will catch UDP sockets not bound before connect() */
+	if (addr->sin_addr.s_addr == INADDR_ANY) {
+		addr->sin_addr.s_addr = sysctl_ip_default_bind.s_addr;
+        }
 
 	chk_addr_ret = inet_addr_type(addr->sin_addr.s_addr);
 
diff -Nur linux/net/ipv4/sysctl_net_ipv4.c linux.mjf/net/ipv4/sysctl_net_ipv4.c
--- linux/net/ipv4/sysctl_net_ipv4.c	Fri Nov 23 09:26:31 2001
+++ linux.mjf/net/ipv4/sysctl_net_ipv4.c	Wed Jan 16 20:24:01 2002
@@ -17,6 +17,7 @@
 
 /* From af_inet.c */
 extern int sysctl_ip_nonlocal_bind;
+extern struct in_addr sysctl_ip_default_bind;
 
 /* From icmp.c */
 extern int sysctl_icmp_echo_ignore_all;
@@ -115,6 +116,9 @@
 	{NET_IPV4_NONLOCAL_BIND, "ip_nonlocal_bind",
 	 &sysctl_ip_nonlocal_bind, sizeof(int), 0644, NULL,
 	 &proc_dointvec},
+	{NET_IPV4_DEFAULT_BIND, "ip_default_bind",
+	 &sysctl_ip_default_bind, sizeof(struct in_addr), 0644, NULL,
+	 &proc_doinaddr},
 	{NET_IPV4_TCP_SYN_RETRIES, "tcp_syn_retries",
 	 &sysctl_tcp_syn_retries, sizeof(int), 0644, NULL, &proc_dointvec},
 	{NET_TCP_SYNACK_RETRIES, "tcp_synack_retries",
diff -Nur linux/net/ipv4/tcp_ipv4.c linux.mjf/net/ipv4/tcp_ipv4.c
--- linux/net/ipv4/tcp_ipv4.c	Wed Jan 16 22:34:43 2002
+++ linux.mjf/net/ipv4/tcp_ipv4.c	Thu Jan 17 16:15:58 2002
@@ -643,6 +643,7 @@
 }
 
 /* This will initiate an outgoing connection. */
+extern struct in_addr sysctl_ip_default_bind;
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
@@ -665,6 +666,11 @@
 			return -EINVAL;
 		nexthop = sk->protinfo.af_inet.opt->faddr;
 	}
+
+        /* This will catch TCP sockets not bound before connect */
+        if (sk->saddr == INADDR_ANY) {
+                sk->saddr = sysctl_ip_default_bind.s_addr;
+        }
 
 	tmp = ip_route_connect(&rt, nexthop, sk->saddr,
 			       RT_CONN_FLAGS(sk), sk->bound_dev_if);
