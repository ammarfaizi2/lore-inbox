Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVCVAbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVCVAbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCVAaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:30:20 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:55484 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262169AbVCVA11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:27:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16959.26301.299807.585891@wombat.chubb.wattle.id.au>
Date: Tue, 22 Mar 2005 11:28:45 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: jniehof@bu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: LBD/filesystems over 2TB: is it safe?
In-Reply-To: <37550.128.197.73.126.1111445738.squirrel@128.197.73.126>
References: <37550.128.197.73.126.1111445738.squirrel@128.197.73.126>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jniehof" == jniehof  <jniehof@bu.edu> writes:

jniehof> Someone posted to the LBD list last December regarding some
jniehof> supposedly horrible bugs in large filesystems:
jniehof> https://www.gelato.unsw.edu.au/archives/lbd/2004-December/000075.html
jniehof> https://www.gelato.unsw.edu.au/archives/lbd/2004-December/000074.html

The changes in those emails are irrelevant --- they fail to take into
account the properties of the filesystems that they modify, that mean
that the 32-bit quantities being shifted will not overflow.

They're typically of the form:
-       iblock = index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	iblock = (sector_t) index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 
Now, on a 32-bit processor with 4k pages, PAGE_CACHE_SHIFT is 12, and
i_blkbits is also 12 if you're using 4k blocks (which you have to to
get a large filesystem).  So this does nothing and is safe.  The
on-disk format for ext[23] uses 32-bit block numbers, so your maximum
filesystem size is 16TB, and your maximum value of iblock is 2^32-1.

Please do benchmark XFS and ext3 on your system before choosing.  Our
tests (to be published in Linux.Conf.Au next month) show that XFS is
significantly faster for some workloads.
Also its scalability to very large filesystems is much more mature than ext3.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
