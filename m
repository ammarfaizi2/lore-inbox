Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVCDVXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVCDVXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVCDVEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:04:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:12706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263168AbVCDUyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:35 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: get rid of the potential problems with atomic operations.
In-Reply-To: <11099687823191@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:43 -0800
Message-Id: <1109968783581@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2085, 2005/03/02 16:59:41-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: get rid of the potential problems with atomic operations.

Get rid of the potential problems with atomic operations.

According to upcoming atomic_ops.txt by David Miller and Anton Blanchard
some archs may reoder atomic operations with nonatomic, since
the former are always visible but the latter are not, this can lead
to unpredicted behaviour.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/w1/w1_family.c |    2 ++
 drivers/w1/w1_therm.c  |    2 ++
 2 files changed, 4 insertions(+)


diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2005-03-04 12:37:51 -08:00
+++ b/drivers/w1/w1_family.c	2005-03-04 12:37:51 -08:00
@@ -138,7 +138,9 @@
 
 void __w1_family_get(struct w1_family *f)
 {
+	smp_mb__before_atomic_inc();
 	atomic_inc(&f->refcnt);
+	smp_mb__after_atomic_inc();
 }
 
 EXPORT_SYMBOL(w1_family_get);
diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c	2005-03-04 12:37:51 -08:00
+++ b/drivers/w1/w1_therm.c	2005-03-04 12:37:51 -08:00
@@ -104,6 +104,7 @@
 	int i, max_trying = 10;
 
 	atomic_inc(&sl->refcnt);
+	smp_mb__after_atomic_inc();
 	if (down_interruptible(&sl->master->mutex)) {
 		count = 0;
 		goto out_dec;
@@ -179,6 +180,7 @@
 out:
 	up(&dev->mutex);
 out_dec:
+	smp_mb__before_atomic_inc();
 	atomic_dec(&sl->refcnt);
 
 	return count;

