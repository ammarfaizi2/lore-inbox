Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbQKKVOq>; Sat, 11 Nov 2000 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbQKKVO0>; Sat, 11 Nov 2000 16:14:26 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:40713 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132573AbQKKVOP>; Sat, 11 Nov 2000 16:14:15 -0500
Date: Sat, 11 Nov 2000 21:15:15 GMT
Message-Id: <200011112115.VAA32114@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda12 (Re: was: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda12 (Re: was: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda12.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda12.diff :
-----------------
	o [CORRECT] Remove memset of net_device (preserve device name)
	o [CORRECT] Correct structure member init for compressors
	o [CORRECT] Non module init of toshoboe and litelink drivers
	o [CORRECT] Add CONFIG_PROC_FS where needed
	o [FEATURE] Add MODULE_PARM_DESC there and there

diff -urpN old-linux/drivers/net/irda/irport.c linux/drivers/net/irda/irport.c
--- old-linux/drivers/net/irda/irport.c	Tue Mar 21 11:17:28 2000
+++ linux/drivers/net/irda/irport.c	Thu Nov  9 16:09:38 2000
@@ -999,7 +999,9 @@ static struct net_device_stats *irport_n
 
 #ifdef MODULE
 MODULE_PARM(io, "1-4i");
+MODULE_PARM_DESC(io, "Base I/O adresses");
 MODULE_PARM(irq, "1-4i");
+MODULE_PARM_DESC(irq, "IRQ lines");
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("Half duplex serial driver for IrDA SIR mode");
diff -urpN old-linux/drivers/net/irda/irtty.c linux/drivers/net/irda/irtty.c
--- old-linux/drivers/net/irda/irtty.c	Thu Nov  9 14:47:22 2000
+++ linux/drivers/net/irda/irtty.c	Thu Nov  9 16:09:38 2000
@@ -234,14 +234,6 @@ static int irtty_open(struct tty_struct 
 		return -ENOMEM;
 	}
 
-#if LINUX_VERSION_CODE >= 0x020362	/* 2.3.99-pre7 */
-	/* dev_alloc doesn't clear the struct (Yuck !!!) */
-	memset(((__u8*)dev)+IFNAMSIZ,0,sizeof(struct net_device)-IFNAMSIZ);
-#else
-	/* dev_alloc doesn't clear the struct */
-	memset(((__u8*)dev)+sizeof(char*),0,sizeof(struct net_device)-sizeof(char*));
-#endif /* LINUX_VERSION_CODE >= 0x020362 */
-
 	dev->priv = (void *) self;
 	self->netdev = dev;
 
@@ -1035,6 +1027,7 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("IrDA TTY device driver");
 
 MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
 
 /*
  * Function init_module (void)
diff -urpN old-linux/drivers/net/irda/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- old-linux/drivers/net/irda/nsc-ircc.c	Mon Oct 16 12:58:51 2000
+++ linux/drivers/net/irda/nsc-ircc.c	Thu Nov  9 16:09:38 2000
@@ -2029,10 +2029,15 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("NSC IrDA Device Driver");
 
 MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
 MODULE_PARM(io,  "1-4i");
+MODULE_PARM_DESC(io, "Base I/O addresses");
 MODULE_PARM(irq, "1-4i");
+MODULE_PARM_DESC(irq, "IRQ lines");
 MODULE_PARM(dma, "1-4i");
+MODULE_PARM_DESC(dma, "DMA channels");
 MODULE_PARM(dongle_id, "i");
+MODULE_PARM_DESC(dongle_id, "Type-id of used dongle");
 
 int init_module(void)
 {
diff -urpN old-linux/drivers/net/irda/smc-ircc.c linux/drivers/net/irda/smc-ircc.c
--- old-linux/drivers/net/irda/smc-ircc.c	Thu Nov  9 16:08:25 2000
+++ linux/drivers/net/irda/smc-ircc.c	Thu Nov  9 16:09:38 2000
@@ -1039,7 +1039,9 @@ static int ircc_pmproc(struct pm_dev *de
 MODULE_AUTHOR("Thomas Davis <tadavis@jps.net>");
 MODULE_DESCRIPTION("SMC IrCC controller driver");
 MODULE_PARM(ircc_dma, "1i");
+MODULE_PARM_DESC(ircc_dma, "DMA channel");
 MODULE_PARM(ircc_irq, "1i");
+MODULE_PARM_DESC(ircc_irq, "IRQ line");
 
 int init_module(void)
 {
diff -urpN old-linux/drivers/net/irda/toshoboe.c linux/drivers/net/irda/toshoboe.c
--- old-linux/drivers/net/irda/toshoboe.c	Sun Sep 17 09:45:07 2000
+++ linux/drivers/net/irda/toshoboe.c	Thu Nov  9 16:09:38 2000
@@ -628,7 +628,10 @@ static int toshoboe_net_ioctl(struct net
 
 #ifdef MODULE
 
+MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
+MODULE_AUTHOR("James McKenzie <james@fishsoup.dhs.org>");
 MODULE_PARM (max_baud, "i");
+MODULE_PARM_DESC(max_baus, "Maximum baud rate");
 
 static int
 toshoboe_close (struct toshoboe_cb *self)
diff -urpN old-linux/drivers/net/irda/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- old-linux/drivers/net/irda/w83977af_ir.c	Tue Mar 21 11:17:28 2000
+++ linux/drivers/net/irda/w83977af_ir.c	Thu Nov  9 16:09:38 2000
@@ -1366,9 +1366,11 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("Winbond W83977AF IrDA Device Driver");
 
 MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "Mimimum Turn Time");
 MODULE_PARM(io, "1-4i");
-MODULE_PARM(io2, "1-4i");
+MODULE_PARM_DESC(io, "Base I/O addresses");
 MODULE_PARM(irq, "1-4i");
+MODULE_PARM_DESC(irq, "IRQ lines");
 
 /*
  * Function init_module (void)
diff -urpN old-linux/net/irda/compressors/irda_deflate.c linux/net/irda/compressors/irda_deflate.c
--- old-linux/net/irda/compressors/irda_deflate.c	Tue Aug 31 11:23:03 1999
+++ linux/net/irda/compressors/irda_deflate.c	Thu Nov  9 16:09:38 2000
@@ -561,37 +561,37 @@ extern void irda_unregister_compressor (
  * Procedures exported to if_ppp.c.
  */
 static struct compressor irda_deflate = {
-	CI_DEFLATE,		/* compress_proto */
-	z_comp_alloc,		/* comp_alloc */
-	z_comp_free,		/* comp_free */
-	z_comp_init,		/* comp_init */
-	z_comp_reset,		/* comp_reset */
-	z_compress,		/* compress */
-	z_comp_stats,		/* comp_stat */
-	z_decomp_alloc,		/* decomp_alloc */
-	z_decomp_free,		/* decomp_free */
-	z_decomp_init,		/* decomp_init */
-	z_decomp_reset,		/* decomp_reset */
-	z_decompress,		/* decompress */
-	z_incomp,		/* incomp */
-	z_comp_stats,		/* decomp_stat */
+compress_proto:	CI_DEFLATE,
+comp_alloc:	z_comp_alloc,
+comp_free:	z_comp_free,
+comp_init:	z_comp_init,
+comp_reset:	z_comp_reset,
+compress:	z_compress,
+comp_stat:	z_comp_stats,
+decomp_alloc:	z_decomp_alloc,
+decomp_free:	z_decomp_free,
+decomp_init:	z_decomp_init,
+decomp_reset:	z_decomp_reset,
+decompress:	z_decompress,
+incomp:		z_incomp,
+decomp_stat:	z_comp_stats
 };
 
 static struct compressor irda_deflate_draft = {
-	CI_DEFLATE_DRAFT,	/* compress_proto */
-	z_comp_alloc,		/* comp_alloc */
-	z_comp_free,		/* comp_free */
-	z_comp_init,		/* comp_init */
-	z_comp_reset,		/* comp_reset */
-	z_compress,		/* compress */
-	z_comp_stats,		/* comp_stat */
-	z_decomp_alloc,		/* decomp_alloc */
-	z_decomp_free,		/* decomp_free */
-	z_decomp_init,		/* decomp_init */
-	z_decomp_reset,		/* decomp_reset */
-	z_decompress,		/* decompress */
-	z_incomp,		/* incomp */
-	z_comp_stats,		/* decomp_stat */
+compress_proto:	CI_DEFLATE_DRAFT,
+comp_alloc:	z_comp_alloc,
+comp_free:	z_comp_free,
+comp_init:	z_comp_init,
+comp_reset:	z_comp_reset,
+compress:	z_compress,
+comp_stat:	z_comp_stats,
+decomp_alloc:	z_decomp_alloc,
+decomp_free:	z_decomp_free,
+decomp_init:	z_decomp_init,
+decomp_reset:	z_decomp_reset,
+decompress:	z_decompress,
+incomp:		z_incomp,
+decomp_stat:	z_comp_stats
 };
 
 int __init irda_deflate_init(void)
diff -urpN old-linux/net/irda/ircomm/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- old-linux/net/irda/ircomm/ircomm_core.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/ircomm/ircomm_core.c	Thu Nov  9 16:09:38 2000
@@ -512,6 +512,9 @@ int ircomm_proc_read(char *buf, char **s
 #endif /* CONFIG_PROC_FS */
 
 #ifdef MODULE
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("IrCOMM protocol");
+
 int init_module(void) 
 {
 	return ircomm_init();
diff -urpN old-linux/net/irda/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- old-linux/net/irda/ircomm/ircomm_tty.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Nov  9 16:09:38 2000
@@ -1352,6 +1352,9 @@ done:
 
 
 #ifdef MODULE
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("IrCOMM serial TTY driver");
+
 int init_module(void) 
 {
 	return ircomm_tty_init();
diff -urpN old-linux/net/irda/irda_device.c linux/net/irda/irda_device.c
--- old-linux/net/irda/irda_device.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irda_device.c	Thu Nov  9 16:09:38 2000
@@ -58,6 +58,8 @@
 extern int irtty_init(void);
 extern int nsc_ircc_init(void);
 extern int ircc_init(void);
+extern int toshoboe_init(void);
+extern int litelink_init(void);
 extern int w83977af_init(void);
 extern int esi_init(void);
 extern int tekram_init(void);
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 16:09:38 2000
@@ -62,6 +62,7 @@ static __u32 ckey, skey;
 static int eth = 0; /* Use "eth" or "irlan" name for devices */
 static int access = ACCESS_PEER; /* PEER, DIRECT or HOSTED */
 
+#ifdef CONFIG_PROC_FS
 static char *irlan_state[] = {
 	"IRLAN_IDLE",
 	"IRLAN_QUERY",
@@ -88,6 +89,7 @@ static char *irlan_media[] = {
 	"802.3",
 	"802.5"
 };
+#endif /* CONFIG_PROC_FS */
 
 static void __irlan_close(struct irlan_cb *self);
 static int __irlan_insert_param(struct sk_buff *skb, char *param, int type, 
@@ -1278,8 +1280,9 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 
 MODULE_PARM(eth, "i");
+MODULE_PARM_DESC(eth, "Name devices ethX (0) or irlanX (1)");
 MODULE_PARM(access, "i");
-MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(access, "Access type DIRECT=1, PEER=2, HOSTED=3");
 
 /*
  * Function init_module (void)
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 16:08:25 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 16:12:47 2000
@@ -546,7 +546,10 @@ void irda_proc_modcount(struct inode *in
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
+#ifdef CONFIG_IRDA_DEBUG
 MODULE_PARM(irda_debug, "1l");
+MODULE_PARM_DESC(irda_debug, "IrDA debug level");
+#endif
 
 module_init(irda_init);
 module_exit(irda_cleanup);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
