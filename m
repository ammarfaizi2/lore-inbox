Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWI0R75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWI0R75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWI0R7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:59:38 -0400
Received: from [198.99.130.12] ([198.99.130.12]:50355 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030513AbWI0R7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:59:33 -0400
Message-Id: <200609271757.k8RHvqnk005732@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/5] UML - Mechanical tidying after random MACs change
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Sep 2006 13:57:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mechanical, hopefully non-functional changes stemming from
setup_etheraddr always succeeding now that it always assigns a MAC,
either from the command line or generated randomly:
   the test of the return of setup_etheraddr is removed, and code
dependent on it succeeding is now unconditional
   setup_etheraddr can now be made void
   struct uml_net.have_mac is now always 1, so tests of it can be
similarly removed, and uses of it can be replaced with 1
   struct uml_net.have_mac is no longer used, so it can be removed
   struct uml_net_private.have_mac is copied from struct uml_net, so
it is always 1
   tests of uml_net_private.have_mac can be removed
   uml_net_private.have_mac can now be removed
   the only call to dev_ip_addr was removed, so it can be deleted

It also turns out that setup_etheraddr is called only once, from the
same file, so it can be static and its declaration removed from
net_kern.h.

Similarly, set_ether_mac is defined and called only from one file.

Finally, setup_etheraddr and set_ether_mac were moved to avoid
needing forward declarations.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/net_kern.c |  105 +++++++++++++++++----------------------------
 arch/um/include/net_kern.h |   14 ------
 arch/um/include/net_user.h |    1 
 3 files changed, 40 insertions(+), 80 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-09-22 10:19:26.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-09-22 10:33:33.000000000 -0400
@@ -118,11 +118,6 @@ static int uml_net_open(struct net_devic
 		goto out;
 	}
 
-	if(!lp->have_mac){
- 		dev_ip_addr(dev, &lp->mac[2]);
- 		set_ether_mac(dev, lp->mac);
-	}
-
 	lp->fd = (*lp->open)(&lp->user);
 	if(lp->fd < 0){
 		err = lp->fd;
@@ -286,6 +281,39 @@ void uml_net_user_timer_expire(unsigned 
 #endif
 }
 
+static void setup_etheraddr(char *str, unsigned char *addr)
+{
+	char *end;
+	int i;
+
+	if(str == NULL)
+		goto random;
+
+	for(i=0;i<6;i++){
+		addr[i] = simple_strtoul(str, &end, 16);
+		if((end == str) ||
+		   ((*end != ':') && (*end != ',') && (*end != '\0'))){
+			printk(KERN_ERR
+			       "setup_etheraddr: failed to parse '%s' "
+			       "as an ethernet address\n", str);
+			goto random;
+		}
+		str = end + 1;
+	}
+	if(addr[0] & 1){
+		printk(KERN_ERR
+		       "Attempt to assign a broadcast ethernet address to a "
+		       "device disallowed\n");
+		goto random;
+	}
+	return;
+
+random:
+	addr[0] = 0xfe;
+	addr[1] = 0xfd;
+	random_mac(addr);
+}
+
 static DEFINE_SPINLOCK(devices_lock);
 static LIST_HEAD(devices);
 
@@ -321,15 +349,13 @@ static int eth_configure(int n, void *in
 	list_add(&device->list, &devices);
 	spin_unlock(&devices_lock);
 
-	if (setup_etheraddr(mac, device->mac))
-		device->have_mac = 1;
+	setup_etheraddr(mac, device->mac);
 
 	printk(KERN_INFO "Netdevice %d ", n);
-	if (device->have_mac)
-		printk("(%02x:%02x:%02x:%02x:%02x:%02x) ",
-		       device->mac[0], device->mac[1],
-		       device->mac[2], device->mac[3],
-		       device->mac[4], device->mac[5]);
+	printk("(%02x:%02x:%02x:%02x:%02x:%02x) ",
+	       device->mac[0], device->mac[1],
+	       device->mac[2], device->mac[3],
+	       device->mac[4], device->mac[5]);
 	printk(": ");
 	dev = alloc_etherdev(size);
 	if (dev == NULL) {
@@ -395,7 +421,6 @@ static int eth_configure(int n, void *in
 		  .dev 			= dev,
 		  .fd 			= -1,
 		  .mac 			= { 0xfe, 0xfd, 0x0, 0x0, 0x0, 0x0},
-		  .have_mac 		= device->have_mac,
 		  .protocol 		= transport->kern->protocol,
 		  .open 		= transport->user->open,
 		  .close 		= transport->user->close,
@@ -410,14 +435,12 @@ static int eth_configure(int n, void *in
 	init_timer(&lp->tl);
 	spin_lock_init(&lp->lock);
 	lp->tl.function = uml_net_user_timer_expire;
-	if (lp->have_mac)
-		memcpy(lp->mac, device->mac, sizeof(lp->mac));
+	memcpy(lp->mac, device->mac, sizeof(lp->mac));
 
 	if (transport->user->init) 
 		(*transport->user->init)(&lp->user, dev);
 
-	if (device->have_mac)
-		set_ether_mac(dev, device->mac);
+	set_ether_mac(dev, device->mac);
 
 	return 0;
 }
@@ -746,54 +769,6 @@ static void close_devices(void)
 
 __uml_exitcall(close_devices);
 
-int setup_etheraddr(char *str, unsigned char *addr)
-{
-	char *end;
-	int i;
-
-	if(str == NULL)
-		goto random;
-
-	for(i=0;i<6;i++){
-		addr[i] = simple_strtoul(str, &end, 16);
-		if((end == str) ||
-		   ((*end != ':') && (*end != ',') && (*end != '\0'))){
-			printk(KERN_ERR 
-			       "setup_etheraddr: failed to parse '%s' "
-			       "as an ethernet address\n", str);
-			goto random;
-		}
-		str = end + 1;
-	}
-	if(addr[0] & 1){
-		printk(KERN_ERR 
-		       "Attempt to assign a broadcast ethernet address to a "
-		       "device disallowed\n");
-		goto random;
-	}
-	return 1;
-
-random:
-	addr[0] = 0xfe;
-	addr[1] = 0xfd;
-	random_mac(addr);
-	return 1;
-}
-
-void dev_ip_addr(void *d, unsigned char *bin_buf)
-{
-	struct net_device *dev = d;
-	struct in_device *ip = dev->ip_ptr;
-	struct in_ifaddr *in;
-
-	if((ip == NULL) || ((in = ip->ifa_list) == NULL)){
-		printk(KERN_WARNING "dev_ip_addr - device not assigned an "
-		       "IP address\n");
-		return;
-	}
-	memcpy(bin_buf, &in->ifa_address, sizeof(in->ifa_address));
-}
-
 struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra)
 {
 	if((skb != NULL) && (skb_tailroom(skb) < extra)){
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-09-22 09:19:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-09-22 10:22:59.000000000 -0400
@@ -18,7 +18,6 @@ struct uml_net {
 	struct platform_device pdev;
 	int index;
 	unsigned char mac[ETH_ALEN];
-	int have_mac;
 };
 
 struct uml_net_private {
@@ -29,7 +28,6 @@ struct uml_net_private {
 	struct net_device_stats stats;
 	int fd;
 	unsigned char mac[ETH_ALEN];
-	int have_mac;
 	unsigned short (*protocol)(struct sk_buff *);
 	int (*open)(void *);
 	void (*close)(int, void *);
@@ -62,7 +60,6 @@ struct transport {
 
 extern struct net_device *ether_init(int);
 extern unsigned short ether_protocol(struct sk_buff *);
-extern int setup_etheraddr(char *str, unsigned char *addr);
 extern struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra);
 extern int tap_setup_common(char *str, char *type, char **dev_name, 
 			    char **mac_out, char **gate_addr);
@@ -70,14 +67,3 @@ extern void register_transport(struct tr
 extern unsigned short eth_protocol(struct sk_buff *skb);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/include/net_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_user.h	2006-09-22 10:20:11.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/net_user.h	2006-09-22 10:34:01.000000000 -0400
@@ -25,7 +25,6 @@ struct net_user_info {
 };
 
 extern void ether_user_init(void *data, void *dev);
-extern void dev_ip_addr(void *d, unsigned char *bin_buf);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *,
 					       unsigned char *, void *),
 			   void *arg);

