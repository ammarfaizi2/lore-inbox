Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753529AbWKGWKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbWKGWKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbWKGWKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:10:03 -0500
Received: from mail.suse.de ([195.135.220.2]:14728 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753491AbWKGWJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:32 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:36 +1100
Message-Id: <1061107220936.12501@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 003 of 9] md: Do not freeze md threads for suspend.
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From:  "Rafael J. Wysocki" <rjw@sisk.pl>

If there's a swap file on a software RAID, it should be possible to use this
file for saving the swsusp's suspend image.  Also, this file should be
available to the memory management subsystem when memory is being freed before
the suspend image is created.

For the above reasons it seems that md_threads should not be frozen during
the suspend and the appended patch makes this happen, but then there is the
question if they don't cause any data to be written to disks after the
suspend image has been created, provided that all filesystems are frozen
at that time.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-11-06 11:28:44.000000000 +1100
+++ ./drivers/md/md.c	2006-11-06 11:29:00.000000000 +1100
@@ -4488,6 +4488,7 @@ static int md_thread(void * arg)
 	 * many dirty RAID5 blocks.
 	 */
 
+	current->flags |= PF_NOFREEZE;
 	allow_signal(SIGKILL);
 	while (!kthread_should_stop()) {
 
@@ -4504,7 +4505,6 @@ static int md_thread(void * arg)
 			 test_bit(THREAD_WAKEUP, &thread->flags)
 			 || kthread_should_stop(),
 			 thread->timeout);
-		try_to_freeze();
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
