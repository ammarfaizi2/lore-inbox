Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVJaDrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVJaDrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVJaDrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:47:09 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:33030 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751312AbVJaDqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:50 -0500
Message-Id: <200510310439.j9V4dNkn000844@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 3/10] UML - Fix UML network driver endianness bugs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

ifa->ifa_address and ifa->ifa_mask are defined as __u32,
but used as if they were char[4].
Network code uses htons() to convert it.
So UML's method to access these fields is wrong for bigendians
(e.g. s390)
I replaced bytewise copying by memcpy(), maybe even that might
be removed, if ifa->ifa_address/mask may be used immediately.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/drivers/net_kern.c~fix-net-ordering arch/um/drivers/net_kern.c
--- linux-2.6.13-rc5/arch/um/drivers/net_kern.c~fix-net-ordering	2005-08-10 14:57:13.296403116 +0200
+++ linux-2.6.13-rc5-root/arch/um/drivers/net_kern.c	2005-08-10 14:57:13.303400833 +0200
@@ -95,7 +95,6 @@ irqreturn_t uml_net_interrupt(int irq, v
 static int uml_net_open(struct net_device *dev)
 {
 	struct uml_net_private *lp = dev->priv;
-	char addr[sizeof("255.255.255.255\0")];
 	int err;
 
 	spin_lock(&lp->lock);
@@ -106,7 +105,7 @@ static int uml_net_open(struct net_devic
 	}
 
 	if(!lp->have_mac){
- 		dev_ip_addr(dev, addr, &lp->mac[2]);
+ 		dev_ip_addr(dev, &lp->mac[2]);
  		set_ether_mac(dev, lp->mac);
 	}
 
@@ -663,8 +662,6 @@ static int uml_inetaddr_event(struct not
 			      void *ptr)
 {
 	struct in_ifaddr *ifa = ptr;
-	u32 addr = ifa->ifa_address;
-	u32 netmask = ifa->ifa_mask;
 	struct net_device *dev = ifa->ifa_dev->dev;
 	struct uml_net_private *lp;
 	void (*proc)(unsigned char *, unsigned char *, void *);
@@ -684,14 +681,8 @@ static int uml_inetaddr_event(struct not
 		break;
 	}
 	if(proc != NULL){
-		addr_buf[0] = addr & 0xff;
-		addr_buf[1] = (addr >> 8) & 0xff;
-		addr_buf[2] = (addr >> 16) & 0xff;
-		addr_buf[3] = addr >> 24;
-		netmask_buf[0] = netmask & 0xff;
-		netmask_buf[1] = (netmask >> 8) & 0xff;
-		netmask_buf[2] = (netmask >> 16) & 0xff;
-		netmask_buf[3] = netmask >> 24;
+		memcpy(addr_buf, &ifa->ifa_address, sizeof(addr_buf));
+		memcpy(netmask_buf, &ifa->ifa_mask, sizeof(netmask_buf));
 		(*proc)(addr_buf, netmask_buf, &lp->user);
 	}
 	return(NOTIFY_DONE);
@@ -773,27 +764,18 @@ int setup_etheraddr(char *str, unsigned 
 	return(1);
 }
 
-void dev_ip_addr(void *d, char *buf, char *bin_buf)
+void dev_ip_addr(void *d, unsigned char *bin_buf)
 {
 	struct net_device *dev = d;
 	struct in_device *ip = dev->ip_ptr;
 	struct in_ifaddr *in;
-	u32 addr;
 
 	if((ip == NULL) || ((in = ip->ifa_list) == NULL)){
 		printk(KERN_WARNING "dev_ip_addr - device not assigned an "
 		       "IP address\n");
 		return;
 	}
-	addr = in->ifa_address;
-	sprintf(buf, "%d.%d.%d.%d", addr & 0xff, (addr >> 8) & 0xff, 
-		(addr >> 16) & 0xff, addr >> 24);
-	if(bin_buf){
-		bin_buf[0] = addr & 0xff;
-		bin_buf[1] = (addr >> 8) & 0xff;
-		bin_buf[2] = (addr >> 16) & 0xff;
-		bin_buf[3] = addr >> 24;
-	}
+	memcpy(bin_buf, &in->ifa_address, sizeof(in->ifa_address));
 }
 
 void set_ether_mac(void *d, unsigned char *addr)
@@ -828,14 +810,8 @@ void iter_addresses(void *d, void (*cb)(
 	if(ip == NULL) return;
 	in = ip->ifa_list;
 	while(in != NULL){
-		address[0] = in->ifa_address & 0xff;
-		address[1] = (in->ifa_address >> 8) & 0xff;
-		address[2] = (in->ifa_address >> 16) & 0xff;
-		address[3] = in->ifa_address >> 24;
-		netmask[0] = in->ifa_mask & 0xff;
-		netmask[1] = (in->ifa_mask >> 8) & 0xff;
-		netmask[2] = (in->ifa_mask >> 16) & 0xff;
-		netmask[3] = in->ifa_mask >> 24;
+		memcpy(address, &in->ifa_address, sizeof(address));
+		memcpy(netmask, &in->ifa_mask, sizeof(netmask));
 		(*cb)(address, netmask, arg);
 		in = in->ifa_next;
 	}
diff -puN arch/um/include/net_user.h~fix-net-ordering arch/um/include/net_user.h
--- linux-2.6.13-rc5/arch/um/include/net_user.h~fix-net-ordering	2005-08-10 14:57:13.299402138 +0200
+++ linux-2.6.13-rc5-root/arch/um/include/net_user.h	2005-08-10 14:57:13.304400507 +0200
@@ -25,7 +25,7 @@ struct net_user_info {
 };
 
 extern void ether_user_init(void *data, void *dev);
-extern void dev_ip_addr(void *d, char *buf, char *bin_buf);
+extern void dev_ip_addr(void *d, unsigned char *bin_buf);
 extern void set_ether_mac(void *d, unsigned char *addr);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *, 
 					       unsigned char *, void *), 
_

