Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGIBGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGIBGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGIBGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:06:03 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:57741 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262085AbUGIBF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:05:58 -0400
Message-ID: <40EDEF68.2020503@kolivas.org>
Date: Fri, 09 Jul 2004 11:05:44 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>	 <cone.1089268800.781084.4554.502@pc.kolivas.org>	 <20040708001027.7fed0bc4.akpm@osdl.org>	 <cone.1089273505.418287.4554.502@pc.kolivas.org>	 <20040708010842.2064a706.akpm@osdl.org>	 <cone.1089275229.304355.4554.502@pc.kolivas.org> <1089284097.3691.52.camel@localhost.localdomain>
In-Reply-To: <1089284097.3691.52.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig52CB04A09B52BE232EEF4589"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52CB04A09B52BE232EEF4589
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

FabF wrote:
> Con,
> 	What's interesting is try_to_free_pages comment :
> 
> " the zone may be full of dirty or under-writeback pages, which this
>  * caller can't do much about.  We kick pdflush and take explicit naps
> in the
>  * hope that some of these pages can be written.  But if the allocating
> task..."
> 
> 	I mean do we have high activity profile of that side of the kernel when
> bringing up some big application to life ?
> 	Does work consist here in 50% out, 50% in (time) ? Your anticipation
> algorithm can help the "in" side but maybe we can optimize yet the "out"
> side.btw, I'm surprised to see autoswappiness so far in fx tree:
> 
> page_reclaim
> 	try_to_free_pages
> 		shrink_caches
> 			shrink_zone
> 				refill_inactive_zone
> 					auto_swap calculation
> 
> 
> IOW, does such parameter could not involve more decisions ?

If you put it that way, yes - it would classify as duct tape. However 
the code already acted based upon mapped_ratio which is pretty much all 
this patch does. Folded in in that sample patch I sent out earlier you 
can see that all it does is acted on mapped_ratio in a different manner 
so it's not really an extra layer at all.

-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+	vm_swappiness = mapped_ratio * 150 / 100;
+	vm_swappiness = vm_swappiness * vm_swappiness / 150;
+	swap_tendency = distress + vm_swappiness;

Con

> Regards,
> FabF

--------------enig52CB04A09B52BE232EEF4589
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7e9oZUg7+tp6mRURAglEAJ0e2N+IT5JjHaAuQdJmiD0trH4JbwCgkeVi
NHKQVDEhXQZ6Q0JzqYVayOY=
=qYp9
-----END PGP SIGNATURE-----

--------------enig52CB04A09B52BE232EEF4589--
