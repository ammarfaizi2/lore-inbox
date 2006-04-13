Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWDMUfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWDMUfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWDMUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:50 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:33814 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964953AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 03/08] dm: fix idr_pre_get lock ordering
Message-ID: <20060413203546.GA3209@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 idr_pre_get() can sleep while allocating memory for the worst-case scenario.
 This isn't a huge deal with the current code, but the next patch will
 switch _minor_lock to a spinlock.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:17.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:17.000000000 -0400
@@ -717,6 +717,10 @@ static int specific_minor(struct mapped_
 	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
 	down(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
@@ -724,12 +728,6 @@ static int specific_minor(struct mapped_
 		goto out;
 	}
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
-
 	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
 	if (r) {
 		goto out;
@@ -751,13 +749,11 @@ static int next_free_minor(struct mapped
 	int r;
 	unsigned int m;
 
-	down(&_minor_lock);
-
 	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
+	if (!r)
+		return -ENOMEM;
+
+	down(&_minor_lock);
 
 	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
