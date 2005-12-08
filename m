Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVLHWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVLHWhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVLHWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:37:12 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932683AbVLHWgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:36:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=ihZsGbJVimhCVhEITpr3SJMVnNma1gFEUX9ab/fKcH9uCP0+DlKlt2e06dkbPdotGyZYqZ31hgJzhKUZ+R/odB+c1B5z8KCRqbl3SmsFbofRCP8w/ju3k18oFtrKU9NQJjNrgKFBkfBlMGGL77i+uGJ792PSnoTZB5/kDTVDZ0s=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in multipath.c
Date: Thu, 8 Dec 2005 23:36:29 +0100
User-Agent: KMail/1.9
Cc: Ingo Molnar <mingo@elte.hu>, Miguel de Icaza <miguel@nuclecu.unam.mx>,
       Gadi Oxman <gadio@netvision.net.il>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082336.30194.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
drivers/md/multipath.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/md/multipath.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

orig:
   text    data     bss     dec     hex filename
   3747      68       0    3815     ee7 drivers/md/multipath.o

patched:
   text    data     bss     dec     hex filename
   3736      68       0    3804     edc drivers/md/multipath.o

--- linux-2.6.15-rc5-git1-orig/drivers/md/multipath.c	2005-12-04 18:47:49.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/md/multipath.c	2005-12-08 21:30:57.000000000 +0100
@@ -308,6 +308,7 @@ static void print_multipath_conf (multip
 static int multipath_add_disk(mddev_t *mddev, mdk_rdev_t *rdev)
 {
 	multipath_conf_t *conf = mddev->private;
+	struct request_queue *q;
 	int found = 0;
 	int path;
 	struct multipath_info *p;
@@ -316,8 +317,8 @@ static int multipath_add_disk(mddev_t *m
 
 	for (path=0; path<mddev->raid_disks; path++) 
 		if ((p=conf->multipaths+path)->rdev == NULL) {
-			blk_queue_stack_limits(mddev->queue,
-					       rdev->bdev->bd_disk->queue);
+			q = rdev->bdev->bd_disk->queue;
+			blk_queue_stack_limits(mddev->queue, q);
 
 		/* as we don't honour merge_bvec_fn, we must never risk
 		 * violating it, so limit ->max_sector to one PAGE, as
@@ -325,7 +326,7 @@ static int multipath_add_disk(mddev_t *m
 		 * (Note: it is very unlikely that a device with
 		 * merge_bvec_fn will be involved in multipath.)
 		 */
-			if (rdev->bdev->bd_disk->queue->merge_bvec_fn &&
+			if (q->merge_bvec_fn &&
 			    mddev->queue->max_sectors > (PAGE_SIZE>>9))
 				blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 


