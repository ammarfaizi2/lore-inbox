Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267067AbUBRBWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267088AbUBRBWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:22:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:60822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267067AbUBRBWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:22:11 -0500
Date: Tue, 17 Feb 2004 17:23:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: [BUG] AIC7*** SMP deadlock in ahc_linux_free_device
Message-Id: <20040217172323.1a9bb055.akpm@osdl.org>
In-Reply-To: <20040217102732.GA21221@gondor.apana.org.au>
References: <20040217102732.GA21221@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> The del_timer_sync call in ahc_linux_free_device added in 2.5.67
> leads to an SMP deadlock when the function is called from the timer
> itself in ahc_linux_dev_timed_unfreeze.

Yup, that will deadlock every time on SMP.  The below should fix it.

> I haven't dug too deeply but it seems that there are also possible
> races where ahc_linux_free_device can be called twice on the same
> dev.  Once from the timer and then again from a non-timer location.

Possibly, although it might be the case that external locking and
refcounting prevent this from happening (hopes).



diff -puN drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx-deadlock-fix drivers/scsi/aic7xxx/aic7xxx_osm.c
--- 25/drivers/scsi/aic7xxx/aic7xxx_osm.c~aic7xxx-deadlock-fix	Tue Feb 17 17:21:44 2004
+++ 25-akpm/drivers/scsi/aic7xxx/aic7xxx_osm.c	Tue Feb 17 17:21:44 2004
@@ -3969,11 +3969,10 @@ ahc_linux_alloc_device(struct ahc_softc 
 }
 
 static void
-ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
+__ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
 {
 	struct ahc_linux_target *targ;
 
-	del_timer_sync(&dev->timer);
 	targ = dev->target;
 	targ->devices[dev->lun] = NULL;
 	free(dev, M_DEVBUF);
@@ -3983,6 +3982,13 @@ ahc_linux_free_device(struct ahc_softc *
 		ahc_linux_free_target(ahc, targ);
 }
 
+static void
+ahc_linux_free_device(struct ahc_softc *ahc, struct ahc_linux_device *dev)
+{
+	del_timer_sync(&dev->timer);
+	__ahc_linux_free_device(ahc, dev);
+}
+
 void
 ahc_send_async(struct ahc_softc *ahc, char channel,
 	       u_int target, u_int lun, ac_code code, void *arg)
@@ -4693,7 +4699,7 @@ ahc_linux_dev_timed_unfreeze(u_long arg)
 		ahc_linux_run_device_queue(ahc, dev);
 	if (TAILQ_EMPTY(&dev->busyq)
 	 && dev->active == 0)
-		ahc_linux_free_device(ahc, dev);
+		__ahc_linux_free_device(ahc, dev);
 	ahc_unlock(ahc, &s);
 }
 

_

