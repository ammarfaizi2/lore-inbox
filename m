Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWIEV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWIEV0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWIEV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:26:47 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:35816 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751422AbWIEV0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:26:45 -0400
Subject: Re: [PATCH] SCSI: Fix refcount breakage with 'echo "1" > scan'
	when target already present
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux SCSI <linux-scsi@vger.kernel.org>, Dror Cohen <dror@xiv.co.il>
In-Reply-To: <20060905183936.GA7268@localdomain>
References: <20060905183936.GA7268@localdomain>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 16:26:41 -0500
Message-Id: <1157491601.3463.81.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 21:39 +0300, Dan Aloni wrote:
> I traced the problem, and figured out that the action above caused the 
> refcount of the kobj in the respective 'struct scsi_target' to be 
> increased without a reason. The bad side effect is that the scsi_host 
> and the scsi_eh_ thread stay alive even after I remove the SCSI driver 
> with rmmod...
> 
> If I do 'echo 1 >" into the 'delete' attr of the target, effectively 
> removing it before I do the scan, the problem doesn't appear (actually,
> it did appear when I did the same with 2.6.16, I guess something was
> fixed along the way).
> 
> I don't think the fix below would be perfect (I think the SCSI layer
> gurus can come up with the something better), but at least it fixes
> the problem for me, so I might as well share it with the world.

There's definitely a problem here.  We have three users of
scsi_alloc_target() in scsi_scan.c; two seem to assume they have to get
the device and the third assumes the device is pre-got.

> It is also possible that I use a broken driver (it's a forward-ported 
> version 3.6.1 of the SATA Marvell driver. It doesn't implement 
> target_alloc, BTW). If you have any idea what needs to be fixed, I'll
> be glad to know.
> 
> Addon: I think there's a missing get_device(parent) in case the
> 'goto retry' branch kicks off. You might want to review it too.

This is spot on.

> Signed-off-by: Dan Aloni <da-xx@monatomic.org>
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 1bd92b9..fca3a93 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -392,12 +392,14 @@ static struct scsi_target *scsi_alloc_ta
>  	spin_unlock_irqrestore(shost->host_lock, flags);
>  	put_device(parent);
>  	if (found_target->state != STARGET_DEL) {
> +		put_device(&found_target->dev);
>  		kfree(starget);
>  		return found_target;
>  	}
>  	/* Unfortunately, we found a dying target; need to
>  	 * wait until it's dead before we can get a new one */
>  	put_device(&found_target->dev);
> +	get_device(parent);

This would fix it, but a better fix is simply to move the
put_device(parent) within the if().  In general, you never want to drop
and re-acquire a reference if you can avoid it, otherwise you have to
worry about you doing a last put and the device being released before
the get.

How does the attached work (I also corrected a potential reap problem)?

James

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 31d05ab..325f8c2 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -266,6 +266,18 @@ static struct scsi_target *__scsi_find_t
 	return found_starget;
 }
 
+/**
+ * scsi_alloc_target - allocate a new or find an existing target
+ * @parent:	parent of the target (need not be a scsi host)
+ * @channel:	target channel number (zero if no channels)
+ * @id:		target id number
+ *
+ * Return an existing target if one exists, provided it hasn't already
+ * gone into STARGET_DEL state, otherwise allocate a new target.
+ *
+ * The target is returned with an incremented reference, so the caller 
+ * is responsible for both reaping and doing a last put
+ */
 static struct scsi_target *scsi_alloc_target(struct device *parent,
 					     int channel, uint id)
 {
@@ -331,14 +343,15 @@ static struct scsi_target *scsi_alloc_ta
 			return NULL;
 		}
 	}
+	get_device(dev);
 
 	return starget;
 
  found:
 	found_target->reap_ref++;
 	spin_unlock_irqrestore(shost->host_lock, flags);
-	put_device(parent);
 	if (found_target->state != STARGET_DEL) {
+		put_device(parent);
 		kfree(starget);
 		return found_target;
 	}
@@ -1341,7 +1354,6 @@ struct scsi_device *__scsi_add_device(st
 	if (!starget)
 		return ERR_PTR(-ENOMEM);
 
-	get_device(&starget->dev);
 	mutex_lock(&shost->scan_mutex);
 	if (scsi_host_scan_allowed(shost))
 		scsi_probe_and_add_lun(starget, lun, NULL, &sdev, 1, hostdata);
@@ -1400,7 +1412,6 @@ static void __scsi_scan_target(struct de
 	if (!starget)
 		return;
 
-	get_device(&starget->dev);
 	if (lun != SCAN_WILD_CARD) {
 		/*
 		 * Scan for a specific host/chan/id/lun.
@@ -1582,7 +1593,8 @@ struct scsi_device *scsi_get_host_dev(st
 	if (sdev) {
 		sdev->sdev_gendev.parent = get_device(&starget->dev);
 		sdev->borken = 0;
-	}
+	} else
+		scsi_target_reap(starget);
 	put_device(&starget->dev);
  out:
 	mutex_unlock(&shost->scan_mutex);


