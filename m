Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTGDFNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 01:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbTGDFNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 01:13:52 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:25077 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265772AbTGDFNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 01:13:50 -0400
Date: Fri, 04 Jul 2003 01:27:56 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-reply-to: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com
Message-id: <200307040128.11894.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 03 July 2003 23:08, Linus Torvalds wrote:
> Please do this in user space. The "overflow every 2^32 packets" thing is
> _not_ a problem, if you just gather the statistics at any kind of
> reasonable interval.

The packet counters are fine (for now, that is), but the tx_bytes and rx_bytes 
counters need those 64-bits. 4GB (= 2^32 bytes) is not enough. For example:

- - gigabit ethernet will cause 32-bit counters to overflow about every 34 
seconds (at full speed.)
- - 10Gb/s ethernet will only take about 3.4 seconds
- - a user like me, who has 5Mbit/s connection to the net can cause the counter 
to overflow in 1 hour 54 minutes

(Most of the time, the devices are not maxed out, but we have to check the 
worst case scenario.) Now, how often should the user space 
statistics-gathering program should run? Well, at least every 30 seconds, for 
now that should be good, but the rein of 10Gb/s is approaching...

> I'd hate to penalise performance for something like this. We have
> generally avoided locking _entirely_ for statistics, exactly because
> people felt that there are major performance issues wrt network packet
> handling, and that "perfect statistics" aren't important enough to
> penalize performance over.

I agree with you, that is why I made it optional so the user may choose to 
sacrifice performace for statistics when needed.

Additionally, I am sure there is a way of optimizing the patch I wrote (i.e. 
actual transmition is locked with a lock from struct net_device.) I am aware 
that this patch is a major undertaking, but it is only a matter of time 
before someone will have to do it anyway.

> Remember: "perfect is the enemy of good".

Very true.


Jeff.

- -- 
Only two things are infinite, the universe and human stupidity, and I'm 
not sure about the former.
		- Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BRBjwFP0+seVj/4RAnDSAJ90uOIpgtk0O7YLSsdj97kNbhr/jgCgrmlS
GYbA4luLnY7bli1jYVuZD3s=
=7zXz
-----END PGP SIGNATURE-----

