Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVF3SU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVF3SU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVF3SU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:20:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262820AbVF3SUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:20:50 -0400
Date: Thu, 30 Jun 2005 19:19:31 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>,
       Zhao Qian <zhaoqian@aaastor.com>
Subject: [PATCH] device-mapper: dm-raid1: Limit bios to size of mirror region
Message-ID: <20050630181931.GL4211@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>, Zhao Qian <zhaoqian@aaastor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the target's split_io field when building a dm-mirror device so
incoming bios won't span the mirror's internal regions.  Without
this, regions can be accessed while not holding correct locks and data
corruption is possible.

Reported-By: "Zhao Qian" <zhaoqian@aaastor.com>
From: Kevin Corry <kevcorry@us.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-raid1.c	2005-06-17 20:48:29.000000000 +0100
+++ source/drivers/md/dm-raid1.c	2005-06-29 21:12:13.000000000 +0100
@@ -1060,6 +1060,7 @@
 	}
 
 	ti->private = ms;
+ 	ti->split_io = ms->rh->region_size;
 
 	r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
 	if (r) {
