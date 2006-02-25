Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWBYQE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWBYQE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWBYQE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:04:27 -0500
Received: from pat.uio.no ([129.240.130.16]:42170 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161021AbWBYQE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:04:26 -0500
Subject: Re: kernel BUG at fs/locks.c:1932!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Adrian Bunk <bunk@stusta.de>
Cc: Fermin Molina <fermin@asic.udl.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20060225153525.GT3674@stusta.de>
References: <1140189359.22719.51.camel@viagra.udl.net>
	 <1140373675.7883.45.camel@lade.trondhjem.org>
	 <20060225153525.GT3674@stusta.de>
Content-Type: multipart/mixed; boundary="=-S7UU9j340PJ1CWOrTh2T"
Date: Sat, 25 Feb 2006 11:04:06 -0500
Message-Id: <1140883446.3615.168.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.136, required 12,
	autolearn=disabled, AWL 1.68, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S7UU9j340PJ1CWOrTh2T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2006-02-25 at 16:35 +0100, Adrian Bunk wrote:
> On Sun, Feb 19, 2006 at 01:27:55PM -0500, Trond Myklebust wrote:
> > On Fri, 2006-02-17 at 16:15 +0100, Fermin Molina wrote:
> > > Hi,
> > > 
> > > I run samba sharing NFS mounted shares from another machine. I'm getting
> > > the following bugs in console (and in logs), when I stop samba (but not
> > > always, I think it depends of stalled locks):
> > > 
> > > lockd: unexpected unlock status: 7
> > > lockd: unexpected unlock status: 7
> > > lockd: unexpected unlock status: 7
> > > ------------[ cut here ]------------
> > 
> > Hmm... The problem here is that the server is returning an unexpected
> > error: it is normally supposed to return "lock granted" or "grace
> > error", but is actually returning "stale filehandle".
> > 
> > Anyhow, the client should be able to deal with this without Oopsing.
> 
> 
> This seems to be a patch that should go into 2.6.16?

I'm still waiting to hear if it fixes the problem. In the meantime, here
is a slightly cleaner version, that also fixes most of those "unexpected
un/lock status" messages.

Cheers,
  Trond



--=-S7UU9j340PJ1CWOrTh2T
Content-Disposition: inline; filename=linux-2.6.16-04-fix_unlock_bad_res.dif
Content-Type: text/plain; name=linux-2.6.16-04-fix_unlock_bad_res.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

Author: Trond Myklebust <Trond.Myklebust@netapp.com>
NLM: Ensure we do not Oops in the case of an unlock

In theory, NLM specs assure us that the server will only reply LCK_GRANTED
or LCK_DENIED_GRACE_PERIOD to our NLM_UNLOCK request.

In practice, we should not assume this to be the case, and the code will
currently Oops if we do.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntproc.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 220058d..970b6a6 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -662,12 +662,18 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	 * reclaimed while we're stuck in the unlock call. */
 	fl->fl_u.nfs_fl.flags &= ~NFS_LCK_GRANTED;
 
+	/*
+	 * Note: the server is supposed to either grant us the unlock
+	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
+	 * case, we want to unlock.
+	 */
+	do_vfs_lock(fl);
+
 	if (req->a_flags & RPC_TASK_ASYNC) {
 		status = nlmclnt_async_call(req, NLMPROC_UNLOCK,
 					&nlmclnt_unlock_ops);
 		/* Hrmf... Do the unlock early since locks_remove_posix()
 		 * really expects us to free the lock synchronously */
-		do_vfs_lock(fl);
 		if (status < 0) {
 			nlmclnt_release_lockargs(req);
 			kfree(req);
@@ -680,7 +686,6 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	if (status < 0)
 		return status;
 
-	do_vfs_lock(fl);
 	if (resp->status == NLM_LCK_GRANTED)
 		return 0;
 

--=-S7UU9j340PJ1CWOrTh2T--

