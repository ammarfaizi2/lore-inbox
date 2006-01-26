Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWAZWxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWAZWxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWAZWxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:53:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1543 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751353AbWAZWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:53:44 -0500
Date: Thu, 26 Jan 2006 23:53:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       perex@suse.cz, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [6/10] remove ISA legacy functions: drivers/net/hp100.c
Message-ID: <20060126225342.GK3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

hp100 has ->mem_ptr_virt set for all memory-mapped cases; removed
rudiment of old version that used ioremap() only when physical
address wasn't an ISA one.  These days it's simply a dead code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/hp100.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

c9a2c709fa782a0dd7b1bbb0160b325e446ae523
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -1718,17 +1718,10 @@ static int hp100_start_xmit(struct sk_bu
 	hp100_outw(i, FRAGMENT_LEN);	/* and first/only fragment length    */
 
 	if (lp->mode == 2) {	/* memory mapped */
-		if (lp->mem_ptr_virt) {	/* high pci memory was remapped */
-			/* Note: The J2585B needs alignment to 32bits here!  */
-			memcpy_toio(lp->mem_ptr_virt, skb->data, (skb->len + 3) & ~3);
-			if (!ok_flag)
-				memset_io(lp->mem_ptr_virt, 0, HP100_MIN_PACKET_SIZE - skb->len);
-		} else {
-			/* Note: The J2585B needs alignment to 32bits here!  */
-			isa_memcpy_toio(lp->mem_ptr_phys, skb->data, (skb->len + 3) & ~3);
-			if (!ok_flag)
-				isa_memset_io(lp->mem_ptr_phys, 0, HP100_MIN_PACKET_SIZE - skb->len);
-		}
+		/* Note: The J2585B needs alignment to 32bits here!  */
+		memcpy_toio(lp->mem_ptr_virt, skb->data, (skb->len + 3) & ~3);
+		if (!ok_flag)
+			memset_io(lp->mem_ptr_virt, 0, HP100_MIN_PACKET_SIZE - skb->len);
 	} else {		/* programmed i/o */
 		outsl(ioaddr + HP100_REG_DATA32, skb->data,
 		      (skb->len + 3) >> 2);
@@ -1798,10 +1791,7 @@ static void hp100_rx(struct net_device *
 		/* First we get the header, which contains information about the */
 		/* actual length of the received packet. */
 		if (lp->mode == 2) {	/* memory mapped mode */
-			if (lp->mem_ptr_virt)	/* if memory was remapped */
-				header = readl(lp->mem_ptr_virt);
-			else
-				header = isa_readl(lp->mem_ptr_phys);
+			header = readl(lp->mem_ptr_virt);
 		} else		/* programmed i/o */
 			header = hp100_inl(DATA32);
 
@@ -1833,13 +1823,9 @@ static void hp100_rx(struct net_device *
 			ptr = skb->data;
 
 			/* Now transfer the data from the card into that area */
-			if (lp->mode == 2) {
-				if (lp->mem_ptr_virt)
-					memcpy_fromio(ptr, lp->mem_ptr_virt,pkt_len);
-				/* Note alignment to 32bit transfers */
-				else
-					isa_memcpy_fromio(ptr, lp->mem_ptr_phys, pkt_len);
-			} else	/* io mapped */
+			if (lp->mode == 2)
+				memcpy_fromio(ptr, lp->mem_ptr_virt,pkt_len);
+			else	/* io mapped */
 				insl(ioaddr + HP100_REG_DATA32, ptr, pkt_len >> 2);
 
 			skb->protocol = eth_type_trans(skb, dev);

