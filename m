Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUGDGl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUGDGl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGDGl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:41:26 -0400
Received: from holomorphy.com ([207.189.100.168]:4808 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265399AbUGDGlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:41:24 -0400
Date: Sat, 3 Jul 2004 23:41:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, hugh@veritas.com
Subject: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704064122.GY21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Internal kernel open() of files barfs in important contexts, for
instance, using strict non-overcommit with enough swap for large
commitments. This is carried out through the entrypoint filp_open(),
not sys_open(). sys_open() in turn calls filp_open(). So merely
moving the forcing of the flag on 64-bit resolves this situation there,
though not for 32-bit, whose solution is to appear in the sequel.


-- wli

Index: mm5-2.6.7/fs/open.c
===================================================================
--- mm5-2.6.7.orig/fs/open.c	2004-06-15 22:18:56.000000000 -0700
+++ mm5-2.6.7/fs/open.c	2004-07-03 22:58:51.081134896 -0700
@@ -755,6 +755,8 @@
 	int namei_flags, error;
 	struct nameidata nd;
 
+	if (BITS_PER_LONG > 32)
+		flags |= O_LARGEFILE;
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
 		namei_flags++;
@@ -943,9 +945,6 @@
 	char * tmp;
 	int fd, error;
 
-#if BITS_PER_LONG != 32
-	flags |= O_LARGEFILE;
-#endif
 	tmp = getname(filename);
 	fd = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
