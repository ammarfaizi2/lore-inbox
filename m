Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUJWNAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUJWNAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUJWNAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:00:00 -0400
Received: from www.marcet.info ([213.60.130.45]:38325 "EHLO mail.marcet.info")
	by vger.kernel.org with ESMTP id S261161AbUJWM7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:59:52 -0400
Date: Sat, 23 Oct 2004 14:59:49 +0200
From: Javier Marcet <javier@marcet.info>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
Message-ID: <20041023125948.GC9488@marcet.info>
Reply-To: Javier Marcet <javier@marcet.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 2004.2 / 2.6.9-ck1-marcet i686 AMD Athlon(TM) XP 2000+ AuthenticAMD
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been following quite closely the development of 2.6.9, testing
every -rc release and a lot of -bk's.

Upon changing from 2.6.9-rc2 to 2.6.9-rc3 I began experiencing random
oom kills whenever a high memory i/o load took place.
This happened with plenty of free memory, and with whatever values I
used for vm.overcommit_ratio and vm.overcommit_memory
Doubling the physical RAM didn't change the situation either.

Having traced the problem to 2.6.9-rc3, I took a look at the differences
in memory handling between 2.6.9-rc2 and 2.6.9-rc3 and with the attached
patch I have no more oom kills. Not a single one.

I'm not saying everything within the patch is needed, not even that it's
the right thing to change. Nonetheless, 2.6.9 vanilla was unusable,
while this avoids those memory leaks.

Please, review and see what's wrong there :)


--=20
A mother takes twenty years to make a man of her boy, and another woman
makes a fool of him in twenty minutes.
a		-- Frost

Javier Marcet <javier@marcet.info>

--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="revert_mem_to_2.6.8.1.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.9-rc3/mm/highmem.c	2004-10-23 09:31:45.314459000 +0200
+++ linux-2.6.9-rc2/mm/highmem.c	2004-10-23 09:29:30.451961216 +0200
@@ -300,7 +300,6 @@
 		 */
 		vfrom =3D page_address(fromvec->bv_page) + tovec->bv_offset;
=20
-		flush_dcache_page(tovec->bv_page);
 		bounce_copy_vec(tovec, vfrom);
 	}
 }
@@ -407,7 +406,6 @@
 		if (rw =3D=3D WRITE) {
 			char *vto, *vfrom;
=20
-			flush_dcache_page(from->bv_page);
 			vto =3D page_address(to->bv_page) + to->bv_offset;
 			vfrom =3D kmap(from->bv_page) + from->bv_offset;
 			memcpy(vto, vfrom, to->bv_len);
--- linux-2.6.9-rc3/mm/mempolicy.c	2004-10-23 09:31:45.321457936 +0200
+++ linux-2.6.9-rc2/mm/mempolicy.c	2004-10-23 09:29:30.474957720 +0200
@@ -132,7 +132,6 @@
 	unsigned long nlongs;
 	unsigned long endmask;
=20
-	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
 	if (maxnode =3D=3D 0 || !nmask)
 		return 0;
@@ -146,8 +145,6 @@
 	/* When the user specified more nodes than supported just check
 	   if the non supported part is all zero. */
 	if (nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
-		if (nlongs > PAGE_SIZE/sizeof(long))
-			return -EINVAL;
 		for (k =3D BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
 			unsigned long t;
 			if (get_user(t,  nmask + k))

--1SQmhf2mF2YjsYvc--
