Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWFPD46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWFPD46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWFPD46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:56:58 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:53484 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751021AbWFPD45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:56:57 -0400
Date: Fri, 16 Jun 2006 13:56:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix cdrom open
Message-Id: <20060616135631.146a24fe.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Some time ago the cdrom open routine was changed so that we call the
driver's open routine before checking to see if it is read only.  However,
if we discovered that a read write open was not possible and the open
flags required a writable open, we just returned -EROFS without calling
the driver's release routine.   This seems to work for most cdrom drivers,
but breaks the Powerpc iSeries virtual cdrom rather badly.  The following
patch just inserts the release call in the error path.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

It would be good is this could go into 2.6.17 as it affects the new distro
kernels.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a59876a..3170eaa 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1009,9 +1009,9 @@ int cdrom_open(struct cdrom_device_info 
 		if (fp->f_mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
-				goto err;
+				goto err_release;
 			if (!CDROM_CAN(CDC_RAM))
-				goto err;
+				goto err_release;
 			ret = 0;
 			cdi->media_written = 0;
 		}
@@ -1026,6 +1026,8 @@ int cdrom_open(struct cdrom_device_info 
 	    not be mounting, but opening with O_NONBLOCK */
 	check_disk_change(ip->i_bdev);
 	return 0;
+err_release:
+	cdi->ops->release(cdi);
 err:
 	cdi->use_count--;
 	return ret;
