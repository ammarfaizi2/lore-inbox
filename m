Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTIXJ55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbTIXJ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:57:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42894 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261157AbTIXJ5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:57:55 -0400
Date: Wed, 24 Sep 2003 10:57:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4 boot crash
Message-ID: <20030924095754.GW7665@parcelfarce.linux.theplanet.co.uk>
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <3F716177.6060607@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F716177.6060607@aitel.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 11:18:47AM +0200, Helge Hafting wrote:
> Unable to handle null pointer deref at virtual address 00000000
> eip c02b7d1e  eip at md_probe

Oh, boy...  OK, I see what happens and it's _ugly_.  md_probe() is misused
there big way.  The minimal fix is to revert the cleanup in md_probe() -
replace
	int unit = *part;
with
	int unit = MINOR(dev);


However, that is crap solution.  The problem is that md_probe() is called
directly with bogus arguments - not only part is NULL (which triggers the
oops), but dev (which is supposed to be dev_t value) is actually mdidx(mddev).

Cleaner fix follows, but we really need to get the situation with gendisk
allocations into the sane shape there.  Sigh...

diff -urN B5-tty_devnum-fix/drivers/md/md.c B5-current/drivers/md/md.c
--- B5-tty_devnum-fix/drivers/md/md.c	Tue Sep 23 04:16:30 2003
+++ B5-current/drivers/md/md.c	Wed Sep 24 05:44:27 2003
@@ -1500,6 +1500,7 @@
 	mdk_rdev_t *rdev;
 	struct gendisk *disk;
 	char b[BDEVNAME_SIZE];
+	int unit;
 
 	if (list_empty(&mddev->disks)) {
 		MD_BUG();
@@ -1591,8 +1592,9 @@
 		invalidate_bdev(rdev->bdev, 0);
 	}
 
-	md_probe(mdidx(mddev), NULL, NULL);
-	disk = disks[mdidx(mddev)];
+	unit = mdidx(mddev);
+	md_probe(0, &unit, NULL);
+	disk = disks[unit];
 	if (!disk)
 		return -ENOMEM;
 
