Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVAHILe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVAHILe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVAHIKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:10:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:23941 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261819AbVAHFsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:02 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627732623@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:33 -0800
Message-Id: <11051627732076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.45, 2005/01/06 13:54:20-08:00, khali@linux-fr.org

[PATCH] I2C: Add secondary Super-I/O address support to

This patch adds support for the secondary Super-I/O address to the
w83627hf driver. Most manufacturer use the primary address but at least
the EPoX EP-9NDA3+ had a Winbond W83627THF at the secondary address.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-01-07 14:54:49 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-01-07 14:54:49 -08:00
@@ -67,9 +67,9 @@
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
 /* modified from kernel/include/traps.c */
-#define	REG	0x2e	/* The register to read/write */
+static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
-#define	VAL	0x2f	/* The value to read/write */
+static int VAL;		/* The value to read/write */
 
 /* logical device numbers for superio_select (below) */
 #define W83627HF_LD_FDC		0x00
@@ -938,10 +938,13 @@
 	return i2c_detect(adapter, &addr_data, w83627hf_detect);
 }
 
-static int w83627hf_find(int *address)
+static int w83627hf_find(int sioaddr, int *address)
 {
 	u16 val;
 
+	REG = sioaddr;
+	VAL = sioaddr + 1;
+
 	superio_enter();
 	val= superio_inb(DEVID);
 	if(val != W627_DEVID &&
@@ -1422,7 +1425,8 @@
 {
 	int addr;
 
-	if (w83627hf_find(&addr)) {
+	if (w83627hf_find(0x2e, &addr)
+	 && w83627hf_find(0x4e, &addr)) {
 		return -ENODEV;
 	}
 	normal_isa[0] = addr;

