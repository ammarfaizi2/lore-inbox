Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932936AbWKLPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWKLPsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932937AbWKLPsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:48:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53443 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932936AbWKLPsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:48:02 -0500
Date: Sun, 12 Nov 2006 16:47:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] floppy: suspend/resume fix
Message-ID: <20061112154711.GA14543@elte.hu>
References: <200611112048.kABKmg2u002509@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611112048.kABKmg2u002509@harpo.it.uu.se>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikael Pettersson <mikpe@it.uu.se> wrote:

> On my old Dell Latitude laptop, the first access to the floppy after 
> having resumed from APM suspend fails miserably and generates these 
> kernel messages (from 2.6.19-rc5):
[...]

> It's only the first post-resume access that triggers this failure, 
> subsequent accesses do work.
> 
> I've traced the cause to Ingo's lockdep patch in 2.6.18-rc1 (see 
> below): reverting it makes the floppy work after resume again.

could you check the patch below? I had to add a platform driver to 
floppy.c to get suspend/resume callbacks, but otherwise it's relatively 
straightforward.

	Ingo

----------------------->
Subject: [patch] floppy: suspend/resume fix
From: Ingo Molnar <mingo@elte.hu>

introduce a floppy platform-driver and suspend/resume ops to
stop/start the floppy driver. Bug reported by Mikael Pettersson.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/block/floppy.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

Index: linux/drivers/block/floppy.c
===================================================================
--- linux.orig/drivers/block/floppy.c
+++ linux/drivers/block/floppy.c
@@ -4157,6 +4157,28 @@ static void floppy_device_release(struct
 	complete(&device_release);
 }
 
+static int floppy_suspend(struct platform_device *dev, pm_message_t state)
+{
+	floppy_release_irq_and_dma();
+
+	return 0;
+}
+
+static int floppy_resume(struct platform_device *dev)
+{
+	floppy_grab_irq_and_dma();
+
+	return 0;
+}
+
+static struct platform_driver floppy_driver = {
+	.suspend	= floppy_suspend,
+	.resume		= floppy_resume,
+	.driver		= {
+		.name	= "floppy",
+	},
+};
+
 static struct platform_device floppy_device[N_DRIVE];
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
@@ -4205,10 +4227,14 @@ static int __init floppy_init(void)
 	if (err)
 		goto out_put_disk;
 
+	err = platform_driver_register(&floppy_driver);
+	if (err)
+		goto out_unreg_blkdev;
+
 	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
 	if (!floppy_queue) {
 		err = -ENOMEM;
-		goto out_unreg_blkdev;
+		goto out_unreg_driver;
 	}
 	blk_queue_max_sectors(floppy_queue, 64);
 
@@ -4352,6 +4378,8 @@ out_flush_work:
 out_unreg_region:
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	blk_cleanup_queue(floppy_queue);
+out_unreg_driver:
+	platform_driver_unregister(&floppy_driver);
 out_unreg_blkdev:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 out_put_disk:
@@ -4543,6 +4571,7 @@ void cleanup_module(void)
 	init_completion(&device_release);
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
+	platform_driver_unregister(&floppy_driver);
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		del_timer_sync(&motor_off_timer[drive]);
