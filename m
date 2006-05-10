Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWEJJ3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEJJ3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWEJJ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:29:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964872AbWEJJ3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:29:00 -0400
Date: Wed, 10 May 2006 02:25:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Niehusmann <jan@gondor.com>
Cc: urban@teststation.com, linux-kernel@vger.kernel.org, samba@samba.org
Subject: Re: [PATCH] smbfs: Fix slab corruption in samba error path
Message-Id: <20060510022529.24e15d28.akpm@osdl.org>
In-Reply-To: <20060505121856.GA20033@knautsch.gondor.com>
References: <20060505121856.GA20033@knautsch.gondor.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann <jan@gondor.com> wrote:
>
> Yesterday, I got the following error with 2.6.16.13 during a file copy
> from a smb filesystem over a wireless link. I guess there was some error
> on the wireless link, which in turn caused an error condition for the
> smb filesystem.
> 
> In the log, smb_file_read reports error=4294966784 (0xfffffe00), which
> also shows up in the slab dumps, and also is -ERESTARTSYS. Error code
> 27499 corresponds to 0x6b6b, so the rq_errno field seems to be the only
> one being set after freeing the slab.
> 
> In smb_add_request (which is the only place in smbfs where I found
> ERESTARTSYS), I found the following:
> 
>         if (!timeleft || signal_pending(current)) {
>                 /*
>                  * On timeout or on interrupt we want to try and remove the
>                  * request from the recvq/xmitq.
>                  */
>                 smb_lock_server(server);
>                 if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
>                         list_del_init(&req->rq_queue);
>                         smb_rput(req);
>                 }
>                 smb_unlock_server(server);
>         }
> 	[...]
>         if (signal_pending(current))
>                 req->rq_errno = -ERESTARTSYS;
> 
> I guess that some codepath like smbiod_flush() caused the request
> to be removed from the queue, and smb_rput(req) be called, without
> SMB_REQ_RECEIVED being set. This violates an asumption made by the
> quoted code.
> 
> Then, the above code calls smb_rput(req) again, the req gets freed,
> and req->rq_errno = -ERESTARTSYS writes into the already freed slab.  As
> list_del_init doesn't cause an error if called multiple times, that does
> cause the observed behaviour (freed slab with rq_errno=-ERESTARTSYS).
> 
> If this observation is correct, the following patch should fix it.
>
> .. 
> 
> diff --git a/fs/smbfs/request.c b/fs/smbfs/request.c
> index c71c375..d2d8226 100644
> --- a/fs/smbfs/request.c
> +++ b/fs/smbfs/request.c
> @@ -339,9 +339,11 @@ #endif
>  		/*
>  		 * On timeout or on interrupt we want to try and remove the
>  		 * request from the recvq/xmitq.
> +		 * First check if the request is still part of a queue. (May
> +		 * have been removed by some error condition)
>  		 */
>  		smb_lock_server(server);
> -		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
> +		if (&req->rq_queue != req->rq_queue.next) {
>  			list_del_init(&req->rq_queue);
>  			smb_rput(req);
>  		}
> 

I think the bug is actually that this code is accessing *req after having
doen the smb_rput().  I worry that your patch "fixes" this by accidentally
leaking the request.

We can fairly simply restructure this code so that it doesn't touch the
request after that possible smb_rput().

How does this look?  If "OK", are you able to test it?


 fs/smbfs/request.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff -puN fs/smbfs/request.c~smbfs-fix-slab-corruption-in-samba-error-path fs/smbfs/request.c
--- devel/fs/smbfs/request.c~smbfs-fix-slab-corruption-in-samba-error-path	2006-05-10 01:59:08.000000000 -0700
+++ devel-akpm/fs/smbfs/request.c	2006-05-10 02:21:41.000000000 -0700
@@ -335,19 +335,6 @@ int smb_add_request(struct smb_request *
 
 	timeleft = wait_event_interruptible_timeout(req->rq_wait,
 				    req->rq_flags & SMB_REQ_RECEIVED, 30*HZ);
-	if (!timeleft || signal_pending(current)) {
-		/*
-		 * On timeout or on interrupt we want to try and remove the
-		 * request from the recvq/xmitq.
-		 */
-		smb_lock_server(server);
-		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
-			list_del_init(&req->rq_queue);
-			smb_rput(req);
-		}
-		smb_unlock_server(server);
-	}
-
 	if (!timeleft) {
 		PARANOIA("request [%p, mid=%d] timed out!\n",
 			 req, req->rq_mid);
@@ -372,7 +359,22 @@ int smb_add_request(struct smb_request *
 		req->rq_errno = smb_errno(req);
 	if (signal_pending(current))
 		req->rq_errno = -ERESTARTSYS;
-	return req->rq_errno;
+	result = req->rq_errno;
+
+	if (!timeleft || signal_pending(current)) {
+		/*
+		 * On timeout or on interrupt we want to try and remove the
+		 * request from the recvq/xmitq.
+		 */
+		smb_lock_server(server);
+		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
+			list_del_init(&req->rq_queue);
+			smb_rput(req);
+		}
+		smb_unlock_server(server);
+	}
+
+	return result;
 }
 
 /*
_

