Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWGRMSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWGRMSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGRMSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:18:46 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:60613
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751331AbWGRMSq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:18:46 -0400
Message-Id: <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: yunfeng zhang <zyf.zeroos@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
In-Reply-To: Your message of "Tue, 18 Jul 2006 18:03:54 +0800."
             <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153225122_3154P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Jul 2006 08:18:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153225122_3154P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Jul 2006 18:03:54 +0800, yunfeng zhang said:

> 2. Read-ahead process during page-in/out (page fault or swap out) should be
> based on its VMA to enhance IO efficiency instead of the relative physical pages
> in swap space.

But wouldn't that end up causing a seek storm, rather than handling the pages
in the order that minimizes the total seek distance, no matter where they are
in memory? Remember - if you have a 2Ghz processor, and a disk that seeks in 1
millisecond, every seek is (*very* roughly) about 2 million instructions.  So
if we can burn 20 thousand instructions finding a read order that eliminates
*one* seek, we're 1.98M instructions ahead.

Now, if you have an improved read-ahead that spews out page requests that
are both elevator-friendly and temporal-friendly, *then* you might be onto
something.  For instance, if you can identify 80 pages that will likely be
needed in the next 50 milliseconds, of which 50 pages will be likely needed
in the next 30ms, you want to issue those 50 first, in an elevator-friendly
manner (uncaffienated handwave here) - and then issue the other 30 page
requests in a second burst the next time the elevator goes by.  Note this
requires the read-ahead to get a *lot* more chummy with the elevator than
it seems to currently.  In particular, readahead would need to need to be
able to hold off submitting the "later" 30 pages until it could be sure
that the elevator wouldn't merge them into the queue in a way that would
slow down the first 50 requests.

If it does that already, somebody just smack me.  And if there's a good
reason not to do that, hand me some caffeine and a clue. :)



--==_Exmh_1153225122_3154P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvNGicC3lWbTT17ARAlj3AJ9R4nbln7gdXhV4QFvl7JE5B3x6mACgjY89
W9m9jYVFp1omGum1gp/Ygqk=
=ziRy
-----END PGP SIGNATURE-----

--==_Exmh_1153225122_3154P--
