Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVFHLFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVFHLFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVFHLFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:05:47 -0400
Received: from gate.in-addr.de ([212.8.193.158]:59569 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262167AbVFHLFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:05:41 -0400
Date: Wed, 8 Jun 2005 13:04:36 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] [2.6.12-rc6-mm1] Handle READA requests in dm-mpath.c
Message-ID: <20050608110436.GQ27119@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

READA errors failing with EWOULDBLOCK/EAGAIN do not constitute a valid
reason for failing the path; this lead to erratic errors on DM multipath
devices. This error can be safely propagated upwards without failing the
path.

Acked-by: Kevin Corry <kevcorry@us.ibm.com>
Acked-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>

--- linux-2.6.12-rc6-mm1.orig/drivers/md/dm-mpath.c	2005-06-08 12:51:02.741055000 +0200
+++ linux-2.6.12-rc6-mm1/drivers/md/dm-mpath.c	2005-06-08 12:57:55.757828867 +0200
@@ -985,6 +985,9 @@
 	if (!error)
 		return 0;	/* I/O complete */
 
+	if ((error == -EWOULDBLOCK) && bio_rw_ahead(bio))
+		return error;
+
 	spin_lock(&m->lock);
 	if (!m->nr_valid_paths) {
 		if (!m->queue_if_no_path || m->suspended) {


-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

