Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUDAMKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUDAMKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:10:42 -0500
Received: from raven.ecs.soton.ac.uk ([152.78.70.1]:64138 "EHLO
	raven.ecs.soton.ac.uk") by vger.kernel.org with ESMTP
	id S262879AbUDAMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:10:36 -0500
Date: Thu, 1 Apr 2004 13:10:31 +0100
From: Hugo Mills <hugo@soton.ac.uk>
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Cc: hugo-lkml@carfax.org.uk
Subject: [PATCH] RFC3514 packet filtering (part 2)
Message-ID: <20040401121031.GC30129@soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-MailScanner-Information: Please contact helpdesk@ecs.soton.ac.uk for more information
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   This patch provides an RFC3514 filter for iptables. This is the
iptables (userspace) half of the patch, against iptables 1.2.9.

   Please cc: replies to me -- I'm having some trouble subscribing to
linux-kernel at the moment.

   Hugo.

diff -uNr iptables-1.2.9-orig/extensions/Makefile iptables-1.2.9/extensions/Makefile
--- iptables-1.2.9-orig/extensions/Makefile	2003-10-16 07:34:36.000000000 +0000
+++ iptables-1.2.9/extensions/Makefile	2004-03-15 21:32:06.621849218 +0000
@@ -5,7 +5,7 @@
 # header files are present in the include/linux directory of this iptables
 # package (HW)
 #
-PF_EXT_SLIB:=ah connlimit connmark conntrack dscp ecn esp helper icmp iprange length limit mac mark multiport owner physdev pkttype realm rpc standard state tcp tcpmss tos ttl udp unclean CLASSIFY CONNMARK DNAT DSCP ECN LOG MARK MASQUERADE MIRROR NETMAP NOTRACK REDIRECT REJECT SAME SNAT TARPIT TCPMSS TOS TRACE TTL ULOG
+PF_EXT_SLIB:=ah connlimit connmark conntrack dscp ecn esp evil helper icmp iprange length limit mac mark multiport owner physdev pkttype realm rpc standard state tcp tcpmss tos ttl udp unclean CLASSIFY CONNMARK DNAT DSCP ECN LOG MARK MASQUERADE MIRROR NETMAP NOTRACK REDIRECT REJECT SAME SNAT TARPIT TCPMSS TOS TRACE TTL ULOG
 PF6_EXT_SLIB:=eui64 hl icmpv6 length limit mac mark multiport owner standard tcp udp HL LOG MARK TRACE
 
 # Optionals
diff -uNr iptables-1.2.9-orig/extensions/libipt_evil.c iptables-1.2.9/extensions/libipt_evil.c
--- iptables-1.2.9-orig/extensions/libipt_evil.c	1970-01-01 00:00:00.000000000 +0000
+++ iptables-1.2.9/extensions/libipt_evil.c	2004-03-15 21:31:43.009653419 +0000
@@ -0,0 +1,103 @@
+/* 
+ * Shared library add-on to iptables to match 
+ * packets by the "evil" bit
+ *
+ * Hugo Mills <hugo@carfax.org.uk>
+ */
+#include <stdio.h>
+#include <netdb.h>
+#include <string.h>
+#include <stdlib.h>
+#include <getopt.h>
+#if defined(__GLIBC__) && __GLIBC__ == 2
+#include <net/ethernet.h>
+#else
+#include <linux/if_ether.h>
+#endif
+#include <iptables.h>
+#include <linux/if_packet.h>
+#include <linux/netfilter_ipv4/ipt_evil.h>
+
+#define	EVIL_VERSION	"0.1"
+
+/* Function which prints out usage message. */
+static void help(void)
+{
+	printf(
+"evil v%s options:"
+"\n", EVIL_VERSION);
+}
+
+static struct option opts[] = {
+	{0}
+};
+
+static void init(struct ipt_entry_match *m, unsigned int *nfcache)
+{
+	*nfcache |= NFC_UNKNOWN;
+}
+
+static int parse(int c, char **argv, int invert, unsigned int *flags,
+      const struct ipt_entry *entry,
+      unsigned int *nfcache,
+      struct ipt_entry_match **match)
+{
+	struct ipt_evil_info *info = (struct ipt_evil_info *)(*match)->data;
+	
+	switch(c)
+	{
+		case '1':
+/*
+			check_inverse(optarg, &invert, &optind, 0);
+			parse_evil(argv[optind-1], info);
+			if(invert)
+				info->invert=1;
+*/
+			*flags=1;
+			break;
+
+		default: 
+			return 0;
+	}
+
+	return 1;
+}
+
+static void final_check(unsigned int flags)
+{
+}
+
+static void print(const struct ipt_ip *ip, const struct ipt_entry_match *match, int numeric)
+{
+	struct ipt_evil_info *info = (struct ipt_evil_info *)match->data;
+	
+	printf("%sEVIL", info->invert?"!":"");
+}
+
+static void save(const struct ipt_ip *ip, const struct ipt_entry_match *match)
+{
+	struct ipt_evil_info *info = (struct ipt_evil_info *)match->data;
+	
+	printf("%s", info->invert?"! ":"");
+}
+
+static
+struct iptables_match evil = {
+    NULL,
+    "evil",
+    IPTABLES_VERSION,
+    IPT_ALIGN(sizeof(struct ipt_evil_info)),
+    IPT_ALIGN(sizeof(struct ipt_evil_info)),
+    &help,
+    &init,
+    &parse, 
+    &final_check, 
+    &print,
+    &save, 
+    opts
+};
+
+void _init(void)
+{
+	register_match(&evil);
+}


-- 
 --- Hugo Mills - <hugo@soton.ac.uk> - ECS at Southampton University --- 
          --- Comb-e-chem project: http://www.combechem.org/ ---         
              Quantum Mechanics: The dreams stuff is made of             
