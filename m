Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUGNVVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUGNVVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUGNVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:21:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265799AbUGNVTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:19:19 -0400
Date: Wed, 14 Jul 2004 23:19:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: [2.6 patch] netfilter/ip_nat_snmp_basic.c: fix inlines
Message-ID: <20040714211909.GQ7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile net/ipv4/netfilter/ip_nat_snmp_basic.c in 
2.6.8-rc1-mm1 using gcc 3.4 results in the following compile error:

<--  snip  -->

...
  CC      net/ipv4/netfilter/ip_nat_snmp_basic.o
net/ipv4/netfilter/ip_nat_snmp_basic.c: In function `snmp_trap_decode':
net/ipv4/netfilter/ip_nat_snmp_basic.c:612: sorry, unimplemented: 
inlining failed in call to 'mangle_address': function body not available
net/ipv4/netfilter/ip_nat_snmp_basic.c:896: sorry, unimplemented: called from here
make[3]: *** [net/ipv4/netfilter/ip_nat_snmp_basic.o] Error 1

<--  snip  -->

The patch below moves an inlined function above the place where it is 
called the first time.

An alternative approach would be to remove the inline.


diffstat output:
 net/ipv4/netfilter/ip_nat_snmp_basic.c |  142 ++++++++++++-------------
 1 files changed, 71 insertions(+), 71 deletions(-)



Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/net/ipv4/netfilter/ip_nat_snmp_basic.c.old	2004-07-09 02:18:23.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-07-09 02:21:00.000000000 +0200
@@ -862,6 +862,77 @@
 	return 1;
 }
 
+/* 
+ * Fast checksum update for possibly oddly-aligned UDP byte, from the
+ * code example in the draft.
+ */
+static void fast_csum(unsigned char *csum,
+                      const unsigned char *optr,
+                      const unsigned char *nptr,
+                      int odd)
+{
+	long x, old, new;
+	
+	x = csum[0] * 256 + csum[1];
+	
+	x =~ x & 0xFFFF;
+	
+	if (odd) old = optr[0] * 256;
+	else old = optr[0];
+	
+	x -= old & 0xFFFF;
+	if (x <= 0) {
+		x--;
+		x &= 0xFFFF;
+	}
+	
+	if (odd) new = nptr[0] * 256;
+	else new = nptr[0];
+	
+	x += new & 0xFFFF;
+	if (x & 0x10000) {
+		x++;
+		x &= 0xFFFF;
+	}
+	
+	x =~ x & 0xFFFF;
+	csum[0] = x / 256;
+	csum[1] = x & 0xFF;
+}
+
+/* 
+ * Mangle IP address.
+ * 	- begin points to the start of the snmp messgae
+ *      - addr points to the start of the address
+ */
+static inline void mangle_address(unsigned char *begin,
+                                  unsigned char *addr,
+                                  const struct oct1_map *map,
+                                  u_int16_t *check)
+{
+	if (map->from == NOCT1(*addr)) {
+		u_int32_t old;
+		
+		if (debug)
+			memcpy(&old, (unsigned char *)addr, sizeof(old));
+			
+		*addr = map->to;
+		
+		/* Update UDP checksum if being used */
+		if (*check) {
+			unsigned char odd = !((addr - begin) % 2);
+			
+			fast_csum((unsigned char *)check,
+			          &map->from, &map->to, odd);
+			          
+		}
+		
+		if (debug)
+			printk(KERN_DEBUG "bsalg: mapped %u.%u.%u.%u to "
+			       "%u.%u.%u.%u\n", NIPQUAD(old), NIPQUAD(*addr));
+	}
+}
+
 static unsigned char snmp_trap_decode(struct asn1_ctx *ctx,
                                       struct snmp_v1_trap *trap,
                                       const struct oct1_map *map,
@@ -952,77 +1023,6 @@
 	printk("\n");
 }
 
-/* 
- * Fast checksum update for possibly oddly-aligned UDP byte, from the
- * code example in the draft.
- */
-static void fast_csum(unsigned char *csum,
-                      const unsigned char *optr,
-                      const unsigned char *nptr,
-                      int odd)
-{
-	long x, old, new;
-	
-	x = csum[0] * 256 + csum[1];
-	
-	x =~ x & 0xFFFF;
-	
-	if (odd) old = optr[0] * 256;
-	else old = optr[0];
-	
-	x -= old & 0xFFFF;
-	if (x <= 0) {
-		x--;
-		x &= 0xFFFF;
-	}
-	
-	if (odd) new = nptr[0] * 256;
-	else new = nptr[0];
-	
-	x += new & 0xFFFF;
-	if (x & 0x10000) {
-		x++;
-		x &= 0xFFFF;
-	}
-	
-	x =~ x & 0xFFFF;
-	csum[0] = x / 256;
-	csum[1] = x & 0xFF;
-}
-
-/* 
- * Mangle IP address.
- * 	- begin points to the start of the snmp messgae
- *      - addr points to the start of the address
- */
-static inline void mangle_address(unsigned char *begin,
-                                  unsigned char *addr,
-                                  const struct oct1_map *map,
-                                  u_int16_t *check)
-{
-	if (map->from == NOCT1(*addr)) {
-		u_int32_t old;
-		
-		if (debug)
-			memcpy(&old, (unsigned char *)addr, sizeof(old));
-			
-		*addr = map->to;
-		
-		/* Update UDP checksum if being used */
-		if (*check) {
-			unsigned char odd = !((addr - begin) % 2);
-			
-			fast_csum((unsigned char *)check,
-			          &map->from, &map->to, odd);
-			          
-		}
-		
-		if (debug)
-			printk(KERN_DEBUG "bsalg: mapped %u.%u.%u.%u to "
-			       "%u.%u.%u.%u\n", NIPQUAD(old), NIPQUAD(*addr));
-	}
-}
-
 /*
  * Parse and mangle SNMP message according to mapping.
  * (And this is the fucking 'basic' method).

