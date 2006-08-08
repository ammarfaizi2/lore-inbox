Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWHHGsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWHHGsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHHGsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:48:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932269AbWHHGs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:48:29 -0400
Date: Mon, 7 Aug 2006 23:47:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rubini@vision.unipv.it,
       device@lanana.org, linux-kernel@vger.kernel.org,
       Amos Waterland <apw@us.ibm.com>
Subject: Re: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-Id: <20060807234753.ff21eb29.akpm@osdl.org>
In-Reply-To: <20060807225555.GQ10638@austin.ibm.com>
References: <20060807225555.GQ10638@austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 17:55:55 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> The current code in register_chrdev_region() attempts to check 
> for overlapping regions of minor device numbers, but performs 
> that check incorrectly. For example, if a device with minor 
> numbers 128, 129, 130 is registered first, and a device with 
> minor number 3,4,5 is registered later, then the later range
> is incorrectly identified as "overlapping" (since 130>3), 
> when clearly this is the wrong conclusion.
> 
> This patch fixes the overlap check to work correctly.


I yesterday merged the below.   Do you agree that it will fix the bug?


From: Amos Waterland <apw@us.ibm.com>

The code in __register_chrdev_region checks that if the driver wishing to
register has the same major as an existing driver the new minor range is
strictly less than the existing minor range.  However, it does not also
check that the new minor range is strictly greater than the existing minor
range.  That is, if driver X has registered with major=x and minor=0-3,
__register_chrdev_region will allow driver Y to register with major=x and
minor=1-4.

I came across this in the context of the Xen virtual console driver, but I
imagine it causes a problem for any driver with the same major number but
different minor numbers as a driver that has registered ahead of it.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---


diff -puN fs/char_dev.c~fix-bounds-check-bug-in-__register_chrdev_region fs/char_dev.c
--- a/fs/char_dev.c~fix-bounds-check-bug-in-__register_chrdev_region
+++ a/fs/char_dev.c
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
_

