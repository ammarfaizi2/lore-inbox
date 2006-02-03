Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWBCNPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWBCNPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWBCNPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:15:44 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:13987 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750763AbWBCNPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:15:43 -0500
Subject: Re: Size-128 slab leak
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Chris Wright <chrisw@sous-sol.org>, Jeff Mahoney <jeffm@suse.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, jmorris@namei.org
In-Reply-To: <20060203040018.GA3757@double.lan>
References: <20060131024928.GA11395@double.lan>
	 <20060201231001.0ca96bf0.akpm@osdl.org>  <20060203040018.GA3757@double.lan>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 03 Feb 2006 08:21:12 -0500
Message-Id: <1138972872.18268.327.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 23:00 -0500, Kevin O'Connor wrote:
> Thanks Andrew.
> 
> I've applied the patch and found the leak.  It's in kzalloc.  :-)
> 
> With kzalloc inlined, however, it appears that selinux is the likely
> culprit.  I would not have expected that.
> 
> After running updatedb I got 23530 occurrences of:
> 
> kernel: obj ffff81003f04f000/12: ffffffff801ed7b7 <selinux_inode_alloc_security+0x37/0x100>
> 
> I'm not sure how to debug selinux issues, but at least I can disable
> it.

Hmm...that allocation call occurs upon alloc_inode() via
security_inode_alloc, and the associated free call occurs upon
destroy_inode() via security_inode_free.  However, when Jeff Mahoney
introduced the support for "private inodes" (S_PRIVATE flag) to support
reiserfs xattrs-as-files, he added the IS_PRIVATE guards to both
security_inode_alloc and security_inode_free.  I think that this ends up
causing SELinux to allocate a security structure for every reiserfs
inode including private inodes since they are not marked until later by
reiserfs, while preventing SELinux from ever freeing the security
structure for the private inodes.  Note that
selinux_inode_free_security() should be safe even for the private
inodes, as it doesn't assume any other initialization beyond the
allocation-time initialization.  Patch below.  

BTW, Jeff - I assume you know about the unrelated breakage in
SELinux/reiserfs support that was introduced by the changes for atomic
security labeling of inodes in 2.6.14.  If you care, you might want to
use the same workaround upstreamed for xfs for 2.6.16.  But I understand
that SELinux is not a priority in SuSE presently.

BTW, Chris - are you still serving as LSM maintainer?  MAINTAINERS still
lists your osdl address.

---

Remove private inode tests from security_inode_alloc and security_inode_free,
as we otherwise end up leaking inode security structures for private inodes.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 include/linux/security.h |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6/include/linux/security.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/include/linux/security.h,v
retrieving revision 1.50
diff -u -p -r1.50 security.h
--- linux-2.6/include/linux/security.h	3 Jan 2006 16:36:48 -0000	1.50
+++ linux-2.6/include/linux/security.h	3 Feb 2006 12:50:57 -0000
@@ -1437,15 +1437,11 @@ static inline void security_sb_post_pivo
 
 static inline int security_inode_alloc (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return 0;
 	return security_ops->inode_alloc_security (inode);
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
-	if (unlikely (IS_PRIVATE (inode)))
-		return;
 	security_ops->inode_free_security (inode);
 }
 


-- 
Stephen Smalley
National Security Agency

