Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbUDGSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbUDGSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:09:29 -0400
Received: from holomorphy.com ([207.189.100.168]:34438 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264079AbUDGSJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:09:20 -0400
Date: Wed, 7 Apr 2004 11:09:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc2
Message-ID: <20040407180919.GB30117@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040406221744.2bd7c7e4.akpm@osdl.org> <20040407180430.GA30117@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407180430.GA30117@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:04:30AM -0700, William Lee Irwin III wrote:
> +	if (sizeof(unsigned long) == 8)

Ugh.


Index: wli-2.6.5-3/fs/open.c
===================================================================
--- wli-2.6.5-3.orig/fs/open.c	2004-04-07 07:18:19.000000000 -0700
+++ wli-2.6.5-3/fs/open.c	2004-04-07 11:06:49.000000000 -0700
@@ -44,6 +44,13 @@
 
 EXPORT_SYMBOL(vfs_statfs);
 
+static inline int vfs_statfs_overflow(unsigned long x)
+{
+	if (sizeof(unsigned long) == 4)
+		return 0;
+	return x != ~0UL && x > ((1UL << (BITS_PER_LONG/2)) - 1);
+}
+
 static int vfs_statfs_native(struct super_block *sb, struct statfs *buf)
 {
 	struct kstatfs st;
@@ -64,11 +71,9 @@
 			 * f_files and f_ffree may be -1; it's okay to stuff
 			 * that into 32 bits
 			 */
-			if (st.f_files != 0xffffffffffffffffULL &&
-			    (st.f_files & 0xffffffff00000000ULL))
+			if (vfs_statfs_overflow(st.f_files))
 				return -EOVERFLOW;
-			if (st.f_ffree != 0xffffffffffffffffULL &&
-			    (st.f_ffree & 0xffffffff00000000ULL))
+			if (vfs_statfs_overflow(st.f_ffree))
 				return -EOVERFLOW;
 		}
 
