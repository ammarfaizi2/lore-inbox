Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWKLRxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWKLRxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKLRxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:53:32 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21914 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751695AbWKLRxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:53:31 -0500
Date: Sun, 12 Nov 2006 18:53:13 +0100 (MET)
Message-Id: <200611121753.kACHrDDi004283@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mingo@elte.hu
Subject: Re: [patch] floppy: suspend/resume fix
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 16:47:12 +0100, Ingo Molnar wrote:
>* Mikael Pettersson <mikpe@it.uu.se> wrote:
>
>> On my old Dell Latitude laptop, the first access to the floppy after 
>> having resumed from APM suspend fails miserably and generates these 
>> kernel messages (from 2.6.19-rc5):
>[...]
>
>> It's only the first post-resume access that triggers this failure, 
>> subsequent accesses do work.
>> 
>> I've traced the cause to Ingo's lockdep patch in 2.6.18-rc1 (see 
>> below): reverting it makes the floppy work after resume again.
>
>could you check the patch below? I had to add a platform driver to 
>floppy.c to get suspend/resume callbacks, but otherwise it's relatively 
>straightforward.

Sorry, no joy. The first access post-resume still fails and generates:

floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 8
Buffer I/O error on device fd0, logical block 1
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 16
Buffer I/O error on device fd0, logical block 2
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 24
Buffer I/O error on device fd0, logical block 3
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 32
Buffer I/O error on device fd0, logical block 4
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 40
Buffer I/O error on device fd0, logical block 5
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 48
Buffer I/O error on device fd0, logical block 6
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 56
Buffer I/O error on device fd0, logical block 7
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0

The 2nd etc post-resume accesses work like before.

Your patch did change the failure behaviour slightly.
Previously the first post-resume access would experience
a delay of about a second or so, and then report an error.
With this patch the error is immediate.

/Mikael

>	Ingo
>
>----------------------->
>Subject: [patch] floppy: suspend/resume fix
>From: Ingo Molnar <mingo@elte.hu>
>
>introduce a floppy platform-driver and suspend/resume ops to
>stop/start the floppy driver. Bug reported by Mikael Pettersson.
>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>---
> drivers/block/floppy.c |   31 ++++++++++++++++++++++++++++++-
> 1 file changed, 30 insertions(+), 1 deletion(-)
>
>Index: linux/drivers/block/floppy.c
>===================================================================
>--- linux.orig/drivers/block/floppy.c
>+++ linux/drivers/block/floppy.c
>@@ -4157,6 +4157,28 @@ static void floppy_device_release(struct
> 	complete(&device_release);
> }
> 
>+static int floppy_suspend(struct platform_device *dev, pm_message_t state)
>+{
>+	floppy_release_irq_and_dma();
>+
>+	return 0;
>+}
>+
>+static int floppy_resume(struct platform_device *dev)
>+{
>+	floppy_grab_irq_and_dma();
>+
>+	return 0;
>+}
>+
>+static struct platform_driver floppy_driver = {
>+	.suspend	= floppy_suspend,
>+	.resume		= floppy_resume,
>+	.driver		= {
>+		.name	= "floppy",
>+	},
>+};
>+
> static struct platform_device floppy_device[N_DRIVE];
> 
> static struct kobject *floppy_find(dev_t dev, int *part, void *data)
>@@ -4205,10 +4227,14 @@ static int __init floppy_init(void)
> 	if (err)
> 		goto out_put_disk;
> 
>+	err = platform_driver_register(&floppy_driver);
>+	if (err)
>+		goto out_unreg_blkdev;
>+
> 	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
> 	if (!floppy_queue) {
> 		err = -ENOMEM;
>-		goto out_unreg_blkdev;
>+		goto out_unreg_driver;
> 	}
> 	blk_queue_max_sectors(floppy_queue, 64);
> 
>@@ -4352,6 +4378,8 @@ out_flush_work:
> out_unreg_region:
> 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
> 	blk_cleanup_queue(floppy_queue);
>+out_unreg_driver:
>+	platform_driver_unregister(&floppy_driver);
> out_unreg_blkdev:
> 	unregister_blkdev(FLOPPY_MAJOR, "fd");
> out_put_disk:
>@@ -4543,6 +4571,7 @@ void cleanup_module(void)
> 	init_completion(&device_release);
> 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
> 	unregister_blkdev(FLOPPY_MAJOR, "fd");
>+	platform_driver_unregister(&floppy_driver);
> 
> 	for (drive = 0; drive < N_DRIVE; drive++) {
> 		del_timer_sync(&motor_off_timer[drive]);
>
