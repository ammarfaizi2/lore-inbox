Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUISWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUISWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUISWv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:51:58 -0400
Received: from pat.uio.no ([129.240.130.16]:1741 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264915AbUISWvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:51:54 -0400
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040919203619.GA8618@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru>
	 <20040919200527.GA7184@tentacle.sectorb.msk.ru>
	 <1095625531.7860.59.camel@lade.trondhjem.org>
	 <20040919203619.GA8618@tentacle.sectorb.msk.ru>
Content-Type: multipart/mixed; boundary="=-XlP7KfIK53H8lakgmCtB"
Message-Id: <1095634303.7860.122.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 15:51:43 -0700
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XlP7KfIK53H8lakgmCtB
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

P=E5 su , 19/09/2004 klokka 13:36, skreiv Vladimir B. Savkin:
> On Sun, Sep 19, 2004 at 01:32:08PM -0700, Trond Myklebust wrote:
> > P? su , 19/09/2004 klokka 13:05, skreiv Vladimir B. Savkin:
> > > >=20
> > > > Today I managed to see the output of Alt+SysRq+P on the
> > > > hanged box and write down call trace (from screen, so it is incompl=
ete).
> > > >=20
> > > > EIP (c015da89) was in function posix_locks_deadlock,
> > > > and the call trace was:
> > > >  __posix_lock_file
> > > >  fcntl_setlk

Hmm...  It appears that it is indeed possible for both leases and flocks
to be on the global "blocked_list", so the appended check is *not*
redundant.
Since flocks in particular do not initialize fl_owner, I suspect that
you might be seeing wierd loops that were previously being avoided due
to the ->fl_pid checks...

Cheers,
 Trond


--=-XlP7KfIK53H8lakgmCtB
Content-Disposition: inline; filename=fix_posix_locks_deadlock.dif
Content-Type: text/plain; name=fix_posix_locks_deadlock.dif; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

[PATCH] fix posix_locks_deadlock().

"blocked_list" may contain both leases and flock locks. Since the latter in
particular do not initialize the fl_owner field, we have to beware not to
call posix_same_owner() on them.

Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 locks.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.9-rc2-up/fs/locks.c
===================================================================
--- linux-2.6.9-rc2-up.orig/fs/locks.c	2004-09-19 13:55:33.680258334 -0700
+++ linux-2.6.9-rc2-up/fs/locks.c	2004-09-19 15:37:32.595634679 -0700
@@ -634,14 +634,13 @@
 int posix_locks_deadlock(struct file_lock *caller_fl,
 				struct file_lock *block_fl)
 {
-	struct list_head *tmp;
+	struct file_lock *fl;
 
 next_task:
 	if (posix_same_owner(caller_fl, block_fl))
 		return 1;
-	list_for_each(tmp, &blocked_list) {
-		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
-		if (posix_same_owner(fl, block_fl)) {
+	list_for_each_entry(fl, &blocked_list, fl_link) {
+		if (IS_POSIX(fl) && posix_same_owner(fl, block_fl)) {
 			fl = fl->fl_next;
 			block_fl = fl;
 			goto next_task;

--=-XlP7KfIK53H8lakgmCtB--

