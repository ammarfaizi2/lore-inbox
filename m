Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWHAXDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHAXDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHAXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:03:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22706 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750729AbWHAXDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:03:24 -0400
Date: Tue, 1 Aug 2006 19:02:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bounds check bug in __register_chrdev_region
Message-ID: <20060801230243.GA8263@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Amos Waterland <apw@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code in __register_chrdev_region checks that if the driver wishing
to register has the same major as an existing driver the new minor range
is strictly less than the existing minor range.  However, it does not
also check that the new minor range is strictly greater than the
existing minor range.  That is, if driver X has registered with 
major=x and minor=0-3, __register_chrdev_region will allow driver Y to
register with major=x and minor=1-4.

I came across this in the context of the Xen virtual console driver, but I
imagine it causes a problem for any driver with the same major number
but different minor numbers as a driver that has registered ahead of it.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 fs/char_dev.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

5127ecec5817868799c55ac27e8d1651308d1497
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3483d3c..11c0249 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -109,10 +109,13 @@ __register_chrdev_region(unsigned int ma
 
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major > major ||
-		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
+		    ((*cp)->major == major &&
+		     (((*cp)->baseminor >= baseminor) ||
+		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
 			break;
 	if (*cp && (*cp)->major == major &&
-	    (*cp)->baseminor < baseminor + minorct) {
+	    (((*cp)->baseminor < baseminor + minorct) ||
+	     ((*cp)->baseminor + (*cp)->minorct > baseminor))) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
1.0.4


