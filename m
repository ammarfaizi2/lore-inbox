Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUGDRiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUGDRiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUGDRiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:38:12 -0400
Received: from holomorphy.com ([207.189.100.168]:51658 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265291AbUGDRiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:38:09 -0400
Date: Sun, 4 Jul 2004 10:38:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hugh@veritas.com
Subject: Re: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704173805.GK21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <200407041422.57614.arnd@arndb.de> <20040704161530.GF21066@holomorphy.com> <200407041922.45976.arnd@arndb.de> <20040704172708.GI21066@holomorphy.com> <20040704172750.GJ21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704172750.GJ21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 07:22:42PM +0200, Arnd Bergmann wrote:
>>> I'm not sure if you understood the intention of compat_sys_open
>>> right. Old 32 bit applications assume they are not using O_LARGEFILE,
>>> so you can't switch it on unconditionally in filp_open() for those
>>> cases. With your patch applied, sys_open and compat_sys_open would
>>> be identical again, which reverses the point of my patch.
>>> What is need is a way to turn on O_LARGEFILE on 64 bit archs for
>>> every use of filp_open _except_ from compat_sys_open.

On Sun, Jul 04, 2004 at 10:27:08AM -0700, William Lee Irwin III wrote:
>> Oh, that's easy, just shove the MAX_NON_LFS check into compat_sys_open().

On Sun, Jul 04, 2004 at 10:27:50AM -0700, William Lee Irwin III wrote:
> BTW, for some reason that's what I thought you were doing in your patch.

How does this look as an implementation of that suggestion, incremental
to your compat_sys_open() consolidation patch?


-- wli

Index: mm5-2.6.7/fs/compat.c
===================================================================
--- mm5-2.6.7.orig/fs/compat.c	2004-07-04 10:29:04.691152200 -0700
+++ mm5-2.6.7/fs/compat.c	2004-07-04 10:34:33.015239352 -0700
@@ -160,6 +160,12 @@
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
+			if (!(filp->f_flags & O_LARGEFILE) &&
+				i_size_read(file->f_dentry->d_inode) > MAX_NON_LFS) {
+				error = -EFBIG;
+				filp_close(filp, current->files);
+				goto out_error;
+			}
 			fd_install(fd, f);
 		}
 out:
