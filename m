Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUCaWQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCaWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:16:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262399AbUCaWQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:16:10 -0500
Subject: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>, Ulrich Drepper <drepper@redhat.com>
Content-Type: multipart/mixed; boundary="=-6twgfjbm5DUd3lrSreG0"
Organization: 
Message-Id: <1080771361.1991.73.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Mar 2004 23:16:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6twgfjbm5DUd3lrSreG0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've been looking at a discrepancy between msync() behaviour on 2.4.9
and newer 2.4 kernels, and it looks like things changed again in
2.5.68.  From the ChangeLog:

ChangeSet 1.971.76.156 2003/04/09 11:31:36 akpm@digeo.com
  [PATCH] Make msync(MS_ASYNC) no longer start the I/O
  
  MS_ASYNC will currently wait on previously-submitted I/O, then start new I/O
  and not wait on it.  This can cause undesirable blocking if msync is called
  rapidly against the same memory.
  
  So instead, change msync(MS_ASYNC) to not start any IO at all.  Just flush
  the pte dirty bits into the pageframe and leave it at that.
  
  The IO _will_ happen within a kupdate period.  And the application can use
  fsync() or fadvise(FADV_DONTNEED) if it actually wants to schedule the IO
  immediately.

Unfortunately, this seems to contradict SingleUnix requirements, which
state:

        When MS_ASYNC is specified, msync() shall return immediately
        once all the write operations are initiated or queued for
        servicing
        
although I can't find an unambiguous definition of "queued for service"
in the online standard.  I'm reading it as requiring that the I/O has
reached the block device layer, not simply that it has been marked dirty
for some future writeback pass to catch; Uli agrees with that
interpretation.

The comment that was added with this change in 2.5.68 states:

 * MS_ASYNC does not start I/O (it used to, up to 2.5.67).  Instead, it just
 * marks the relevant pages dirty.  The application may now run fsync() to
 * write out the dirty pages and wait on the writeout and check the result.
 * Or the application may run fadvise(FADV_DONTNEED) against the fd to start
 * async writeout immediately.
 * So my _not_ starting I/O in MS_ASYNC we provide complete flexibility to
 * applications.

but that's actually misleading --- in every kernel I've looked at as far
back as 2.4.9, the "new" behaviour of simply queueing the pages for
kupdated writeback is already available by specifying flags==0 for
msync(), so there's no additional flexibility added by making MS_ASYNC
do the same thing.  And FADV_DONTNEED doesn't make any guarantees that
anything gets queued for writeback: it only does a filemap writeback if
there's no congestion on the backing device.

So we're actually _more_ flexible, as well as more compliant, under the
old behaviour --- flags==0 gives the "defer to kupdated" behaviour,
MS_ASYNC guarantees that IOs have been queued, and MS_SYNC waits for
synchronised completion.

All that's really missing is documentation to define how Linux deals
with flags==0 as an extension to SingleUnix (which requires either
MS_SYNC, MS_ASYNC or MS_INVALIDATE to be set, and which does not define
a behaviour for flags==0.)
  
The 2.5.68 changeset also includes the comment:

  (This has triggered an ext3 bug - the page's buffers get dirtied so fast
  that kjournald keeps writing the buffers over and over for 10-20 seconds
  before deciding to give up for some reason)

Was that ever resolved?  If it's still there, I should have a look at it
if we're restoring the old trigger.

Patch below reverts the behaviour in 2.6.

--Stephen


--=-6twgfjbm5DUd3lrSreG0
Content-Disposition: inline; filename=msync-async-writeout.patch
Content-Type: text/plain; name=msync-async-writeout.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.6-tmp/mm/msync.c.=3DK0000=3D.orig
+++ linux-2.6-tmp/mm/msync.c
@@ -127,13 +127,10 @@ static int filemap_sync(struct vm_area_s
 /*
  * MS_SYNC syncs the entire file - including mappings.
  *
- * MS_ASYNC does not start I/O (it used to, up to 2.5.67).  Instead, it ju=
st
- * marks the relevant pages dirty.  The application may now run fsync() to
- * write out the dirty pages and wait on the writeout and check the result=
.
- * Or the application may run fadvise(FADV_DONTNEED) against the fd to sta=
rt
- * async writeout immediately.
- * So my _not_ starting I/O in MS_ASYNC we provide complete flexibility to
- * applications.
+ * MS_ASYNC once again starts I/O (it did not between 2.5.68 and 2.6.4.)
+ * SingleUnix requires it.  If an application wants to queue dirty pages
+ * for normal asychronous writeback, msync with flags=3D=3D0 should achiev=
e
+ * that on all kernels at least as far back as 2.4.
  */
 static int msync_interval(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, int flags)
@@ -147,20 +144,22 @@ static int msync_interval(struct vm_area
 	if (file && (vma->vm_flags & VM_SHARED)) {
 		ret =3D filemap_sync(vma, start, end-start, flags);
=20
-		if (!ret && (flags & MS_SYNC)) {
+		if (!ret && (flags & (MS_SYNC|MS_ASYNC))) {
 			struct address_space *mapping =3D file->f_mapping;
 			int err;
=20
 			down(&mapping->host->i_sem);
 			ret =3D filemap_fdatawrite(mapping);
-			if (file->f_op && file->f_op->fsync) {
-				err =3D file->f_op->fsync(file,file->f_dentry,1);
-				if (err && !ret)
+			if (flags & MS_SYNC) {
+				if (file->f_op && file->f_op->fsync) {
+					err =3D file->f_op->fsync(file, file->f_dentry, 1);
+					if (err && !ret)
+						ret =3D err;
+				}
+				err =3D filemap_fdatawait(mapping);
+				if (!ret)
 					ret =3D err;
 			}
-			err =3D filemap_fdatawait(mapping);
-			if (!ret)
-				ret =3D err;
 			up(&mapping->host->i_sem);
 		}
 	}

--=-6twgfjbm5DUd3lrSreG0--
