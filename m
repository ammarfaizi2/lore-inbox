Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUGDGoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUGDGoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGDGoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:44:44 -0400
Received: from holomorphy.com ([207.189.100.168]:6088 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265410AbUGDGom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:44:42 -0400
Date: Sat, 3 Jul 2004 23:44:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Subject: force O_LARGEFILE in sys_swapon() and sys_swapoff()
Message-ID: <20040704064440.GZ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704064122.GY21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 11:41:22PM -0700, William Lee Irwin III wrote:
> Internal kernel open() of files barfs in important contexts, for
> instance, using strict non-overcommit with enough swap for large
> commitments. This is carried out through the entrypoint filp_open(),
> not sys_open(). sys_open() in turn calls filp_open(). So merely
> moving the forcing of the flag on 64-bit resolves this situation there,
> though not for 32-bit, whose solution is to appear in the sequel.

For 32-bit, one quickly discovers that swapon() is not given an fd
already opened with O_LARGEFILE to act upon and the forcing of
O_LARGEFILE for 64-bit is irrelevant, as the system call's argument is
a path. So this patch manually forces it for swapon() and swapoff().


-- wli

Index: mm5-2.6.7/mm/swapfile.c
===================================================================
--- mm5-2.6.7.orig/mm/swapfile.c	2004-07-02 20:43:30.000000000 -0700
+++ mm5-2.6.7/mm/swapfile.c	2004-07-03 23:12:35.000000000 -0700
@@ -1085,7 +1085,7 @@
 	if (IS_ERR(pathname))
 		goto out;
 
-	victim = filp_open(pathname, O_RDWR, 0);
+	victim = filp_open(pathname, O_RDWR|O_LARGEFILE, 0);
 	putname(pathname);
 	err = PTR_ERR(victim);
 	if (IS_ERR(victim))
@@ -1354,7 +1354,7 @@
 		name = NULL;
 		goto bad_swap_2;
 	}
-	swap_file = filp_open(name, O_RDWR, 0);
+	swap_file = filp_open(name, O_RDWR|O_LARGEFILE, 0);
 	error = PTR_ERR(swap_file);
 	if (IS_ERR(swap_file)) {
 		swap_file = NULL;
