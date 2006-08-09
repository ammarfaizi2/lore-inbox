Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHIRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHIRGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHIRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:06:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46267 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751163AbWHIRGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:06:50 -0400
Date: Wed, 9 Aug 2006 13:06:36 -0400
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rubini@vision.unipv.it, device@lanana.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-ID: <20060809170636.GA3114@kvasir.watson.ibm.com>
References: <20060807225555.GQ10638@austin.ibm.com> <20060807234753.ff21eb29.akpm@osdl.org> <20060808205258.GA6111@kvasir.watson.ibm.com> <20060808213331.GW10638@austin.ibm.com> <20060808222041.GA9708@kvasir.watson.ibm.com> <20060809011519.GZ10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809011519.GZ10638@austin.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Amos Waterland <apw@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 08:15:19PM -0500, Linas Vepstas wrote:
> On Tue, Aug 08, 2006 at 06:20:41PM -0400, Amos Waterland wrote:
> > Are you sure?  I do not see how that can happen.  
> 
> On closer examination, indeed, this cannot happen.  I was presuming an
> order dependence when there wasn't one. I am now older and wiser: 
> although I had to write my own patch to become that. 
> 
> I beleive there's still an off-by-one error:
> Presume list contains
>   maj=x, minor=0-64  (and nothing else)
> Go to add
>   maj=x, minor=64-127
> 
> The conditions to break out of the for-loop are never met, so
> the loop terminates naturally, with *cp null, (or with a higher 
> major number), and the new interval is added when it should not 
> have been.

The condition to break out of the for-loop is in fact met, specifically
the check that: (*cp)->baseminor + (*cp)->minorct > baseminor.  In your
example, this is: 0 + 65 > 64.  This is determined by inspection and
verified by putting your proposed sequence through the harness.

Andrew, I believe this is ready for submission.

---

The code in __register_chrdev_region checks that if the driver wishing
to register has the same major as an existing driver the new minor range
is strictly less than the existing minor range.  However, it does not
also check that the new minor range is strictly greater than the
existing minor range.  That is, if driver X has registered with major=x
and minor=0-3, __register_chrdev_region will allow driver Y to register
with major=x and minor=1-4.  

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 char_dev.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3483d3c..e13157f 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -109,13 +109,31 @@ __register_chrdev_region(unsigned int ma
 
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major > major ||
-		    ((*cp)->major == major && (*cp)->baseminor >= baseminor))
+		    ((*cp)->major == major && 
+		     (((*cp)->baseminor >= baseminor) ||
+		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
 			break;
-	if (*cp && (*cp)->major == major &&
-	    (*cp)->baseminor < baseminor + minorct) {
-		ret = -EBUSY;
-		goto out;
+
+	/* Check for overlapping minor ranges.  */
+	if (*cp && (*cp)->major == major) {
+		int old_min = (*cp)->baseminor;
+		int old_max = (*cp)->baseminor + (*cp)->minorct - 1;
+		int new_min = baseminor;
+		int new_max = baseminor + minorct - 1;
+
+		/* New driver overlaps from the left.  */
+		if (new_max >= old_min && new_max <= old_max) {
+			ret = -EBUSY;
+			goto out;
+		}
+
+		/* New driver overlaps from the right.  */
+		if (new_min <= old_max && new_min >= old_min) {
+			ret = -EBUSY;
+			goto out;
+		}
 	}
+
 	cd->next = *cp;
 	*cp = cd;
 	mutex_unlock(&chrdevs_lock);
