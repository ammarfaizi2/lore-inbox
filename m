Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbVLGS4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbVLGS4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbVLGS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:56:09 -0500
Received: from pat.uio.no ([129.240.130.16]:12443 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751756AbVLGS4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:56:07 -0500
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
	 <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
	 <1133969671.27373.47.camel@lade.trondhjem.org>
	 <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
Content-Type: multipart/mixed; boundary="=-2Oq2Q4N/5K5plfKZp8y4"
Date: Wed, 07 Dec 2005 13:55:25 -0500
Message-Id: <1133981725.8459.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.889, required 12,
	autolearn=disabled, AWL 1.11, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Oq2Q4N/5K5plfKZp8y4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-12-07 at 10:34 -0600, Dave Kleikamp wrote:
> On Wed, 2005-12-07 at 10:34 -0500, Trond Myklebust wrote:
> > If you really want a variable size type here, then the right thing to do
> > is to define a __kernel_blkcnt_t or some such thing, and hide the
> > configuration knob for it somewhere in the arch-specific Kconfigs.
> 
> Takashi's patch does improve on what currently exists.  Maybe someone
> can create a separate patch to replace sector_t with blkcnt_t where it
> makes sense.

I can't see that it makes sense to replace sector_t with blkcnt_t in the
case of kstatfs. The only place where it may make sense is i_block,
since that grows the size of the inode on embedded systems.

Here is a patch to fix the former.

Cheers,
  Trond


--=-2Oq2Q4N/5K5plfKZp8y4
Content-Disposition: inline; filename=linux-2.6.15-fix_borken_sector_t.dif
Content-Type: text/plain; name=linux-2.6.15-fix_borken_sector_t.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

VFS: Convert abuses of sector_t

 The type "sector_t" is heavily tied in to the block layer interface as an
 offset/handle to a block, and is subject to a supposedly block-specific
 configuration option: CONFIG_LBD. Despite this, it is used in struct
 kstatfs to save a couple of bytes on the stack whenever we call the
 filesystems' ->statfs().

 One consequence is that networked filesystems may break if CONFIG_LBD is
 not set, since it is quite common to have multi-TB remote filesystems.

 The following patch just converts struct kstatfs to use the standard type u64.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 include/linux/statfs.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index ad83a2b..b34cc82 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -8,11 +8,11 @@
 struct kstatfs {
 	long f_type;
 	long f_bsize;
-	sector_t f_blocks;
-	sector_t f_bfree;
-	sector_t f_bavail;
-	sector_t f_files;
-	sector_t f_ffree;
+	u64 f_blocks;
+	u64 f_bfree;
+	u64 f_bavail;
+	u64 f_files;
+	u64 f_ffree;
 	__kernel_fsid_t f_fsid;
 	long f_namelen;
 	long f_frsize;

--=-2Oq2Q4N/5K5plfKZp8y4--

