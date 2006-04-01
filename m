Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWDAGjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDAGjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 01:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDAGjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 01:39:55 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:1694 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750701AbWDAGjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 01:39:55 -0500
To: trond.myklebust@fys.uio.no
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <1143865851.8116.30.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 31 Mar 2006 23:30:50 -0500)
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org>
	 <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu>
	 <1143834022.8116.1.camel@lade.trondhjem.org>
	 <E1FPPZK-0005qJ-00@dorka.pomaz.szeredi.hu> <1143865851.8116.30.camel@lade.trondhjem.org>
Message-Id: <E1FPZlS-0007hH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 01 Apr 2006 08:39:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. I see what you mean now. Do you agree with the following analysis?
> 
>         1) We need 2 extra locks for the case where we
>         upgrade/downgrade, a single existing lock and end up splitting
>         it.
> 
>         2) We need to use 1 extra lock in the case where we unlock and
>         split a single existing lock.
> 
>         3) We also need to use 1 extra lock in the case where there is
>         no existing lock that is contiguous with the region to lock.

   4) Also 1 extra lock needed if there's an existing lock that is
      contiguous/overlapping with the new region but it's a different
      type, and no existing locks are completely covered

> In all other cases, we resort to modifying existing locks instead of
> using new_fl/new_fl2.
> 
> In cases (1) and (2) we do need to modify the existing lock. Since this
> is only done after we've set up the extra locks, we're safe.

And 4.

> Could I still suggest a couple of modifications to your patch? Firstly,
> we only need to test for 'added' once.

Like this?  

 
+	/*
+	 * The above code only modifies existing locks in case of
+	 * merging or replacing.  If new lock(s) need to be inserted
+	 * all modifications are done bellow this, so it's safe yet to
+	 * bail out.
+	 */
+	error = -ENOLCK; /* "no luck" */
+	if (right && left == right && !new_fl2)
+		goto out;
+
 	error = 0;
 	if (!added) {
 		if (request->fl_type == F_UNLCK)
 			goto out;
+
+		if (!new_fl) {
+			error -ENOLCK;
+			goto out;
+		}
 		locks_copy_lock(new_fl, request);
 		locks_insert_lock(before, new_fl);
 		new_fl = NULL;

> Secondly, in cases (2) and (3), we can still complete the lock
> despite one of new_fl/new_fl2 failing to be allocated.

I think it's highly unlikely that one of the allocations would succeed
and the other fail.  If the machine is OOM, then it will very likely
fail all allocations.

But even if that would happen it's not worth it to add more
complexity, just to squeeze the last drop out of the available memory
for file locking purposes.

Miklos
