Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271022AbRHOFCA>; Wed, 15 Aug 2001 01:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271023AbRHOFBu>; Wed, 15 Aug 2001 01:01:50 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:43020 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271022AbRHOFBl>; Wed, 15 Aug 2001 01:01:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Date: Wed, 15 Aug 2001 15:01:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15226.568.747760.467691@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: need help debugging a weird md/devfs problem...
In-Reply-To: message from Kevin P. Fleming on Tuesday August 14
In-Reply-To: <022901c124dc$ee5138f0$6baaa8c0@kevin>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 14, kevin@labsysgrp.com wrote:
> 
> Anyone have any suggesting as to where to continue looking to find the
> problem? I can put a workaround in to get my machine working, but there's
> definitely something very weird going on here. Too bad I can't just tell the
> kernel to notify me when that particular memory location gets modified...
> 

The arrays in the "struct gendisk" are only allocated big enough to
hold any drives that were found.  See init_gendisk in
drivers/ide/ide-probe.c

In your situation device 3,67 is being referenced, which is hdb3.  As
hdb was not detected, the arrays, particularly the partition array is
not big enough to refer to that.  So when disk_name does:
      hd->part[minor].de
is it indexing off the end of an array an getting garbage.

At least, that is my 5minute assessment.

If I am right, the following patch should fix it for you.

NeilBrown

--- fs/partitions/check.c	2001/08/15 04:56:57	1.1
+++ fs/partitions/check.c	2001/08/15 04:57:47
@@ -101,7 +101,7 @@
 	int unit = (minor >> hd->minor_shift) + 'a';
 
 	part = minor & ((1 << hd->minor_shift) - 1);
-	if (hd->part[minor].de) {
+	if (unit < hd->nr_real && hd->part[minor].de) {
 		int pos;
 
 		pos = devfs_generate_path (hd->part[minor].de, buf, 64);
