Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270454AbUJUD3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270454AbUJUD3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbUJUD1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:27:53 -0400
Received: from fmr12.intel.com ([134.134.136.15]:41604 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S270454AbUJUDII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:08:08 -0400
Subject: [PATCH 2/5]PNP core handle big IRQ
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-5QUXfd0u/gAA8pEXVSoB"
Message-Id: <1098327562.6132.222.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:59:29 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5QUXfd0u/gAA8pEXVSoB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
In IA64, some PNP devices such as 8250 have big IRQ (>15). This patch
lets the PNP core be able to handle > 15 IRQ.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li@intel.com>

--- 2.6/drivers/pnp/isapnp/core.c.stg2	2004-09-28 10:08:21.790559096
+0800
+++ 2.6/drivers/pnp/isapnp/core.c	2004-09-28 10:11:44.422754320 +0800
@@ -477,12 +477,14 @@ static void __init isapnp_parse_irq_reso
 {
 	unsigned char tmp[3];
 	struct pnp_irq *irq;
+	unsigned long bits;
 
 	isapnp_peek(tmp, size);
 	irq = isapnp_alloc(sizeof(struct pnp_irq));
 	if (!irq)
 		return;
-	irq->map = (tmp[1] << 8) | tmp[0];
+	bits = (tmp[1] << 8) | tmp[0];
+	bitmap_copy(irq->map, &bits, 16);
 	if (size > 2)
 		irq->flags = tmp[2];
 	else
--- 2.6/drivers/pnp/pnpbios/rsparser.c.stg2	2004-09-28
10:08:43.249296872 +0800
+++ 2.6/drivers/pnp/pnpbios/rsparser.c	2004-09-28 10:12:00.196356368
+0800
@@ -285,10 +285,13 @@ static void
 pnpbios_parse_irq_option(unsigned char *p, int size, struct pnp_option
*option)
 {
 	struct pnp_irq * irq;
+	unsigned long bits;
+
 	irq = pnpbios_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
-	irq->map = (p[2] << 8) | p[1];
+	bits = (p[2] << 8) | p[1];
+	bitmap_copy(irq->map, &bits, 16);
 	if (size > 2)
 		irq->flags = p[3];
 	else
--- 2.6/drivers/pnp/interface.c.stg2	2004-09-28 10:08:55.987360392 +0800
+++ 2.6/drivers/pnp/interface.c	2004-09-28 10:12:21.509116336 +0800
@@ -60,8 +60,8 @@ static void pnp_print_irq(pnp_info_buffe
 	int first = 1, i;
 
 	pnp_printf(buffer, "%sirq ", space);
-	for (i = 0; i < 16; i++)
-		if (irq->map & (1<<i)) {
+	for (i = 0; i < PNP_IRQ_NR; i++)
+		if (test_bit(i, irq->map)) {
 			if (!first) {
 				pnp_printf(buffer, ",");
 			} else {
@@ -72,7 +72,7 @@ static void pnp_print_irq(pnp_info_buffe
 			else
 				pnp_printf(buffer, "%i", i);
 		}
-	if (!irq->map)
+	if (bitmap_empty(irq->map, PNP_IRQ_NR))
 		pnp_printf(buffer, "<none>");
 	if (irq->flags & IORESOURCE_IRQ_HIGHEDGE)
 		pnp_printf(buffer, " High-Edge");
--- 2.6/drivers/pnp/manager.c.stg2	2004-09-28 10:09:07.869554024 +0800
+++ 2.6/drivers/pnp/manager.c	2004-09-28 10:12:49.630841184 +0800
@@ -150,13 +150,19 @@ static int pnp_assign_irq(struct pnp_dev
 	*flags |= rule->flags | IORESOURCE_IRQ;
 	*flags &=  ~IORESOURCE_UNSET;
 
-	if (!rule->map) {
+	if (bitmap_empty(rule->map, PNP_IRQ_NR)) {
 		*flags |= IORESOURCE_DISABLED;
 		return 1; /* skip disabled resource requests */
 	}
 
+	/* TBD: need check for >16 IRQ */
+	*start = find_next_bit(rule->map, PNP_IRQ_NR, 16);
+	if (*start < PNP_IRQ_NR) {
+		*end = *start;
+		return 1;
+	}
 	for (i = 0; i < 16; i++) {
-		if(rule->map & (1<<xtab[i])) {
+		if(test_bit(xtab[i], rule->map)) {
 			*start = *end = xtab[i];
 			if(pnp_check_irq(dev, idx))
 				return 1;
--- 2.6/drivers/pnp/quirks.c.stg2	2004-09-28 10:09:21.554473600 +0800
+++ 2.6/drivers/pnp/quirks.c	2004-09-28 10:13:08.710940568 +0800
@@ -63,14 +63,17 @@ static void quirk_awe32_resources(struct
 static void quirk_cmi8330_resources(struct pnp_dev *dev)
 {
 	struct pnp_option *res = dev->dependent;
+	unsigned long tmp;
 
 	for ( ; res ; res = res->next ) {
 
 		struct pnp_irq *irq;
 		struct pnp_dma *dma;
 
-		for( irq = res->irq; irq; irq = irq->next )	// Valid irqs are 5, 7,
10
-			irq->map = 0x04A0;						// 0000 0100 1010 0000
+		for( irq = res->irq; irq; irq = irq->next ) {	// Valid irqs are 5, 7,
10
+			tmp = 0x04A0;
+			bitmap_copy(irq->map, &tmp, 16);	// 0000 0100 1010 0000
+		}
 
 		for( dma = res->dma; dma; dma = dma->next ) // Valid 8bit dma
channels are 1,3
 			if( ( dma->flags & IORESOURCE_DMA_TYPE_MASK ) == IORESOURCE_DMA_8BIT
)
--- 2.6/drivers/pnp/resource.c.stg2	2004-09-28 10:09:40.184641384 +0800
+++ 2.6/drivers/pnp/resource.c	2004-09-28 10:13:27.508082968 +0800
@@ -101,8 +101,8 @@ int pnp_register_irq_resource(struct pnp
 	{
 		int i;
 
-		for (i=0; i<16; i++)
-			if (data->map & (1<<i))
+		for (i = 0; i < 16; i++)
+			if (test_bit(i, data->map))
 				pcibios_penalize_isa_irq(i);
 	}
 #endif
--- 2.6/include/linux/pnp.h.stg2	2004-09-28 10:09:58.139911768 +0800
+++ 2.6/include/linux/pnp.h	2004-09-28 10:13:47.459049960 +0800
@@ -82,8 +82,9 @@ struct pnp_port {
 	struct pnp_port *next;		/* next port */
 };
 
+#define PNP_IRQ_NR 256
 struct pnp_irq {
-	unsigned short map;		/* bitmaks for IRQ lines */
+	DECLARE_BITMAP(map, PNP_IRQ_NR); /* bitmaks for IRQ lines */
 	unsigned char flags;		/* IRQ flags */
 	unsigned char pad;		/* pad */
 	struct pnp_irq *next;		/* next IRQ */


--=-5QUXfd0u/gAA8pEXVSoB
Content-Disposition: attachment; filename=irq256.patch
Content-Type: text/x-patch; name=irq256.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6/drivers/pnp/isapnp/core.c.stg2	2004-09-28 10:08:21.790559096 +0800
+++ 2.6/drivers/pnp/isapnp/core.c	2004-09-28 10:11:44.422754320 +0800
@@ -477,12 +477,14 @@ static void __init isapnp_parse_irq_reso
 {
 	unsigned char tmp[3];
 	struct pnp_irq *irq;
+	unsigned long bits;
 
 	isapnp_peek(tmp, size);
 	irq = isapnp_alloc(sizeof(struct pnp_irq));
 	if (!irq)
 		return;
-	irq->map = (tmp[1] << 8) | tmp[0];
+	bits = (tmp[1] << 8) | tmp[0];
+	bitmap_copy(irq->map, &bits, 16);
 	if (size > 2)
 		irq->flags = tmp[2];
 	else
--- 2.6/drivers/pnp/pnpbios/rsparser.c.stg2	2004-09-28 10:08:43.249296872 +0800
+++ 2.6/drivers/pnp/pnpbios/rsparser.c	2004-09-28 10:12:00.196356368 +0800
@@ -285,10 +285,13 @@ static void
 pnpbios_parse_irq_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_irq * irq;
+	unsigned long bits;
+
 	irq = pnpbios_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
-	irq->map = (p[2] << 8) | p[1];
+	bits = (p[2] << 8) | p[1];
+	bitmap_copy(irq->map, &bits, 16);
 	if (size > 2)
 		irq->flags = p[3];
 	else
--- 2.6/drivers/pnp/interface.c.stg2	2004-09-28 10:08:55.987360392 +0800
+++ 2.6/drivers/pnp/interface.c	2004-09-28 10:12:21.509116336 +0800
@@ -60,8 +60,8 @@ static void pnp_print_irq(pnp_info_buffe
 	int first = 1, i;
 
 	pnp_printf(buffer, "%sirq ", space);
-	for (i = 0; i < 16; i++)
-		if (irq->map & (1<<i)) {
+	for (i = 0; i < PNP_IRQ_NR; i++)
+		if (test_bit(i, irq->map)) {
 			if (!first) {
 				pnp_printf(buffer, ",");
 			} else {
@@ -72,7 +72,7 @@ static void pnp_print_irq(pnp_info_buffe
 			else
 				pnp_printf(buffer, "%i", i);
 		}
-	if (!irq->map)
+	if (bitmap_empty(irq->map, PNP_IRQ_NR))
 		pnp_printf(buffer, "<none>");
 	if (irq->flags & IORESOURCE_IRQ_HIGHEDGE)
 		pnp_printf(buffer, " High-Edge");
--- 2.6/drivers/pnp/manager.c.stg2	2004-09-28 10:09:07.869554024 +0800
+++ 2.6/drivers/pnp/manager.c	2004-09-28 10:12:49.630841184 +0800
@@ -150,13 +150,19 @@ static int pnp_assign_irq(struct pnp_dev
 	*flags |= rule->flags | IORESOURCE_IRQ;
 	*flags &=  ~IORESOURCE_UNSET;
 
-	if (!rule->map) {
+	if (bitmap_empty(rule->map, PNP_IRQ_NR)) {
 		*flags |= IORESOURCE_DISABLED;
 		return 1; /* skip disabled resource requests */
 	}
 
+	/* TBD: need check for >16 IRQ */
+	*start = find_next_bit(rule->map, PNP_IRQ_NR, 16);
+	if (*start < PNP_IRQ_NR) {
+		*end = *start;
+		return 1;
+	}
 	for (i = 0; i < 16; i++) {
-		if(rule->map & (1<<xtab[i])) {
+		if(test_bit(xtab[i], rule->map)) {
 			*start = *end = xtab[i];
 			if(pnp_check_irq(dev, idx))
 				return 1;
--- 2.6/drivers/pnp/quirks.c.stg2	2004-09-28 10:09:21.554473600 +0800
+++ 2.6/drivers/pnp/quirks.c	2004-09-28 10:13:08.710940568 +0800
@@ -63,14 +63,17 @@ static void quirk_awe32_resources(struct
 static void quirk_cmi8330_resources(struct pnp_dev *dev)
 {
 	struct pnp_option *res = dev->dependent;
+	unsigned long tmp;
 
 	for ( ; res ; res = res->next ) {
 
 		struct pnp_irq *irq;
 		struct pnp_dma *dma;
 
-		for( irq = res->irq; irq; irq = irq->next )	// Valid irqs are 5, 7, 10
-			irq->map = 0x04A0;						// 0000 0100 1010 0000
+		for( irq = res->irq; irq; irq = irq->next ) {	// Valid irqs are 5, 7, 10
+			tmp = 0x04A0;
+			bitmap_copy(irq->map, &tmp, 16);	// 0000 0100 1010 0000
+		}
 
 		for( dma = res->dma; dma; dma = dma->next ) // Valid 8bit dma channels are 1,3
 			if( ( dma->flags & IORESOURCE_DMA_TYPE_MASK ) == IORESOURCE_DMA_8BIT )
--- 2.6/drivers/pnp/resource.c.stg2	2004-09-28 10:09:40.184641384 +0800
+++ 2.6/drivers/pnp/resource.c	2004-09-28 10:13:27.508082968 +0800
@@ -101,8 +101,8 @@ int pnp_register_irq_resource(struct pnp
 	{
 		int i;
 
-		for (i=0; i<16; i++)
-			if (data->map & (1<<i))
+		for (i = 0; i < 16; i++)
+			if (test_bit(i, data->map))
 				pcibios_penalize_isa_irq(i);
 	}
 #endif
--- 2.6/include/linux/pnp.h.stg2	2004-09-28 10:09:58.139911768 +0800
+++ 2.6/include/linux/pnp.h	2004-09-28 10:13:47.459049960 +0800
@@ -82,8 +82,9 @@ struct pnp_port {
 	struct pnp_port *next;		/* next port */
 };
 
+#define PNP_IRQ_NR 256
 struct pnp_irq {
-	unsigned short map;		/* bitmaks for IRQ lines */
+	DECLARE_BITMAP(map, PNP_IRQ_NR); /* bitmaks for IRQ lines */
 	unsigned char flags;		/* IRQ flags */
 	unsigned char pad;		/* pad */
 	struct pnp_irq *next;		/* next IRQ */

--=-5QUXfd0u/gAA8pEXVSoB--

