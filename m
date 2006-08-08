Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWHHN0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWHHN0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHHN0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:26:55 -0400
Received: from pat.uio.no ([129.240.10.4]:53937 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932541AbWHHN0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:26:54 -0400
Subject: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Beschorner Daniel <Daniel.Beschorner@facton.com>
Cc: linux-kernel@vger.kernel.org, orion@cora.nwra.com,
       76306.1226@compuserve.com, sfr@canb.auug.org.au
In-Reply-To: <664E3671B2B6DC439E0C9FFCF8E40CA205F4C6@exchange.I-BNEX>
References: <664E3671B2B6DC439E0C9FFCF8E40CA205F4C6@exchange.I-BNEX>
Content-Type: multipart/mixed; boundary="=-bs3kwqGT1hPyKcRew0XI"
Date: Tue, 08 Aug 2006 09:26:30 -0400
Message-Id: <1155043590.5673.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.898, required 12,
	autolearn=disabled, AWL 0.59, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bs3kwqGT1hPyKcRew0XI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-08-08 at 07:38 +0200, Beschorner Daniel wrote:
> >>> static void lease_release_private_callback(struct file_lock *fl) 
> >>> { 
> >>>         if (!fl->fl_file) 
> >>>                 return; 
> >>>         f_delown(fl->fl_file); 
> >>> =>      fl->fl_file->f_owner.signum = 0; 
> >>> } 
> 
> >> Why should the lease cleanup code be resetting f_owner.signum? That 
> >> looks wrong. 
> >> Stephen, I think this line of code predates the CITI changes. Do you 
> >> know who added it and why? 
> 
> >Because when the original code was written, it was only called when we
> got 
> >a fcntl(F_SETLEASE, F_UNLCK) call.  The code got moved incorrectly and 
> >noone noticed.
> 
> Does somebody have a patch for this issue? It breaks one important
> application (Samba) in its default configuration.
> 
> Daniel

I believe this ought to fix it.

Cheers,
  Trond


--=-bs3kwqGT1hPyKcRew0XI
Content-Disposition: inline; filename=linux-2.6.18-fix_lease_signals.dif
Content-Type: message/rfc822; name=linux-2.6.18-fix_lease_signals.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
fs/locks.c: Fix fcntl(F_SETSIG) on leases
Date: Tue, 08 Aug 2006 09:26:30 -0400
Subject: No Subject
Message-Id: <1155043590.5673.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

fcntl(F_SETSIG) no longer works on leases because
lease_release_private_callback() gets called as the lease is copied in
order to initialise it.
The problem is that lease_alloc() performs an unnecessary initialisation,
which sets the lease_manager_ops. Avoid the problem by allocating the
target lease structure using locks_alloc_lock().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b0b41a6..d7c5339 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1421,8 +1421,9 @@ static int __setlease(struct file *filp,
 	if (!leases_enable)
 		goto out;
 
-	error = lease_alloc(filp, arg, &fl);
-	if (error)
+	error = -ENOMEM;
+	fl = locks_alloc_lock();
+	if (fl == NULL)
 		goto out;
 
 	locks_copy_lock(fl, lease);
@@ -1430,6 +1431,7 @@ static int __setlease(struct file *filp,
 	locks_insert_lock(before, fl);
 
 	*flp = fl;
+	error = 0;
 out:
 	return error;
 }

--=-bs3kwqGT1hPyKcRew0XI--

