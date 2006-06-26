Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWFZBHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWFZBHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWFZBHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54462 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964996AbWFZBHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:07:03 -0400
From: Neil Brown <neilb@suse.de>
To: Ronald Lembcke <es186@fen-net.de>
Date: Mon, 26 Jun 2006 11:06:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17567.13099.133933.397389@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Bug in 2.6.17 / mdadm 2.5.1
In-Reply-To: message from Ronald Lembcke on Sunday June 25
References: <20060624104745.GA6352@defiant.crash>
	<20060625135926.GA6253@defiant.crash>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 25, es186@fen-net.de wrote:
> Hi!
> 
> There's a bug in Kernel 2.6.17 and / or mdadm which prevents (re)adding
> a disk to a degraded RAID5-Array.

Thank you for the detailed report.
The bug is in the md driver in the kernel (not in mdadm), and only
affects version-1 superblocks.  Debian recently changed the default
(in /etc/mdadm.conf) to use version-1 superblocks which I thought
would be OK (I've some testing) but obviously I missed something. :-(

If you remove the "metadata=1" (or whatever it is) from
/etc/mdadm/mdadm.conf and then create the array, it will be created
with a version-0.90 superblock has had more testing.

Alternately you can apply the following patch to the kernel and
version-1 superblocks should work better.

NeilBrown

-------------------------------------------------
Set desc_nr correctly for version-1 superblocks.

This has to be done in ->load_super, not ->validate_super

### Diffstat output
 ./drivers/md/md.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-06-26 11:02:43.000000000 +1000
+++ ./drivers/md/md.c	2006-06-26 11:02:46.000000000 +1000
@@ -1057,6 +1057,11 @@ static int super_1_load(mdk_rdev_t *rdev
 	if (rdev->sb_size & bmask)
 		rdev-> sb_size = (rdev->sb_size | bmask)+1;
 
+	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH))
+		rdev->desc_nr = -1;
+	else
+		rdev->desc_nr = le32_to_cpu(sb->dev_number);
+
 	if (refdev == 0)
 		ret = 1;
 	else {
@@ -1165,7 +1170,6 @@ static int super_1_validate(mddev_t *mdd
 
 	if (mddev->level != LEVEL_MULTIPATH) {
 		int role;
-		rdev->desc_nr = le32_to_cpu(sb->dev_number);
 		role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
 		switch(role) {
 		case 0xffff: /* spare */
