Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030690AbWF0HFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbWF0HFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWF0HFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:18563 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030675AbWF0HFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:10 +1000
Message-Id: <1060627070510.25960@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 12] md: Possible fix for unplug problem
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have reports of a problem with raid5 which turns out to be because
the raid5 device gets stuck in a 'plugged' state.  This shouldn't be
able to happen as 3msec after it gets plugged it should get unplugged.
However it happens none-the-less.  This patch fixes the problem and is
a reasonable thing to do, though it might hurt performance slightly in
some cases.

Until I can find the real problem, we should probably have this
workaround in place.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-06-27 12:15:17.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-27 12:16:41.000000000 +1000
@@ -271,7 +271,7 @@ static struct stripe_head *get_active_st
 						     < (conf->max_nr_stripes *3/4)
 						     || !conf->inactive_blocked),
 						    conf->device_lock,
-						    unplug_slaves(conf->mddev)
+						    raid5_unplug_device(conf->mddev->queue)
 					);
 				conf->inactive_blocked = 0;
 			} else
