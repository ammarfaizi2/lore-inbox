Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUGDRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUGDRwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUGDRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:52:21 -0400
Received: from holomorphy.com ([207.189.100.168]:57034 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265290AbUGDRwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:52:06 -0400
Date: Sun, 4 Jul 2004 10:52:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Subject: Re: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704175202.GL21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <20040704172750.GJ21066@holomorphy.com> <20040704173805.GK21066@holomorphy.com> <200407041949.01126.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407041949.01126.arnd@arndb.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. Juli 2004 19:38, William Lee Irwin III wrote:
>> How does this look as an implementation of that suggestion, incremental
>> to your compat_sys_open() consolidation patch?

On Sun, Jul 04, 2004 at 07:49:00PM +0200, Arnd Bergmann wrote:
> At first sight, it looks like (filp->f_flags & O_LARGEFILE) will always
> be true after calling filp_open, but I don't have time to look closer
> today.

Quite right.


Index: mm5-2.6.7/fs/compat.c
===================================================================
--- mm5-2.6.7.orig/fs/compat.c	2004-07-04 10:29:04.691152200 -0700
+++ mm5-2.6.7/fs/compat.c	2004-07-04 10:51:05.329384672 -0700
@@ -160,6 +160,12 @@
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			if (!(flags & O_LARGEFILE) &&
+				i_size_read(f->f_dentry->d_inode) > MAX_NON_LFS) {
+				error = -EFBIG;
+				filp_close(f, current->files);
+				goto out_error;
+			}
 			fd_install(fd, f);
 		}
 out:
