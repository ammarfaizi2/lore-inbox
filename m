Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVLLOGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVLLOGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLLOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:06:03 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:15039 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751202AbVLLOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:06:02 -0500
Date: Mon, 12 Dec 2005 15:05:47 +0100
From: Cornelia Huck <huckc@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.15-rc5-mm2
Message-ID: <20051212150547.62941e2a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
References: <20051211041308.7bb19454.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the following patch fixes the issues in
s390-introduce-struct-channel_subsystem.patch and
s390-convert-proc-cio_ignore.patch.

s390: Fix missing release function and cosmetic changes.

- Use kzalloc() in blacklist.c.
- Kill unwanted casts in blacklist.c.
- Provide release function for struct channel_subsystem.

Signed-off-by: Cornelia Huck <huckc@de.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

 blacklist.c |    7 +++----
 css.c       |   10 ++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff -Naurp linux-2.6.15-rc5-mm2/drivers/s390/cio/blacklist.c linux-2.6.15-rc5-mm2+cio/drivers/s390/cio/blacklist.c
--- linux-2.6.15-rc5-mm2/drivers/s390/cio/blacklist.c	2005-12-12 13:20:53.000000000 +0100
+++ linux-2.6.15-rc5-mm2+cio/drivers/s390/cio/blacklist.c	2005-12-12 13:21:05.000000000 +0100
@@ -299,10 +299,9 @@ cio_ignore_proc_seq_start(struct seq_fil
 
 	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
-	iter = kmalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
+	iter = kzalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
-	memset(iter, 0, sizeof(struct ccwdev_iter));
 	iter->ssid = *offset / (__MAX_SUBCHANNEL + 1);
 	iter->devno = *offset % (__MAX_SUBCHANNEL + 1);
 	return iter;
@@ -322,7 +321,7 @@ cio_ignore_proc_seq_next(struct seq_file
 
 	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
-	iter = (struct ccwdev_iter *)it;
+	iter = it;
 	if (iter->devno == __MAX_SUBCHANNEL) {
 		iter->devno = 0;
 		iter->ssid++;
@@ -339,7 +338,7 @@ cio_ignore_proc_seq_show(struct seq_file
 {
 	struct ccwdev_iter *iter;
 
-	iter = (struct ccwdev_iter *)it;
+	iter = it;
 	if (!is_blacklisted(iter->ssid, iter->devno))
 		/* Not blacklisted, nothing to output. */
 		return 0;
diff -Naurp linux-2.6.15-rc5-mm2/drivers/s390/cio/css.c linux-2.6.15-rc5-mm2+cio/drivers/s390/cio/css.c
--- linux-2.6.15-rc5-mm2/drivers/s390/cio/css.c	2005-12-12 13:20:53.000000000 +0100
+++ linux-2.6.15-rc5-mm2+cio/drivers/s390/cio/css.c	2005-12-12 13:21:05.000000000 +0100
@@ -444,6 +444,15 @@ css_generate_pgid(struct channel_subsyst
 
 }
 
+static void
+channel_subsystem_release(struct device *dev)
+{
+	struct channel_subsystem *css;
+
+	css = to_css(dev);
+	kfree(css);
+}
+
 static inline void __init
 setup_css(int nr)
 {
@@ -453,6 +462,7 @@ setup_css(int nr)
 	css[nr]->valid = 1;
 	css[nr]->cssid = nr;
 	sprintf(css[nr]->device.bus_id, "css%x", nr);
+	css[nr]->device.release = channel_subsystem_release;
 	tod_high = (u32) (get_clock() >> 32);
 	css_generate_pgid(css[nr], tod_high);
 }
