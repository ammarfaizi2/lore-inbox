Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWEIU1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWEIU1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWEIU1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:27:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:59521 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750868AbWEIU1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:27:06 -0400
Date: Tue, 9 May 2006 13:29:23 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Olaf Kirch <okir@suse.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Steven French <sfrench@us.ibm.com>, shaggy@austin.ibm.com,
       Mark Moseley <moseleymark@gmail.com>,
       Marcel Holtmann <holtmann@redhat.com>
Subject: [PATCH resend] smbfs chroot issue (CVE-2006-1864)
Message-ID: <20060509202923.GS24291@moss.sous-sol.org>
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

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
