Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbVLRWYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbVLRWYm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVLRWYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:24:42 -0500
Received: from pat.uio.no ([129.240.130.16]:45208 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965295AbVLRWYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:24:41 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051218200052.GA21665@tau.solarneutrino.net>
References: <20051216235841.GA20539@tau.solarneutrino.net>
	 <1134797577.20929.2.camel@lade.trondhjem.org>
	 <20051217055907.GC20539@tau.solarneutrino.net>
	 <1134801822.7946.4.camel@lade.trondhjem.org>
	 <20051217070222.GD20539@tau.solarneutrino.net>
	 <1134847699.7950.25.camel@lade.trondhjem.org>
	 <20051217194553.GE20539@tau.solarneutrino.net>
	 <1134894836.7931.17.camel@lade.trondhjem.org>
	 <20051218180150.GF20539@tau.solarneutrino.net>
	 <1134934267.7966.37.camel@lade.trondhjem.org>
	 <20051218200052.GA21665@tau.solarneutrino.net>
Content-Type: multipart/mixed; boundary="=-3xOXE17WFX1q7ZScmDDK"
Date: Sun, 18 Dec 2005 17:24:24 -0500
Message-Id: <1134944665.11596.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.037, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3xOXE17WFX1q7ZScmDDK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-12-18 at 15:00 -0500, Ryan Richter wrote:
> On Sun, Dec 18, 2005 at 02:31:07PM -0500, Trond Myklebust wrote:
> > On Sun, 2005-12-18 at 13:01 -0500, Ryan Richter wrote:
> > > Code: 48 39 78 18 75 1c 8b 86 8c 00 00 00 a8 01 74 12 83 c8 02 89 
> > > RIP <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62} RSP <ffff81007dfade70>
> > > CR2: 0000000000000018
> > 
> > Looks like the global lock list is corrupted. Could you cat the contents
> > of /proc/locks?
> 
> $ cat /proc/locks
> 1: POSIX  ADVISORY  WRITE 1657 00:0e:1771273 0 EOF
> 2: FLOCK  ADVISORY  WRITE 1486 00:0e:1770759 0 EOF
> 3: FLOCK  ADVISORY  WRITE 1478 00:0e:1770399 0 EOF

OK. I think this client patch ought to fix the Oopses. It should apply
to a 2.6.14 kernel as well as 2.6.15-rc5.

Cheers,
  Trond


--=-3xOXE17WFX1q7ZScmDDK
Content-Disposition: inline; filename=linux-2.6.15-49-fix_nlm_recovery_oops.dif
Content-Type: text/plain; name=linux-2.6.15-49-fix_nlm_recovery_oops.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

NLM: Fix Oops in nlmclnt_mark_reclaim()

 When mixing -olock and -onolock mounts on the same client, we have to
 check that fl->fl_u.nfs_fl.owner is set before dereferencing it.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntlock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 006bb9e..3eaf6e7 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -157,6 +157,8 @@ void nlmclnt_mark_reclaim(struct nlm_hos
 		inode = fl->fl_file->f_dentry->d_inode;
 		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
 			continue;
+		if (fl->fl_u.nfs_fl.owner == NULL)
+			continue;
 		if (fl->fl_u.nfs_fl.owner->host != host)
 			continue;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED))
@@ -226,6 +228,8 @@ restart:
 		inode = fl->fl_file->f_dentry->d_inode;
 		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
 			continue;
+		if (fl->fl_u.nfs_fl.owner == NULL)
+			continue;
 		if (fl->fl_u.nfs_fl.owner->host != host)
 			continue;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_RECLAIM))

--=-3xOXE17WFX1q7ZScmDDK--

