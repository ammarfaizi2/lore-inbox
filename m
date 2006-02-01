Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWBAVEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWBAVEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:04:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932453AbWBAVEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:04:46 -0500
Date: Wed, 1 Feb 2006 21:04:39 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper log bitset: fix big endian find_next_zero_bit
Message-ID: <20060201210439.GN4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

This is a fix to the device-mapper-log-bitset-fix-endian patch that
switched to ext2_* versions of the set and clear bit functions.
The find_next_zero_bit function also has to be the ext2 one. Otherwise 
the mirror target tries to recover non-existent regions beyond the end of
device.

Signed-Off-By: Stefan Bader <shbader@de.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-log.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-log.c	2006-01-23 21:22:19.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm-log.c	2006-02-01 20:54:50.000000000 +0000
@@ -545,7 +545,8 @@ static int core_get_resync_work(struct d
 		return 0;
 
 	do {
-		*region = find_next_zero_bit((unsigned long *) lc->sync_bits,
+		*region = ext2_find_next_zero_bit(
+					     (unsigned long *) lc->sync_bits,
 					     lc->region_count,
 					     lc->sync_search);
 		lc->sync_search = *region + 1;
