Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLKGWv>; Mon, 11 Dec 2000 01:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQLKGWm>; Mon, 11 Dec 2000 01:22:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28681 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130026AbQLKGWa>; Mon, 11 Dec 2000 01:22:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 11 Dec 2000 16:51:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14900.27515.416607.892448@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - use submit_bh in brw_kiovec
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
  the new submit_bh function provides functionality that is better
  suited for brw_kiovec to use than generic_make_request.

  This patch replaced generic_make_request with submit_bh in
  brw_kiovec and removed some field initialisation which is no longer
  required.

 patch against 2.4.0-test12-pre8

NeilBrown

--- ./fs/buffer.c	2000/12/10 23:51:16	1.1
+++ ./fs/buffer.c	2000/12/10 23:55:35	1.2
@@ -2040,7 +2040,6 @@
 	int		pageind;
 	int		bhind;
 	int		offset;
-	int		sectors = size>>9;
 	unsigned long	blocknr;
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
@@ -2092,9 +2091,8 @@
 				tmp->b_this_page = tmp;
 
 				init_buffer(tmp, end_buffer_io_kiobuf, iobuf);
-				tmp->b_rdev = tmp->b_dev = dev;
+				tmp->b_dev = dev;
 				tmp->b_blocknr = blocknr;
-				tmp->b_rsector = blocknr*sectors;
 				tmp->b_state = (1 << BH_Mapped) | (1 << BH_Lock) | (1 << BH_Req);
 
 				if (rw == WRITE) {
@@ -2108,7 +2106,7 @@
 
 				atomic_inc(&iobuf->io_count);
 
-				generic_make_request(rw, tmp);
+				submit_bh(rw, tmp);
 				/* 
 				 * Wait for IO if we have got too much 
 				 */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
