Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWIYVJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWIYVJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIYVJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:09:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5340
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751398AbWIYVJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:09:51 -0400
Date: Mon, 25 Sep 2006 14:09:34 -0700 (PDT)
Message-Id: <20060925.140934.41635124.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-git on SPARC64: Section mismatches
From: David Miller <davem@davemloft.net>
In-Reply-To: <200609251650.k8PGodOl005239@laptop13.inf.utfsm.cl>
References: <200609251650.k8PGodOl005239@laptop13.inf.utfsm.cl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Mon, 25 Sep 2006 12:50:39 -0400

> I got the following today:
> 
>   Building modules, stage 2.
>   MODPOST 425 modules
> WARNING: arch/sparc64/solaris/solaris.o - Section mismatch: reference to .init.text:init_socksys from .text between 'init_module' (at offset 0x2a14) and 'solaris_register'
> WARNING: drivers/net/sunlance.o - Section mismatch: reference to .init.text: from .text between 'sunlance_sbus_probe' (at offset 0x350) and 'lance_set_multicast'
> WARNING: sound/sparc/snd-sun-amd7930.o - Section mismatch: reference to .init.text: from .text between 'amd7930_sbus_probe' (at offset 0x4c0) and 'snd_amd7930_capture_prepare'
> 
> Dunno how long this has been going on, just spotted it today.

Thanks, the following patch should clear those up.

diff --git a/arch/sparc64/solaris/misc.c b/arch/sparc64/solaris/misc.c
index 8135ec3..6425417 100644
--- a/arch/sparc64/solaris/misc.c
+++ b/arch/sparc64/solaris/misc.c
@@ -736,20 +736,15 @@ struct exec_domain solaris_exec_domain =
 
 extern int init_socksys(void);
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Jakub Jelinek (jj@ultra.linux.cz), Patrik Rak (prak3264@ss1000.ms.mff.cuni.cz)");
 MODULE_DESCRIPTION("Solaris binary emulation module");
 MODULE_LICENSE("GPL");
 
-#ifdef __sparc_v9__
 extern u32 tl0_solaris[8];
 #define update_ttable(x) 										\
 	tl0_solaris[3] = (((long)(x) - (long)tl0_solaris - 3) >> 2) | 0x40000000;			\
 	wmb();		\
 	__asm__ __volatile__ ("flush %0" : : "r" (&tl0_solaris[3]))
-#else
-#endif	
 
 extern u32 solaris_sparc_syscall[];
 extern u32 solaris_syscall[];
@@ -757,7 +752,7 @@ extern void cleanup_socksys(void);
 
 extern u32 entry64_personality_patch;
 
-int init_module(void)
+static int __init solaris_init(void)
 {
 	int ret;
 
@@ -777,19 +772,12 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void __exit solaris_exit(void)
 {
 	update_ttable(solaris_syscall);
 	cleanup_socksys();
 	unregister_exec_domain(&solaris_exec_domain);
 }
 
-#else
-int init_solaris_emul(void)
-{
-	register_exec_domain(&solaris_exec_domain);
-	init_socksys();
-	return 0;
-}
-#endif
-
+module_init(solaris_init);
+module_exit(solaris_exit);
diff --git a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
index bc3df95..7c90e41 100644
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -168,8 +168,7 @@ static struct file_operations socksys_fo
 	.release =	socksys_release,
 };
 
-int __init
-init_socksys(void)
+int __init init_socksys(void)
 {
 	int ret;
 	struct file * file;
@@ -199,8 +198,7 @@ init_socksys(void)
 	return 0;
 }
 
-void
-cleanup_socksys(void)
+void __exit cleanup_socksys(void)
 {
 	if (unregister_chrdev(30, "socksys"))
 		printk ("Couldn't unregister socksys character device\n");
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 7767074..feb42db 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -1323,9 +1323,9 @@ static const struct ethtool_ops sparc_la
 	.get_link		= sparc_lance_get_link,
 };
 
-static int __init sparc_lance_probe_one(struct sbus_dev *sdev,
-					struct sbus_dma *ledma,
-					struct sbus_dev *lebuffer)
+static int __devinit sparc_lance_probe_one(struct sbus_dev *sdev,
+					   struct sbus_dma *ledma,
+					   struct sbus_dev *lebuffer)
 {
 	static unsigned version_printed;
 	struct net_device *dev;
@@ -1515,7 +1515,7 @@ fail:
 }
 
 /* On 4m, find the associated dma for the lance chip */
-static inline struct sbus_dma *find_ledma(struct sbus_dev *sdev)
+static struct sbus_dma * __devinit find_ledma(struct sbus_dev *sdev)
 {
 	struct sbus_dma *p;
 
@@ -1533,7 +1533,7 @@ #include <asm/machines.h>
 
 /* Find all the lance cards on the system and initialize them */
 static struct sbus_dev sun4_sdev;
-static int __init sparc_lance_init(void)
+static int __devinit sparc_lance_init(void)
 {
 	if ((idprom->id_machtype == (SM_SUN4|SM_4_330)) ||
 	    (idprom->id_machtype == (SM_SUN4|SM_4_470))) {
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 2bd8e40..be0bd50 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -755,7 +755,7 @@ static struct snd_pcm_ops snd_amd7930_ca
 	.pointer	=	snd_amd7930_capture_pointer,
 };
 
-static int __init snd_amd7930_pcm(struct snd_amd7930 *amd)
+static int __devinit snd_amd7930_pcm(struct snd_amd7930 *amd)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -870,7 +870,7 @@ static int snd_amd7930_put_volume(struct
 	return change;
 }
 
-static struct snd_kcontrol_new amd7930_controls[] __initdata = {
+static struct snd_kcontrol_new amd7930_controls[] __devinitdata = {
 	{
 		.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name		=	"Monitor Volume",
@@ -900,7 +900,7 @@ static struct snd_kcontrol_new amd7930_c
 	},
 };
 
-static int __init snd_amd7930_mixer(struct snd_amd7930 *amd)
+static int __devinit snd_amd7930_mixer(struct snd_amd7930 *amd)
 {
 	struct snd_card *card;
 	int idx, err;
@@ -945,11 +945,11 @@ static struct snd_device_ops snd_amd7930
 	.dev_free	=	snd_amd7930_dev_free,
 };
 
-static int __init snd_amd7930_create(struct snd_card *card,
-				     struct resource *rp,
-				     unsigned int reg_size,
-				     int irq, int dev,
-				     struct snd_amd7930 **ramd)
+static int __devinit snd_amd7930_create(struct snd_card *card,
+					struct resource *rp,
+					unsigned int reg_size,
+					int irq, int dev,
+					struct snd_amd7930 **ramd)
 {
 	unsigned long flags;
 	struct snd_amd7930 *amd;
@@ -1013,7 +1013,7 @@ static int __init snd_amd7930_create(str
 	return 0;
 }
 
-static int __init amd7930_attach_common(struct resource *rp, int irq)
+static int __devinit amd7930_attach_common(struct resource *rp, int irq)
 {
 	static int dev_num;
 	struct snd_card *card;
@@ -1065,7 +1065,7 @@ out_err:
 	return err;
 }
 
-static int __init amd7930_obio_attach(struct device_node *dp)
+static int __devinit amd7930_obio_attach(struct device_node *dp)
 {
 	struct linux_prom_registers *regs;
 	struct linux_prom_irqs *irqp;
