Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCQVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUCQVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:18:57 -0500
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:57507 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262073AbUCQVSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:18:44 -0500
Date: Wed, 17 Mar 2004 23:18:40 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Matthias Andree <ma+lscsi@dt.e-technik.uni-dortmund.de>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.5-rc1 SCSI + st regressions (was: Linux 2.6.5-rc1)
In-Reply-To: <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local>
Message-ID: <Pine.LNX.4.58.0403172312410.1093@kai.makisara.local>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
 <20040316211203.GA3679@merlin.emma.line.org> <20040316211700.GA25059@parcelfarce.linux.theplanet.co.uk>
 <20040316215659.GA3861@merlin.emma.line.org> <Pine.LNX.4.58.0403172145420.1093@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Kai Makisara wrote:

> On Tue, 16 Mar 2004, Matthias Andree wrote:
> 
> > On Tue, 16 Mar 2004, Matthew Wilcox wrote:
> > 
> > > On Tue, Mar 16, 2004 at 10:12:03PM +0100, Matthias Andree wrote:
> > > > I have some SCSI troubles with 2.6.5-rc1 (from BK) that 2.6.4 didn't
> > > > have.
> > > > 
> > > > Modprobe, loading the st driver, tries a NULL pointer dereference in
> > > > kernel space and my 2nd tape drive isn't found: st1 is not shown. cat
> > > > /proc/scsi/scsi (typed after the attempted zero page dereference) hangs
> > > > in rwsem_down_read_failed with process state D.
> > > 
> > > I notice you're using the sym2 driver.  Could you try backing out the
> > > changes made to it in 2.6.5-rc1, just to be sure we're looking at an st
> > > problem, not a sym2 problem?
> > 
...
> st.c is using the name put into kobj.name in making 
> the class file names. I will make a patch that removes this dependency.
> 
The patch at the end of this message removes the dependency on the kobj 
name being set. It also tries to once more restore the naming that is 
defined in devices.txt. The patch is against 2.6.5-rc1-bk2 and it seems to 
work correctly in my tests.

-- 
Kai
------------------------------8<-------------------------------------------
--- linux-2.6.5-rc1-bk2/drivers/scsi/st.c	2004-03-17 22:37:11.000000000 +0200
+++ linux-2.6.5-rc1-bk2-k1/drivers/scsi/st.c	2004-03-17 23:03:57.000000000 +0200
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20040226";
+static char *verstr = "20040317";
 
 #include <linux/module.h>
 
@@ -4193,19 +4193,24 @@
 
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
+						&STp->device->sdev_gendev, "%s", name);
 		if (!st_class_member) {
 			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
 			       dev_num);
