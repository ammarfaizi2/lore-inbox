Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSKTEsH>; Tue, 19 Nov 2002 23:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKTEsH>; Tue, 19 Nov 2002 23:48:07 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:47353 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265727AbSKTEsG>; Tue, 19 Nov 2002 23:48:06 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15835.5488.59408.747895@wombat.chubb.wattle.id.au>
Date: Wed, 20 Nov 2002 15:54:08 +1100
To: =?ISO-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
Subject: [patch] 2.5.48-bk, md raid0 fix
In-Reply-To: <101840980@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
CC: linux-kernel@vger.kernel.org
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thorbjørn" == Thorbjørn Lind <mtl@slowbone.net> writes:

Thorbjørn> Fixes the 'BUG at drivers/block/ll_rw_blk.c:19xx' when
Thorbjørn> using raid0 md devices since 2.5.45...  /tul

Your patch won't work if CONFIG_LBD is on.  I haven't seen this bug
reported since the raid0_mergeable_bvec() function went in.

Are you not using power-of-two sized chunks?  If not, use the
sector_div() macro to do the remainder, not a direct remainder
operation (which will fail to link if CONFIG_LBD on IA32)


You could try ... (untested)
--- /tmp/geta22599	2002-11-20 15:48:17.000000000 +1100
+++ raid0.c		2002-11-20 15:46:11.000000000 +1100
@@ -163,7 +163,7 @@
 }
 
 /**
- *	raid0_mergeable_bvec -- tell bio layer if a two requests can be merged
+ *	raid0_mergeable_bvec -- tell bio layer if two requests can be merged
  *	@q: request queue
  *	@bio: the buffer head that's been built up so far
  *	@biovec: the request that could be merged to it.
@@ -181,7 +181,7 @@
	block = bio->bi_sector >> 1;
	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
 
-	return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
+	return (chunk_size - (sector_div(block, chunk_size) + bio_sz))
<< 10;
 }
 

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.


