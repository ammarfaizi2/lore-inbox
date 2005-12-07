Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVLGWEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVLGWEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbVLGWEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:04:38 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:48909 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750787AbVLGWEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:04:38 -0500
Date: Wed, 7 Dec 2005 17:04:01 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, akpm@osdl.org
Subject: [PATCH] vm: enhance __alloc_pages to prioritize pagecache eviction when pressed for memory
Message-ID: <20051207220401.GB13577@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all-
     I was recently shown this issue, wherein, if the kernel was kept full =
of
pagecache via applications that were constantly writing large amounts of da=
ta to
disk, the box could find itself in a position where the vm, in __alloc_pages
would invoke the oom killer repetatively within try_to_free_pages, until su=
ch
time as the box had no candidate processes left to kill, at which point it =
would
panic.  While this seems like the right thing to do in general, it occured =
to me
that if we could simply force some additional evictions from pagecache befo=
re we
tried to reclaim memory in try_to_free_pages, we stood a good chance of avo=
iding
the need to invoke the oom killer at all (assuming that the pages freed from
pagecache were physically contiguous).  The following patch preforms this
operation and in my testing, and that of the origional reporter, results in
avoidance of the oom killer being invoked for the workloads which would
previously oom kill the box to the point that it would panic.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@redhat.com>


 include/linux/writeback.h |    1 +
 mm/page-writeback.c       |   17 +++++++++++++++++
 mm/page_alloc.c           |   10 ++++++++++
 3 files changed, 28 insertions(+)


diff --git a/include/linux/writeback.h b/include/linux/writeback.h
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -86,6 +86,7 @@ static inline void wait_on_inode(struct=20
  * mm/page-writeback.c
  */
 int wakeup_pdflush(long nr_pages);
+void clean_pagecache(long nr_pages);
 void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -350,6 +350,23 @@ static void background_writeout(unsigned
 }
=20
 /*
+ * Writeback nr_pages from pagecache to disk synchronously
+ * blocks until the writeback is complete
+ */
+void clean_pagecache(long nr_pages)
+{
+	struct writeback_control wbc =3D {
+		.bdi            =3D NULL,
+		.sync_mode      =3D WB_SYNC_ALL,
+		.older_than_this =3D NULL,
+		.nr_to_write    =3D nr_pages,
+		.nonblocking    =3D 0,
+	};
+
+	writeback_inodes(&wbc);
+}
+
+/*
  * Start writeback of `nr_pages' pages.  If `nr_pages' is zero, write back
  * the whole world.  Returns 0 if a pdflush thread was dispatched.  Returns
  * -1 if all pdflush threads were busy.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -949,6 +949,16 @@ rebalance:
 	reclaim_state.reclaimed_slab =3D 0;
 	p->reclaim_state =3D &reclaim_state;
=20
+	/*
+	 * We're pinched for memory, so before we try to reclaim some=20
+	 * pages synchronously, lets try to force some more pages out
+	 * of pagecache, to raise our chances of this succeding.
+	 * specifically, lets write out the number of pages that this
+	 * allocation is requesting, in the hopes that they will be
+	 * contiguous
+	 */
+	clean_pagecache(1<<order);
+
 	did_some_progress =3D try_to_free_pages(zonelist->zones, gfp_mask);
=20
 	p->reclaim_state =3D NULL;
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDl1xRM+bEoZKnT6ERAuPTAJ0csGqZvpx+4AkDnipLNeCoPwsUsACeLDQv
YCL739Ba7P9Mgb2ih7NfPnw=
=YPv/
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
