Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUEMGW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUEMGW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUEMGWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:22:25 -0400
Received: from ozlabs.org ([203.10.76.45]:27115 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263810AbUEMGUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:20:37 -0400
Date: Thu, 13 May 2004 16:20:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513062014.GJ27403@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Muli Ben-Yehuda <mulix@mulix.org>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20040513060549.GA12695@mulix.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 09:05:50AM +0300, Muli Ben-Yehuda wrote:
> On Thu, May 13, 2004 at 03:55:20PM +1000, David Gibson wrote:
>=20
> > +++ working-2.6/mm/mmap.c	2004-04-27 13:40:01.062285976 +1000
> > @@ -21,6 +21,7 @@
> >  #include <linux/profile.h>
> >  #include <linux/module.h>
> >  #include <linux/mount.h>
> > +#include <linux/err.h>
> > =20
> >  #include <asm/uaccess.h>
> >  #include <asm/pgalloc.h>
> > @@ -62,6 +63,9 @@
> >  EXPORT_SYMBOL(sysctl_max_map_count);
> >  EXPORT_SYMBOL(vm_committed_space);
> > =20
> > +int mmap_use_hugepages =3D 0;
> > +int mmap_hugepages_map_sz =3D 256;
>=20
> These two global variables do not appear to be used anywhere in this
> patch?=20

Bother, they leaked in there from the other patch I had on top of
this.  Revised version below.

> > +static inline unsigned long __do_mmap_pgoff(struct file * file, unsign=
ed long addr,
>=20
> __do_mmap_pgoff seems rather long to be inline?=20

Well, it's only called in one place - it's really the one function,
just split up to let us put the wrapper creating the hugetlb file in
the right place without excessive indentation.  I guess it doesn't
really matter, with -funit-at-a-time it will end up the same anyway.

Add a new MAP_HUGETLB mmap() flag to easily request that a block of
anonymous memory come from hugepages.

Index: working-2.6/include/asm-i386/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-i386/mman.h	2003-10-03 11:24:48.000000000 =
+1000
+++ working-2.6/include/asm-i386/mman.h	2004-05-13 14:51:18.698011208 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed by hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ppc64/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-ppc64/mman.h	2003-10-01 11:47:33.000000000=
 +1000
+++ working-2.6/include/asm-ppc64/mman.h	2004-05-13 14:51:18.705010144 +1000
@@ -26,6 +26,7 @@
 #define MAP_LOCKED	0x80
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
=20
Index: working-2.6/include/linux/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/linux/mman.h	2003-10-07 10:31:58.000000000 +10=
00
+++ working-2.6/include/linux/mman.h	2004-05-13 14:51:18.712009080 +1000
@@ -58,6 +58,9 @@
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
+#ifdef CONFIG_HUGETLB_PAGE
+               _calc_vm_trans(flags, MAP_HUGETLB,    VM_HUGETLB   ) |
+#endif
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
=20
Index: working-2.6/include/asm-sh/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-sh/mman.h	2003-10-01 11:47:40.000000000 +1=
000
+++ working-2.6/include/asm-sh/mman.h	2004-05-13 14:51:18.718008168 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ia64/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-ia64/mman.h	2004-01-28 10:55:18.000000000 =
+1100
+++ working-2.6/include/asm-ia64/mman.h	2004-05-13 14:51:18.721007712 +1000
@@ -24,6 +24,7 @@
=20
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
 #define MAP_GROWSUP	0x00200		/* register stack-like segment */
+#define MAP_HUGETLB	0x00400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x00800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x01000		/* mark it as an executable */
 #define MAP_LOCKED	0x02000		/* pages are locked */
Index: working-2.6/include/asm-sparc64/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-sparc64/mman.h	2003-10-01 11:47:45.0000000=
00 +1000
+++ working-2.6/include/asm-sparc64/mman.h	2004-05-13 14:51:18.724007256 +1=
000
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... =
*/
=20
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
=20
Index: working-2.6/include/asm-x86_64/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-x86_64/mman.h	2003-10-01 11:47:50.00000000=
0 +1000
+++ working-2.6/include/asm-x86_64/mman.h	2004-05-13 14:51:18.726006952 +10=
00
@@ -17,6 +17,7 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ppc/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-ppc/mman.h	2003-10-01 11:47:28.000000000 +=
1000
+++ working-2.6/include/asm-ppc/mman.h	2004-05-13 14:51:18.733005888 +1000
@@ -19,6 +19,7 @@
 #define MAP_LOCKED	0x80
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
Index: working-2.6/include/asm-alpha/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-alpha/mman.h	2003-10-01 11:46:52.000000000=
 +1000
+++ working-2.6/include/asm-alpha/mman.h	2004-05-13 14:51:18.735005584 +1000
@@ -28,6 +28,7 @@
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_HUGETLB	0x80000		/* Backed with hugetlb pages */
=20
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
Index: working-2.6/include/asm-arm/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-arm/mman.h	2003-10-01 11:46:53.000000000 +=
1000
+++ working-2.6/include/asm-arm/mman.h	2004-05-13 14:51:18.741004672 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-arm26/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-arm26/mman.h	2003-10-01 11:47:01.000000000=
 +1000
+++ working-2.6/include/asm-arm26/mman.h	2004-05-13 14:51:18.744004216 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-cris/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-cris/mman.h	2003-10-01 11:47:02.000000000 =
+1000
+++ working-2.6/include/asm-cris/mman.h	2004-05-13 14:51:18.751003152 +1000
@@ -18,6 +18,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-h8300/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-h8300/mman.h	2003-10-01 11:47:05.000000000=
 +1000
+++ working-2.6/include/asm-h8300/mman.h	2004-05-13 14:51:18.764001176 +1000
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-m68k/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-m68k/mman.h	2003-10-01 11:47:14.000000000 =
+1000
+++ working-2.6/include/asm-m68k/mman.h	2004-05-13 14:51:18.771000112 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-mips/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-mips/mman.h	2003-10-01 11:47:19.000000000 =
+1000
+++ working-2.6/include/asm-mips/mman.h	2004-05-13 14:51:18.779998744 +1000
@@ -38,6 +38,7 @@
 #define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
=20
 /* These are linux-specific */
+#define MAP_HUGETLB	0x0200		/* Backed with hugetlb pages */
 #define MAP_NORESERVE	0x0400		/* don't check for reservations */
 #define MAP_ANONYMOUS	0x0800		/* don't use a file */
 #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
Index: working-2.6/include/asm-parisc/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-parisc/mman.h	2003-10-01 11:47:25.00000000=
0 +1000
+++ working-2.6/include/asm-parisc/mman.h	2004-05-13 14:51:18.785997832 +10=
00
@@ -15,6 +15,7 @@
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
=20
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-s390/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-s390/mman.h	2003-10-01 11:47:38.000000000 =
+1000
+++ working-2.6/include/asm-s390/mman.h	2004-05-13 14:51:18.791996920 +1000
@@ -24,6 +24,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-sparc/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-sparc/mman.h	2003-10-01 11:47:43.000000000=
 +1000
+++ working-2.6/include/asm-sparc/mman.h	2004-05-13 14:51:18.797996008 +1000
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... =
*/
=20
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
=20
Index: working-2.6/include/asm-v850/mman.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/include/asm-v850/mman.h	2003-10-01 11:47:49.000000000 =
+1000
+++ working-2.6/include/asm-v850/mman.h	2004-05-13 14:51:18.803995096 +1000
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
=20
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/mm/mmap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- working-2.6.orig/mm/mmap.c	2004-04-20 10:50:09.000000000 +1000
+++ working-2.6/mm/mmap.c	2004-05-13 16:13:58.213950408 +1000
@@ -21,6 +21,7 @@
 #include <linux/profile.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/err.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -476,13 +477,9 @@
 	return NULL;
 }
=20
-/*
- * The caller must hold down_write(current->mm->mmap_sem).
- */
-
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff)
+static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned l=
ong addr,
+					    unsigned long len, unsigned long prot,
+					    unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm =3D current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -494,40 +491,19 @@
 	int accountable =3D 1;
 	unsigned long charged =3D 0;
=20
-	if (file) {
-		if (is_file_hugepages(file))
-			accountable =3D 0;
-
-		if (!file->f_op || !file->f_op->mmap)
-			return -ENODEV;
-
-		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
-	}
-
-	if (!len)
-		return addr;
-
-	/* Careful about overflows.. */
-	len =3D PAGE_ALIGN(len);
-	if (!len || len > TASK_SIZE)
-		return -EINVAL;
-
-	/* offset overflow? */
-	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
-		return -EINVAL;
-
-	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
-		return -ENOMEM;
-
-	/* Obtain the address to map to. we verify (or select) it and ensure
-	 * that it represents a valid section of the address space.
+	/* Obtain the address to map to. we verify (or select) it and
+	 * ensure that it represents a valid section of the address
+	 * space.  VM_HUGETLB will never appear in vm_flags when
+	 * CONFIG_HUGETLB is unset.
 	 */
 	addr =3D get_unmapped_area(file, addr, len, pgoff, flags);
 	if (addr & ~PAGE_MASK)
 		return addr;
=20
+	/* Huge pages aren't accounted for here */
+	if (file && is_file_hugepages(file))
+		accountable =3D 0;
+
 	/* Do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
@@ -724,11 +700,17 @@
 unmap_and_free_vma:
 	if (correct_wcount)
 		atomic_inc(&inode->i_writecount);
-	vma->vm_file =3D NULL;
-	fput(file);
=20
-	/* Undo any partial mapping done by a device driver. */
+	/*
+	 * Undo any partial mapping done by a device driver. =20
+	 * hugetlb wants to know the vma's file etc. so nuke =20
+	 * the file afterward.                               =20
+	 */                                                  =20
 	zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+
+	if (file)
+		fput(vma->vm_file);=20
+
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
@@ -737,6 +719,62 @@
 	return error;
 }
=20
+/*
+ * The caller must hold down_write(current->mm->mmap_sem).
+ */
+
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+			unsigned long len, unsigned long prot,
+			unsigned long flags, unsigned long pgoff)
+{
+	struct file *hugetlb_file =3D NULL;
+	unsigned long result;
+
+	if (file) {
+		if ((flags & MAP_HUGETLB) && !is_file_hugepages(file))
+			return -EINVAL;
+
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
+
+	if (!len)
+		return addr;
+
+	/* Careful about overflows.. */
+	len =3D PAGE_ALIGN(len);
+	if (!len || len > TASK_SIZE)
+		return -EINVAL;
+
+	/* offset overflow? */
+	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
+		return -EINVAL;
+
+	/* Too many mappings? */
+	if (current->mm->map_count > sysctl_max_map_count)
+		return -ENOMEM;
+
+	/* Create an implicit hugetlb file if necessary */
+	if (!file && (flags & MAP_HUGETLB)) {
+		file =3D hugetlb_file =3D hugetlb_zero_setup(len);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+	}
+
+	result =3D __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+
+	/* Drop reference to implicit hugetlb file, it's already been
+	 * "gotten" in __do_mmap_pgoff in case of success
+	 */
+	if (hugetlb_file)
+		fput(hugetlb_file);
+
+	return result;
+}
+
 EXPORT_SYMBOL(do_mmap_pgoff);
=20
 /* Get an address range which is currently unmapped.


--=20
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoxOeaILKxv3ab8YRAkYZAJ4wmGylfmEvQ2NXfyLKs47mgJUv/QCffFtj
yGBTxXc1dS/fY7wQPBBbldY=
=RcrF
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
