Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUGJMax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUGJMax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUGJMax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:30:53 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:1163 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266233AbUGJMat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:30:49 -0400
Message-ID: <40EFE169.5060304@kolivas.org>
Date: Sat, 10 Jul 2004 22:30:33 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, FabF <fabian.frederick@skynet.be>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Autotune inactivation
References: <1089453053.3646.18.camel@localhost.localdomain> <40EFDA89.4020001@yahoo.com.au>
In-Reply-To: <40EFDA89.4020001@yahoo.com.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94A897D16255BC0EC1D588E9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94A897D16255BC0EC1D588E9
Content-Type: multipart/mixed;
 boundary="------------040001030803060001060103"

This is a multi-part message in MIME format.
--------------040001030803060001060103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> FabF wrote:
>> http://fabian.unixtech.be/kernel/autoregulate/

> I didn't see Con's newest autoswappiness patch do a great deal
> for kbuild here. The inactivation thing seems to help more - it
> appears to increase the rate of active list scanning, which is
> consistient with the sort of behaviour I have seen. However, the
> problem with increased active list scanning is that it can be
> quicker to evict RSS over throwaway data which is bad.
> 
> Changes should be tested one at a time if possible, and when they
> are determined to be an improvement, we should try to look into
> what the "auto tuning" magic is doing right, and see if that can
> be implemented in a simpler way (although it may be already as
> simple as possible).

The autotuned swappiness part tended to have the most effect at avoiding 
the morning drag, or the post ISO image copy drag without slowing things 
down under real heavy memory stress.

The original version of autotuned inactivation simply increased the 
number of pages scanned and had better results on my benching but this 
part of code changed somewhat and I dont think I put it back to the best 
way. This patch recreates more closely the behaviour of the original 
version.

It would be nice if people who have tested the previous more confused 
patches to try these two in sequence and see what measurable results 
they give.


Description:
This patch increases the number of active pages inactivated and the 
number of inactive pages freed dependent inversely on the vm_swappiness. 
The vm_swappiness in turn is tuned by the previous patch 
(autotune_swappiness) according to the mapped ratio. As the 
vm_swappiness is proportional to the square root of the mapped ratio, 
this means that the mapped ratio has to be quite high before this patch 
has any great effect.

Patch applies to 2.6.7-bk20 and mm6
Signed-off-by: Con Kolivas <kernel@kolivas.org>

--------------040001030803060001060103
Content-Type: text/x-patch;
 name="autotune_inactivation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autotune_inactivation.diff"

Index: linux-2.6.7-bk20/mm/vmscan.c
===================================================================
--- linux-2.6.7-bk20.orig/mm/vmscan.c	2004-07-10 20:10:25.324562938 +1000
+++ linux-2.6.7-bk20/mm/vmscan.c	2004-07-10 21:17:08.045968091 +1000
@@ -801,20 +801,23 @@
 {
 	unsigned long nr_active;
 	unsigned long nr_inactive;
+	unsigned long mapped_bias;
+
+	mapped_bias = 151 - vm_swappiness;
 
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
 	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
-	nr_active = zone->nr_scan_active;
+	nr_active = zone->nr_scan_active * 150 / mapped_bias;
 	if (nr_active >= SWAP_CLUSTER_MAX)
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
 
 	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
+	nr_inactive = zone->nr_scan_inactive * 150 / mapped_bias;
 	if (nr_inactive >= SWAP_CLUSTER_MAX)
 		zone->nr_scan_inactive = 0;
 	else

--------------040001030803060001060103--

--------------enig94A897D16255BC0EC1D588E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7+FsZUg7+tp6mRURArYCAJ9P/qrO9xa7JSSwaE+y3YaSNWtH/ACgkvJq
RLRnmz3FWlBaeKfK70jnvIA=
=Sp/o
-----END PGP SIGNATURE-----

--------------enig94A897D16255BC0EC1D588E9--
