Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJ2Oqy>; Tue, 29 Oct 2002 09:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSJ2Oqy>; Tue, 29 Oct 2002 09:46:54 -0500
Received: from gate.perex.cz ([194.212.165.105]:55817 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261742AbSJ2Oqv>;
	Tue, 29 Oct 2002 09:46:51 -0500
Date: Tue, 29 Oct 2002 15:50:37 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>
Subject: [PATCH] MODULE_DEVICE_TABLE update && !CONFIG_PROC_FS
Message-ID: <Pine.LNX.4.33.0210291502300.567-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	this is a simple patch which allows use of MODULE_DEVICE_TABLE()
for new PnP layer. insmod utility can generate PnP tables from the kernel
modules now. Also, it fixes numerous troubles when CONFIG_PROC_FS is not
defined. Please, apply.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.872, 2002-10-29 14:44:19+01:00, perex@suse.cz
  E100, ISA PnP, SunRPC - compilation fixes without CONFIG_PROC_FS.
  PnP - added definition of pnpc_device_id and pnp_device_id to allow
        use of MODULE_DEVICE_TABLE() macro
  opl3sa2 - added MODULE_DEVICE_TABLE() for pnp devices


 drivers/net/e100/e100_main.c |    4 ++--
 include/linux/isapnp.h       |    4 ++--
 include/linux/module.h       |    2 ++
 include/linux/pnp.h          |    3 +++
 include/linux/sunrpc/stats.h |   18 ++++++++++--------
 sound/oss/opl3sa2.c          |    2 +-
 6 files changed, 20 insertions(+), 13 deletions(-)


diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Tue Oct 29 14:50:57 2002
+++ b/drivers/net/e100/e100_main.c	Tue Oct 29 14:50:57 2002
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
diff -Nru a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Tue Oct 29 14:50:57 2002
+++ b/include/linux/isapnp.h	Tue Oct 29 14:50:57 2002
@@ -195,8 +195,8 @@
 int isapnp_proc_init(void);
 int isapnp_proc_done(void);
 #else
-static inline isapnp_proc_init(void) { return 0; }
-static inline isapnp_proc_done(void) { return 0; )
+static inline int isapnp_proc_init(void) { return 0; }
+static inline int isapnp_proc_done(void) { return 0; }
 #endif
 
 /* misc */
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Oct 29 14:50:57 2002
+++ b/include/linux/module.h	Tue Oct 29 14:50:57 2002
@@ -239,6 +239,8 @@
  * The following is a list of known device types (arg 1),
  * and the C types which are to be passed as arg 2.
  * pci - struct pci_device_id - List of PCI ids supported by this module
+ * pnpc - struct pnpc_device_id - List of PnP card ids (PNPBIOS, ISA PnP) supported by this module
+ * pnp - struct pnp_device_id - List of PnP ids (PNPBIOS, ISA PnP) supported by this module
  * isapnp - struct isapnp_device_id - List of ISA PnP ids supported by this module
  * usb - struct usb_device_id - List of USB ids supported by this module
  */
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Oct 29 14:50:57 2002
+++ b/include/linux/pnp.h	Tue Oct 29 14:50:57 2002
@@ -78,6 +78,9 @@
 
 /* Driver Management */
 
+#define pnpc_device_id pnp_id		/* for module.h */
+#define pnp_device_id pnp_id		/* for module.h */
+
 struct pnp_id {
 	char id[7];
 	unsigned long driver_data;	/* data private to the driver */
diff -Nru a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
--- a/include/linux/sunrpc/stats.h	Tue Oct 29 14:50:57 2002
+++ b/include/linux/sunrpc/stats.h	Tue Oct 29 14:50:57 2002
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
diff -Nru a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Tue Oct 29 14:50:57 2002
+++ b/sound/oss/opl3sa2.c	Tue Oct 29 14:50:57 2002
@@ -841,7 +841,7 @@
 	{.id = ""}
 };
 
-/*MODULE_DEVICE_TABLE(isapnp, isapnp_opl3sa2_list);*/
+MODULE_DEVICE_TABLE(pnp, pnp_opl3sa2_list);
 
 static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id,
 			     const struct pnp_id *dev_id)

===================================================================


This BitKeeper patch contains the following changesets:
1.872
## Wrapped with gzip_uu ##


begin 664 bkpatch17491
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
J9.5H:.E[$*QJ']9Q!P/]Z4^YX4"$-SH?'L"1P`FA,['^`>Q\BNX^%@``
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


