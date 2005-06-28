Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVF1EOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVF1EOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVF1EOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:14:30 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:3493 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262514AbVF1EOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:14:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: earny@net4u.de, Andrew Morton <akpm@osdl.org>
Date: Tue, 28 Jun 2005 14:13:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17088.52861.78252.726904@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
In-Reply-To: message from Neil Brown on Tuesday June 28
References: <200506272222.51993.list-lkml@net4u.de>
	<17088.41384.864708.23860@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 28, neilb@cse.unsw.edu.au wrote:
> 
> I just checked my test machine (running 2.6.12-rc3-mm3) and it had a
> really large number of bio and biovec-1 in use too (and it's been
> sitting fairly idle for several days).
> 
> I've quickly reviewed the raid1 code and I cannot see a bio leak
> (though that doesn't mean there isn't one..)
> 
> If anyone else has a large 'bio' slab, please report the configuration
> (kernel, is md in use, etc).

It's OK, I found it.  The bio leaks when writing the md superblock.

Thanks,
NeilBrown


--
insert a missing bio_put when writting the md superblock.

Without this we have a steady growth in the "bio" slab.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/md/md.c |    1 +
 1 files changed, 1 insertion(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2005-06-22 13:16:28.000000000 +1000
+++ ./drivers/md/md.c	2005-06-28 13:02:04.000000000 +1000
@@ -338,6 +338,7 @@ static int super_written(struct bio *bio
 
 	if (atomic_dec_and_test(&rdev->mddev->pending_writes))
 		wake_up(&rdev->mddev->sb_wait);
+	bio_put(bio);
 	return 0;
 }
 
