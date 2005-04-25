Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVDYUNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVDYUNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVDYUNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:13:04 -0400
Received: from colino.net ([213.41.131.56]:24562 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262778AbVDYUMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:12:48 -0400
Date: Mon, 25 Apr 2005 22:12:42 +0200
From: Colin Leroy <colin@colino.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050425221242.680ed82d@jack.colino.net>
In-Reply-To: <20050425200704.GA16093@infradead.org>
References: <20050425211915.126ddab5@jack.colino.net>
	<Pine.LNX.4.61.0504252145220.25129@scrub.home>
	<20050425220345.6b2ed6d5@jack.colino.net>
	<20050425200704.GA16093@infradead.org>
X-Mailer: Sylpheed-Claws 1.9.6cvs36 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Apr 2005 at 21h04, Christoph Hellwig wrote:

Hi, 

> On Mon, Apr 25, 2005 at 10:03:45PM +0200, Colin Leroy wrote:
> 
> absolutely no need to cast here.

Third update then :-)

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/fs/hfsplus/super.c	2005-04-25 21:56:56.000000000 +0200
+++ b/fs/hfsplus/super.c	2005-04-25 21:58:39.000000000 +0200
@@ -226,6 +226,9 @@
 	brelse(HFSPLUS_SB(sb).s_vhbh);
 	if (HFSPLUS_SB(sb).nls)
 		unload_nls(HFSPLUS_SB(sb).nls);
+
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
@@ -298,7 +301,7 @@
 		if (!silent)
 			printk("HFS+-fs: unable to parse mount options\n");
 		err = -EINVAL;
-		goto cleanup;
+		goto cleanup_little;
 	}
 
 	/* temporarily use utf8 to correctly find the hidden dir below */
@@ -307,7 +310,7 @@
 	if (!nls) {
 		printk("HFS+: unable to load nls for utf8\n");
 		err = -EINVAL;
-		goto cleanup;
+		goto cleanup_little;
 	}
 
 	/* Grab the volume header */
@@ -315,7 +318,7 @@
 		if (!silent)
 			printk("HFS+-fs: unable to find HFS+ superblock\n");
 		err = -EINVAL;
-		goto cleanup;
+		goto cleanup_little;
 	}
 	vhdr = HFSPLUS_SB(sb).s_vhdr;
 
@@ -428,8 +431,12 @@
 
 cleanup:
 	hfsplus_put_super(sb);
+
+cleanup_little:
 	if (nls)
 		unload_nls(nls);
+	sb->s_fs_info = NULL;
+	kfree(sbi);
 	return err;
 }
 
