Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUB0WBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUB0V7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:59:50 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:720 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263155AbUB0V4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:56:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jurriaan <thunder7@xs4all.nl>, Andrew Morton <akpm@osdl.org>
Date: Sat, 28 Feb 2004 08:56:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16447.48383.185576.969926@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio_put oopses in 2.6.3-mm3 when resyncing reiserfs/raid1
In-Reply-To: message from Jurriaan on Friday February 27
References: <20040227185758.GA8450@middle.of.nowhere>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 27, thunder7@xs4all.nl wrote:
> I got this in 2.6.3-mm3 when rsyncing my reiserfs on raid1 system.
> The taint is vmware (with the latest vmware-any-any updates) but X
> hadn't been started, let alone vmware. It happened multiple times,
> until I rebooted 2.6.3-mm1 and all was fine again. I don't see any
> patches in 2.6.3-mm4 that would solve this, and I couldn't find any
> similar reports on lkml.

Thanks for the report.  This patch should fix the problem.

NeilBrown


 ----------- Diffstat output ------------
 ./drivers/md/raid1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2004-02-24 11:49:11.000000000 +1100
+++ ./drivers/md/raid1.c	2004-02-28 08:44:05.000000000 +1100
@@ -104,8 +104,8 @@ out_free_pages:
 	for ( ; i > 0 ; i--)
 		__free_page(bio->bi_io_vec[i-1].bv_page);
 out_free_bio:
-	while ( j < raid_disks )
-		bio_put(r1_bio->bios[++j]);
+	while ( ++j < raid_disks )
+		bio_put(r1_bio->bios[j]);
 	r1bio_pool_free(r1_bio, data);
 	return NULL;
 }
