Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132239AbRCYWnJ>; Sun, 25 Mar 2001 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132240AbRCYWmv>; Sun, 25 Mar 2001 17:42:51 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:21354 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132239AbRCYWml>; Sun, 25 Mar 2001 17:42:41 -0500
Date: Sun, 25 Mar 2001 16:41:58 -0600
Message-Id: <200103252241.QAA29192@mandrakesoft.mandrakesoft.com>
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <andrewm@uow.edu.au>, alan@lxorguk.ukuu.org.uk,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: PATCH 2.4.3.7: net drvr probe fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch provides a solution for the problem where an
interface is not completely ready by the time /sbin/hotplug is called,
from init_etherdev.  The patch also includes semi-related cleanups and
fixes found along the way.

Changes:
* Add alloc_etherdev, alloc_fddidev, alloc_hippi_dev, alloc_trdev, alloc_fcdev
* Add register_hipdev for API completeness
* Add inline source docs for init_fddidev, init_hippi_dev, init_trdev,
  init_fcdev
* Move EXPORT_SYMBOL for public functions from net/netsyms.c to
  drivers/net/net_init.c.
* Remove duplicate code by making unregister_foo functions simply call
  unregister_netdev()
* Remove duplicate code by making register_foo functions simply call
  new static function __register_netdev()
* Propagate returned error codes in register_netdev()
* Rename private tr_configure() to public tr_setup(), and remove no-op
  tr_setup() function.



diff -u linux_2_4/drivers/net/net_init.c:1.1.1.8 linux_2_4/drivers/net/net_init.c:1.1.1.8.38.2
--- linux_2_4/drivers/net/net_init.c:1.1.1.8	Mon Feb 26 19:03:50 2001
+++ linux_2_4/drivers/net/net_init.c	Sun Mar 25 12:43:06 2001
@@ -28,10 +28,12 @@
 			up. We now share common code and have regularised name
 			allocation setups. Abolished the 16 card limits.
 	03/19/2000 - jgarzik and Urban Widmark: init_etherdev 32-byte align
+	03/21/2001 - jgarzik: alloc_etherdev and friends
 
 */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>
@@ -68,6 +70,33 @@
 */
 
 
+static struct net_device *alloc_netdev(int sizeof_priv, const char *mask,
+				       void (*setup)(struct net_device *))
+{
+	struct net_device *dev;
+	int alloc_size;
+
+	/* ensure 32-byte alignment of the private area */
+	alloc_size = sizeof (*dev) + sizeof_priv + 31;
+
+	dev = (struct net_device *) kmalloc (alloc_size, GFP_KERNEL);
+	if (dev == NULL)
+	{
+		printk(KERN_ERR "alloc_dev: Unable to allocate device memory.\n");
+		return NULL;
+	}
+
+	memset(dev, 0, alloc_size);
+
+	if (sizeof_priv)
+		dev->priv = (void *) (((long)(dev + 1) + 31) & ~31);
+
+	setup(dev);
+	strcpy(dev->name, mask);
+
+	return dev;
+}
+
 static struct net_device *init_alloc_dev(int sizeof_priv)
 {
 	struct net_device *dev;
@@ -142,6 +171,17 @@
 	return dev;
 }
 
+static int __register_netdev(struct net_device *dev)
+{
+	dev_init_buffers(dev);
+	
+	if (dev->init && dev->init(dev) != 0) {
+		unregister_netdev(dev);
+		return -EIO;
+	}
+	return 0;
+}
+
 /**
  * init_etherdev - Register ethernet device
  * @dev: An ethernet device structure to be filled in, or %NULL if a new
@@ -164,6 +204,25 @@
 	return init_netdev(dev, sizeof_priv, "eth%d", ether_setup);
 }
 
+/**
+ * alloc_etherdev - Register ethernet device
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this ethernet device
+ *
+ * Fill in the fields of the device structure with ethernet-generic values.
+ *
+ * Constructs a new net device, complete with a private data area of
+ * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
+ * this private data area.
+ */
+
+struct net_device *alloc_etherdev(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "eth%d", ether_setup);
+}
+
+EXPORT_SYMBOL(init_etherdev);
+EXPORT_SYMBOL(alloc_etherdev);
 
 static int eth_mac_addr(struct net_device *dev, void *p)
 {
@@ -184,11 +243,48 @@
 
 #ifdef CONFIG_FDDI
 
+/**
+ * init_fddidev - Register FDDI device
+ * @dev: A FDDI device structure to be filled in, or %NULL if a new
+ *	struct should be allocated.
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this ethernet device
+ *
+ * Fill in the fields of the device structure with FDDI-generic values.
+ *
+ * If no device structure is passed, a new one is constructed, complete with
+ * a private data area of size @sizeof_priv.  A 32-byte (not bit)
+ * alignment is enforced for this private data area.
+ *
+ * If an empty string area is passed as dev->name, or a new structure is made,
+ * a new name string is constructed.
+ */
+
 struct net_device *init_fddidev(struct net_device *dev, int sizeof_priv)
 {
 	return init_netdev(dev, sizeof_priv, "fddi%d", fddi_setup);
 }
 
+/**
+ * alloc_fddidev - Register FDDI device
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this FDDI device
+ *
+ * Fill in the fields of the device structure with FDDI-generic values.
+ *
+ * Constructs a new net device, complete with a private data area of
+ * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
+ * this private data area.
+ */
+
+struct net_device *alloc_fddidev(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "fddi%d", fddi_setup);
+}
+
+EXPORT_SYMBOL(init_fddidev);
+EXPORT_SYMBOL(alloc_fddidev);
+
 static int fddi_change_mtu(struct net_device *dev, int new_mtu)
 {
 	if ((new_mtu < FDDI_K_SNAP_HLEN) || (new_mtu > FDDI_K_SNAP_DLEN))
@@ -227,19 +323,59 @@
 }
 
 
+/**
+ * init_hippi_dev - Register HIPPI device
+ * @dev: A HIPPI device structure to be filled in, or %NULL if a new
+ *	struct should be allocated.
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this ethernet device
+ *
+ * Fill in the fields of the device structure with HIPPI-generic values.
+ *
+ * If no device structure is passed, a new one is constructed, complete with
+ * a private data area of size @sizeof_priv.  A 32-byte (not bit)
+ * alignment is enforced for this private data area.
+ *
+ * If an empty string area is passed as dev->name, or a new structure is made,
+ * a new name string is constructed.
+ */
+
 struct net_device *init_hippi_dev(struct net_device *dev, int sizeof_priv)
 {
 	return init_netdev(dev, sizeof_priv, "hip%d", hippi_setup);
 }
 
+/**
+ * alloc_hippi_dev - Register HIPPI device
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this HIPPI device
+ *
+ * Fill in the fields of the device structure with HIPPI-generic values.
+ *
+ * Constructs a new net device, complete with a private data area of
+ * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
+ * this private data area.
+ */
 
+struct net_device *alloc_hippi_dev(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "hip%d", hippi_setup);
+}
+
+int register_hipdev(struct net_device *dev)
+{
+	return __register_netdev(dev);
+}
+
 void unregister_hipdev(struct net_device *dev)
 {
-	rtnl_lock();
-	unregister_netdevice(dev);
-	rtnl_unlock();
+	unregister_netdev(dev);
 }
 
+EXPORT_SYMBOL(init_hippi_dev);
+EXPORT_SYMBOL(alloc_hippi_dev);
+EXPORT_SYMBOL(register_hipdev);
+EXPORT_SYMBOL(unregister_hipdev);
 
 static int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p)
 {
@@ -283,6 +419,7 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(ether_setup);
 
 #ifdef CONFIG_FDDI
 
@@ -312,6 +449,7 @@
 	
 	return;
 }
+EXPORT_SYMBOL(fddi_setup);
 
 #endif /* CONFIG_FDDI */
 
@@ -349,6 +487,7 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(hippi_setup);
 #endif /* CONFIG_HIPPI */
 
 #if defined(CONFIG_ATALK) || defined(CONFIG_ATALK_MODULE)
@@ -387,6 +526,7 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(ltalk_setup);
 
 #endif /* CONFIG_ATALK || CONFIG_ATALK_MODULE */
 
@@ -403,8 +543,8 @@
 	 
 	if (strchr(dev->name, '%'))
 	{
-		err = -EBUSY;
-		if(dev_alloc_name(dev, dev->name)<0)
+		err = dev_alloc_name(dev, dev->name);
+		if (err < 0)
 			goto out;
 	}
 	
@@ -414,17 +554,12 @@
 	
 	if (dev->name[0]==0 || dev->name[0]==' ')
 	{
-		err = -EBUSY;
-		if(dev_alloc_name(dev, "eth%d")<0)
+		err = dev_alloc_name(dev, "eth%d");
+		if (err < 0)
 			goto out;
 	}
-		
-		
-	err = -EIO;
-	if (register_netdevice(dev))
-		goto out;
 
-	err = 0;
+	err = register_netdevice(dev);
 
 out:
 	rtnl_unlock();
@@ -438,10 +573,12 @@
 	rtnl_unlock();
 }
 
+EXPORT_SYMBOL(register_netdev);
+EXPORT_SYMBOL(unregister_netdev);
 
 #ifdef CONFIG_TR
 
-static void tr_configure(struct net_device *dev)
+void tr_setup(struct net_device *dev)
 {
 	/*
 	 *	Configure and register
@@ -462,32 +599,61 @@
 	dev->flags		= IFF_BROADCAST | IFF_MULTICAST ;
 }
 
+/**
+ * init_trdev - Register token ring device
+ * @dev: A token ring device structure to be filled in, or %NULL if a new
+ *	struct should be allocated.
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this ethernet device
+ *
+ * Fill in the fields of the device structure with token ring-generic values.
+ *
+ * If no device structure is passed, a new one is constructed, complete with
+ * a private data area of size @sizeof_priv.  A 32-byte (not bit)
+ * alignment is enforced for this private data area.
+ *
+ * If an empty string area is passed as dev->name, or a new structure is made,
+ * a new name string is constructed.
+ */
+
 struct net_device *init_trdev(struct net_device *dev, int sizeof_priv)
 {
-	return init_netdev(dev, sizeof_priv, "tr%d", tr_configure);
+	return init_netdev(dev, sizeof_priv, "tr%d", tr_setup);
 }
 
-void tr_setup(struct net_device *dev)
+/**
+ * alloc_trdev - Register token ring device
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this token ring device
+ *
+ * Fill in the fields of the device structure with token ring-generic values.
+ *
+ * Constructs a new net device, complete with a private data area of
+ * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
+ * this private data area.
+ */
+
+struct net_device *alloc_trdev(int sizeof_priv)
 {
+	return alloc_netdev(sizeof_priv, "tr%d", tr_setup);
 }
 
 int register_trdev(struct net_device *dev)
 {
-	dev_init_buffers(dev);
-	
-	if (dev->init && dev->init(dev) != 0) {
-		unregister_trdev(dev);
-		return -EIO;
-	}
-	return 0;
+	return __register_netdev(dev);
 }
 
 void unregister_trdev(struct net_device *dev)
 {
-	rtnl_lock();
-	unregister_netdevice(dev);
-	rtnl_unlock();
+	unregister_netdev(dev);
 }
+
+EXPORT_SYMBOL(tr_setup);
+EXPORT_SYMBOL(init_trdev);
+EXPORT_SYMBOL(alloc_trdev);
+EXPORT_SYMBOL(register_trdev);
+EXPORT_SYMBOL(unregister_trdev);
+
 #endif /* CONFIG_TR */
 
 
@@ -509,31 +675,62 @@
         /* New-style flags. */
         dev->flags              =        IFF_BROADCAST;
 	dev_init_buffers(dev);
-        return;
 }
 
+/**
+ * init_fcdev - Register fibre channel device
+ * @dev: A fibre channel device structure to be filled in, or %NULL if a new
+ *	struct should be allocated.
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this ethernet device
+ *
+ * Fill in the fields of the device structure with fibre channel-generic values.
+ *
+ * If no device structure is passed, a new one is constructed, complete with
+ * a private data area of size @sizeof_priv.  A 32-byte (not bit)
+ * alignment is enforced for this private data area.
+ *
+ * If an empty string area is passed as dev->name, or a new structure is made,
+ * a new name string is constructed.
+ */
 
 struct net_device *init_fcdev(struct net_device *dev, int sizeof_priv)
 {
 	return init_netdev(dev, sizeof_priv, "fc%d", fc_setup);
 }
 
+/**
+ * alloc_fcdev - Register fibre channel device
+ * @sizeof_priv: Size of additional driver-private structure to be allocated
+ *	for this fibre channel device
+ *
+ * Fill in the fields of the device structure with fibre channel-generic values.
+ *
+ * Constructs a new net device, complete with a private data area of
+ * size @sizeof_priv.  A 32-byte (not bit) alignment is enforced for
+ * this private data area.
+ */
+
+struct net_device *alloc_fcdev(int sizeof_priv)
+{
+	return alloc_netdev(sizeof_priv, "fc%d", fc_setup);
+}
+
 int register_fcdev(struct net_device *dev)
 {
-        dev_init_buffers(dev);
-        if (dev->init && dev->init(dev) != 0) {
-                unregister_fcdev(dev);
-                return -EIO;
-        }
-        return 0;
+	return __register_netdev(dev);
 }                                               
         
 void unregister_fcdev(struct net_device *dev)
 {
-        rtnl_lock();
-	unregister_netdevice(dev);
-        rtnl_unlock();
+	unregister_netdev(dev);
 }
+
+EXPORT_SYMBOL(fc_setup);
+EXPORT_SYMBOL(init_fcdev);
+EXPORT_SYMBOL(alloc_fcdev);
+EXPORT_SYMBOL(register_fcdev);
+EXPORT_SYMBOL(unregister_fcdev);
 
 #endif /* CONFIG_NET_FC */
 
diff -u linux_2_4/include/linux/etherdevice.h:1.1.1.15 linux_2_4/include/linux/etherdevice.h:1.1.1.15.4.1
--- linux_2_4/include/linux/etherdevice.h:1.1.1.15	Fri Mar 23 08:14:53 2001
+++ linux_2_4/include/linux/etherdevice.h	Fri Mar 23 20:04:23 2001
@@ -38,19 +38,28 @@
 					 struct hh_cache *hh);
 extern int		eth_header_parse(struct sk_buff *skb,
 					 unsigned char *haddr);
-extern struct net_device	* init_etherdev(struct net_device *, int);
+extern struct net_device *init_etherdev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_etherdev(int sizeof_priv);
 
-static __inline__ void eth_copy_and_sum (struct sk_buff *dest, unsigned char *src, int len, int base)
+static inline void eth_copy_and_sum (struct sk_buff *dest, unsigned char *src, int len, int base)
 {
 	memcpy (dest->data, src, len);
 }
 
-/* Check that the ethernet address (MAC) is not 00:00:00:00:00:00 and is not
- * a multicast address.  Return true if the address is valid.
+/**
+ * is_valid_ether_addr - Determine if the given Ethernet address is valid
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
+ * a multicast address, and is not FF:FF:FF:FF:FF:FF.
+ *
+ * Return true if the address is valid.
  */
-static __inline__ int is_valid_ether_addr( u8 *addr )
+static inline int is_valid_ether_addr( u8 *addr )
 {
-	return !(addr[0]&1) && memcmp( addr, "\0\0\0\0\0\0", 6);
+	const char zaddr[6] = {0,};
+
+	return !(addr[0]&1) && memcmp( addr, zaddr, 6);
 }
 
 #endif
diff -u linux_2_4/include/linux/fcdevice.h:1.1.1.1 linux_2_4/include/linux/fcdevice.h:1.1.1.1.182.1
--- linux_2_4/include/linux/fcdevice.h:1.1.1.1	Sun Oct 22 12:36:14 2000
+++ linux_2_4/include/linux/fcdevice.h	Fri Mar 23 20:04:23 2001
@@ -33,7 +33,10 @@
 extern int		fc_rebuild_header(struct sk_buff *skb);
 //extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
 
-extern struct net_device    * init_fcdev(struct net_device *, int);
+extern struct net_device *init_fcdev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_fcdev(int sizeof_priv);
+extern int register_fcdev(struct net_device *dev);
+extern void unregister_fcdev(struct net_device *dev);
 
 #endif
 
diff -u linux_2_4/include/linux/fddidevice.h:1.1.1.2 linux_2_4/include/linux/fddidevice.h:1.1.1.2.174.1
--- linux_2_4/include/linux/fddidevice.h:1.1.1.2	Sun Oct 22 13:44:24 2000
+++ linux_2_4/include/linux/fddidevice.h	Fri Mar 23 20:04:23 2001
@@ -34,7 +34,8 @@
 extern int		fddi_rebuild_header(struct sk_buff *skb);
 extern unsigned short	fddi_type_trans(struct sk_buff *skb,
 				struct net_device *dev);
-extern struct net_device        * init_fddidev(struct net_device *, int);
+extern struct net_device *init_fddidev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_fddidev(int sizeof_priv);
 #endif
 
 #endif	/* _LINUX_FDDIDEVICE_H */
diff -u linux_2_4/include/linux/hippidevice.h:1.1.1.1 linux_2_4/include/linux/hippidevice.h:1.1.1.1.182.1
--- linux_2_4/include/linux/hippidevice.h:1.1.1.1	Sun Oct 22 12:36:13 2000
+++ linux_2_4/include/linux/hippidevice.h	Fri Mar 23 20:04:23 2001
@@ -51,7 +51,9 @@
 extern void hippi_net_init(void);
 void hippi_setup(struct net_device *dev);
 
-extern struct net_device *init_hippi_dev(struct net_device *, int);
+extern struct net_device *init_hippi_dev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_hippi_dev(int sizeof_priv);
+extern int register_hipdev(struct net_device *dev);
 extern void unregister_hipdev(struct net_device *dev);
 #endif
 
diff -u linux_2_4/include/linux/netdevice.h:1.1.1.23 linux_2_4/include/linux/netdevice.h:1.1.1.23.2.1
--- linux_2_4/include/linux/netdevice.h:1.1.1.23	Fri Mar 23 19:21:18 2001
+++ linux_2_4/include/linux/netdevice.h	Fri Mar 23 20:04:23 2001
@@ -41,6 +41,9 @@
 
 struct divert_blk;
 
+#define HAVE_ALLOC_NETDEV		/* feature macro: alloc_xxxdev
+					   functions are available. */
+
 #define NET_XMIT_SUCCESS	0
 #define NET_XMIT_DROP		1	/* skb dropped			*/
 #define NET_XMIT_CN		2	/* congestion notification	*/
@@ -633,10 +636,6 @@
 /* Support for loadable net-drivers */
 extern int		register_netdev(struct net_device *dev);
 extern void		unregister_netdev(struct net_device *dev);
-extern int		register_trdev(struct net_device *dev);
-extern void		unregister_trdev(struct net_device *dev);
-extern int		register_fcdev(struct net_device *dev);
-extern void		unregister_fcdev(struct net_device *dev);
 /* Functions used for multicast support */
 extern void		dev_mc_upload(struct net_device *dev);
 extern int 		dev_mc_delete(struct net_device *dev, void *addr, int alen, int all);
diff -u linux_2_4/include/linux/trdevice.h:1.1.1.1 linux_2_4/include/linux/trdevice.h:1.1.1.1.182.1
--- linux_2_4/include/linux/trdevice.h:1.1.1.1	Sun Oct 22 12:36:03 2000
+++ linux_2_4/include/linux/trdevice.h	Fri Mar 23 20:04:23 2001
@@ -33,7 +33,10 @@
 				   void *saddr, unsigned len);
 extern int		tr_rebuild_header(struct sk_buff *skb);
 extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device *dev);
-extern struct net_device    * init_trdev(struct net_device *, int);
+extern struct net_device *init_trdev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_trdev(int sizeof_priv);
+extern int register_trdev(struct net_device *dev);
+extern void unregister_trdev(struct net_device *dev);
 
 #endif
 
diff -u linux_2_4/net/netsyms.c:1.1.1.25 linux_2_4/net/netsyms.c:1.1.1.25.2.1
--- linux_2_4/net/netsyms.c:1.1.1.25	Fri Mar 23 19:23:31 2001
+++ linux_2_4/net/netsyms.c	Fri Mar 23 20:04:23 2001
@@ -432,33 +432,19 @@
 #endif  /* CONFIG_INET */
 
 #ifdef CONFIG_TR
-EXPORT_SYMBOL(tr_setup);
 EXPORT_SYMBOL(tr_type_trans);
-EXPORT_SYMBOL(register_trdev);
-EXPORT_SYMBOL(unregister_trdev);
-EXPORT_SYMBOL(init_trdev);
 #endif
 
-#ifdef CONFIG_NET_FC
-EXPORT_SYMBOL(register_fcdev);
-EXPORT_SYMBOL(unregister_fcdev);
-EXPORT_SYMBOL(init_fcdev);
-#endif
-
 /* Device callback registration */
 EXPORT_SYMBOL(register_netdevice_notifier);
 EXPORT_SYMBOL(unregister_netdevice_notifier);
 
 /* support for loadable net drivers */
 #ifdef CONFIG_NET
-EXPORT_SYMBOL(init_etherdev);
 EXPORT_SYMBOL(loopback_dev);
 EXPORT_SYMBOL(register_netdevice);
 EXPORT_SYMBOL(unregister_netdevice);
-EXPORT_SYMBOL(register_netdev);
-EXPORT_SYMBOL(unregister_netdev);
 EXPORT_SYMBOL(netdev_state_change);
-EXPORT_SYMBOL(ether_setup);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_index);
 EXPORT_SYMBOL(__dev_get_by_index);
@@ -469,8 +455,6 @@
 EXPORT_SYMBOL(eth_type_trans);
 #ifdef CONFIG_FDDI
 EXPORT_SYMBOL(fddi_type_trans);
-EXPORT_SYMBOL(fddi_setup);
-EXPORT_SYMBOL(init_fddidev);
 #endif /* CONFIG_FDDI */
 #if 0
 EXPORT_SYMBOL(eth_copy_and_sum);
@@ -511,8 +495,6 @@
 
 #ifdef CONFIG_HIPPI
 EXPORT_SYMBOL(hippi_type_trans);
-EXPORT_SYMBOL(init_hippi_dev);
-EXPORT_SYMBOL(unregister_hipdev);
 #endif
 
 #ifdef CONFIG_SYSCTL
@@ -522,12 +504,6 @@
 EXPORT_SYMBOL(sysctl_ip_default_ttl);
 #endif
 #endif
-
-#if defined(CONFIG_ATALK) || defined(CONFIG_ATALK_MODULE) 
-#include<linux/if_ltalk.h>
-EXPORT_SYMBOL(ltalk_setup);
-#endif
-
 
 /* Packet scheduler modules want these. */
 EXPORT_SYMBOL(qdisc_destroy);
