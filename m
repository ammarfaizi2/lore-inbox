Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbULBNZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbULBNZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULBNZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:25:05 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:44466 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261618AbULBNYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:24:31 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
In-Reply-To: <20041201233203.GA22773@locomotive.unixthugs.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>
	 <20041130112903.C2357@build.pdx.osdl.net>
	 <20041130194328.GA28126@infradead.org>
	 <20041201233203.GA22773@locomotive.unixthugs.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 08:15:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 18:32, Jeffrey Mahoney wrote:
> I took some more time to find a more optimal solution. Since ReiserFS is
> currently the only filesystem that cares about this, it's far easier to keep
> the whole mess internal to ReiserFS. The issue isn't about the treating of
> "private" files in reiserfs, but rather just to avoid the looping of xattr
> calls that selinux would create.

No.  It is also about avoiding applying permission checks to these
"private" inodes when reiserfs performs operations on them, e.g. when
__get_xa_root() does a lookup_one_len(), there is ultimately a call to
permission(inode, MAY_EXEC, nd), which triggers a security hook call,
and SELinux will view this as an attempt by the current process to
access the private directory.  Simply disabling getxattr/setxattr for
the private inodes won't change this, and you can't assume that most
processes have permission to access the default file context (in fact,
in a strict policy, that won't be the case).

Chris' suggestion of exporting this private flag via i_flags and having
the VFS and/or security framework skip the security hook calls for such
inodes is more reasonable, and should yield the same behavior as that
current patchset (just without the extra security hook and the
filesystem and SELinux-specific private flags).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

