Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUHTDUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUHTDUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 23:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHTDUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 23:20:22 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:64485 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266427AbUHTDUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 23:20:07 -0400
Message-ID: <41256DC9.7070500@kolivas.org>
Date: Fri, 20 Aug 2004 13:19:37 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Greg Afinogenov <antisthenes@inbox.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bio_uncopy_user mem leak
References: <1092909598.8364.5.camel@localhost> <412489E5.7000806@kolivas.org> <1092923494.12138.1667.camel@watt.suse.com> <20040819195521.GC12363@tpkurt.garloff.de>
In-Reply-To: <20040819195521.GC12363@tpkurt.garloff.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD305633E8292762E3363D00B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD305633E8292762E3363D00B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kurt Garloff wrote:
> Hi Chris,
> 
> On Thu, Aug 19, 2004 at 09:51:34AM -0400, Chris Mason wrote:
> 
>>On Thu, 2004-08-19 at 07:07, Con Kolivas wrote:
>>
>>>Ok I just tested this patch discretely and indeed the memory leak goes 
>>>away but it still produces coasters so something is still amuck. Just as 
>>>a data point; burning DVDs and data cds is ok. Burning audio *and 
>>>videocds* is not.
>>
>>It might be the cold medicine talking, but I think we need something
>>like this.  gcc tested it for me, beyond that I make no promises....
>>
>>--- l/fs/bio.c.1	2004-08-19 09:36:13.596858736 -0400
>>+++ l/fs/bio.c	2004-08-19 09:47:46.392537784 -0400
>>@@ -454,6 +454,7 @@
>> 	 */
>> 	if (!ret) {
>> 		if (!write_to_vm) {
>>+			unsigned long p = uaddr;
>> 			bio->bi_rw |= (1 << BIO_RW);
>> 			/*
>> 	 		 * for a write, copy in data to kernel pages
>>@@ -462,8 +463,9 @@
>> 			bio_for_each_segment(bvec, bio, i) {
>> 				char *addr = page_address(bvec->bv_page);
>> 
>>-				if (copy_from_user(addr, (char *) uaddr, bvec->bv_len))
>>+				if (copy_from_user(addr, (char *) p, bvec->bv_len))
>> 					goto cleanup;
>>+				p += bvec->bv_len;
>> 			}
>> 		}
>> 
> 
> 
> Hmm, that patch would make a lot of sense to me.
> 
> It matches the problem description; burning data CDs, we don't
> use bounce buffers, so that does not use this code path. Here,
> it looks like we copied the same userspace page again and again
> into a multisegment BIO. Ouch!
> 
> Not yet tested either :-(

Ok looks like your cold medicine is working well for you ;-). This patch 
on top of the other patch has the memory freeing _and_ burns good cds. 
Well done. I only tested with a video cd. Can someone confirm audio cd 
(although it seems obvious it would help both).

Andrew did you threaten to make a 2.6.8.2 since 2.6.8{,.1} cannot safely 
burn an audio cd?

Cheers,
Con

--------------enigD305633E8292762E3363D00B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJW3MZUg7+tp6mRURAoYcAJ9AuBfCGLSrWzvBkgG5ZgkJpE5MLgCeNTi3
aouezZ5R1ZtS56HdKA6r1X8=
=dili
-----END PGP SIGNATURE-----

--------------enigD305633E8292762E3363D00B--
