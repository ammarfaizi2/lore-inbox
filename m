Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUFCOKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUFCOKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUFCOKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:10:04 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:31683 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263881AbUFCOJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:09:46 -0400
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       mason@suse.com, jeffm@suse.com
In-Reply-To: <20040603083622.GA9918@school.ioffe.ru>
References: <20040602174810.GA31263@school.ioffe.ru>
	 <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil>
	 <20040603083622.GA9918@school.ioffe.ru>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1086271751.17657.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 03 Jun 2004 10:09:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 04:36, Dmitry Baryshkov wrote:
> Here is a part related to mount (sorry, it's copied by hand from
> monitor. can't use serial console here.):
> 
> inode2sd+0xcc/0x120
> pathrelse+0x20/0x30
> reiserfs_update_sd_size+0x13a/0x1d0
> rwsem_down_read_failed+0x8d/0x170
> .text.lock.xattr+0xb5/0x22f
> inode_doinit_with_dentry+0x2ea/0x560
> d_instantiate+0x47/0x60
> reiserfs_mkdir+0x29b/0x2d0
> open_xa_dir+0xbe/0x160
> get_xa_file_dentry+0x24/0x100
> open_xa_file+0x5/0x40
> reiserfs_xattr_set+0x8f/0x360
> do_journal_end+0x75e/0xa70
> vsprintf+0x12/0x20
> sprintf+0x11/0x20
> context_struct_to_string+0x108/0x170
> reiserfs_setxattr+0xf4/0x190
> post_create+0xfb/0x220
> vfs_create+0xca/0x130
> open_namei+0x3d0/0x420
> filp_open+0x2d/0x60
> sys_open+0x4d/0xa0
> syscall_call+0x7/0xb

Ok, so vfs_create calls security_inode_post_create hook, and SELinux
attempts to set the xattr on the newly created inode.  But reiserfs
xattr implementation attempts to create a directory to store the xattr,
and the attempt to instantiate the dentry for the directory inode causes
the security_d_instantiate hook to be called, so that SELinux then
attempts to get the xattr value for that directory inode to initialize
the directory inode's security field before it becomes accessible via
the dcache.  More generally, reiserfs_mkdir code is calling
d_instantiate while holding reiserfs_write_lock, but d_instantiate can
_block_ under SELinux due to need to fetch xattr for inode.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=106712276514199&w=2 for
related discussion.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

