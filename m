Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbTIKFg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbTIKFg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:36:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266104AbTIKFgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:36:23 -0400
Date: Thu, 11 Sep 2003 06:36:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <linus@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ps2esdi broken
Message-ID: <20030911053622.GR454@parcelfarce.linux.theplanet.co.uk>
References: <3F5FF829.6060706@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5FF829.6060706@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:20:57PM -0700, Stephen Hemminger wrote:
> This driver has problems all over the place and needs
> to be be disabled (or deleted)
> 
> diff -Nru a/drivers/block/Kconfig b/drivers/block/Kconfig
> --- a/drivers/block/Kconfig    Wed Sep 10 21:15:51 2003
> +++ b/drivers/block/Kconfig    Wed Sep 10 21:15:51 2003
> @@ -44,7 +44,7 @@
> 
> config BLK_DEV_PS2
>     tristate "PS/2 ESDI hard disk support"
> -    depends on MCA
> +    depends on MCA && BROKEN
>     help
>       Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
>       hard disk.

Or just the following, since these problems are actually a couple of
typos on the modular side and misuse of module_init():

diff -urN B5-misc4/drivers/block/Kconfig B5-current/drivers/block/Kconfig
--- B5-misc4/drivers/block/Kconfig	Mon Jul 28 11:13:03 2003
+++ B5-current/drivers/block/Kconfig	Thu Sep 11 01:16:22 2003
@@ -44,7 +44,7 @@
 
 config BLK_DEV_PS2
 	tristate "PS/2 ESDI hard disk support"
-	depends on MCA
+	depends on MCA && MCA_LEGACY
 	help
 	  Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
 	  hard disk.
diff -urN B5-misc4/drivers/block/ps2esdi.c B5-current/drivers/block/ps2esdi.c
--- B5-misc4/drivers/block/ps2esdi.c	Sat Aug  9 02:20:46 2003
+++ B5-current/drivers/block/ps2esdi.c	Thu Sep 11 01:18:39 2003
@@ -62,8 +62,6 @@
 
 static void reset_ctrl(void);
 
-int ps2esdi_init(void);
-
 static int ps2esdi_geninit(void);
 
 static void do_ps2esdi_request(request_queue_t * q);
@@ -141,7 +139,7 @@
 static struct gendisk *ps2esdi_gendisk[2];
 
 /* initialization routine called by ll_rw_blk.c   */
-int __init ps2esdi_init(void)
+static int __init ps2esdi_init(void)
 {
 
 	int error = 0;
@@ -169,9 +167,11 @@
 	return 0;
 }				/* ps2esdi_init */
 
+#ifndef MODULE
+
 module_init(ps2esdi_init);
 
-#ifdef MODULE
+#else
 
 static int cyl[MAX_HD] = {-1,-1};
 static int head[MAX_HD] = {-1, -1};
@@ -187,7 +187,7 @@
 	int drive;
 
 	for(drive = 0; drive < MAX_HD; drive++) {
-	        struct ps2_esdi_i_struct *info = &ps2esdi_info[drive];
+	        struct ps2esdi_i_struct *info = &ps2esdi_info[drive];
 
         	if (cyl[drive] != -1) {
 		  	info->cyl = info->lzone = cyl[drive];
@@ -204,6 +204,7 @@
 
 void
 cleanup_module(void) {
+	int i;
 	if(ps2esdi_slot) {
 		mca_mark_as_unused(ps2esdi_slot);
 		mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);
