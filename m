Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313792AbSDHXb5>; Mon, 8 Apr 2002 19:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313793AbSDHXb4>; Mon, 8 Apr 2002 19:31:56 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:40074 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313792AbSDHXbx>; Mon, 8 Apr 2002 19:31:53 -0400
Subject: [BKPatch-2.5.8-pre2] Cleanup: Remove BH_Req
To: torvalds@transmeta.com
Date: Tue, 9 Apr 2002 00:31:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16uic4-0002wq-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I have noticed that BH_Req is not actually used for anything any more both
in 2.4 and 2.5 kernels. There are a handful of places that set/clear it
but no one tests for it so it seems to me it is a good target for removal.

Unless someone has sinister plans for BH_Req (in which case I expect them 
to scream NOW), please apply below patch which removes the no longer 
user BH_Req altogether from the kernel tree.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--------bhreq.patch--------
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.586, 2002-04-09 00:14:26+01:00, aia21@cam.ac.uk
  Remove BH_Req as it is no longer used for anything.


 drivers/block/ll_rw_blk.c     |    2 --
 drivers/md/raid5.c            |    2 +-
 fs/buffer.c                   |    2 --
 fs/jbd/transaction.c          |    1 -
 fs/reiserfs/tail_conversion.c |    1 -
 include/linux/fs.h            |    1 -
 6 files changed, 1 insertion(+), 8 deletions(-)


diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Tue Apr  9 00:22:36 2002
+++ b/drivers/block/ll_rw_blk.c	Tue Apr  9 00:22:36 2002
@@ -1396,8 +1396,6 @@
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
-	set_bit(BH_Req, &bh->b_state);
-
 	/*
 	 * from here on down, it's all bio -- do the initial mapping,
 	 * submit_bio -> generic_make_request may further map this bio around
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Tue Apr  9 00:22:36 2002
+++ b/drivers/md/raid5.c	Tue Apr  9 00:22:36 2002
@@ -472,7 +472,7 @@
 	/* FIXME - later we will need bdev here */
 	bh->b_blocknr   = block;
 
-	bh->b_state	= (1 << BH_Req) | (1 << BH_Mapped);
+	bh->b_state	= 1 << BH_Mapped;
 	bh->b_size	= sh->size;
 	bh->b_list	= BUF_LOCKED;
 	return bh;
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Tue Apr  9 00:22:36 2002
+++ b/fs/buffer.c	Tue Apr  9 00:22:36 2002
@@ -1313,7 +1313,6 @@
 		bh->b_bdev = NULL;
 		clear_bit(BH_Uptodate, &bh->b_state);
 		clear_bit(BH_Mapped, &bh->b_state);
-		clear_bit(BH_Req, &bh->b_state);
 		clear_bit(BH_New, &bh->b_state);
 		remove_from_queues(bh);
 		unlock_buffer(bh);
@@ -1436,7 +1435,6 @@
 	if (old_bh) {
 		mark_buffer_clean(old_bh);
 		wait_on_buffer(old_bh);
-		clear_bit(BH_Req, &old_bh->b_state);
 		__brelse(old_bh);
 	}
 }
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	Tue Apr  9 00:22:36 2002
+++ b/fs/jbd/transaction.c	Tue Apr  9 00:22:36 2002
@@ -1862,7 +1862,6 @@
 	J_ASSERT_BH(bh, !buffer_jdirty(bh));
 	clear_bit(BH_Uptodate, &bh->b_state);
 	clear_bit(BH_Mapped, &bh->b_state);
-	clear_bit(BH_Req, &bh->b_state);
 	clear_bit(BH_New, &bh->b_state);
 	bh->b_bdev = NULL;
 	return may_free;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Tue Apr  9 00:22:36 2002
+++ b/fs/reiserfs/tail_conversion.c	Tue Apr  9 00:22:36 2002
@@ -140,7 +140,6 @@
     mark_buffer_clean(bh) ;
     lock_buffer(bh) ;
     clear_bit(BH_Mapped, &bh->b_state) ;
-    clear_bit(BH_Req, &bh->b_state) ;
     clear_bit(BH_New, &bh->b_state) ;
     bh->b_bdev = NULL;
     unlock_buffer(bh) ;
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Apr  9 00:22:36 2002
+++ b/include/linux/fs.h	Tue Apr  9 00:22:36 2002
@@ -215,7 +215,6 @@
 	BH_Uptodate,	/* 1 if the buffer contains valid data */
 	BH_Dirty,	/* 1 if the buffer is dirty */
 	BH_Lock,	/* 1 if the buffer is locked */
-	BH_Req,		/* 0 if the buffer has been invalidated */
 	BH_Mapped,	/* 1 if the buffer has a disk mapping */
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


makepatch: ChangeSet |1 revisions
makepatch: fs/jbd/transaction.c |1 revisions
makepatch: fs/reiserfs/tail_conversion.c |1 revisions
makepatch: drivers/block/ll_rw_blk.c |1 revisions
makepatch: drivers/md/raid5.c |1 revisions
makepatch: fs/buffer.c |1 revisions
makepatch: include/linux/fs.h |1 revisions
makepatch: patch contains 7 revisions from 7 files
begin 664 bkpatch30079
M'XL(`#PFLCP``\U778_:.!1])K_"4A\K$E_;<6RV5&S;U7:UK7;$JL_(<<R0
M3DC8?-!VE1^_3B@#0T@ST&TU@`0R\=&Y]_B>>_T,?2A,/AFI6!%PGJ&W65%.
M1EJM7:7=ZLZNS+/,KGA5D7M%KKV$^*Y.C$JKC6/_O5&E7J&MR8O)"%QZOU)^
MV9C):/[;[Q_>_3IWG.D4O5ZI]-;\;4HTG3IEEF]5$A4S5:Z2+'7+7*7%VI3*
MU=FZOG^T)A@3^_8AH-CG-7#,@EI#!*`8F`@3)CASU-UF/?LWWC2;756=[F>8
M8\HXX3633!#G#0+7%QQAXF'F88DPG@";$/X<PP1CU.9B=I\#])RC,79>H?^7
M]&M'H[E99UN#7KU=S,T_2!4H+E%<H#1#%O_6Y*@J3(2668Y4^J5<Q>FMZ_R)
M&*=!X-P<,NJ,+WPY#E;8>3D0493'C;#>.O)R%4=6]Z/0F/VJL4^`U6%@]%)3
M&01",Q+XIPGL!6)8$`J,0.V#W3=(*$YU4D7&2^*T^NPM"W=UG&M)I<VU3X.:
M8R.%B(+E,N*AX1T^?3A'?!BCXM$)"I-,WWE)LL@_+<+D[B1/F%E:7,A:4*"<
M80TDXMJG75X#>`=ZP*5LZ&V:6CO/;5EXN8EM;=L?I8J3A<[2!CRV3Q[S\S&E
M-0;"9$TI#K$`*J-($\(Z]!X!>:!(!(-ABA_#R&L7E2X?,B.8$BIJP!1X'9(@
MY('2@D`DL7^66@_4$2-"R?"AMTAAM5R:_$&6[.$2-2:`H0Y#0QA7$&A-9,CE
M.2X/$8YTPYQ"ZX;G"#?&^$/2Y41J:S[."NLF;F2^"21M07-K6L0'O'/*KD]"
MGT]B-(8?[Y/6`7=2_H7&^:?V8QWMYFQ*KW#&-R"XC^Y5ZC_QPW)]9P%V91LN
M/T;L1FRA@/K0Z@=/4L#6';H"]@=XE9*,?A6RUUF'AY'O-'DK8F+T73PSV[B)
M9+PU:5GEIG@4.!$$@T\MN+0S3*LGDQ?I27Z*GKN&=*)G;W!7:4FE1.2!F(=Q
MXO$J7CK+?*O"^S$YQD"I'2.L)P<75R'\K"K<35T]JAVBND8N%C0>^L?N:Q2N
MQB_#15&JTHRF"-"+%PV)]VJS,=$O>Z?=-\UA,2_NT9T;PID>O;LC^$T9DYUF
M`7V*E=:.$%WGW(=S76W9XPFM7\JOAMD=D8=EN7(\/VES_</YOK?YPK?'MJVJ
J)]G<=I>'$XFZ85VC%`'1"+2_9>N5;2U%M9YR0HT(_<#Y#ZJ0`Q[0#P``
`
end
