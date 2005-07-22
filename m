Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVGVFEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVGVFEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVGVFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:04:20 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:39884 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262038AbVGVFEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:04:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ivC6+IOeQ/oIO5N3zULGjs71h7A2onjsN7mPpHCj5ofji4PVXfilibPBxbEjjABnnTqIrHCHLqjKieIfSV5RtUntm5sHSBmyLdh+2gmxfMXT/ylbD2P6r48EuPTqlSrsBv5w2yP+3VEhkN782TbXttBFtrHzQb4WHHoVc+F4yio=
Date: Fri, 22 Jul 2005 08:16:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, pascal.chapperon@wanadoo.fr,
       lars.vahlenberg@mandator.com, jgarzik@pobox.com, changch@sis.com
Subject: Re: sis190 driver
Message-ID: <20050722041641.GB25990@mipter.zuzino.mipt.ru>
References: <20050721230950.GA419@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721230950.GA419@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 01:09:50AM +0200, Francois Romieu wrote:
> No major change from previous version. I'm quietly merging bits from
> the SiS driver that Lars kindly pointed out. The detection of the
> mac address is done differently.
> 
> I'll welcome feedback related to regressions and/or netconsole testing.
> 
> Single file patch:
> http://www.zoreil.com/~romieu/sis190/20050722-2.6.13-rc2-sis190-test.patch

MAINTAINERS chunk isn't -p1 applicable. ;-)

sparse asks whether you have endianness bugs here:
----------------------------------------------------------------------------
   450	static inline void sis190_make_unusable_by_asic(struct RxDesc *desc)
   451	{
   452		desc->PSize = 0x0;
   453	===>	desc->addr = 0xdeadbeef;	<===
   454		desc->size &= cpu_to_le32(RingEnd);
   455		wmb();
   456		desc->status = 0x0;
   457	}

drivers/net/sis190.c:453:13: warning: incorrect type in assignment (different base types)
drivers/net/sis190.c:453:13:    expected restricted unsigned int [assigned] [usertype] addr
drivers/net/sis190.c:453:13:    got unsigned int
----------------------------------------------------------------------------
   544	static int sis190_rx_interrupt(struct net_device *dev,
   545				       struct sis190_private *tp, void __iomem *ioaddr)
   546	{

   554		for (; rx_left > 0; rx_left--, cur_rx++) {
   555			unsigned int entry = cur_rx % NUM_RX_DESC;
   556			struct RxDesc *desc = tp->RxDescRing + entry;
   557			u32 status;
   558	
   559		===>	if (desc->status & OWNbit)	<===
   560				break;

drivers/net/sis190.c:559:20: warning: incompatible types for operation (&)
drivers/net/sis190.c:559:20:    left side has type restricted unsigned int [assigned] [usertype] status
drivers/net/sis190.c:559:20:    right side has type unsigned int [unsigned] enum _DescStatusBit [unsigned] [toplevel] OWNbit
----------------------------------------------------------------------------
Add endian annotations.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-sis190/drivers/net/sis190.c
===================================================================
--- linux-sis190.orig/drivers/net/sis190.c	2005-07-22 07:56:37.000000000 +0400
+++ linux-sis190/drivers/net/sis190.c	2005-07-22 08:03:47.000000000 +0400
@@ -191,17 +191,17 @@ enum sis190_register_content {
 };
 
 struct TxDesc {
-	u32 PSize;
-	u32 status;
-	u32 addr;
-	u32 size;
+	__le32 PSize;
+	__le32 status;
+	__le32 addr;
+	__le32 size;
 };
 
 struct RxDesc {
-	u32 PSize;
-	u32 status;
-	u32 addr;
-	u32 size;
+	__le32 PSize;
+	__le32 status;
+	__le32 addr;
+	__le32 size;
 };
 
 enum _DescStatusBit {
@@ -1322,7 +1322,7 @@ static int __devinit sis190_get_mac_addr
 
 	/* Get MAC address from EEPROM */
 	for (i = 0; i < MAC_ADDR_LEN / 2; i++) {
-		u16 w = sis190_read_eeprom(ioaddr, EEPROMMACAddr + i);
+		__le16 w = sis190_read_eeprom(ioaddr, EEPROMMACAddr + i);
 
 		((u16 *)dev->dev_addr)[0] = le16_to_cpu(w);
 	}

