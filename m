Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUHGV6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUHGV6O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHGV6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:58:14 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:4077 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264396AbUHGV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:58:09 -0400
Subject: Re: [BUG] 2.6.8-rc3 jffs2 unable to read filesystems
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20040807141829.D2805@flint.arm.linux.org.uk>
References: <20040807141829.D2805@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1091915887.1438.99.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 07 Aug 2004 22:58:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 14:18 +0100, Russell King wrote:
> This can be seen by tracing through the code from jffs2_alloc_raw_inode()
> and noticing that previous implementations do not initialise this field -
> AFAICS kmem_cache_alloc() does not guarantee that memory returned by
> this function will be initialised.

Doh.

> Therefore, recent 2.6.8-rc kernels must _NOT_ use this field if they
> wish to remain compatible with existing jffs2 filesystems.

The format is compatible in theory -- we just need to work around the
bug in the older code. Can you try this?

Index: fs/jffs2/compr.c
===================================================================
RCS file: /home/cvs/mtd/fs/jffs2/compr.c,v
retrieving revision 1.41
retrieving revision 1.42
diff -u -p -r1.41 -r1.42
--- fs/jffs2/compr.c	24 Jun 2004 09:51:38 -0000	1.41
+++ fs/jffs2/compr.c	7 Aug 2004 21:56:08 -0000	1.42
@@ -9,7 +9,7 @@
  *
  * For licensing information, see the file 'LICENCE' in this directory.
  *
- * $Id: compr.c,v 1.41 2004/06/24 09:51:38 havasi Exp $
+ * $Id: compr.c,v 1.42 2004/08/07 21:56:08 dwmw2 Exp $
  *
  */
 
@@ -180,6 +180,11 @@ int jffs2_decompress(struct jffs2_sb_inf
         struct jffs2_compressor *this;
         int ret;
 
+	/* Older code had a bug where it would write non-zero 'usercompr'
+	   fields. Deal with it. */
+	if ((comprtype & 0xff) <= JFFS2_COMPR_ZLIB)
+		comprtype &= 0xff;
+
 	switch (comprtype & 0xff) {
 	case JFFS2_COMPR_NONE:
 		/* This should be special-cased elsewhere, but we might as well deal with it */
@@ -208,7 +213,7 @@ int jffs2_decompress(struct jffs2_sb_inf
                                 return ret;
                         }
                 }
-		printk(KERN_WARNING "JFFS2 compression type 0x%02x not avaiable.\n", comprtype);
+		printk(KERN_WARNING "JFFS2 compression type 0x%02x not available.\n", comprtype);
                 spin_unlock(&jffs2_compressor_list_lock);
 		return -EIO;
 	}



-- 
dwmw2


