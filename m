Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWDAEb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWDAEb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 23:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWDAEb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 23:31:56 -0500
Received: from pat.uio.no ([129.240.10.6]:28855 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751496AbWDAEbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 23:31:55 -0500
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1FPPZK-0005qJ-00@dorka.pomaz.szeredi.hu>
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org>
	 <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu>
	 <1143834022.8116.1.camel@lade.trondhjem.org>
	 <E1FPPZK-0005qJ-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-cnx4u5V9xO7tjO8FM9bS"
Date: Fri, 31 Mar 2006 23:30:50 -0500
Message-Id: <1143865851.8116.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.172, required 12,
	autolearn=disabled, AWL 1.69, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cnx4u5V9xO7tjO8FM9bS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-03-31 at 21:46 +0200, Miklos Szeredi wrote:
> > > In the first case no new locks are needed.  In the second, no locks
> > > are modified prior to the check.
> > 
> > Consider something like
> > 
> > fcntl(SETLK, 0, 100)
> > fcntl(SETLK, 0, 100)
> > fcntl(SETLK, 0, 100)
> 
> Huh?  What is the type of lock in each case.
> 
> But anyway your example is no good.  If the new lock completely covers
> the previous one, then the old lock will simply be adjusted and no new
> lock is inserted.

Slip of the mailer. It posted when I wanted to cancel the mail (I had to
step out for an errand)...

OK. I see what you mean now. Do you agree with the following analysis?

        1) We need 2 extra locks for the case where we
        upgrade/downgrade, a single existing lock and end up splitting
        it.

        2) We need to use 1 extra lock in the case where we unlock and
        split a single existing lock.

        3) We also need to use 1 extra lock in the case where there is
        no existing lock that is contiguous with the region to lock.

In all other cases, we resort to modifying existing locks instead of
using new_fl/new_fl2.

In cases (1) and (2) we do need to modify the existing lock. Since this
is only done after we've set up the extra locks, we're safe.

Could I still suggest a couple of modifications to your patch? Firstly,
we only need to test for 'added' once. Secondly, in cases (2) and (3),
we can still complete the lock despite one of new_fl/new_fl2 failing to
be allocated.

Cheers,
  Trond

--=-cnx4u5V9xO7tjO8FM9bS
Content-Disposition: inline; filename=optimise_lock.dif
Content-Type: text/plain; name=optimise_lock.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

VFS,locks: locks: don't unnecessarily fail posix lock operations

---

 fs/locks.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6ba3756..973c1d9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -839,10 +839,6 @@ static int __posix_lock_file_conf(struct
 	if (request->fl_flags & FL_ACCESS)
 		goto out;
 
-	error = -ENOLCK; /* "no luck" */
-	if (!(new_fl && new_fl2))
-		goto out;
-
 	/*
 	 * We've allocated the new locks in advance, so there are no
 	 * errors possible (and no blocking operations) from here on.
@@ -943,9 +939,25 @@ static int __posix_lock_file_conf(struct
 		before = &fl->fl_next;
 	}
 
-	error = 0;
-	if (!added) {
-		if (request->fl_type == F_UNLCK)
+	if (request->fl_type == F_UNLCK) {
+		if (!added)
+			goto out;
+		if (!new_fl2 && right && left == right) {
+			new_fl2 = new_fl;
+			error = -ENOLCK;
+			if (!new_fl2)
+				goto out;
+			new_fl = NULL;
+		}
+	} else if (!added) {
+		error = -ENOLCK;
+		if (!new_fl) {
+			new_fl = new_fl2;
+			if (!new_fl)
+				goto out;
+			new_fl2 = NULL;
+		}
+		if (!new_fl2 && right && left == right)
 			goto out;
 		locks_copy_lock(new_fl, request);
 		locks_insert_lock(before, new_fl);
@@ -968,6 +980,7 @@ static int __posix_lock_file_conf(struct
 		left->fl_end = request->fl_start - 1;
 		locks_wake_up_blocks(left);
 	}
+	error = 0;
  out:
 	unlock_kernel();
 	/*

--=-cnx4u5V9xO7tjO8FM9bS--

