Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWIFXMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWIFXMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWIFXCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:56780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964997AbWIFXCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:11 -0400
Date: Wed, 6 Sep 2006 15:56:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/37] dm: add module ref counting
Message-ID: <20060906225622.GO15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-add-module-ref-counting.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

The reference counting on dm-mod is zero if no mapped devices are open.  This
is incorrect, and can lead to an oops if the module is unloaded while mapped
devices exist.

This patch claims a reference to the module whenever a device is created, and
drops it again when the device is freed.

Devices must be removed before dm-mod is unloaded.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
@@ -852,6 +852,9 @@ static struct mapped_device *alloc_dev(u
 		return NULL;
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		goto bad0;
+
 	/* get a minor number for the dev */
 	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
 	if (r < 0)
@@ -918,6 +921,8 @@ static struct mapped_device *alloc_dev(u
 	blk_cleanup_queue(md->queue);
 	free_minor(minor);
  bad1:
+	module_put(THIS_MODULE);
+ bad0:
 	kfree(md);
 	return NULL;
 }
@@ -941,6 +946,7 @@ static void free_dev(struct mapped_devic
 
 	put_disk(md->disk);
 	blk_cleanup_queue(md->queue);
+	module_put(THIS_MODULE);
 	kfree(md);
 }
 

--
