Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUCQWZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUCQWZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:25:20 -0500
Received: from fep20-0.kolumbus.fi ([193.229.0.47]:37545 "EHLO
	fep20-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261440AbUCQWZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:25:11 -0500
Date: Thu, 18 Mar 2004 00:25:08 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Mike Anderson <andmike@us.ibm.com>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
In-Reply-To: <20040317214434.GF949@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0403180022420.1090@kai.makisara.local>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
 <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk>
 <20040316215659.GA3861@merlin.emma.line.org> <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local>
 <Pine.LNX.4.58.0403172312410.1093@kai.makisara.local> <20040317214434.GF949@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Mike Anderson wrote:

> Kai Makisara [Kai.Makisara@kolumbus.fi] wrote:
> >  		if (!st_class_member) {
> >  			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
> >  			       dev_num);
> 
> Could you change the if check to use IS_ERR(st_class_member) so in the
> future if do_create_class_files return -E* we will not get a oops.
> 
A revised patch is at the end of this message. Thanks for pointing out 
this bug.

-- 
Kai
--------------------------------8<----------------------------------------------
--- linux-2.6.5-rc1-bk2/drivers/scsi/st.c	2004-03-17 22:37:11.000000000 +0200
+++ linux-2.6.5-rc1-bk2-k1/drivers/scsi/st.c	2004-03-18 00:09:07.000000000 +0200
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20040226";
+static char *verstr = "20040318";
 
 #include <linux/module.h>
 
@@ -4193,20 +4193,25 @@
 
 static void do_create_class_files(Scsi_Tape *STp, int dev_num, int mode)
 {
-	int rew, error;
+	int i, rew, error;
+	char name[10];
 	struct class_device *st_class_member;
 
 	if (!st_sysfs_class)
 		return;
 
 	for (rew=0; rew < 2; rew++) {
+		/* Make sure that the minor numbers corresponding to the four
+		   first modes always get the same names */
+		i = mode << (4 - ST_NBR_MODE_BITS);
+		snprintf(name, 10, "%s%s%s", rew ? "n" : "",
+			 STp->disk->disk_name, st_formats[i]);
 		st_class_member =
 			class_simple_device_add(st_sysfs_class,
 						MKDEV(SCSI_TAPE_MAJOR,
 						      TAPE_MINOR(dev_num, mode, rew)),
-						&STp->device->sdev_gendev, "%s",
-						STp->modes[mode].cdevs[rew]->kobj.name);
-		if (!st_class_member) {
+						&STp->device->sdev_gendev, "%s", name);
+		if (IS_ERR(st_class_member)) {
 			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
 			       dev_num);
 			goto out;
