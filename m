Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSL0WID>; Fri, 27 Dec 2002 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSL0WID>; Fri, 27 Dec 2002 17:08:03 -0500
Received: from shay.ecn.purdue.edu ([128.46.209.11]:28875 "EHLO
	shay.ecn.purdue.edu") by vger.kernel.org with ESMTP
	id <S265171AbSL0WIB>; Fri, 27 Dec 2002 17:08:01 -0500
From: Kevin Corry <corry@ecn.purdue.edu>
Message-Id: <200212272216.gBRMGHB2016255@shay.ecn.purdue.edu>
Subject: Re: [PATCH] dm.c : Check memory allocations
To: jgarzik@pobox.com (Jeff Garzik)
Date: Fri, 27 Dec 2002 17:16:17 -0500 (EST)
Cc: joe@fib011235813.fsnet.co.uk (Joe Thornber), dm-devel@sistina.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021227220008.GA11577@gtf.org> from "Jeff Garzik" at Dec 27, 2002 05:00:08 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 27, 2002 at 04:55:31PM -0500, Kevin Corry wrote:
> > Check memory allocations when cloning bio's.
> > 
> > --- linux-2.5.53a/drivers/md/dm.c	Mon Dec 23 23:21:04 2002
> > +++ linux-2.5.53b/drivers/md/dm.c	Fri Dec 27 14:50:29 2002
> > @@ -394,6 +393,10 @@
> >  		 */
> >  		clone = clone_bio(bio, ci->sector, ci->idx,
> >  				  bio->bi_vcnt - ci->idx, ci->sector_count);
> > +		if (!clone) {
> > +			dec_pending(ci->io, -ENOMEM);
> > +			return;
> > +		}
> >  		__map_bio(ti, clone, ci->io);
> >  		ci->sector_count = 0;
> >  
> > @@ -417,6 +420,10 @@
> >  		}
> >  
> >  		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
> > +		if (!clone) {
> > +			dec_pending(ci->io, -ENOMEM);
> > +			return;
> > +		}
> >  		__map_bio(ti, clone, ci->io);
> >  
> >  		ci->sector += len;
> 
> 
> This seems a bit insufficient.  Why is this error not propagated up
> through to __split_bio ?
> 
> 	Jeff

At second glance, it does seem insufficient. I had simply copied the
same check that was already used later in __clone_and_map().

What we should do is set ci->sector_count to zero. This will prevent
__split_bio() from performing any further processing on the bio.

Alternatively, we could change __clone_and_map() to return an int, and
return the error to __split_bio() and let it do the cleanup.

Here is a replacement patch based on the first suggestion.

-Kevin

--- linux-2.5.53a/drivers/md/dm.c	Mon Dec 23 23:21:04 2002
+++ linux-2.5.53b/drivers/md/dm.c	Fri Dec 27 15:18:19 2002
@@ -394,6 +393,11 @@
 		 */
 		clone = clone_bio(bio, ci->sector, ci->idx,
 				  bio->bi_vcnt - ci->idx, ci->sector_count);
+		if (!clone) {
+			ci->sector_count = 0;
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
 		__map_bio(ti, clone, ci->io);
 		ci->sector_count = 0;
 
@@ -417,6 +421,11 @@
 		}
 
 		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
+		if (!clone) {
+			ci->sector_count = 0;
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
 		__map_bio(ti, clone, ci->io);
 
 		ci->sector += len;
@@ -433,6 +442,7 @@
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset, max);
 		if (!clone) {
+			ci->sector_count = 0;
 			dec_pending(ci->io, -ENOMEM);
 			return;
 		}
@@ -447,6 +457,7 @@
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset + to_bytes(max), len);
 		if (!clone) {
+			ci->sector_count = 0;
 			dec_pending(ci->io, -ENOMEM);
 			return;
 		}
