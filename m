Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbUK0AK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbUK0AK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUK0AHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:07:33 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:52171 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263072AbUK0ACi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:02:38 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: member@bellaby.freeserve.co.uk
Date: Sat, 27 Nov 2004 11:02:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16807.50192.233832.966091@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RAID10 overwrites partition tables
In-Reply-To: message from Felix Bellaby on Friday November 26
References: <10578812.1101490100216.JavaMail.www@wwinf3001>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 26, member@bellaby.freeserve.co.uk wrote:
>    	 mdadm --level 10 does not seem to respect disk partition boundaries.

Hmmm, yes, thanks.

I think the following should fix the bug.  It only affects 'resync'
not normal IO or recovery (after a drive has failed).

(I only tested it on whole-drives....)

Please let me know if it helps.

NeilBrown


 ----------- Diffstat output ------------
 ./drivers/md/raid10.c |    1 +
 1 files changed, 1 insertion(+)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2004-11-16 16:33:50.000000000 +1100
+++ ./drivers/md/raid10.c	2004-11-27 11:00:06.000000000 +1100
@@ -1150,6 +1150,7 @@ static void sync_request_write(mddev_t *
 		md_sync_acct(conf->mirrors[d].rdev->bdev, tbio->bi_size >> 9);
 
 		tbio->bi_sector += conf->mirrors[d].rdev->data_offset;
+		tbio->bi_bdev = conf->mirrors[d].rdev->bdev;
 		generic_make_request(tbio);
 	}
 
