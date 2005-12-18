Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbVLRXLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbVLRXLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbVLRXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:11:04 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49077 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965298AbVLRXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:11:03 -0500
From: Neil Brown <neilb@suse.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Mon, 19 Dec 2005 10:10:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17317.60539.675948.276446@cse.unsw.edu.au>
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: message from Horst von Brand on Friday December 16
References: <vonbrand@inf.utfsm.cl>
	<200512161903.jBGJ3EnR003647@quelen.inf.utfsm.cl>
	<200512170017.jBH0HjSS004744@quelen.inf.utfsm.cl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 16, vonbrand@inf.utfsm.cl wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> [Forgot the attachment]

Thanks...
Based on that, I tried the following patch, and it didn't change the
amount of space that is reserved on the stack.
  gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)

Further, earlier version of gcc miscompile this construct.
They effectively treat that in-line structure as a 'static', and
seeing notify_change changes .ia_valid, the next time it is called
contents of the structure will be wrong.

NeilBrown


### Diffstat output
 ./fs/nfsd/vfs.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2005-12-19 09:44:20.000000000 +1100
+++ ./fs/nfsd/vfs.c	2005-12-19 09:56:46.000000000 +1100
@@ -923,11 +923,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 
 	/* clear setuid/setgid flag after write */
 	if (err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID))) {
-		struct iattr	ia;
-		ia.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
-
 		down(&inode->i_sem);
-		notify_change(dentry, &ia);
+		notify_change(dentry, &((struct iattr)
+		               {.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID}));
 		up(&inode->i_sem);
 	}
 
