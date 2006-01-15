Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWAOReU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWAOReU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWAOReU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:34:20 -0500
Received: from mx3.mail.ru ([194.67.23.149]:20304 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932100AbWAOReU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:34:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6: xfs is rebuilt on every .config change
Date: Sun, 15 Jan 2006 20:34:11 +0300
User-Agent: KMail/1.9.1
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <200601151226.49461.arvidjaar@mail.ru> <20060115095410.GA8195@mars.ravnborg.org>
In-Reply-To: <20060115095410.GA8195@mars.ravnborg.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601152034.16467.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 12:54, Sam Ravnborg wrote:
> On Sun, Jan 15, 2006 at 12:26:46PM +0300, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > This happened for a long time, actually in late 2.5.x (that I have
> > started with). Every time I make some changes to config - or simply do
> > make oldconfig - - xfs is rebuilt. This happens when there are *no*
> > changes related to xfs alltogether. E.g. I now applied 2.6.15.1 patch and
> > xfs got rebuilt again.
>
> The xfs source files do:
> #include <version.h>
> To gain access to actual kernel release.
>
> So each time you do a change to the tree that causes version.h to be
> updated the xfs source files will be recompiled.
>

Ah, thanks. Now the obvious question is, why in-tree code should bother with 
version checking?

The patch removes version check and dependency on linux/version.h from 
xfs_dmapi.h. 

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

- --- linux-2.6.15/fs/xfs/xfs_dmapi.h.version_h	2006-01-03 06:21:10.000000000 
+0300
+++ linux-2.6.15/fs/xfs/xfs_dmapi.h	2006-01-15 20:20:12.000000000 +0300
@@ -18,7 +18,6 @@
 #ifndef __XFS_DMAPI_H__
 #define __XFS_DMAPI_H__
 
- -#include <linux/version.h>
 /*	Values used to define the on-disk version of dm_attrname_t. All
  *	on-disk attribute names start with the 8-byte string "SGI_DMI_".
  *
@@ -159,24 +158,9 @@ typedef enum {
 /*
  *	Based on IO_ISDIRECT, decide which i_ flag is set.
  */
- -#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
 #define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
 			      DM_FLAGS_ISEM : 0)
 #define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
- -#endif
- -
- -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)) && \
- -    (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,22))
- -#define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
- -			      DM_FLAGS_IALLOCSEM_RD : DM_FLAGS_ISEM)
- -#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
- -#endif
- -
- -#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,21)
- -#define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
- -			      0 : DM_FLAGS_ISEM)
- -#define DM_SEM_FLAG_WR	(DM_FLAGS_ISEM)
- -#endif
 
 
 /*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyoeYR6LMutpd94wRAskpAKCu/gV8aNZsX0+fqc9/5fXfQBujsACgjaKf
JvgEK78RgVdD5N+kPDUtoFA=
=BPLI
-----END PGP SIGNATURE-----
