Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWHIBPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWHIBPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWHIBPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:15:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15787 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030391AbWHIBPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:15:21 -0400
Date: Tue, 8 Aug 2006 20:15:19 -0500
To: Amos Waterland <apw@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rubini@vision.unipv.it, device@lanana.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-ID: <20060809011519.GZ10638@austin.ibm.com>
References: <20060807225555.GQ10638@austin.ibm.com> <20060807234753.ff21eb29.akpm@osdl.org> <20060808205258.GA6111@kvasir.watson.ibm.com> <20060808213331.GW10638@austin.ibm.com> <20060808222041.GA9708@kvasir.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808222041.GA9708@kvasir.watson.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 06:20:41PM -0400, Amos Waterland wrote:
> > 
> > Actually, there's still a problem. An added device could still 
> > overlap with a previously added device and not be detected. 
> > We should keep the devices in order, and check that the region
> > fits in between the last and the next device.  So, for example,
> > the following will make the latest patch accept an invalid region:
> > 
> > First, add maj=x, minor=64-127
> > Next, add  maj=x, minor=0-63
> > Next, add  maj=x, minor=32-63
> > 
> > When going to insert the third chardev, the for-loop will catch 
> > the first elt in the chain, do the bounds-check, and add it
> > without complaint.  I'll try a patch shortly.
> 
> Are you sure?  I do not see how that can happen.  

On closer examination, indeed, this cannot happen.  I was presuming an
order dependence when there wasn't one. I am now older and wiser: 
although I had to write my own patch to become that. 

I beleive there's still an off-by-one error:
Presume list contains
  maj=x, minor=0-64  (and nothing else)
Go to add
  maj=x, minor=64-127

The conditions to break out of the for-loop are never met, so
the loop terminates naturally, with *cp null, (or with a higher 
major number), and the new interval is added when it should not 
have been.

I beleive the patch below avoids this.  Perhaps it might be 
easier to understand? I have not run your test harness on it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 fs/char_dev.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc3-mm2/fs/char_dev.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/fs/char_dev.c	2006-08-08 16:52:47.000000000 -0500
+++ linux-2.6.18-rc3-mm2/fs/char_dev.c	2006-08-08 20:07:35.000000000 -0500
@@ -76,6 +76,7 @@ __register_chrdev_region(unsigned int ma
 			   int minorct, const char *name)
 {
 	struct char_device_struct *cd, **cp;
+	int prev_top, curr_top;
 	int ret = 0;
 	int i;
 
@@ -107,18 +108,35 @@ __register_chrdev_region(unsigned int ma
 
 	i = major_to_index(major);
 
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major == major &&
-		     (((*cp)->baseminor >= baseminor) ||
-		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
+	prev_top = -1;
+	curr_top = baseminor + minorct - 1;
+
+	/* Insert into list, with sort order of low to high. */
+	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next) {
+		if ((*cp)->major > major)
 			break;
-	if (*cp && (*cp)->major == major &&
-	    (((*cp)->baseminor < baseminor + minorct) ||
-	     ((*cp)->baseminor + (*cp)->minorct > baseminor))) {
+		if((*cp)->major == major) {
+
+			/* If it fits between this and the previous, accept it. */
+			if (((*cp)->baseminor > curr_top) &&
+				 (prev_top < (int) baseminor))
+				break;
+
+			/* If it overlaps this interval, reject it */
+			prev_top = (*cp)->baseminor + (*cp)->minorct - 1;
+			if (prev_top >= (int) baseminor) {
+				ret = -EBUSY;
+				goto out;
+			}
+		}
+	}
+
+	/* If it overlaps this interval, reject it */
+	if ((*cp) && (curr_top >= (*cp)->baseminor)) {
 		ret = -EBUSY;
 		goto out;
 	}
+
 	cd->next = *cp;
 	*cp = cd;
 	mutex_unlock(&chrdevs_lock);
