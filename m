Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSKGBwM>; Wed, 6 Nov 2002 20:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKGBwM>; Wed, 6 Nov 2002 20:52:12 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:37764 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266270AbSKGBwL>;
	Wed, 6 Nov 2002 20:52:11 -0500
Date: Wed, 6 Nov 2002 21:02:00 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Subject: [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
Message-ID: <20021106210159.GN316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org, perex@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch from Jaroslav Kysela.  It was sent in previously but doesn't 
appear to be included.  Here it is again only now against 2.5.46.



diff -ur --new-file a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Wed Oct 30 17:45:58 2002
+++ b/drivers/net/e100/e100_main.c	Wed Oct 30 17:45:24 2002
@@ -87,8 +87,8 @@
 extern int e100_create_proc_subdir(struct e100_private *, char *);
 extern void e100_remove_proc_subdir(struct e100_private *, char *);
 #else
-#define e100_create_proc_subdir(X) 0
-#define e100_remove_proc_subdir(X) do {} while(0)
+#define e100_create_proc_subdir(X, Y) 0
+#define e100_remove_proc_subdir(X, Y) do {} while(0)
 #endif
 
 static int e100_do_ethtool_ioctl(struct net_device *, struct ifreq *);
diff -ur --new-file a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Wed Oct 30 17:45:58 2002
+++ b/include/linux/module.h	Wed Oct 30 17:45:24 2002
@@ -239,6 +239,8 @@
  * The following is a list of known device types (arg 1),
  * and the C types which are to be passed as arg 2.
  * pci - struct pci_device_id - List of PCI ids supported by this module
+ * pnpc - struct pnpc_device_id - List of PnP card ids (PNPBIOS, ISA PnP) supported by this module
+ * pnp - struct pnp_device_id - List of PnP ids (PNPBIOS, ISA PnP) supported by this module
  * isapnp - struct isapnp_device_id - List of ISA PnP ids supported by this module
  * usb - struct usb_device_id - List of USB ids supported by this module
  */
diff -ur --new-file a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Wed Oct 30 17:45:58 2002
+++ b/include/linux/pnp.h	Wed Oct 30 17:45:24 2002
@@ -79,6 +79,9 @@
 
 /* Driver Management */
 
+#define pnpc_device_id pnp_id		/* for module.h */
+#define pnp_device_id pnp_id		/* for module.h */
+
 struct pnp_id {
 	char id[7];
 	unsigned long driver_data;	/* data private to the driver */
diff -ur --new-file a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
--- a/include/linux/sunrpc/stats.h	Wed Oct 30 17:45:58 2002
+++ b/include/linux/sunrpc/stats.h	Wed Oct 30 17:45:24 2002
@@ -61,16 +61,18 @@
 
 #else
 
+static inline struct proc_dir_entry *rpc_proc_register(struct rpc_stat *s) { return NULL; }
+static inline void rpc_proc_unregister(const char *p) {}
+static inline int rpc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f) { return 0; }
+static inline void rpc_proc_zero(struct rpc_program *p) {}
+
+static inline struct proc_dir_entry *svc_proc_register(struct svc_stat *s) { return NULL; }
 static inline void svc_proc_unregister(const char *p) {}
-static inline struct proc_dir_entry*svc_proc_register(struct svc_stat *s)
-{
-	return NULL;
-}
+static inline int svc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f) { return 0; }
+static inline void svc_proc_zero(struct svc_program *p) {}
+
+#define proc_net_rpc NULL
 
-static inline int svc_proc_read(char *a, char **b, off_t c, int d, int *e, void *f)
-{
-	return 0;
-}
 #endif
 
 #endif /* _LINUX_SUNRPC_STATS_H */
diff -ur --new-file a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Wed Oct 30 17:45:58 2002
+++ b/sound/oss/opl3sa2.c	Wed Oct 30 17:45:24 2002
@@ -841,7 +841,7 @@
 	{.id = ""}
 };
 
-/*MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);*/
+MODULE_DEVICE_TABLE(pnp, pnp_opl3sa2_list);
 
 static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id,
 			     const struct pnp_id *dev_id)
