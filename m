Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVI2UNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVI2UNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVI2UNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:13:48 -0400
Received: from xenotime.net ([66.160.160.81]:39883 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932447AbVI2UNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:13:47 -0400
Date: Thu, 29 Sep 2005 13:13:46 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de,
       torvalds@osdl.org, randy_dunlap <rdunlap@xenotime.net>
Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of Jens'
 SATA suspend-to-ram patch)
In-Reply-To: <433B79D8.9080305@pobox.com>
Message-ID: <Pine.LNX.4.58.0509291309050.1424@shark.he.net>
References: <20050923163334.GA13567@triplehelix.org> <433B79D8.9080305@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Jeff Garzik wrote:

> Joshua Kwan wrote:
> > Hello,
> >
> > I had some time yesterday and decided to help Jens out by rediffing the
> > now-infamous SATA suspend-to-ram patch [1] against current git and
> > test-building it.
> >
> > For posterity,
> >
> > This patch adds the ata_scsi_device_resume and ata_scsi_device_suspend
> > functions (along with helpers) to put to sleep and wake up Serial ATA
> > controllers when entering sleep states, and hooks the functions into
> > each SATA controller driver so that suspend-to-RAM is possible.
> >
> > Note that this patch is a holdover patch until it is possible to
> > generalize this concept for all SCSI devices, which requires more data
> > on which devices need to be put to sleep and which don't.
> >
> > Signed-off-by: Joshua Kwan <joshk@triplehelix.org>
>
> Ah hah!  I found the other SCSI suspend patch:
>
> 	http://lwn.net/Articles/97453/
>
> Anybody (Joshua?) up for reconciling and testing the two?
>
> The main change from Jens/Joshua's patch is that we use SCSI's
> sd_shutdown() to call sync cache, eliminating the need for
> ata_flush_cache(), since the SCSI layer would now perform that.
>
> For bonus points,
>
> 1) sd should call START STOP UNIT on suspend, which eliminates the need
> for ata_standby_drive(), and completely encompasses the suspend process
> in the SCSI layer.
>
> 2) sd should call START STOP UNIT on resume -- and as a SUPER BONUS, the
> combination of these two changes ensures that there are no queue
> synchronization issues, the likes of which would require hacks like
> Jens' while-loop patch.
>
> None of these are huge changes requiring a lot of thinking/planning...
>
> Finally, ideally, we should be issuing a hardware or software reset on
> suspend.

Here's Nathan Bryant's patch (from the lwn.ne article) updated
to 2.6.14-rc2-git7 + changes that Christoph suggested (except
that 'scsi_device_resume' name was already used, so I changed it
to 'scsi_device_wakeup' instead).

I'll get back to Jeff's suggestion(s) and the sysfs flag next,
but others can use this as a basis if wanted.

(also available from
http://www.xenotime.net/linux/scsi/scsi-suspend-resume.patch
)
-- 
~Randy





 drivers/scsi/scsi_priv.h   |    2 +
 drivers/scsi/scsi_sysfs.c  |   39 +++++++++++++++++++++++++++++++++--
 drivers/scsi/sd.c          |   18 +++++++++++++++-
 include/scsi/scsi_driver.h |    2 +
 4 files changed, 58 insertions(+), 3 deletions(-)

diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git7-clean/drivers/scsi/scsi_priv.h linux-2614-rc2-git7-scsi/drivers/scsi/scsi_priv.h
--- linux-2614-rc2-git7-clean/drivers/scsi/scsi_priv.h	2005-09-29 12:58:21.000000000 -0700
+++ linux-2614-rc2-git7-scsi/drivers/scsi/scsi_priv.h	2005-09-29 12:48:00.000000000 -0700
@@ -55,6 +55,8 @@ static inline void scsi_log_send(struct
 static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
 	{ };
 #endif
+extern int scsi_device_suspend(struct device *dev, pm_message_t state);
+extern int scsi_device_wakeup(struct device *dev);

 /* scsi_devinfo.c */
 extern int scsi_get_device_flags(struct scsi_device *sdev,
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git7-clean/drivers/scsi/scsi_sysfs.c linux-2614-rc2-git7-scsi/drivers/scsi/scsi_sysfs.c
--- linux-2614-rc2-git7-clean/drivers/scsi/scsi_sysfs.c	2005-09-29 12:58:25.000000000 -0700
+++ linux-2614-rc2-git7-scsi/drivers/scsi/scsi_sysfs.c	2005-09-29 12:56:16.000000000 -0700
@@ -14,6 +14,7 @@

 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_driver.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport.h>
@@ -264,8 +265,10 @@ static int scsi_bus_match(struct device
 }

 struct bus_type scsi_bus_type = {
-        .name		= "scsi",
-        .match		= scsi_bus_match,
+	.name		= "scsi",
+	.match		= scsi_bus_match,
+	.suspend	= scsi_device_suspend,
+	.resume		= scsi_device_wakeup,
 };

 int scsi_sysfs_register(void)
@@ -770,6 +773,38 @@ void scsi_remove_target(struct device *d
 }
 EXPORT_SYMBOL(scsi_remove_target);

+int scsi_device_suspend(struct device *dev, pm_message_t state)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	err = scsi_device_quiesce(sdev);
+	if (err)
+		return err;
+
+	if (drv->suspend)
+		return drv->suspend(dev, state);
+
+	return 0;
+}
+
+int scsi_device_wakeup(struct device *dev)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	if (drv->resume) {
+		err = drv->resume(dev);
+		if (err)
+			return err;
+	}
+
+	scsi_device_resume(sdev);
+	return 0;
+}
+
 int scsi_register_driver(struct device_driver *drv)
 {
 	drv->bus = &scsi_bus_type;
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git7-clean/drivers/scsi/sd.c linux-2614-rc2-git7-scsi/drivers/scsi/sd.c
--- linux-2614-rc2-git7-clean/drivers/scsi/sd.c	2005-09-29 12:58:25.000000000 -0700
+++ linux-2614-rc2-git7-scsi/drivers/scsi/sd.c	2005-09-29 13:02:10.000000000 -0700
@@ -117,6 +117,8 @@ static void sd_rw_intr(struct scsi_cmnd

 static int sd_probe(struct device *);
 static int sd_remove(struct device *);
+static int sd_suspend(struct device *, pm_message_t);
+static int sd_resume(struct device *);
 static void sd_shutdown(struct device *dev);
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
@@ -136,6 +138,8 @@ static struct scsi_driver sd_template =
 	},
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
+	.suspend		= sd_suspend,
+	.resume			= sd_resume,
 	.issue_flush		= sd_issue_flush,
 	.prepare_flush		= sd_prepare_flush,
 	.end_flush		= sd_end_flush,
@@ -1691,7 +1695,19 @@ static void sd_shutdown(struct device *d
 	printk(KERN_NOTICE "Synchronizing SCSI cache for disk %s: \n",
 			sdkp->disk->disk_name);
 	sd_sync_cache(sdp);
-}
+}
+
+static int sd_suspend(struct device *dev, pm_message_t state)
+{
+	sd_shutdown(dev);
+	return 0;
+}
+
+static int sd_resume(struct device *dev)
+{
+	sd_rescan(dev);
+	return 0;
+}

 /**
  *	init_sd - entry point for this driver (both when built in or when
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git7-clean/include/scsi/scsi_driver.h linux-2614-rc2-git7-scsi/include/scsi/scsi_driver.h
--- linux-2614-rc2-git7-clean/include/scsi/scsi_driver.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc2-git7-scsi/include/scsi/scsi_driver.h	2005-09-29 12:47:43.000000000 -0700
@@ -13,6 +13,8 @@ struct scsi_driver {

 	int (*init_command)(struct scsi_cmnd *);
 	void (*rescan)(struct device *);
+	int (*suspend)(struct device *dev, pm_message_t state);
+	int (*resume)(struct device *dev);
 	int (*issue_flush)(struct device *, sector_t *);
 	int (*prepare_flush)(struct request_queue *, struct request *);
 	void (*end_flush)(struct request_queue *, struct request *);
