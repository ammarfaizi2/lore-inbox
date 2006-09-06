Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWIFXAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWIFXAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIFXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:00:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:57291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751798AbWIFXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:51 -0400
Date: Wed, 6 Sep 2006 15:55:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/37] dm: move idr_pre_get
Message-ID: <20060906225539.GK15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-move-idr_pre_get.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

idr_pre_get() can sleep while allocating memory.

The next patch will change _minor_lock into a spinlock, so this patch moves
idr_pre_get() outside the lock in preparation.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
@@ -766,6 +766,10 @@ static int specific_minor(struct mapped_
 	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
 	mutex_lock(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
@@ -773,16 +777,9 @@ static int specific_minor(struct mapped_
 		goto out;
 	}
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
-
 	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
-	if (r) {
+	if (r)
 		goto out;
-	}
 
 	if (m != minor) {
 		idr_remove(&_minor_idr, m);
@@ -800,13 +797,11 @@ static int next_free_minor(struct mapped
 	int r;
 	unsigned int m;
 
-	mutex_lock(&_minor_lock);
-
 	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
+	if (!r)
+		return -ENOMEM;
+
+	mutex_lock(&_minor_lock);
 
 	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {

--
