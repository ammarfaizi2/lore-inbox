Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbVKPXIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbVKPXIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbVKPXIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:08:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39608 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030574AbVKPXIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:08:41 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 17 Nov 2005 10:08:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17275.48113.533555.948181@cse.unsw.edu.au>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1
 ramdisk patch)
In-Reply-To: message from Andrew Morton on Wednesday November 16
References: <431B9558.1070900@baanhofman.nl>
	<17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 16, akpm@osdl.org wrote:
> Sander <sander@humilis.net> wrote:
> >
> > 
> > With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
> > try this:
> 
> It oopsed in reiser4.  reiserfs-dev added to Cc...
> 

Hmm... It appears that md/bitmap is calling prepare_write and
commit_write with 'file' as NULL - this works for some filesystems,
but not for reiser4.

Does this patch help.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff ./drivers/md/bitmap.c~current~ ./drivers/md/bitmap.c
--- ./drivers/md/bitmap.c~current~	2005-11-17 10:05:18.000000000 +1100
+++ ./drivers/md/bitmap.c	2005-11-17 10:05:40.000000000 +1100
@@ -326,9 +326,9 @@ static int write_page(struct bitmap *bit
 		}
 	}
 
-	ret = page->mapping->a_ops->prepare_write(NULL, page, 0, PAGE_SIZE);
+	ret = page->mapping->a_ops->prepare_write(bitmap->file, page, 0, PAGE_SIZE);
 	if (!ret)
-		ret = page->mapping->a_ops->commit_write(NULL, page, 0,
+		ret = page->mapping->a_ops->commit_write(bitmap->file, page, 0,
 			PAGE_SIZE);
 	if (ret) {
 		unlock_page(page);
