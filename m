Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUFCTrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUFCTrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUFCTrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:47:48 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6018 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263923AbUFCTrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:47:15 -0400
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       mason@suse.com, jeffm@suse.com
In-Reply-To: <1086271751.17657.104.camel@moss-spartans.epoch.ncsc.mil>
References: <20040602174810.GA31263@school.ioffe.ru>
	 <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil>
	 <20040603083622.GA9918@school.ioffe.ru>
	 <1086271751.17657.104.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1086291991.19025.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 03 Jun 2004 15:46:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 10:09, Stephen Smalley wrote:
> Ok, so vfs_create calls security_inode_post_create hook, and SELinux
> attempts to set the xattr on the newly created inode.  But reiserfs
> xattr implementation attempts to create a directory to store the xattr,
> and the attempt to instantiate the dentry for the directory inode causes
> the security_d_instantiate hook to be called, so that SELinux then
> attempts to get the xattr value for that directory inode to initialize
> the directory inode's security field before it becomes accessible via
> the dcache.  More generally, reiserfs_mkdir code is calling
> d_instantiate while holding reiserfs_write_lock, but d_instantiate can
> _block_ under SELinux due to need to fetch xattr for inode.  See
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106712276514199&w=2 for
> related discussion.

Actually, that last part may be a red herring, since reiserfs_write_lock
is simply a macro for lock_kernel.  The more immediate concern is
avoiding the inode->i_op->getxattr call from SELinux on the xattr
directory inode.  reiserfs xattr code would need to call a new security
hook to mark the xattr root directory inode in some manner, so that
subsequent security_d_instantiate calls on the per-object subdirectories
could be identified by SELinux, and it could then just set the SID on
the incore inode to a well-defined value and not call
inode->i_op->getxattr for those inodes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

