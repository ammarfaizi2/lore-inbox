Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUA3FNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUA3FNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:13:20 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:51332 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266509AbUA3FMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:12:13 -0500
Date: Thu, 29 Jan 2004 23:57:02 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235702.GD12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some PnPBIOSes do not follow the specifications with regard to disabling
devices.  This patch preserves the tag bits, while zeroing the resource 
settings.  Previously we would zero the entire buffer.  It has been tested and 
appears to correct the issue while remaining compatible with unbroken PnPBIOSes.

--- a/drivers/pnp/pnpbios/core.c	2004-01-23 15:19:25.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2004-01-23 20:00:45.000000000 +0000
@@ -264,19 +264,49 @@
 	return ret;
 }
 
+static void pnpbios_zero_data_stream(struct pnp_bios_node * node)
+{
+	unsigned char * p = (char *)node->data;
+	unsigned char * end = (char *)(node->data + node->size);
+	unsigned int len;
+	int i;
+	while ((char *)p < (char *)end) {
+		if(p[0] & 0x80) { /* large tag */
+			len = (p[2] << 8) | p[1];
+			p += 3;
+		} else {
+			if (((p[0]>>3) & 0x0f) == 0x0f)
+				return;
+			len = p[0] & 0x07;
+			p += 1;
+		}
+		for (i = 0; i < len; i++)
+			p[i] = 0;
+		p += len;
+	}
+	printk(KERN_ERR "PnPBIOS: Resource structure did not contain an end tag.\n");
+}
+
 static int pnpbios_disable_resources(struct pnp_dev *dev)
 {
 	struct pnp_bios_node * node;
+	u8 nodenum = dev->number;
 	int ret;
 
 	/* just in case */
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	/* the value of this will be zero */
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
+
+	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
+		kfree(node);
+		return -ENODEV;
+	}
+	pnpbios_zero_data_stream(node);
+
 	ret = pnp_bios_set_dev_node(dev->number, (char)PNPMODE_DYNAMIC, node);
 	kfree(node);
 	if (ret > 0)
