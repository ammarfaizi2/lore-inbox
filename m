Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSJLBBS>; Fri, 11 Oct 2002 21:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJLBBS>; Fri, 11 Oct 2002 21:01:18 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:3083 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262576AbSJLBBO>; Fri, 11 Oct 2002 21:01:14 -0400
Date: Fri, 11 Oct 2002 22:06:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [ipv4] move proc init to newly created net/ipv4/ip_proc.c
Message-ID: <20021012010649.GB1745@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please consider pulling from:

master.kernel.org:/home/acme/BK/ip-2.5

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.735, 2002-10-11 20:49:08-03:00, acme@conectiva.com.br
  [ipv4] move proc init to newly created net/ipv4/ip_proc.c
  
  This is the start of the seq_file work, so that I can see if anybody
  will cough too much on the choosen path...
  
  Also convert some unneeded __constat_htons to plain htons, that results
  in the same code being generated.


 include/net/ip.h   |    8 +++---
 net/ipv4/Makefile  |    2 -
 net/ipv4/af_inet.c |   20 +--------------
 net/ipv4/ip_proc.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 22 deletions(-)


diff -Nru a/include/net/ip.h b/include/net/ip.h
--- a/include/net/ip.h	Fri Oct 11 21:34:47 2002
+++ b/include/net/ip.h	Fri Oct 11 21:34:47 2002
@@ -174,7 +174,7 @@
 int ip_decrease_ttl(struct iphdr *iph)
 {
 	u32 check = iph->check;
-	check += __constant_htons(0x0100);
+	check += htons(0x0100);
 	iph->check = check + (check>=0xFFFF);
 	return --iph->ttl;
 }
@@ -191,7 +191,7 @@
 
 static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst, struct sock *sk)
 {
-	if (iph->frag_off&__constant_htons(IP_DF)) {
+	if (iph->frag_off & htons(IP_DF)) {
 		/* This is only to work around buggy Windows95/2000
 		 * VJ compression implementations.  If the ID field
 		 * does not change, they drop every other packet in
@@ -205,7 +205,7 @@
 
 static inline void ip_select_ident_more(struct iphdr *iph, struct dst_entry *dst, struct sock *sk, int more)
 {
-	if (iph->frag_off&__constant_htons(IP_DF)) {
+	if (iph->frag_off & htons(IP_DF)) {
 		if (sk && inet_sk(sk)->daddr) {
 			iph->id = htons(inet_sk(sk)->id);
 			inet_sk(sk)->id += 1 + more;
@@ -279,5 +279,7 @@
 			      u16 port, u32 info, u8 *payload);
 extern void	ip_local_error(struct sock *sk, int err, u32 daddr, u16 dport,
 			       u32 info);
+
+extern int ipv4_proc_init(void);
 
 #endif	/* _IP_H */
diff -Nru a/net/ipv4/Makefile b/net/ipv4/Makefile
--- a/net/ipv4/Makefile	Fri Oct 11 21:34:47 2002
+++ b/net/ipv4/Makefile	Fri Oct 11 21:34:47 2002
@@ -4,7 +4,7 @@
 
 obj-y     := utils.o route.o inetpeer.o proc.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
-	     ip_output.o ip_sockglue.o \
+	     ip_output.o ip_sockglue.o ip_proc.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
 	     tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Fri Oct 11 21:34:47 2002
+++ b/net/ipv4/af_inet.c	Fri Oct 11 21:34:47 2002
@@ -82,7 +82,6 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/poll.h>
@@ -124,12 +123,6 @@
 atomic_t inet_sock_nr;
 #endif
 
-extern int raw_get_info(char *, char **, off_t, int);
-extern int snmp_get_info(char *, char **, off_t, int);
-extern int netstat_get_info(char *, char **, off_t, int);
-extern int afinet_get_info(char *, char **, off_t, int);
-extern int tcp_get_info(char *, char **, off_t, int);
-extern int udp_get_info(char *, char **, off_t, int);
 extern void ip_mc_drop_socket(struct sock *sk);
 
 #ifdef CONFIG_DLCI
@@ -1211,17 +1204,8 @@
 	ip_mr_init();
 #endif
 
-	/*
-	 *	Create all the /proc entries.
-	 */
-#ifdef CONFIG_PROC_FS
-	proc_net_create ("raw", 0, raw_get_info);
-	proc_net_create ("netstat", 0, netstat_get_info);
-	proc_net_create ("snmp", 0, snmp_get_info);
-	proc_net_create ("sockstat", 0, afinet_get_info);
-	proc_net_create ("tcp", 0, tcp_get_info);
-	proc_net_create ("udp", 0, udp_get_info);
-#endif		/* CONFIG_PROC_FS */
+	ipv4_proc_init();
 	return 0;
 }
+
 module_init(inet_init);
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/ipv4/ip_proc.c	Fri Oct 11 21:34:47 2002
@@ -0,0 +1,70 @@
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		ipv4 proc support
+ *
+ *		Arnaldo Carvalho de Melo <acme@conectiva.com.br>, 2002/10/10
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License as
+ *		published by the Free Software Foundation; version 2 of the
+ *		License
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+
+extern int raw_get_info(char *, char **, off_t, int);
+extern int snmp_get_info(char *, char **, off_t, int);
+extern int netstat_get_info(char *, char **, off_t, int);
+extern int afinet_get_info(char *, char **, off_t, int);
+extern int tcp_get_info(char *, char **, off_t, int);
+extern int udp_get_info(char *, char **, off_t, int);
+
+#ifdef CONFIG_PROC_FS
+int __init ipv4_proc_init(void)
+{
+	int rc = 0;
+
+	if (!proc_net_create("raw", 0, raw_get_info))
+		goto out_raw;
+
+	if (!proc_net_create("netstat", 0, netstat_get_info))
+		goto out_netstat;
+
+	if (!proc_net_create("snmp", 0, snmp_get_info))
+		goto out_snmp;
+
+	if (!proc_net_create("sockstat", 0, afinet_get_info))
+		goto out_sockstat;
+
+	if (!proc_net_create("tcp", 0, tcp_get_info))
+		goto out_tcp;
+
+	if (!proc_net_create("udp", 0, udp_get_info))
+		goto out_udp;
+out:
+	return rc;
+out_udp:
+	proc_net_remove("tcp");
+out_tcp:
+	proc_net_remove("sockstat");
+out_sockstat:
+	proc_net_remove("snmp");
+out_snmp:
+	proc_net_remove("netstat");
+out_netstat:
+	proc_net_remove("raw");
+out_raw:
+	rc = -ENOMEM;
+	goto out;
+}
+#else /* CONFIG_PROC_FS */
+int __init ipv4_proc_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PROC_FS */

===================================================================


This BitKeeper patch contains the following changesets:
1.735
## Wrapped with gzip_uu ##


begin 664 bkpatch8730
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
=<I'TZ>9_![HRU4U^@+W/T(^&/OD'I86%A)48````
`
end
