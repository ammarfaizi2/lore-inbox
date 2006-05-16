Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWEPOzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWEPOzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWEPOzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:55:44 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:34942 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751191AbWEPOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:55:43 -0400
From: David Brownell <david-b@pacbell.net>
To: jffs-dev@axis.com
Subject: Re: jffs2 build fixes
Date: Tue, 16 May 2006 07:55:37 -0700
User-Agent: KMail/1.7.1
Cc: dwmw2@infradead.org, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200604010831.57875.david-b@pacbell.net>
In-Reply-To: <200604010831.57875.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qfeaEOgeNL2PDx3"
Message-Id: <200605160755.38606.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qfeaEOgeNL2PDx3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 01 April 2006 8:31 am, David Brownell wrote:
> against today's GIT; there's a section error and
> several printk format warnings.  x86_64.

I see that Andrew also got tired of such printk warnings, so his
fix is now in the kernel.org tree ... here's a resend of this
patch, updated against today's GIT by removing two of the printk
warning fixes.

- Dave


--Boundary-00=_qfeaEOgeNL2PDx3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build.patch"

Resolve some JFFS2 build problems:
  (a) section mismatch error
  (b) wrong printk format warnings

The section mismatch issue was fixed by making a few more routines as
belonging in init or exit sections, but there are more routines that
could (should!) get such annotations.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/fs/jffs2/compr.c
===================================================================
--- g26.orig/fs/jffs2/compr.c	2006-05-12 18:48:21.000000000 -0700
+++ g26/fs/jffs2/compr.c	2006-05-12 19:40:08.000000000 -0700
@@ -412,7 +412,7 @@ void jffs2_free_comprbuf(unsigned char *
                 kfree(comprbuf);
 }
 
-int jffs2_compressors_init(void)
+int __init jffs2_compressors_init(void)
 {
 /* Registering compressors */
 #ifdef CONFIG_JFFS2_ZLIB
@@ -440,7 +440,7 @@ int jffs2_compressors_init(void)
         return 0;
 }
 
-int jffs2_compressors_exit(void)
+int __exit jffs2_compressors_exit(void)
 {
 /* Unregistering compressors */
 #ifdef CONFIG_JFFS2_RUBIN
Index: g26/fs/jffs2/compr_zlib.c
===================================================================
--- g26.orig/fs/jffs2/compr_zlib.c	2006-05-12 18:48:21.000000000 -0700
+++ g26/fs/jffs2/compr_zlib.c	2006-05-12 19:40:08.000000000 -0700
@@ -60,7 +60,7 @@ static int __init alloc_workspaces(void)
 	return 0;
 }
 
-static void free_workspaces(void)
+static void __exit free_workspaces(void)
 {
 	vfree(def_strm.workspace);
 	vfree(inf_strm.workspace);
@@ -216,7 +216,7 @@ int __init jffs2_zlib_init(void)
     return ret;
 }
 
-void jffs2_zlib_exit(void)
+void __exit jffs2_zlib_exit(void)
 {
     jffs2_unregister_compressor(&jffs2_zlib_comp);
     free_workspaces();
Index: g26/fs/jffs2/readinode.c
===================================================================
--- g26.orig/fs/jffs2/readinode.c	2006-05-12 18:48:21.000000000 -0700
+++ g26/fs/jffs2/readinode.c	2006-05-12 19:40:08.000000000 -0700
@@ -204,7 +204,7 @@ static inline int read_dnode(struct jffs
 
 	tn = jffs2_alloc_tmp_dnode_info();
 	if (!tn) {
-		JFFS2_ERROR("failed to allocate tn (%d bytes).\n", sizeof(*tn));
+		JFFS2_ERROR("failed to allocate tn (%zd bytes).\n", sizeof(*tn));
 		return -ENOMEM;
 	}
 
@@ -434,7 +434,7 @@ static int read_more(struct jffs2_sb_inf
 	}
 
 	if (retlen < len) {
-		JFFS2_ERROR("short read at %#08x: %d instead of %d.\n",
+		JFFS2_ERROR("short read at %#08x: %zu instead of %d.\n",
 				offs, retlen, len);
 		return -EIO;
 	}
@@ -542,7 +542,8 @@ static int jffs2_get_inode_nodes(struct 
 		}
 
 		if (retlen < len) {
-			JFFS2_ERROR("short read at %#08x: %d instead of %d.\n", ref_offset(ref), retlen, len);
+			JFFS2_ERROR("short read at %#08x: %zd instead of %d.\n",
+					ref_offset(ref), retlen, len);
 			err = -EIO;
 			goto free_out;
 		}

--Boundary-00=_qfeaEOgeNL2PDx3--
