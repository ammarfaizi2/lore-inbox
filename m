Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWBSS2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWBSS2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWBSS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:28:12 -0500
Received: from pat.uio.no ([129.240.130.16]:61658 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932181AbWBSS2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:28:11 -0500
Subject: Re: kernel BUG at fs/locks.c:1932!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Fermin Molina <fermin@asic.udl.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1140189359.22719.51.camel@viagra.udl.net>
References: <1140189359.22719.51.camel@viagra.udl.net>
Content-Type: multipart/mixed; boundary="=-gijNvOGbqrwhIZQmbxB+"
Date: Sun, 19 Feb 2006 13:27:55 -0500
Message-Id: <1140373675.7883.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.693, required 12,
	autolearn=disabled, AWL 1.12, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gijNvOGbqrwhIZQmbxB+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-02-17 at 16:15 +0100, Fermin Molina wrote:
> Hi,
> 
> I run samba sharing NFS mounted shares from another machine. I'm getting
> the following bugs in console (and in logs), when I stop samba (but not
> always, I think it depends of stalled locks):
> 
> lockd: unexpected unlock status: 7
> lockd: unexpected unlock status: 7
> lockd: unexpected unlock status: 7
> ------------[ cut here ]------------

Hmm... The problem here is that the server is returning an unexpected
error: it is normally supposed to return "lock granted" or "grace
error", but is actually returning "stale filehandle".

Anyhow, the client should be able to deal with this without Oopsing.

The attached patch ought to fix that. Please could you give it a try?

Cheers,
  Trond

--=-gijNvOGbqrwhIZQmbxB+
Content-Disposition: inline; filename=linux-2.6.16-68-fix_unlock_bad_res.dif
Content-Type: text/plain; name=linux-2.6.16-68-fix_unlock_bad_res.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

Author: Trond Myklebust <Trond.Myklebust@netapp.com>
NLM: Ensure we do not Oops in the case of an unlock

In theory, NLM specs assure us that the server will only reply LCK_GRANTED
or LCK_DENIED_GRACE_PERIOD to our NLM_UNLOCK request.

In practice, we should not assume this to be the case, and the code will
currently Oops if we do.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntproc.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 7e89655..da76592 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -644,10 +644,16 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 
 	status = nlmclnt_call(req, NLMPROC_UNLOCK);
 	nlmclnt_release_lockargs(req);
+	/*
+	 * Note: the server is supposed to either grant us the unlock
+	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
+	 * case, we want to unlock.
+	 */
+	do_vfs_lock(fl);
+
 	if (status < 0)
 		return status;
 
-	do_vfs_lock(fl);
 	if (resp->status == NLM_LCK_GRANTED)
 		return 0;
 

--=-gijNvOGbqrwhIZQmbxB+--

