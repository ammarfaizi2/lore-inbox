Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWEEBiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWEEBiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 21:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEEBiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 21:38:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16769 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932405AbWEEBiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 21:38:07 -0400
Date: Thu, 4 May 2006 18:40:41 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <greg@kroah.com>,
       Steven French <sfrench@us.ibm.com>,
       Marcel Holtmann <holtmann@redhat.com>, Olaf Kirch <okir@suse.de>,
       Mark Moseley <moseleymark@gmail.com>, shaggy@austin.ibm.com
Subject: [PATCH] smbfs chroot issue (CVE-2006-1864)
Message-ID: <20060505014041.GZ24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Kirch <okir@suse.de>

Mark Moseley reported that a chroot environment on a SMB share can be
left via "cd ..\\".  Similar to CVE-2006-1863 issue with cifs, this fix
is for smbfs.

Steven French <sfrench@us.ibm.com> wrote:

Looks fine to me.  This should catch the slash on lookup or equivalent,
which will be all obvious paths of interest.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 This fix is in -stable, but doesn't appear to be in your tree yet.

 fs/smbfs/dir.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linus-2.6.orig/fs/smbfs/dir.c
+++ linus-2.6/fs/smbfs/dir.c
@@ -434,6 +434,11 @@ smb_lookup(struct inode *dir, struct den
 	if (dentry->d_name.len > SMB_MAXNAMELEN)
 		goto out;
 
+	/* Do not allow lookup of names with backslashes in */
+	error = -EINVAL;
+	if (memchr(dentry->d_name.name, '\\', dentry->d_name.len))
+		goto out;
+
 	lock_kernel();
 	error = smb_proc_getattr(dentry, &finfo);
 #ifdef SMBFS_PARANOIA
