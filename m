Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbUKMDHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUKMDHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbUKMDG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:06:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6408 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262669AbUKMDDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:03:06 -0500
Date: Sat, 13 Nov 2004 04:02:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] misc ISAPNP cleanups
Message-ID: <20041113030234.GX2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some completely unused code and makes some 
needlessly global code static in drivers/pnp/isapnp/core.c .

Please review whether this patch is correct or whether it conflicts with 
pending ISAPNP updates/usages.


diffstat output:
 drivers/pnp/isapnp/core.c |   47 ++++++++------------------------------
 include/linux/isapnp.h    |   20 ----------------
 2 files changed, 11 insertions(+), 56 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/include/linux/isapnp.h.old	2004-11-13 03:28:53.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/isapnp.h	2004-11-13 03:34:16.000000000 +0100
@@ -100,16 +100,7 @@
 int isapnp_cfg_begin(int csn, int device);
 int isapnp_cfg_end(void);
 unsigned char isapnp_read_byte(unsigned char idx);
-unsigned short isapnp_read_word(unsigned char idx);
-unsigned int isapnp_read_dword(unsigned char idx);
 void isapnp_write_byte(unsigned char idx, unsigned char val);
-void isapnp_write_word(unsigned char idx, unsigned short val);
-void isapnp_write_dword(unsigned char idx, unsigned int val);
-void isapnp_wake(unsigned char csn);
-void isapnp_device(unsigned char device);
-void isapnp_activate(unsigned char device);
-void isapnp_deactivate(unsigned char device);
-void *isapnp_alloc(long size);
 
 #ifdef CONFIG_PROC_FS
 int isapnp_proc_init(void);
@@ -119,9 +110,6 @@
 static inline int isapnp_proc_done(void) { return 0; }
 #endif
 
-/* init/main.c */
-int isapnp_init(void);
-
 /* compat */
 struct pnp_card *pnp_find_card(unsigned short vendor,
 			       unsigned short device,
@@ -138,15 +126,7 @@
 static inline int isapnp_cfg_begin(int csn, int device) { return -ENODEV; }
 static inline int isapnp_cfg_end(void) { return -ENODEV; }
 static inline unsigned char isapnp_read_byte(unsigned char idx) { return 0xff; }
-static inline unsigned short isapnp_read_word(unsigned char idx) { return 0xffff; }
-static inline unsigned int isapnp_read_dword(unsigned char idx) { return 0xffffffff; }
 static inline void isapnp_write_byte(unsigned char idx, unsigned char val) { ; }
-static inline void isapnp_write_word(unsigned char idx, unsigned short val) { ; }
-static inline void isapnp_write_dword(unsigned char idx, unsigned int val) { ; }
-static inline void isapnp_wake(unsigned char csn) { ; }
-static inline void isapnp_device(unsigned char device) { ; }
-static inline void isapnp_activate(unsigned char device) { ; }
-static inline void isapnp_deactivate(unsigned char device) { ; }
 
 static inline struct pnp_card *pnp_find_card(unsigned short vendor,
 					     unsigned short device,
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/isapnp/core.c.old	2004-11-13 03:29:38.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/isapnp/core.c	2004-11-13 03:34:26.000000000 +0100
@@ -52,9 +52,9 @@
 #endif
 
 int isapnp_disable;			/* Disable ISA PnP */
-int isapnp_rdp;				/* Read Data Port */
-int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
-int isapnp_verbose = 1;			/* verbose mode */
+static int isapnp_rdp;			/* Read Data Port */
+static int isapnp_reset = 1;		/* reset all PnP cards (deactivate) */
+static int isapnp_verbose = 1;		/* verbose mode */
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Generic ISA Plug & Play support");
@@ -121,7 +121,7 @@
 	return read_data();
 }
 
-unsigned short isapnp_read_word(unsigned char idx)
+static unsigned short isapnp_read_word(unsigned char idx)
 {
 	unsigned short val;
 
@@ -130,38 +130,19 @@
 	return val;
 }
 
-unsigned int isapnp_read_dword(unsigned char idx)
-{
-	unsigned int val;
-
-	val = isapnp_read_byte(idx);
-	val = (val << 8) + isapnp_read_byte(idx+1);
-	val = (val << 8) + isapnp_read_byte(idx+2);
-	val = (val << 8) + isapnp_read_byte(idx+3);
-	return val;
-}
-
 void isapnp_write_byte(unsigned char idx, unsigned char val)
 {
 	write_address(idx);
 	write_data(val);
 }
 
-void isapnp_write_word(unsigned char idx, unsigned short val)
+static void isapnp_write_word(unsigned char idx, unsigned short val)
 {
 	isapnp_write_byte(idx, val >> 8);
 	isapnp_write_byte(idx+1, val);
 }
 
-void isapnp_write_dword(unsigned char idx, unsigned int val)
-{
-	isapnp_write_byte(idx, val >> 24);
-	isapnp_write_byte(idx+1, val >> 16);
-	isapnp_write_byte(idx+2, val >> 8);
-	isapnp_write_byte(idx+3, val);
-}
-
-void *isapnp_alloc(long size)
+static void *isapnp_alloc(long size)
 {
 	void *result;
 
@@ -196,24 +177,24 @@
 	isapnp_write_byte(0x02, 0x02);
 }
 
-void isapnp_wake(unsigned char csn)
+static void isapnp_wake(unsigned char csn)
 {
 	isapnp_write_byte(0x03, csn);
 }
 
-void isapnp_device(unsigned char logdev)
+static void isapnp_device(unsigned char logdev)
 {
 	isapnp_write_byte(0x07, logdev);
 }
 
-void isapnp_activate(unsigned char logdev)
+static void isapnp_activate(unsigned char logdev)
 {
 	isapnp_device(logdev);
 	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 1);
 	udelay(250);
 }
 
-void isapnp_deactivate(unsigned char logdev)
+static void isapnp_deactivate(unsigned char logdev)
 {
 	isapnp_device(logdev);
 	isapnp_write_byte(ISAPNP_CFG_ACTIVATE, 0);
@@ -972,13 +953,7 @@
 EXPORT_SYMBOL(isapnp_cfg_begin);
 EXPORT_SYMBOL(isapnp_cfg_end);
 EXPORT_SYMBOL(isapnp_read_byte);
-EXPORT_SYMBOL(isapnp_read_word);
-EXPORT_SYMBOL(isapnp_read_dword);
 EXPORT_SYMBOL(isapnp_write_byte);
-EXPORT_SYMBOL(isapnp_write_word);
-EXPORT_SYMBOL(isapnp_write_dword);
-EXPORT_SYMBOL(isapnp_wake);
-EXPORT_SYMBOL(isapnp_device);
 
 static int isapnp_read_resources(struct pnp_dev *dev, struct pnp_resource_table *res)
 {
@@ -1070,7 +1045,7 @@
 	.disable = isapnp_disable_resources,
 };
 
-int __init isapnp_init(void)
+static int __init isapnp_init(void)
 {
 	int cards;
 	struct pnp_card *card;

