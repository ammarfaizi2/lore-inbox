Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSKSFMb>; Tue, 19 Nov 2002 00:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267087AbSKSFMb>; Tue, 19 Nov 2002 00:12:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27387 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267085AbSKSFMa>;
	Tue, 19 Nov 2002 00:12:30 -0500
Date: Mon, 18 Nov 2002 21:17:30 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 and SCSI ? (devfs problem!!!)
Message-ID: <20021118211730.A24422@eng2.beaverton.ibm.com>
References: <20021118203605.GC8357@ulima.unil.ch> <Pine.LNX.4.44.0211182329020.736-100000@kai.makisara.local> <20021118214922.GA9613@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021118214922.GA9613@ulima.unil.ch>; from greg@ulima.unil.ch on Mon, Nov 18, 2002 at 10:49:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 10:49:22PM +0100, Gregoire Favre wrote:
> On Mon, Nov 18, 2002 at 11:33:58PM +0200, Kai Makisara wrote:
> > I had the same problem with sym53c8xxx_2 when devfs was configured into
> > the kernel (but not mounted). Then I made a kernel with devfs disabled and
> > now this boots (and seems to work).
> 
> Hello,
> 
> well, I "need" devfs and it is mounted... I really don't want to create
> all the devices I use... At least now I know where does the prolem come
> from ;-)
> 
> Thank you very much,
> 
> 	Grégoire

Here's a patch you can try out, I already posted this to linux-scsi
as a fix for /proc/scsi not showing up, I'll make sure James or
someone pushes it to Linus' tree. I don't use devfs.

This is against linus bk but should apply fine against 2.5.48.

-- Patrick Mansfield

===== scsi.c 1.67 vs edited =====
--- 1.67/drivers/scsi/scsi.c	Mon Nov 18 08:42:42 2002
+++ edited/scsi.c	Mon Nov 18 16:14:23 2002
@@ -2225,6 +2225,8 @@
 			printk(KERN_ERR "SCSI: can't init sg mempool %s\n", sgp->name);
 	}
 
+	scsi_init_procfs();
+	scsi_devfs_handle = devfs_mk_dir(NULL, "scsi", NULL);
 	scsi_host_init();
 	scsi_dev_info_list_init(scsi_dev_flags);
 	bus_register(&scsi_driverfs_bus_type);
@@ -2236,9 +2238,10 @@
 {
 	int i;
 
+	bus_unregister(&scsi_driverfs_bus_type);
+	scsi_dev_info_list_delete();
 	devfs_unregister(scsi_devfs_handle);
 	scsi_exit_procfs();
-	scsi_dev_info_list_delete();
 
 	for (i = 0; i < SG_MEMPOOL_NR; i++) {
 		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
