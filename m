Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUBNCE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 21:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUBNCE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 21:04:56 -0500
Received: from cm6.gamma186.maxonline.com.sg ([202.156.186.6]:12160 "EHLO
	garfield.anomalistic.org") by vger.kernel.org with ESMTP
	id S264542AbUBNCEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 21:04:52 -0500
Date: Sat, 14 Feb 2004 10:04:49 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: VM Acct patch (was Re: 2.6.3-rc1-mm1)
Message-ID: <20040214020449.GA2252@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20040209014035.251b26d1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
X-Operating-System: Linux 2.6.3-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<quote sender=3D"Andrew Morton">
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2=
=2E6.3-rc1-mm1/

[snipped]

While doing my port, I noticed that add_page_state macro can be used
in place of mod_page_state, since both performs the same task, and the
former is more meaningful.

Here my patch. It applies to 2.6.3-rc2-mm1, but it shouldn't matter if
-rc2 or -rc2-mm1 is applied. I have compiled this patch, and tested it
too.

http://www.anomalistic.org/patches/vmacct-mod_page_state-fix-2.6.3-rc2-mm1.=
patch

diff -Naur -X /home/amnesia/w/dontdiff 2.6.3-rc2-mm1-BAK/drivers/block/ll_r=
w_blk.c 2.6.3-rc2-mm1-fix/drivers/block/ll_rw_blk.c
--- 2.6.3-rc2-mm1-BAK/drivers/block/ll_rw_blk.c	2004-02-14 09:36:28.0000000=
00 +0800
+++ 2.6.3-rc2-mm1-fix/drivers/block/ll_rw_blk.c	2004-02-14 09:40:43.0000000=
00 +0800
@@ -2313,9 +2313,9 @@
 	BIO_BUG_ON(!bio->bi_io_vec);
 	bio->bi_rw =3D rw;
 	if (rw & WRITE)
-		mod_page_state(pgpgout, count);
+		add_page_state(pgpgout, count);
 	else
-		mod_page_state(pgpgin, count);
+		add_page_state(pgpgin, count);
=20
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
diff -Naur -X /home/amnesia/w/dontdiff 2.6.3-rc2-mm1-BAK/fs/inode.c 2.6.3-r=
c2-mm1-fix/fs/inode.c
--- 2.6.3-rc2-mm1-BAK/fs/inode.c	2004-02-14 09:36:30.000000000 +0800
+++ 2.6.3-rc2-mm1-fix/fs/inode.c	2004-02-14 09:44:57.000000000 +0800
@@ -453,9 +453,9 @@
 	up(&iprune_sem);
=20
 	if (current_is_kswapd())
-		mod_page_state(kswapd_inodesteal, reap);
+		add_page_state(kswapd_inodesteal, reap);
 	else
-		mod_page_state(pginodesteal, reap);
+		add_page_state(pginodesteal, reap);
 }
=20
 /*
diff -Naur -X /home/amnesia/w/dontdiff 2.6.3-rc2-mm1-BAK/mm/page_alloc.c 2.=
6.3-rc2-mm1-fix/mm/page_alloc.c
--- 2.6.3-rc2-mm1-BAK/mm/page_alloc.c	2004-02-14 09:36:30.000000000 +0800
+++ 2.6.3-rc2-mm1-fix/mm/page_alloc.c	2004-02-14 09:42:01.000000000 +0800
@@ -268,7 +268,7 @@
 	LIST_HEAD(list);
 	int i;
=20
-	mod_page_state(pgfree, 1 << order);
+	add_page_state(pgfree, 1 << order);
 	for (i =3D 0 ; i < (1 << order) ; ++i)
 		free_pages_check(__FUNCTION__, page + i);
 	list_add(&page->list, &list);
@@ -512,7 +512,7 @@
=20
 	if (page !=3D NULL) {
 		BUG_ON(bad_range(zone, page));
-		mod_page_state(pgalloc, 1 << order);
+		add_page_state(pgalloc, 1 << order);
 		prep_new_page(page, order);
 	}
 	return page;
diff -Naur -X /home/amnesia/w/dontdiff 2.6.3-rc2-mm1-BAK/mm/vmscan.c 2.6.3-=
rc2-mm1-fix/mm/vmscan.c
--- 2.6.3-rc2-mm1-BAK/mm/vmscan.c	2004-02-14 09:36:30.000000000 +0800
+++ 2.6.3-rc2-mm1-fix/mm/vmscan.c	2004-02-14 09:45:09.000000000 +0800
@@ -460,10 +460,10 @@
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
-	mod_page_state(pgsteal, ret);
+	add_page_state(pgsteal, ret);
 	if (current_is_kswapd())
-		mod_page_state(kswapd_steal, ret);
-	mod_page_state(pgactivate, pgactivate);
+		add_page_state(kswapd_steal, ret);
+	add_page_state(pgactivate, pgactivate);
 	return ret;
 }
=20
@@ -535,7 +535,7 @@
 		if (nr_taken =3D=3D 0)
 			goto again;
=20
-		mod_page_state(pgscan, nr_scan);
+		add_page_state(pgscan, nr_scan);
 		nr_freed =3D shrink_list(&page_list, gfp_mask, nr_scanned);
 		ret +=3D nr_freed;
=20
@@ -784,8 +784,8 @@
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
=20
-	mod_page_state(pgrefill, nr_pages_in - nr_pages);
-	mod_page_state(pgdeactivate, pgdeactivate);
+	add_page_state(pgrefill, nr_pages_in - nr_pages);
+	add_page_state(pgdeactivate, pgdeactivate);
 }
=20
 /*

--=20
Eugene TEO -  <eugeneteo%eugeneteo!net>   <http://www.anomalistic.org/>
1024D/14A0DDE5 print D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALYJBcyGjihSg3eURAh8kAJ9cRCWsoTXn/KZ3czvPrCuIe7g1AwCeK9XK
Bm/PQgeD+TBfmJVp6eQmAwI=
=oJ1L
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
