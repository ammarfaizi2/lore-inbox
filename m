Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUKET7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUKET7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUKET54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:57:56 -0500
Received: from pat.uio.no ([129.240.130.16]:39377 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261195AbUKETzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:55:53 -0500
Subject: Re: Hanging NFS umounts with 2.4.27
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Gernoth <simigern@stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041105100237.GA27689@cip.informatik.uni-erlangen.de>
References: <20041105100237.GA27689@cip.informatik.uni-erlangen.de>
Content-Type: multipart/mixed; boundary="=-U2GGM7mCFOgBCi5THzgH"
Date: Fri, 05 Nov 2004 11:55:41 -0800
Message-Id: <1099684541.19858.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.211, required 12,
	NORMAL_HTTP_TO_IP 0.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U2GGM7mCFOgBCi5THzgH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

fr den 05.11.2004 Klokka 11:02 (+0100) skreiv Michael Gernoth:

> Searching through the Changesets I found 1.1402.1.19:
> http://linux.bkbits.net:8080/linux-2.4/cset@1.1402.1.19
> After reverting this one, we have a stable umount-behaviour again.
> 

Does the attached patch help at all?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

--=-U2GGM7mCFOgBCi5THzgH
Content-Disposition: inline; filename=linux-2.4.28-fix_unlink.dif
Content-Type: text/plain; name=linux-2.4.28-fix_unlink.dif; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  NFS: Always wake up tasks that are waiting on the sillyrenamed file to
       complete.
---
 unlink.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.4.28-rc1/fs/nfs/unlink.c
===================================================================
--- linux-2.4.28-rc1.orig/fs/nfs/unlink.c	2004-11-05 11:26:07.832922087 -0800
+++ linux-2.4.28-rc1/fs/nfs/unlink.c	2004-11-05 11:44:38.241824060 -0800
@@ -130,13 +130,14 @@ nfs_async_unlink_done(struct rpc_task *t
 	if (nfs_async_handle_jukebox(task))
 		return;
 	if (!dir)
-		return;
+		goto out;
 	dir_i = dir->d_inode;
 	nfs_zap_caches(dir_i);
 	NFS_PROTO(dir_i)->unlink_done(dir, &task->tk_msg);
 	put_rpccred(data->cred);
 	data->cred = NULL;
 	dput(dir);
+out:
 	data->completed = 1;
 	wake_up(&data->waitq);
 }

--=-U2GGM7mCFOgBCi5THzgH--

