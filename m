Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTEBENa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 00:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTEBENa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 00:13:30 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:24336 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261287AbTEBEN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 00:13:26 -0400
Date: Thu, 01 May 2003 22:25:31 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Willy Tarreau <willy@w.ods.org>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <700140000.1051849531@aslan.scsiguy.com>
In-Reply-To: <20030502001758.GA20977@alpha.home.local>
References: <1866260000.1051828092@aslan.btc.adaptec.com> <20030502001758.GA20977@alpha.home.local>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 01, 2003 at 04:28:12PM -0600, Justin T. Gibbs wrote:
>> Folks,
>> 
>> I've just uploaded version 1.3.8 of the aic79xx driver and version 
>> 6.2.33 of the aic7xxx driver.  Both are available for 2.4.X and
>> 2.5.X kernels in either bk send format or as a tarball from here:
>> 
>> http://people.FreeBSD.org/~gibbs/linux/SRC/
> 
> Hi Justin,
> 
> I've just tested it and I still have the deadlock on SMP. I also tried with
> noapic, but it didn't change. I have reduced the TCQ from 253 to 32, and I
> had the impression that it was more difficult to trigger, although I cannot
> be certain. With 32, I could boot and go to about half the 'make -j 8 dep',
> while it hanged during init script with 253. I may retest by the week-end, but
> now I'm going to sleep. Now I'm back to 6.2.28 and everything's OK.

Can you try with this patch?  It seems I forgot to pull part of a change
from the aic79xx driver into the aic7xxx driver.  This could easily cause
a lock order reversal. <sigh>

==== //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic79xx_osm.c#159 - /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic79xx_osm.c ====
--- /tmp/tmp.29873.0	2003-05-01 22:21:54.000000000 -0600
+++ /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic79xx_osm.c	2003-05-01 22:04:07.000000000 -0600
@@ -670,7 +670,6 @@
 		TAILQ_REMOVE(&ahd->platform_data->completeq,
 			     acmd, acmd_links.tqe);
 		cmd = &acmd_scsi_cmd(acmd);
-		acmd = TAILQ_NEXT(acmd, acmd_links.tqe);
 		cmd->host_scribble = NULL;
 		if (ahd_cmd_get_transaction_status(cmd) != DID_OK
 		 || (cmd->result & 0xFF) != SCSI_STATUS_OK)
@@ -1756,9 +1755,11 @@
 		TAILQ_REMOVE(&ahd->platform_data->device_runq, dev, links);
 		dev->flags &= ~AHD_DEV_ON_RUN_LIST;
 		ahd_linux_check_device_queue(ahd, dev);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		/* Yeild to our interrupt handler */
 		ahd_unlock(ahd, &flags);
 		ahd_lock(ahd, &flags);
+#endif
 	}
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	ahd_unlock(ahd, &flags);
==== //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c#220 - /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic7xxx_osm.c ====
--- /tmp/tmp.29873.1	2003-05-01 22:21:54.000000000 -0600
+++ /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-01 22:19:46.000000000 -0600
@@ -664,7 +664,6 @@
 		TAILQ_REMOVE(&ahc->platform_data->completeq,
 			     acmd, acmd_links.tqe);
 		cmd = &acmd_scsi_cmd(acmd);
-		acmd = TAILQ_NEXT(acmd, acmd_links.tqe);
 		cmd->host_scribble = NULL;
 		if (ahc_cmd_get_transaction_status(cmd) != DID_OK
 		 || (cmd->result & 0xFF) != SCSI_STATUS_OK)
@@ -1385,9 +1384,11 @@
 		TAILQ_REMOVE(&ahc->platform_data->device_runq, dev, links);
 		dev->flags &= ~AHC_DEV_ON_RUN_LIST;
 		ahc_linux_check_device_queue(ahc, dev);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		/* Yeild to our interrupt handler */
 		ahc_unlock(ahc, &flags);
 		ahc_lock(ahc, &flags);
+#endif
 	}
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	ahc_unlock(ahc, &flags);
==== //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.h#140 - /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic7xxx_osm.h ====
--- /tmp/tmp.29873.2	2003-05-01 22:21:54.000000000 -0600
+++ /home/gibbs/bk/linux-2.4/drivers/scsi/aic7xxx/aic7xxx_osm.h	2003-05-01 22:21:10.000000000 -0600
@@ -737,7 +737,8 @@
 	 * trade the io_request_lock for our per-softc lock.
 	 */
 #if AHC_SCSI_HAS_HOST_LOCK == 0
-	ahc_lock(ahc, flags);
+	spin_unlock(&io_request_lock);
+	spin_lock(&ahc->platform_data->spin_lock);
 #endif
 }
 
@@ -745,7 +746,8 @@
 ahc_midlayer_entrypoint_unlock(struct ahc_softc *ahc, unsigned long *flags)
 {
 #if AHC_SCSI_HAS_HOST_LOCK == 0
-	ahc_unlock(ahc, flags);
+	spin_unlock(&ahd->platform_data->spin_lock);
+	spin_lock(&io_request_lock);
 #endif
 }
 

