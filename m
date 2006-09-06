Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWIFXMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWIFXMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWIFXCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:55500 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964992AbWIFXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:09 -0400
Date: Wed, 6 Sep 2006 15:56:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/37] fcntl(F_SETSIG) fix
Message-ID: <20060906225659.GV15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fcntl-fix.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Trond Myklebust <trond.myklebust@fys.uio.no>

[PATCH] fcntl(F_SETSIG) fix

fcntl(F_SETSIG) no longer works on leases because
lease_release_private_callback() gets called as the lease is copied in
order to initialise it.

The problem is that lease_alloc() performs an unnecessary initialisation,
which sets the lease_manager_ops.  Avoid the problem by allocating the
target lease structure using locks_alloc_lock().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/locks.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17.11.orig/fs/locks.c
+++ linux-2.6.17.11/fs/locks.c
@@ -1389,8 +1389,9 @@ static int __setlease(struct file *filp,
 	if (!leases_enable)
 		goto out;
 
-	error = lease_alloc(filp, arg, &fl);
-	if (error)
+	error = -ENOMEM;
+	fl = locks_alloc_lock();
+	if (fl == NULL)
 		goto out;
 
 	locks_copy_lock(fl, lease);
@@ -1398,6 +1399,7 @@ static int __setlease(struct file *filp,
 	locks_insert_lock(before, fl);
 
 	*flp = fl;
+	error = 0;
 out:
 	return error;
 }

--
