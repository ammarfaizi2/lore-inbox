Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264652AbSKDL4W>; Mon, 4 Nov 2002 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSKDL4W>; Mon, 4 Nov 2002 06:56:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:14340 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264652AbSKDL4V>; Mon, 4 Nov 2002 06:56:21 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15814.25070.118410.47102@laputa.namesys.com>
Date: Mon, 4 Nov 2002 15:02:54 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alexander Zarochentcev <zam@namesys.com>, Hans Reiser <reiser@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <20021102133824.GL28803@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com>
	<200210312334.18146.Dieter.Nuetzel@hamburg.de>
	<3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
	<15810.46998.714820.519167@crimson.namesys.com>
	<20021102133824.GL28803@louise.pinerecords.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe writes:
 > Hi,
 > 
 > Another one: trying to build 2.5.45 off a reiser4 mountpoint, I get:
 > 
 > reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
 > WARNING: Flush raced against extent->tail
 > reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
 > WARNING: flush failed: -11
 > jnode_flush failed with err = -11

Can you please try the following patch to the fs/reiser4/flush.c:
----------------------------------------------------------------------
--- /tmp/flush.c	Mon Nov  4 14:32:21 2002
+++ flush.c	Mon Nov  4 14:32:32 2002
@@ -3149,7 +3149,8 @@ flush_scan_extent(flush_scan * scan, int
 				   only. Will be removed. */
 				warning("nikita-2732", 
 					"Flush raced against extent->tail");
-				ret = -EAGAIN;
+				scan->stop = 1;
+				ret = 0;
 				goto exit;
 			}
 			assert("jmacd-1230", item_is_extent(&scan->parent_coord));
----------------------------------------------------------------------

 > reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
 > WARNING: Flush raced against extent->tail

[...]

 > WARNING: Too many iterations: 8192
 > reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
 > WARNING: Too many iterations: 16384
 > reiser4[fixdep(952)]: extent2tail (fs/reiser4/plugin/file/tail_conversion.c:476)[nikita-2282]:
 > WARNING: Partial conversion of 105116: 1 of 2
 > reiser4[cc1(957)]: extent2tail (fs/reiser4/plugin/file/tail_conversion.c:476)[nikita-2282]:
 > WARNING: Partial conversion of 105116: 0 of 2
 > [snip]
 > 
 > ... after which r4 crashes completely --
 > Starts to hog all cpu time and umount() never goes through.

Try to wait a bit more and check whether any more "WARNING: Too many
iterations" appear, OK?

 > 
 > T.

Nikita.

