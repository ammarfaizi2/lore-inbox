Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKCS5p>; Sat, 3 Nov 2001 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281008AbRKCS5Z>; Sat, 3 Nov 2001 13:57:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25793 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281012AbRKCS5O>;
	Sat, 3 Nov 2001 13:57:14 -0500
Date: Sat, 3 Nov 2001 13:57:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for cdput() race
Message-ID: <Pine.GSO.4.21.0111031348220.18001-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Resend - that area hadn't changed and bug is still there.

Race between cdput() and cdget() - if we have the only reference to
char_device and call cdput() while somebody else does cdget() on
another CPU, we are going to hit a race:

cdget:
	grabs cdev_lock
	searches the lists
				cdput:
					decrements ->count to 0
					spins on attempt to get cdev_lock
	find the structure
	increments ->count
	drops cdev_lock
	returns pointer to found	acquires cdev_lock
					removes the structure from lists
					frees it
caller of cdget:
	dereferences the returned value
	oops

This is exactly the same scenario as we had in d_lookup()/dput() - one
that lead to introduction of atomic_dec_and_lock().  Fix is trivial.
Please, apply.

--- linux/fs/char_dev.c	Thu May 24 18:26:45 2001
+++ /tmp/char_dev.c	Mon Oct 29 13:43:41 2001
@@ -104,8 +104,7 @@
 
 void cdput(struct char_device *cdev)
 {
-	if (atomic_dec_and_test(&cdev->count)) {
-		spin_lock(&cdev_lock);
+	if (atomic_dec_and_lock(&cdev->count, &cdev_lock)) {
 		list_del(&cdev->hash);
 		spin_unlock(&cdev_lock);
 		destroy_cdev(cdev);

