Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWEVGTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWEVGTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEVGTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:19:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:31695 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932435AbWEVGTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:19:15 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 16:18:50 +1000
Message-Id: <1060522061850.2849@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Don Dupuis" <dondster@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 2] md: Fix possible oops when starting a raid0 array
References: <20060522161259.2792.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This loop that sets up the hash_table has problems.

Careful examination will show that the last time through, everything
but the first line is pointless.  This is because all it does is
change 'cur' and 'size' and neither of these are used after
the loop.  This should ring warning bells...
That last time through the loop, 
        size += conf->strip_zone[cur].size
can index off the end of the strip_zone array.
Depending on what it finds there, it might exit the loop cleanly, 
or it might spin going further and further beyond the array until
it hits an unmapped address.

This patch rearranges the code so that the last, pointless, iteration
of the loop never happens.  i.e. the one statement of the last loop
that is needed is moved the the end of the previous loop - or to
before the loop starts - and the loop counter starts from 1
instead of 0.


Cc: "Don Dupuis" <dondster@gmail.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid0.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
--- ./drivers/md/raid0.c~current~	2006-05-22 15:33:05.000000000 +1000
+++ ./drivers/md/raid0.c	2006-05-22 15:35:01.000000000 +1000
@@ -331,13 +331,14 @@ static int raid0_run (mddev_t *mddev)
 		goto out_free_conf;
 	size = conf->strip_zone[cur].size;
 
-	for (i=0; i< nb_zone; i++) {
-		conf->hash_table[i] = conf->strip_zone + cur;
+	conf->hash_table[0] = conf->strip_zone + cur;
+	for (i=1; i< nb_zone; i++) {
 		while (size <= conf->hash_spacing) {
 			cur++;
 			size += conf->strip_zone[cur].size;
 		}
 		size -= conf->hash_spacing;
+		conf->hash_table[i] = conf->strip_zone + cur;
 	}
 	if (conf->preshift) {
 		conf->hash_spacing >>= conf->preshift;
