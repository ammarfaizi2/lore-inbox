Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWA1AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWA1AVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWA1AUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:20:23 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48297 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422729AbWA1AUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:20:05 -0500
Subject: [patch 6/6] Create and Use common mempool allocators
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060128001539.030809000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 27 Jan 2006 16:20:01 -0800
Message-Id: <1138407601.26088.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-use_kzalloc_allocator.patch)
From: Matthew Dobson <colpatch@us.ibm.com>
Subject: [patch 6/6] mempool - Use common mempool kzalloc allocator

This patch changes a mempool user, which is basically just a wrapper around
kzalloc(), to use the common mempool_kmalloc/kfree, rather than its own wrapper
function, removing duplicated code.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 drivers/md/multipath.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

Index: linux-2.6.16-rc1-mm3+mempool_work/drivers/md/multipath.c
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/drivers/md/multipath.c
+++ linux-2.6.16-rc1-mm3+mempool_work/drivers/md/multipath.c
@@ -35,18 +35,6 @@
 #define	NR_RESERVED_BUFS	32
 

-static void *mp_pool_alloc(gfp_t gfp_flags, void *data)
-{
-	struct multipath_bh *mpb;
-	mpb = kzalloc(sizeof(*mpb), gfp_flags);
-	return mpb;
-}
-
-static void mp_pool_free(void *mpb, void *data)
-{
-	kfree(mpb);
-}
-
 static int multipath_map (multipath_conf_t *conf)
 {
 	int i, disks = conf->raid_disks;
@@ -495,8 +483,8 @@ static int multipath_run (mddev_t *mddev
 	mddev->degraded = conf->raid_disks = conf->working_disks;
 
 	conf->pool = mempool_create(NR_RESERVED_BUFS,
-				    mp_pool_alloc, mp_pool_free,
-				    NULL);
+				    mempool_kzalloc, mempool_kfree,
+				    sizeof(struct multipath_bh));
 	if (conf->pool == NULL) {
 		printk(KERN_ERR 
 			"multipath: couldn't allocate memory for %s\n",

--

