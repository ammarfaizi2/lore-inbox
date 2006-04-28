Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWD1AWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWD1AWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWD1AVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:21:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:50393 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751823AbWD1AV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:21:29 -0400
Date: Thu, 27 Apr 2006 17:19:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Junichi Nomura <j-nomura@ce.jp.nec.com>,
       Alasdair G Kergon <agk@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/24] dm flush queue EINTR
Message-ID: <20060428001955.GN18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-flush-queue-EINTR.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
If dm_suspend() is cancelled, bios already added to the deferred list need to
be submitted.  Otherwise they remain 'in limbo' until there's a dm_resume().

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/md/dm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.16.11.orig/drivers/md/dm.c
+++ linux-2.6.16.11/drivers/md/dm.c
@@ -1098,6 +1098,7 @@ int dm_suspend(struct mapped_device *md,
 {
 	struct dm_table *map = NULL;
 	DECLARE_WAITQUEUE(wait, current);
+	struct bio *def;
 	int r = -EINVAL;
 
 	down(&md->suspend_lock);
@@ -1157,9 +1158,11 @@ int dm_suspend(struct mapped_device *md,
 	/* were we interrupted ? */
 	r = -EINTR;
 	if (atomic_read(&md->pending)) {
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		def = bio_list_get(&md->deferred);
+		__flush_deferred_io(md, def);
 		up_write(&md->io_lock);
 		unlock_fs(md);
-		clear_bit(DMF_BLOCK_IO, &md->flags);
 		goto out;
 	}
 	up_write(&md->io_lock);

--
