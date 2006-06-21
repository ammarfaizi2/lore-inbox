Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWFUTgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWFUTgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWFUTgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:36:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932698AbWFUTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:35:42 -0400
Date: Wed, 21 Jun 2006 20:35:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] dm mirror log: sync_count fix
Message-ID: <20060621193537.GW4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a mirror is reduced in size, clear the part of the bitmap that is
no longer used.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-log.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-log.c	2006-06-21 17:17:56.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-log.c	2006-06-21 17:17:56.000000000 +0100
@@ -447,7 +447,7 @@ static int disk_resume(struct dirty_log 
 	if (r)
 		return r;
 
-	/* set or clear any new bits */
+	/* set or clear any new bits -- device has grown */
 	if (lc->sync == NOSYNC)
 		for (i = lc->header.nr_regions; i < lc->region_count; i++)
 			/* FIXME: amazingly inefficient */
@@ -457,6 +457,10 @@ static int disk_resume(struct dirty_log 
 			/* FIXME: amazingly inefficient */
 			log_clear_bit(lc, lc->clean_bits, i);
 
+	/* clear any old bits -- device has shrunk */
+	for (i = lc->region_count; i % (sizeof(*lc->clean_bits) << BYTE_SHIFT); i++)
+		log_clear_bit(lc, lc->clean_bits, i);
+
 	/* copy clean across to sync */
 	memcpy(lc->sync_bits, lc->clean_bits, size);
 	lc->sync_count = count_bits32(lc->clean_bits, lc->bitset_uint32_count);
