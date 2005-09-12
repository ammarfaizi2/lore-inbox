Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVILOpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVILOpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVILOpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:45:47 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:23789 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751158AbVILOpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:45:46 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.13-mm3 BUG in ntfs or slab
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200509121417.j8CEH7u5006138@wscnet.wsc.cz>
References: <200509121417.j8CEH7u5006138@wscnet.wsc.cz>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 12 Sep 2005 15:45:28 +0100
Message-Id: <1126536328.19902.9.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 16:17 +0200, Jiri Slaby wrote:
> This BUG causes freeze of applications, such as beep-media-player (e.g.
> uninterruptible sleep in futex with no wake), ls (un. sleep, i don't know
> where), bash, when listing ntfs dirs.

Ok, it is official.  I can't read.  All my fault.  Brown paperbag time.

This should fix it:

diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -45,7 +45,7 @@ static inline void *__ntfs_malloc(unsign
 	if (likely(size <= PAGE_SIZE)) {
 		BUG_ON(!size);
 		/* kmalloc() has per-CPU caches so is faster for now. */
-		return kmalloc(PAGE_SIZE, gfp_mask);
+		return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
 		/* return (void *)__get_free_page(gfp_mask); */
 	}
 	if (likely(size >> PAGE_SHIFT < num_physpages))

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

