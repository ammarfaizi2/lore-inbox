Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbTDAGx2>; Tue, 1 Apr 2003 01:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbTDAGx2>; Tue, 1 Apr 2003 01:53:28 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:45567
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262067AbTDAGx1>; Tue, 1 Apr 2003 01:53:27 -0500
Date: Tue, 1 Apr 2003 02:00:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: gibbs@scsiguy.com
Subject: Re: aic7(censored) use after free in 2.5.66
In-Reply-To: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Zwane Mwaikambo wrote:

> I got this on boot on an 8way/16G box, perhaps Justin should try 
> and push his latest? CONFIG_PREEMPT=y if that makes any difference at 
> all.. If anyone is interested i can provide more info.
> 
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
> 
> Slab corruption: start=f7d66248, expend=f7d662c7, problemat=f7d662ac
> Last user: [<c024f0b7>](ahc_linux_free_device+0x27/0x60)
> Data: 

This probably wants; Or if we can sleep in all the paths, a  
synchronize_kernel after del_timer should suffice.

Justin?

Index: linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 aic7xxx_osm.c
--- linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm.c	24 Mar 2003 23:39:44 -0000	1.1.1.1
+++ linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm.c	1 Apr 2003 06:54:01 -0000
@@ -4097,7 +4097,7 @@ ahc_linux_free_device(struct ahc_softc *
 {
 	struct ahc_linux_target *targ;
 
-	del_timer(&dev->timer);
+	del_timer_sync(&dev->timer);
 	targ = dev->target;
 	targ->devices[dev->lun] = NULL;
 	free(dev, M_DEVBUF);
-- 
function.linuxpower.ca
