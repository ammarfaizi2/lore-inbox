Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSL3Bfs>; Sun, 29 Dec 2002 20:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSL3Bfs>; Sun, 29 Dec 2002 20:35:48 -0500
Received: from smtp.terra.es ([213.4.129.129]:64815 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S265806AbSL3Bfo>;
	Sun, 29 Dec 2002 20:35:44 -0500
Date: Mon, 30 Dec 2002 02:43:40 +0100
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.4: opl3.c release_region() race
Message-Id: <20021230024340.67f8cd9e.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch *tries* to do some cleanup in the adlib_card.c & opl3.c files in current 2.4
First, adlib_card.c is a module that requires the opl3 module.
Actually, the code has the following bug:
 o Compile opl3 and adlib_card as module
 o insmod opl3 without io= parameter
 o insmod adlib_card: it does request_region()
 o rmmod adlib_card it doesn't do release_region()
 o rmmod opl3: it doesn't do release_region()

So this "fix" does the following:
 o Remove a silly typedef not used
 o adlib_card uses op3_detect & opl3_init. 
	opl3_detect inizializates some things
	(ie: it does request_region() there)
	so i renamed opl3_detect to opl3_init
	and added a call to the old opl3_init.
 o So i killed adlib_card.c:probe_adlib, now only attach_adlib_card remains
 o Also fixed some return paths (ie: returning 0 on error)
 o Now the release_region() bug is fixed.
 o Though i'm sure it has problems.
	It's my second patch so it *has* some errors, comments?

PD: I don't know who is the maintainer of this driver, so i send it, hope
it doesn't get lost in the noise.

diff -ruN sta/drivers/sound/adlib_card.c sta-opl3/drivers/sound/adlib_card.c
--- sta/drivers/sound/adlib_card.c	2001-09-30 21:26:08.000000000 +0200
+++ sta-opl3/drivers/sound/adlib_card.c	2002-12-27 20:35:20.000000000 +0100
@@ -17,14 +17,18 @@
 
 #include "opl3.h"
 
-static void __init attach_adlib_card(struct address_info *hw_config)
+static int __init attach_adlib_card(struct address_info *hw_config)
 {
-	hw_config->slots[0] = opl3_init(hw_config->io_base, hw_config->osp, THIS_MODULE);
-}
-
-static int __init probe_adlib(struct address_info *hw_config)
-{
-	return opl3_detect(hw_config->io_base, hw_config->osp);
+	int ret = -1;
+	ret = opl3_modinit(hw_config->io_base, hw_config->osp, THIS_MODULE);
+	if (ret == -1)
+	{
+		return ret;
+	}	
+	else
+		hw_config->slots[0] = ret;
+	
+	return 0;
 }
 
 static struct address_info cfg;
@@ -41,15 +45,16 @@
 		printk(KERN_ERR "adlib: must specify I/O address.\n");
 		return -EINVAL;
 	}
-	if (probe_adlib(&cfg) == 0)
+
+	if (attach_adlib_card(&cfg) == -1)
 		return -ENODEV;
-	attach_adlib_card(&cfg);
 
 	return 0;
 }
 
 static void __exit cleanup_adlib(void)
 {
+	opl3_modclose();
 	sound_unload_synthdev(cfg.slots[0]);
 	
 }
diff -ruN sta/drivers/sound/opl3.c sta-opl3/drivers/sound/opl3.c
--- sta/drivers/sound/opl3.c	2001-09-30 21:26:08.000000000 +0200
+++ sta-opl3/drivers/sound/opl3.c	2002-12-27 20:40:21.000000000 +0100
@@ -52,7 +52,7 @@
 	int             panning;	/* 0xffff means not set */
 };
 
-typedef struct opl_devinfo
+struct opl_devinfo
 {
 	int             base;
 	int             left_io, right_io;
@@ -74,16 +74,20 @@
 
 	int             is_opl4;
 	int            *osp;
-} opl_devinfo;
+};
 
 static struct opl_devinfo *devc = NULL;
 
 static int      detected_model;
+static int	me = -1;
+static int	io = -1;
 
 static int      store_instr(int instr_no, struct sbi_instrument *instr);
 static void     freq_to_fnum(int freq, int *block, int *fnum);
 static void     opl3_command(int io_addr, unsigned int addr, unsigned int val);
 static int      opl3_kill_note(int dev, int voice, int note, int velocity);
+static int 	opl3_endinit(int ioaddr, int *osp, struct module *owner);
+static void 	__exit cleanup_opl3(void);
 
 static void enter_4op_mode(void)
 {
@@ -144,7 +148,7 @@
 	}
 }
 
-int opl3_detect(int ioaddr, int *osp)
+int opl3_init(int ioaddr, int *osp, struct module *owner)
 {
 	/*
 	 * This function returns 1 if the FM chip is present at the given I/O port
@@ -160,10 +164,16 @@
 	unsigned char stat1, signature;
 	int i;
 
+	if (io != -1)
+	{
+		printk(KERN_INFO "opl3: module initializated before\n");
+		return me;
+	}
+
 	if (devc != NULL)
 	{
 		printk(KERN_ERR "opl3: Only one OPL3 supported.\n");
-		return 0;
+		return -1;
 	}
 
 	devc = (struct opl_devinfo *)kmalloc(sizeof(*devc), GFP_KERNEL);
@@ -172,7 +182,7 @@
 	{
 		printk(KERN_ERR "opl3: Can't allocate memory for the device control "
 			"structure \n ");
-		return 0;
+		return -1;
 	}
 
 	memset(devc, 0, sizeof(*devc));
@@ -180,7 +190,9 @@
 
 	if (!request_region(ioaddr, 4, devc->fm_info.name)) {
 		printk(KERN_WARNING "opl3: I/O port 0x%x already in use\n", ioaddr);
-		goto cleanup_devc;
+		kfree(devc);
+		devc = NULL;
+		return -1;
 	}
 
 	devc->osp = osp;
@@ -259,13 +271,17 @@
 	opl3_command(ioaddr, PERCOSSION_REGISTER, 0x00);	/*
 								 * Melodic mode.
 								 */
-	return 1;
+	/* 
+	 * Now the card is semi-initialized. Let's
+	 * call the rest of the initialization
+	 */
+	return opl3_endinit(ioaddr, osp, owner);
+
 cleanup_region:
 	release_region(ioaddr, 4);
-cleanup_devc:
 	kfree(devc);
 	devc = NULL;
-	return 0;
+	return -1;
 }
 
 static int opl3_kill_note  (int devno, int voice, int note, int velocity)
@@ -1102,10 +1118,10 @@
 	setup_voice:	opl3_setup_voice
 };
 
-int opl3_init(int ioaddr, int *osp, struct module *owner)
+static int opl3_endinit(int ioaddr, int *osp, struct module *owner)
 {
 	int i;
-	int me;
+	int nrsynth = -1;
 
 	if (devc == NULL)
 	{
@@ -1113,7 +1129,7 @@
 		return -1;
 	}
 
-	if ((me = sound_alloc_synthdev()) == -1)
+	if ((nrsynth = sound_alloc_synthdev()) == -1)
 	{
 		printk(KERN_WARNING "opl3: Too many synthesizers\n");
 		return -1;
@@ -1143,10 +1159,10 @@
 
 	opl3_operations.info = &devc->fm_info;
 
-	synth_devs[me] = &opl3_operations;
+	synth_devs[nrsynth] = &opl3_operations;
 
 	if (owner)
-		synth_devs[me]->owner = owner;
+		synth_devs[nrsynth]->owner = owner;
 	
 	sequencer_init();
 	devc->v_alloc = &opl3_operations.alloc;
@@ -1188,15 +1204,19 @@
 	for (i = 0; i < SBFM_MAXINSTR; i++)
 		devc->i_map[i].channel = -1;
 
-	return me;
-}
+	/* Not really useful */
+	me = nrsynth;
 
-EXPORT_SYMBOL(opl3_init);
-EXPORT_SYMBOL(opl3_detect);
+	return nrsynth;
+}
 
-static int me;
+void opl3_modclose(void)
+{
+	cleanup_opl3();
+}
 
-static int io = -1;
+EXPORT_SYMBOL(opl3_modinit);
+EXPORT_SYMBOL(opl3_modclose);
 
 MODULE_PARM(io, "i");
 
@@ -1206,12 +1226,11 @@
 
 	if (io != -1)	/* User loading pure OPL3 module */
 	{
-		if (!opl3_detect(io, NULL))
+		me = opl3_modinit(io, NULL, THIS_MODULE);
+		if (me == -1)
 		{
 			return -ENODEV;
 		}
-
-		me = opl3_init(io, NULL, THIS_MODULE);
 	}
 
 	return 0;
@@ -1229,6 +1248,8 @@
 		kfree(devc);
 		devc = NULL;
 		sound_unload_synthdev(me);
+		me = -1;
+		io = -1;
 	}
 }
 
diff -ruN sta/drivers/sound/opl3.h sta-opl3/drivers/sound/opl3.h
--- sta/drivers/sound/opl3.h	2002-02-25 20:38:06.000000000 +0100
+++ sta-opl3/drivers/sound/opl3.h	2002-12-27 17:00:59.000000000 +0100
@@ -1,5 +1,5 @@
 
-int opl3_detect (int ioaddr, int *osp);
-int opl3_init(int ioaddr, int *osp, struct module *owner);
+int opl3_modinit(int ioaddr, int *osp, struct module *owner);
+void opl3_modclose(void);
 
 void enable_opl3_mode(int left, int right, int both);
