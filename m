Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274874AbTHKW2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274871AbTHKW2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:28:49 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:19720 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S274870AbTHKW2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:28:46 -0400
Date: Tue, 12 Aug 2003 00:28:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-scsi@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] oops in sd_shutdown
Message-ID: <20030812002844.B1353@pclin040.win.tue.nl>
References: <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher>; from number6@cox.net on Mon, Aug 11, 2003 at 02:38:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see an Oops in the SCSI code, caused by the fact that sdkp is NULL
in sd_shutdown. "How can that be?", you will ask - dev->driver_data was set
in sd_probe. But in my case sd_probe never finished. An insmod usb-storage
hangs forever, or at least for more than six hours, giving ample opportunity
to observe this race between sd_probe and sd_shutdown.
(Of course sd_probe hangs in sd_revalidate disk.)

Perhaps the obvious test is a good idea.
Locking seems meaningless - sd_probe will never finish.

Andries

[Probably the init of usb_storage should start probing the devices in separate
threads, in parallel, and return immediately.]

The obvious patch (with whitespace damage)

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c Mon Jul 28 05:39:31 2003
+++ b/drivers/scsi/sd.c Tue Aug 12 01:24:51 2003
@@ -1351,10 +1351,14 @@
 static void sd_shutdown(struct device *dev)
 {
        struct scsi_device *sdp = to_scsi_device(dev);
-       struct scsi_disk *sdkp = dev_get_drvdata(dev);
+       struct scsi_disk *sdkp;
        struct scsi_request *sreq;
        int retries, res;
 
+       sdkp = dev_get_drvdata(dev);
+       if (!sdkp)
+               return;         /* this can happen */
+
        if (!sdp->online || !sdkp->WCE)
                return;
 

