Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbVKRVAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbVKRVAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbVKRVAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:00:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38194 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161203AbVKRVAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:00:18 -0500
Date: Fri, 18 Nov 2005 22:01:24 +0100
From: Jens Axboe <axboe@suse.de>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] cciss: bug fix for BIG_PASS_THRU
Message-ID: <20051118210123.GC25454@suse.de>
References: <20051118164112.GA14937@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118164112.GA14937@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18 2005, mikem wrote:
> Patch 2 of 3
> 
> Applications using CCISS_BIG_PASSTHRU complained that the data written
> was zeros.  The code looked alright, but it seems that copy_from_user 
> already does a memset on the buffer. Removing it from the pass-through
> fixes the apps.

Hmm, I don't like this patch, since you never clear the buffer for reads
now. If the controller for some reason doesn't overwrite this buffer,
you could be leaking privileged data! Your bug is because you do:

        if (write && copy_from_user(...))
                fail
        else
                clear

so you end up in the clear case for any case where copy_from_user()
doesn't fail. I've fixed it up for you, this is what I committed:

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index e239a6c..33f8341 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1017,10 +1017,11 @@ static int cciss_ioctl(struct inode *ino
 				status = -ENOMEM;
 				goto cleanup1;
 			}
-			if (ioc->Request.Type.Direction == XFER_WRITE &&
-				copy_from_user(buff[sg_used], data_ptr, sz)) {
+			if (ioc->Request.Type.Direction == XFER_WRITE) {
+				if (copy_from_user(buff[sg_used], data_ptr, sz)) {
 					status = -ENOMEM;
-					goto cleanup1;			
+					goto cleanup1;
+				}
 			} else {
 				memset(buff[sg_used], 0, sz);
 			}

-- 
Jens Axboe

