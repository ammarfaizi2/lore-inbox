Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRCUO2b>; Wed, 21 Mar 2001 09:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCUO2N>; Wed, 21 Mar 2001 09:28:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48867 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131482AbRCUO2A>;
	Wed, 21 Mar 2001 09:28:00 -0500
Message-ID: <3AB8BA16.A25C0929@mandrakesoft.com>
Date: Wed, 21 Mar 2001 09:26:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: PATCH 2.4.3.6: fix netdevice initialization
Content-Type: multipart/mixed;
 boundary="------------98FC4B3C4E3DBB7B168B218A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------98FC4B3C4E3DBB7B168B218A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

(Linus, please do not apply this.  After some patch review, I'll send
this to you along with driver updates to use it)

Attached is a patch against 2.4.3-pre6, which adds alloc_etherdev and
variants to the driver API.  This API addition should allow us to close
the gaping race between init_etherdev call time, and when the network
device is actually ready.

This version removes the DECLARE_xxx at the request of the crowd. 
Hooray for cut-n-paste code... please check for errors.

Driver API changes for this stable kernel series are:
* Six functions added,
* Four prototypes moved from netdevice.h to foodevice.h, and
* No behavior changes, no code changes requiring immediate driver
updates

Main change in this patch:
* New functions alloc_etherdev, alloc_fddidev, alloc_hippi_dev,
alloc_fcdev, alloc_trdev

Cleanup changes in this patch:
* Move prototypes from netdevice.h to foodevice.h: [un]register_fcdev,
[un]register_trdev
* Add inline source docs for init_xxxdev
* Move EXPORT_SYMBOL for public functions from net/netsyms.c to
net_init.c
* New function register_hipdev, for API completeness
* Remove duplicate code from unregister_hipdev, [un]register_trdev,
[un]register_fcdev
* tr_setup was exported but did nothing.  Rename tr_configure to
tr_setup, remove old no-op tr_setup.

-- 
Jeff Garzik       | More novel than War and Peace
Building 1024     | More tongue-in-cheek than a lesbian orgy
MandrakeSoft      | Sneakin' up like celery, yeah I'm stalkin'
--------------98FC4B3C4E3DBB7B168B218A
Content-Type: text/plain; charset=us-ascii;
 name="net-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-fix.patch"

Index: drivers/net/net_init.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/net_init.c,v
retrieving revision 1.1.1.8
retrieving revision 1.1.1.8.34.3
diff -u -r1.1.1.8 -r1.1.1.8.34.3
--- drivers/net/net_init.c	2001/02/27 03:03:50	1.1.1.8
+++ drivers/net/net_init.c	2001/03/21 14:10:50	1.1.1.8.34.3
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
 
@@ -438,10 +578,12 @@
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
@@ -462,32 +604,61 @@
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
 
 
@@ -509,31 +680,62 @@
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
 
Index: net/netsyms.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/net/netsyms.c,v
retrieving revision 1.1.1.23
retrieving revision 1.1.1.23.4.1
diff -u -r1.1.1.23 -r1.1.1.23.4.1
--- net/netsyms.c	2001/03/20 12:56:42	1.1.1.23
+++ net/netsyms.c	2001/03/21 02:19:50	1.1.1.23.4.1
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
Index: include/linux/etherdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
retrieving revision 1.1.1.14
retrieving revision 1.1.1.14.4.2
diff -u -r1.1.1.14 -r1.1.1.14.4.2
--- include/linux/etherdevice.h	2001/03/20 12:54:47	1.1.1.14
+++ include/linux/etherdevice.h	2001/03/21 14:10:50	1.1.1.14.4.2
@@ -38,7 +38,8 @@
 					 struct hh_cache *hh);
 extern int		eth_header_parse(struct sk_buff *skb,
 					 unsigned char *haddr);
-extern struct net_device	* init_etherdev(struct net_device *, int);
+extern struct net_device *init_etherdev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_etherdev(int sizeof_priv);
 
 static __inline__ void eth_copy_and_sum (struct sk_buff *dest, unsigned char *src, int len, int base)
 {
Index: include/linux/fcdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/fcdevice.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.178.2
diff -u -r1.1.1.1 -r1.1.1.1.178.2
--- include/linux/fcdevice.h	2000/10/22 19:36:14	1.1.1.1
+++ include/linux/fcdevice.h	2001/03/21 14:10:50	1.1.1.1.178.2
@@ -33,7 +33,10 @@
 extern int		fc_rebuild_header(struct sk_buff *skb);
 //extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
 
-extern struct net_device    * init_fcdev(struct net_device *, int);
+extern struct net_device *init_fcdev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_fcdev(int sizeof_priv);
+extern int register_fcdev(struct net_device *dev);
+extern void unregister_fcdev(struct net_device *dev);
 
 #endif
 
Index: include/linux/fddidevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/fddidevice.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.170.2
diff -u -r1.1.1.2 -r1.1.1.2.170.2
--- include/linux/fddidevice.h	2000/10/22 20:44:24	1.1.1.2
+++ include/linux/fddidevice.h	2001/03/21 14:10:50	1.1.1.2.170.2
@@ -34,7 +34,8 @@
 extern int		fddi_rebuild_header(struct sk_buff *skb);
 extern unsigned short	fddi_type_trans(struct sk_buff *skb,
 				struct net_device *dev);
-extern struct net_device        * init_fddidev(struct net_device *, int);
+extern struct net_device *init_fddidev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_fddidev(int sizeof_priv);
 #endif
 
 #endif	/* _LINUX_FDDIDEVICE_H */
Index: include/linux/hippidevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/hippidevice.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.178.2
diff -u -r1.1.1.1 -r1.1.1.1.178.2
--- include/linux/hippidevice.h	2000/10/22 19:36:13	1.1.1.1
+++ include/linux/hippidevice.h	2001/03/21 14:10:50	1.1.1.1.178.2
@@ -51,7 +51,9 @@
 extern void hippi_net_init(void);
 void hippi_setup(struct net_device *dev);
 
-extern struct net_device *init_hippi_dev(struct net_device *, int);
+extern struct net_device *init_hippi_dev(struct net_device *dev, int sizeof_priv);
+extern struct net_device *alloc_hippi_dev(int sizeof_priv);
+extern int register_hipdev(struct net_device *dev);
 extern void unregister_hipdev(struct net_device *dev);
 #endif
 
Index: include/linux/netdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/netdevice.h,v
retrieving revision 1.1.1.21
retrieving revision 1.1.1.21.4.1
diff -u -r1.1.1.21 -r1.1.1.21.4.1
--- include/linux/netdevice.h	2001/03/20 12:54:47	1.1.1.21
+++ include/linux/netdevice.h	2001/03/21 14:10:50	1.1.1.21.4.1
@@ -633,10 +633,6 @@
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
Index: include/linux/trdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/trdevice.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.178.2
diff -u -r1.1.1.1 -r1.1.1.1.178.2
--- include/linux/trdevice.h	2000/10/22 19:36:03	1.1.1.1
+++ include/linux/trdevice.h	2001/03/21 14:10:50	1.1.1.1.178.2
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
 

--------------98FC4B3C4E3DBB7B168B218A--

