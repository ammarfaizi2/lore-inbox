Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUG2VXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUG2VXC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2VXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:23:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59364 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265661AbUG2VU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:20:56 -0400
Date: Thu, 29 Jul 2004 23:20:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Morris <jmorris@intercode.com.au>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: [2.6 patch] netfilter/ip_nat_snmp_basic.c: fix inlines (fwd)
Message-ID: <20040729212048.GD23589@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 14 Jul 2004 23:19:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: [2.6 patch] netfilter/ip_nat_snmp_basic.c: fix inlines

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

