Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTHVOku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbTHVOku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:40:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:53253 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263299AbTHVOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:40:40 -0400
Subject: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on
	parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Cc: davem@redhat.com, drepper@redhat.com
Content-Type: multipart/mixed; boundary="=-lmHKO1hPltD8R1GkCOtr"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Aug 2003 09:40:37 -0500
Message-Id: <1061563239.2090.25.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lmHKO1hPltD8R1GkCOtr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This test essentially opens a file (via open(2)), writes something,
opens it via a mmaped file object *read only* (via fopen(...,"rm)) reads
what was writtent, writes some more and reads it via the mmaped file
object.

This last read fails to get the data on parisc.  The problem is that our
CPU cache is virtually indexed, and the page the write is storing the
data to (in the buffer cache) and the page it is mmapped to have the
same physical, but different virtual addresses.  We need the write() to
trigger a cache update via flush_dcache_page to get the virtually
indexed cache in sync.

The reason this doesn't happen is because the mapping is not on the
mmap_shared list that flush_dcache_page() updates.

And the reason it's not on the correct list is because there's a check
in mm/mmap.c:do_mmap_pgoff() that drops the VM_SHARED flag on the
mapping if the file wasn't opened for writing (about line 541).

Semantically, it seems that whether the mmaping sees a write or not on a
different descriptor shouldn't depend on whether the underlying file was
opened read only or read write, so I think the glibc test is correct,
and we should keep the VM_SHARED flag even if the underlying file was
opened read only.

The patch is attached (and makes the test pass on parisc).

Comments?

James


--=-lmHKO1hPltD8R1GkCOtr
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D mm/mmap.c 1.89 vs edited =3D=3D=3D=3D=3D
--- 1.89/mm/mmap.c	Thu Jul 10 21:46:52 2003
+++ edited/mm/mmap.c	Fri Aug 22 09:36:32 2003
@@ -539,7 +539,7 @@
=20
 			vm_flags |=3D VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
-				vm_flags &=3D ~(VM_MAYWRITE | VM_SHARED);
+				vm_flags &=3D ~VM_MAYWRITE;
=20
 			/* fall through */
 		case MAP_PRIVATE:

--=-lmHKO1hPltD8R1GkCOtr--

