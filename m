Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHUSwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHUSwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHUSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:50:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:50566 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWHUSt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:49:58 -0400
Date: Mon, 21 Aug 2006 11:48:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-raid@vger.kernel.org,
       Neil Brown <neilb@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/20] MD: Fix a potential NULL dereference in md/raid1
Message-ID: <20060821184824.GU21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="md-fix-a-potential-null-dereference-in-md-raid1.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: NeilBrown <neilb@suse.de>

At the point where this 'atomic_add' is, rdev could be NULL, as seen by
the fact that we test for this in the very next statement.

Further is it is really the wrong place of the add.  We could add to the
count of corrected errors once the are sure it was corrected, not before
trying to correct it.

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
---
 drivers/md/raid1.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17.9.orig/drivers/md/raid1.c
+++ linux-2.6.17.9/drivers/md/raid1.c
@@ -1486,7 +1486,6 @@ static void raid1d(mddev_t *mddev)
 							d = conf->raid_disks;
 						d--;
 						rdev = conf->mirrors[d].rdev;
-						atomic_add(s, &rdev->corrected_errors);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
 							if (sync_page_io(rdev->bdev,
@@ -1509,6 +1508,9 @@ static void raid1d(mddev_t *mddev)
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							else
+								atomic_add(s, &rdev->corrected_errors);
+
 						}
 					}
 				} else {

--
