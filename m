Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWIFXFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWIFXFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWIFXDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:50380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964967AbWIFXCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:03 -0400
Date: Wed, 6 Sep 2006 15:56:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/37] dm: fix block device initialisation
Message-ID: <20060906225634.GP15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-fix-block-device-initialisation.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

In alloc_dev(), we register the device with the block layer and then continue
to initialize the device.  But register_disk() makes the device available to
be opened before we have completed initialising it.

This patch moves the final bits of the initialization above the disk
registration.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
@@ -891,6 +891,10 @@ static struct mapped_device *alloc_dev(u
 	if (!md->disk)
 		goto bad4;
 
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
 	md->disk->fops = &dm_blk_dops;
@@ -900,10 +904,6 @@ static struct mapped_device *alloc_dev(u
 	add_disk(md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
-	atomic_set(&md->pending, 0);
-	init_waitqueue_head(&md->wait);
-	init_waitqueue_head(&md->eventq);
-
 	/* Populate the mapping, nobody knows we exist yet */
 	spin_lock(&_minor_lock);
 	old_md = idr_replace(&_minor_idr, md, minor);

--
