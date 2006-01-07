Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWAGTHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWAGTHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWAGTHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:07:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56837 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030545AbWAGTHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:07:04 -0500
Date: Sat, 7 Jan 2006 20:07:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] OCFS2: __init / __exit problem
Message-ID: <20060107190702.GT3774@stusta.de>
References: <20060107132008.GE820@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107132008.GE820@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 02:20:08PM +0100, Jan-Benedict Glaw wrote:
> Hi!
> 
> $ make ARCH=vax CROSS_COMPILE=vax-linux-uclibc- mopboot
> :
>   LD      .tmp_vmlinux1
> `exit_ocfs2_uptodate_cache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o
> `exit_ocfs2_extent_maps' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o
> make: *** [.tmp_vmlinux1] Error 1
>...

Thanks for your report.

It's a real problem that due to the fact that these errors have become 
runtime errors on i386 in kernel 2.6, we do no longer have a big testing 
coverage for them.  :-(

Patch below.

> MfG, JBG

cu
Adrian


<--  snip  -->


Functions called by __init funtions mustn't be __exit.

Reported by Jan-Benedict Glaw <jbglaw@lug-owl.de>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/extent_map.c |    2 +-
 fs/ocfs2/uptodate.c   |    2 +-
 fs/ocfs2/uptodate.h   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-mm2-full/fs/ocfs2/uptodate.h.old	2006-01-07 19:45:11.000000000 +0100
+++ linux-2.6.15-mm2-full/fs/ocfs2/uptodate.h	2006-01-07 19:45:19.000000000 +0100
@@ -27,7 +27,7 @@
 #define OCFS2_UPTODATE_H
 
 int __init init_ocfs2_uptodate_cache(void);
-void __exit exit_ocfs2_uptodate_cache(void);
+void exit_ocfs2_uptodate_cache(void);
 
 void ocfs2_metadata_cache_init(struct inode *inode);
 void ocfs2_metadata_cache_purge(struct inode *inode);
--- linux-2.6.15-mm2-full/fs/ocfs2/uptodate.c.old	2006-01-07 19:45:35.000000000 +0100
+++ linux-2.6.15-mm2-full/fs/ocfs2/uptodate.c	2006-01-07 19:45:44.000000000 +0100
@@ -537,7 +537,7 @@
 	return 0;
 }
 
-void __exit exit_ocfs2_uptodate_cache(void)
+void exit_ocfs2_uptodate_cache(void)
 {
 	if (ocfs2_uptodate_cachep)
 		kmem_cache_destroy(ocfs2_uptodate_cachep);
--- linux-2.6.15-mm2-full/fs/ocfs2/extent_map.c.old	2006-01-07 19:46:08.000000000 +0100
+++ linux-2.6.15-mm2-full/fs/ocfs2/extent_map.c	2006-01-07 19:46:40.000000000 +0100
@@ -988,7 +988,7 @@
 	return 0;
 }
 
-void __exit exit_ocfs2_extent_maps(void)
+void exit_ocfs2_extent_maps(void)
 {
 	kmem_cache_destroy(ocfs2_em_ent_cachep);
 }

