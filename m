Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWAZWv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWAZWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWAZWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:51:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64774 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964971AbWAZWv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:51:58 -0500
Date: Thu, 26 Jan 2006 23:51:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [5/10] remove ISA legacy functions: drivers/net/hp-plus.c
Message-ID: <20060126225155.GI3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

switch to ioremap()

Adrian Bunk:
The order of the hunks in the patch was slightly rearranged due to an 
unrelated change in the driver.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/hp-plus.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

202702a915ccef02d54b57e39a4545e4f310ac76
diff --git a/drivers/net/hp-plus.c b/drivers/net/hp-plus.c
--- a/drivers/net/hp-plus.c
+++ b/drivers/net/hp-plus.c
@@ -256,6 +257,12 @@ static int __init hpp_probe1(struct net_
 		ei_status.block_output = &hpp_mem_block_output;
 		ei_status.get_8390_hdr = &hpp_mem_get_8390_hdr;
 		dev->mem_start = mem_start;
+		ei_status.mem = ioremap(mem_start,
+					(HP_STOP_PG - HP_START_PG)*256);
+		if (!ei_status.mem) {
+			retval = -ENOMEM;
+			goto out;
+		}
 		ei_status.rmem_start = dev->mem_start + TX_PAGES/2*256;
 		dev->mem_end = ei_status.rmem_end
 			= dev->mem_start + (HP_STOP_PG - HP_START_PG)*256;
@@ -268,8 +275,10 @@ static int __init hpp_probe1(struct net_
 
 	retval = register_netdev(dev);
 	if (retval)
-		goto out;
+		goto out1;
 	return 0;
+out1:
+	iounmap(ei_status.mem);
 out:
 	release_region(ioaddr, HP_IO_EXTENT);
 	return retval;
@@ -378,7 +387,7 @@ hpp_mem_get_8390_hdr(struct net_device *
 
 	outw((ring_page<<8), ioaddr + HPP_IN_ADDR);
 	outw(option_reg & ~(MemDisable + BootROMEnb), ioaddr + HPP_OPTION);
-	isa_memcpy_fromio(hdr, dev->mem_start, sizeof(struct e8390_pkt_hdr));
+	memcpy_fromio(hdr, ei_status.mem, sizeof(struct e8390_pkt_hdr));
 	outw(option_reg, ioaddr + HPP_OPTION);
 	hdr->count = (le16_to_cpu(hdr->count) + 3) & ~3;	/* Round up allocation. */
 }
@@ -397,7 +406,7 @@ hpp_mem_block_input(struct net_device *d
 	   Also note that we *can't* use eth_io_copy_and_sum() because
 	   it will not always copy "count" bytes (e.g. padded IP).  */
 
-	isa_memcpy_fromio(skb->data, dev->mem_start, count);
+	memcpy_fromio(skb->data, ei_status.mem, count);
 	outw(option_reg, ioaddr + HPP_OPTION);
 }
 
@@ -422,7 +431,7 @@ hpp_mem_block_output(struct net_device *
 
 	outw(start_page << 8, ioaddr + HPP_OUT_ADDR);
 	outw(option_reg & ~(MemDisable + BootROMEnb), ioaddr + HPP_OPTION);
-	isa_memcpy_toio(dev->mem_start, buf, (count + 3) & ~3);
+	memcpy_toio(ei_status.mem, buf, (count + 3) & ~3);
 	outw(option_reg, ioaddr + HPP_OPTION);
 
 	return;
@@ -541,6 +541,7 @@ static int __init do_hpp_probe(struct ne
 static void cleanup_card(struct net_device *dev)
 {
 	/* NB: hpp_close() handles free_irq */
+	iounmap(ei_status.mem);
 	release_region(dev->base_addr - NIC_OFFSET, HP_IO_EXTENT);
 }
 
