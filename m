Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWJHTWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJHTWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJHTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:22:20 -0400
Received: from pat.uio.no ([129.240.10.4]:4567 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751355AbWJHTWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:22:18 -0400
Subject: Re: BUG when doing parallel NFS mounts (WAS: Re: Merge window
	closed: v2.6.19-rc1)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Osterlund <petero2@telia.com>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m31wpihc4u.fsf@telia.com>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <m37izbhvvb.fsf@telia.com> <m3mz86hm39.fsf@telia.com>
	 <1160332545.11233.3.camel@lade.trondhjem.org>  <m31wpihc4u.fsf@telia.com>
Content-Type: multipart/mixed; boundary="=-3gjP7hbLsl2JLu3lYS0M"
Date: Sun, 08 Oct 2006 15:21:59 -0400
Message-Id: <1160335319.11233.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.218, required 12,
	autolearn=disabled, AWL 1.65, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3gjP7hbLsl2JLu3lYS0M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-10-08 at 20:54 +0200, Peter Osterlund wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > On Sun, 2006-10-08 at 17:19 +0200, Peter Osterlund wrote:
> > > > kernel BUG at fs/nfs/client.c:352!
> > 
> > Does the following patch fix it?
> 
> Yes it does. Thanks!

Hmm... There would appear to be another bug there. After breaking out of
the loop, the task state is left as TASK_INTERRUPTIBLE. Let's just
replace the whole thing with a wait_on_event_interruptible.

Cheers,
  Trond

--=-3gjP7hbLsl2JLu3lYS0M
Content-Disposition: inline; filename=linux-2.6.19-002-fix_nfs_get_client.dif
Content-Type: message/rfc822; name=linux-2.6.19-002-fix_nfs_get_client.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Sun, 8 Oct 2006 14:33:24 -0400
Subject: NFS: Fix typo in nfs_get_client()
Message-Id: <1160335297.11233.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

NFS_CS_INITING > NFS_CS_READY, so instead of waiting for the structure to
get initialised, we currently immediately jump out of the loop without ever
sleeping.

It is also possible to break out of the loop while still in
TASK_INTERRUPTIBLE. Replace by wait_event_interruptible, which doesn't
suffer from these problems.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6e4e48c..013cdbc 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -322,25 +322,11 @@ found_client:
 	if (new)
 		nfs_free_client(new);
 
-	if (clp->cl_cons_state == NFS_CS_INITING) {
-		DECLARE_WAITQUEUE(myself, current);
-
-		add_wait_queue(&nfs_client_active_wq, &myself);
-
-		for (;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (signal_pending(current) ||
-			    clp->cl_cons_state > NFS_CS_READY)
-				break;
-			schedule();
-		}
-
-		remove_wait_queue(&nfs_client_active_wq, &myself);
-
-		if (signal_pending(current)) {
-			nfs_put_client(clp);
-			return ERR_PTR(-ERESTARTSYS);
-		}
+	error = wait_event_interruptible(&nfs_client_active_wq,
+				clp->cl_cons_state != NFS_CS_INITING);
+	if (error < 0) {
+		nfs_put_client(clp);
+		return ERR_PTR(-ERESTARTSYS);
 	}
 
 	if (clp->cl_cons_state < NFS_CS_READY) {

--=-3gjP7hbLsl2JLu3lYS0M--

