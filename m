Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSJWTPD>; Wed, 23 Oct 2002 15:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265161AbSJWTPD>; Wed, 23 Oct 2002 15:15:03 -0400
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:40846 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265154AbSJWTPB>;
	Wed, 23 Oct 2002 15:15:01 -0400
Date: Wed, 23 Oct 2002 15:24:03 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PnPBIOS changes - 2.5.44 (2/4)
Message-ID: <20021023152403.GD10638@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible PnP ID support to the PnPBIOS protocol.  None of my 
test systems take advantage of this feature but it is included in the 
specifications so it makes sense to support it.  If anyone does get a compatible 
ID listed for the PnPBIOS I'd be interested to hear about it (if more than 1 id 
is listed when viewing the driverfs file 'id' within the PnPBIOS protocol).  Also
it fixes the dma and mem resource problem.

Applies against 2.5.44 and the pnp fix patch.

Thanks,
Adam




diff -ur a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sat Oct 19 04:01:08 2002
+++ b/drivers/pnp/pnpbios/core.c	Mon Oct 21 16:51:32 2002
@@ -680,7 +680,7 @@
 
 static void add_dmaresource(struct pnp_dev *dev, int dma)
 {
-	int i = 8;
+	int i = 0;
 	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
 	if (i < DEVICE_COUNT_DMA) {
 		dev->dma_resource[i].start = (unsigned long) dma;
@@ -701,7 +701,7 @@
 
 static void add_memresource(struct pnp_dev *dev, int mem, int len)
 {
-	int i = 0;
+	int i = 8;
 	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
 		dev->resource[i].start = (unsigned long) mem;
@@ -816,6 +816,7 @@
         } /* while */
 	end:
 	if ((dev->resource[0].start == 0) &&
+	    (dev->resource[8].start == 0) &&
 	    (dev->irq_resource[0].start == -1) &&
 	    (dev->dma_resource[0].start == -1))
 		dev->active = 0;
@@ -927,7 +928,6 @@
 
 static unsigned char *node_possible_resource_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
 {
-	unsigned char *lastp = NULL;
 	int len, depnum, dependent;
 
 	if ((char *)p == NULL)
@@ -963,8 +963,7 @@
 				break;
 			}
 			} /* switch */
-                        lastp = p+3;
-                        p = p + p[1] + p[2]*256 + 3;
+                        p += len + 3;
                         continue;
                 }
 		len = p[0] & 0x07;
@@ -1030,6 +1029,70 @@
         return NULL;
 }
 
+/* pnp EISA ids */
+
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+//
+
+static void inline pnpid32_to_pnpid(u32 id, char *str)
+{
+	const char *hex = "0123456789abcdef";
+
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+
+	return;
+}
+//
+#undef CHAR
+#undef HEX
+
+static void node_id_data_to_dev(unsigned char *p, struct pnp_bios_node *node, struct pnp_dev *dev)
+{
+	int len;
+	struct pnp_id *dev_id;
+
+	if ((char *)p == NULL)
+		return;
+        while ( (char *)p < ((char *)node->data + node->size )) {
+
+                if( p[0] & 0x80 ) {// large item
+			len = (p[2] << 8) | p[1];
+                        p += len + 3;
+                        continue;
+                }
+		len = p[0] & 0x07;
+                switch ((p[0]>>3) & 0x0f) {
+		case 0x0f:
+		{
+        		return;
+			break;
+		}
+                case 0x03: // compatible ID
+                {
+			if (len != 4)
+				goto __skip;
+			dev_id =  pnpbios_kmalloc(sizeof (struct pnp_id), GFP_KERNEL);
+			if (!dev_id)
+				return;
+			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,dev_id->id);
+			pnp_add_id(dev_id, dev);
+			break;
+                }
+                } /* switch */
+		__skip:
+                p += len + 1;
+
+        } /* while */
+}
 
 /* pnp resource writing functions */
 
@@ -1314,31 +1377,6 @@
 	return 0;
 }
 
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
-//
-
-static void inline pnpid32_to_pnpid(u32 id, char *str)
-{
-	const char *hex = "0123456789abcdef";
-
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-
-	return;
-}
-//
-#undef CHAR
-#undef HEX
-
-
 static void __init build_devlist(void)
 {
 	u8 nodenum;
@@ -1386,7 +1424,8 @@
 		memcpy(dev_id->id,id,8);
 		pnp_add_id(dev_id, dev);
 		pos = node_current_resource_data_to_dev(node,dev);
-		node_possible_resource_data_to_dev(pos,node,dev);
+		pos = node_possible_resource_data_to_dev(pos,node,dev);
+		node_id_data_to_dev(pos,node,dev);
 
 		dev->protocol = &pnpbios_protocol;
 
