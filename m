Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265347AbSKARRb>; Fri, 1 Nov 2002 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265356AbSKARRb>; Fri, 1 Nov 2002 12:17:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51725 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265347AbSKARRa>; Fri, 1 Nov 2002 12:17:30 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15810.46998.714820.519167@crimson.namesys.com>
Date: Fri, 1 Nov 2002 20:19:18 +0300
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Hans Reiser <reiser@namesys.com>, lkml <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <20021101102327.GA26306@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com>
	<200210312334.18146.Dieter.Nuetzel@hamburg.de>
	<3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
X-Mailer: VM 7.00 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe writes:
 > > The atomic transactions that reiser4 offers are a much higher level of 
 > > data security than data journaling.  Really, you should read the 17 page 
 > > papers I send you URLs to;-).....
 > > (www.namesys.com/v4/fast_reiser4.html).
 > 
 > Am I to assume the following is expected behavior then?
 > 
 > # mkfs.reiser4 /dev/sda2
 > mkfs.reiser4, 0.1.0
 > Information: Reiser4 is going to be created on /dev/sda2.
 > (Yes/No): y
 > Creating reiser4 on /dev/sda2 with default40 profile...done
 > Synchronizing /dev/sda2...done
 > # mount /dev/sda2 /ap
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332       136   1490196   1% /ap
 > # (cd /ap && tar xzf /usr/src/linux-2.5.45.tgz)
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332    200508   1289824  14% /ap
 > # sync
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332    200468   1289864  14% /ap
 > # rm -rf /ap/linux-2.5.45
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332    255436   1234896  18% /ap
 > # # wtf is going on here?
 > # sync
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332     85848   1404484   6% /ap
 > # umount /ap
 > # mount /dev/sda2 /ap
 > # df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332     54532   1435800   4% /ap
 > # # and here?

This should help:

diff -Nru a/txnmgr.c b/txnmgr.c
--- a/txnmgr.c	Wed Oct 30 18:58:09 2002
+++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
@@ -1917,7 +1917,7 @@
 		return;
 	}
 
-	if (!jnode_is_unformatted) {
+	if (jnode_is_znode(node)) {
 		if ( /**jnode_get_block(node) &&*/
 			   !blocknr_is_fake(jnode_get_block(node))) {
 			/* jnode has assigned real disk block. Put it into

 > 
 > T.

Thank you for report.

-- 
Alex.
