Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWCBCdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWCBCdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCBCdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:33:52 -0500
Received: from pat.uio.no ([129.240.130.16]:59790 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750957AbWCBCdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:33:51 -0500
Subject: Re: Linux 2.6.15.5 - NFS client broken
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Saitz <Ingo.Saitz@stud.uni-hannover.de>,
       Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060302021758.GA24337@schwan.subspace.exe>
References: <20060302021758.GA24337@schwan.subspace.exe>
Content-Type: multipart/mixed; boundary="=-hOt9Mq8Jagw6zdjd6Ysk"
Date: Wed, 01 Mar 2006 18:33:38 -0800
Message-Id: <1141266818.26382.46.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.867, required 12,
	autolearn=disabled, AWL 2.08, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hOt9Mq8Jagw6zdjd6Ysk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-02 at 03:17 +0100, Ingo Saitz wrote:
> Moin
>=20
> Compiling 2.6.15.5 aborts with the following error:
>=20
>   CC [M]  fs/nfs/direct.o
> fs/nfs/direct.c: In function =E2=80=98nfs_get_user_pages=E2=80=99:
> fs/nfs/direct.c:110: warning: implicit declaration of function =E2=80=98n=
fs_free_user_pages=E2=80=99
> fs/nfs/direct.c: At top level:
> fs/nfs/direct.c:127: warning: conflicting types for =E2=80=98nfs_free_use=
r_pages=E2=80=99
> fs/nfs/direct.c:127: error: static declaration of =E2=80=98nfs_free_user_=
pages=E2=80=99 follows non-static declaration
> fs/nfs/direct.c:110: error: previous implicit declaration of =E2=80=98nfs=
_free_user_pages=E2=80=99 was here
> make[3]: *** [fs/nfs/direct.o] Error 1
>=20
> Attached .config

Here is the full patch I sent to Chris the other day. That first hunk
must have gotten lost somewhere...

Cheers,
 Trond

--=-hOt9Mq8Jagw6zdjd6Ysk
Content-Disposition: inline; filename=linux-2.6.16-01-fix_oopsable_odirect.dif
Content-Type: text/plain; name=linux-2.6.16-01-fix_oopsable_odirect.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

Author: Trond Myklebust <Trond.Myklebust@netapp.com>
NFS: Fix a potential panic in O_DIRECT

Based on an original patch by Mike O'Connor and Greg Banks of SGI.

Mike states:

A normal user can panic an NFS client and cause a local DoS with
'judicious'(?) use of O_DIRECT. Any O_DIRECT write to an NFS file where the
user buffer starts with a valid mapped page and contains an unmapped page,
will crash in this way.  I haven't followed the code, but O_DIRECT reads
with similar user buffers will probably also crash albeit in different
ways.

Details:  when nfs_get_user_pages() calls get_user_pages(), it detects
and correctly handles get_user_pages() returning an error, which happens
if the first page covered by the user buffer's address range is unmapped.
However, if the first page is mapped but some subsequent page isn't,
get_user_pages() will return a positive number which is less than the
number of pages requested (this behaviour is sort of analagous to a
short write() call and appears to be intentional).  nfs_get_user_pages()
doesn't detect this and hands off the array of pages (whose last few
elements are random rubbish from the newly allocated array memory) to
it's caller, whence they go to nfs_direct_write_seg(), which then totally
ignores the nr_pages it's given, and calculates its own idea of how many
pages are in the array from the user buffer length.  Needless to say,
when it comes to transmit those uninitialised page* pointers, we see
a crash in the network stack.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/direct.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 04ab2fc..4e9b3a1 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -57,6 +57,7 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
+static void nfs_free_user_pages(struct page **pages, int npages, int do_dirty);
 static kmem_cache_t *nfs_direct_cachep;
 
 /*
@@ -107,6 +108,15 @@ nfs_get_user_pages(int rw, unsigned long
 					page_count, (rw == READ), 0,
 					*pages, NULL);
 		up_read(&current->mm->mmap_sem);
+		/*
+		 * If we got fewer pages than expected from get_user_pages(),
+		 * the user buffer runs off the end of a mapping; return EFAULT.
+		 */
+		if (result >= 0 && result < page_count) {
+			nfs_free_user_pages(*pages, result, 0);
+			*pages = NULL;
+			result = -EFAULT;
+		}
 	}
 	return result;
 }

--=-hOt9Mq8Jagw6zdjd6Ysk--

