Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTHWRAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbTHWQ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:59:28 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:35077 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263288AbTHWQAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:00:01 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <Pine.LNX.4.44.0308230820020.3590-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308230820020.3590-100000@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-twwyVK3YP0a7nX0FTdaG"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Aug 2003 10:59:48 -0500
Message-Id: <1061654391.1995.74.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-twwyVK3YP0a7nX0FTdaG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-08-23 at 02:22, Hugh Dickins wrote:
> Good idea.  It's VM_MAYSHARE you need to check for.

OK, to get all this to work, there's a corner case in do_mremap() that I
need to be fixed:

When choosing the flags for the new area, it keys off VM_SHARED to
determine whether MAP_SHARED is passed to the mapping.  It has to key of
VM_MAYSHARE to preserve VM_MAYSHARE on the new mapping.

Patch below.

James



--=-twwyVK3YP0a7nX0FTdaG
Content-Disposition: inline; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D mremap.c 1.32 vs edited =3D=3D=3D=3D=3D
--- 1.32/mm/mremap.c	Thu Aug  7 12:29:10 2003
+++ edited/mremap.c	Sat Aug 23 10:54:21 2003
@@ -420,7 +420,7 @@
 	if (flags & MREMAP_MAYMOVE) {
 		if (!(flags & MREMAP_FIXED)) {
 			unsigned long map_flags =3D 0;
-			if (vma->vm_flags & VM_SHARED)
+			if (vma->vm_flags & VM_MAYSHARE)
 				map_flags |=3D MAP_SHARED;
=20
 			new_addr =3D get_unmapped_area(vma->vm_file, 0, new_len,

--=-twwyVK3YP0a7nX0FTdaG--

