Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVLWWtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVLWWtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVLWWto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:27856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161114AbVLWWtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:43 -0500
Date: Fri, 23 Dec 2005 14:48:56 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       mason@suse.de, agruen@suse.de, mawa@uni-freiburg.de,
       Trond.Myklebust@netapp.com
Subject: [patch 19/19] setting ACLs on readonly mounted NFS filesystems (CVE-2005-3623)
Message-ID: <20051223224856.GS19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="setting-acls-on-readonly-mounted-nfs-filesystems.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andreas Gruenbacher <agruen@suse.de>

We must check for MAY_SATTR before setting acls, which includes
checking for read-only exports: the lower-level setxattr operation
that eventually sets the acl cannot check export-level restrictions.

Bug reported by Martin Walter <mawa@uni-freiburg.de>.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/nfsd/nfs2acl.c |    2 +-
 fs/nfsd/nfs3acl.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.4.orig/fs/nfsd/nfs2acl.c
+++ linux-2.6.14.4/fs/nfsd/nfs2acl.c
@@ -107,7 +107,7 @@ static int nfsacld_proc_setacl(struct sv
 	dprintk("nfsd: SETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_SATTR);
 
 	if (!nfserr) {
 		nfserr = nfserrno( nfsd_set_posix_acl(
--- linux-2.6.14.4.orig/fs/nfsd/nfs3acl.c
+++ linux-2.6.14.4/fs/nfsd/nfs3acl.c
@@ -101,7 +101,7 @@ static int nfsd3_proc_setacl(struct svc_
 	int nfserr = 0;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_SATTR);
 
 	if (!nfserr) {
 		nfserr = nfserrno( nfsd_set_posix_acl(

--
