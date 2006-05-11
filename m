Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWEKDTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWEKDTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 23:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWEKDTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 23:19:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965119AbWEKDTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 23:19:31 -0400
Date: Wed, 10 May 2006 20:16:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Niehusmann <jan@gondor.com>
Cc: urban@teststation.com, linux-kernel@vger.kernel.org, samba@samba.org
Subject: Re: [PATCH] smbfs: Fix slab corruption in samba error path
Message-Id: <20060510201619.6e9fb4c9.akpm@osdl.org>
In-Reply-To: <20060510103202.GA5913@knautsch.gondor.com>
References: <20060505121856.GA20033@knautsch.gondor.com>
	<20060510022529.24e15d28.akpm@osdl.org>
	<20060510103202.GA5913@knautsch.gondor.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann <jan@gondor.com> wrote:
>
> On Wed, May 10, 2006 at 02:25:29AM -0700, Andrew Morton wrote:
> > I think the bug is actually that this code is accessing *req after having
> > doen the smb_rput().  I worry that your patch "fixes" this by accidentally
> > leaking the request.
> > 
> > We can fairly simply restructure this code so that it doesn't touch the
> > request after that possible smb_rput().
> > 
> > How does this look?  If "OK", are you able to test it?
> 
> No, it doesn't look ok: The callers of smb_add_request (which are all in
> fs/smbfs/proc.c) do touch the req structure after calling
> smb_add_request, even if an error is returned. So your code would still
> cause access after release and double frees on the req object.

OK.

> As I understand the code smb_add_request is not allowed to completely 
> release the req structure at all.

yup.

> What smb_add_request should do is 
>  - increase the req usage counter by one (by calling smb_rget), and add 
>    the req to one of the work queues
>  - or leave the usage counter alone, and don't add the req to one of the
>    work queues
> 
> On error, one has to be careful: If we actively remove the req from the
> work queues again, we have to decrease the usage counter (otherwise we
> leak requests). But if some other function already removed the req from
> the queue, that function already did decrease the counter, so we are not
> allowed to do it again.
> 
> The original code did get the latter case partly wrong. It assumed that
> the only way a req could be removed from the work queue would be in
> smb_request_recv, where the SMB_REQ_RECEIVED flag gets set. But it did
> miss the error cases in smbiod.c, eg. smbiod_flush(), where the req gets
> removed from the queues (and the usage counter decreased), without the
> SMB_REQ_RECEIVED flag being set.
> 
> Therefore I changed the code to not check SMB_REQ_RECEIVED, but test if
> the req is still on one of the work queue linked lists.
> 
> After that change, smb_add_request never releases the req, so reordering
> is not necessary.

yup, makes sense.  It'd be nice if we knew who was doing the smb_rput()
without setting SMB_REQ_RECEIVED.

> Unfortunately it's not easy to test the patch: Of course I did check
> that it properly compiles, but the bug is not easily reproducible.

btw, is there any particular reason why you're using smbfs rather than
cifs?

I'll queue up an smbfs patch to inform people that the fs is deprecated and
I'll schedule its removal.

I tweaked your patch a bit:

diff -puN fs/smbfs/request.c~smbfs-fix-slab-corruption-in-samba-error-path fs/smbfs/request.c
--- devel/fs/smbfs/request.c~smbfs-fix-slab-corruption-in-samba-error-path	2006-05-10 20:11:53.000000000 -0700
+++ devel-akpm/fs/smbfs/request.c	2006-05-10 20:12:25.000000000 -0700
@@ -339,9 +339,11 @@ int smb_add_request(struct smb_request *
 		/*
 		 * On timeout or on interrupt we want to try and remove the
 		 * request from the recvq/xmitq.
+		 * First check if the request is still part of a queue. (May
+		 * have been removed by some error condition)
 		 */
 		smb_lock_server(server);
-		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
+		if (!list_empty(&req->rq_queue)) {
 			list_del_init(&req->rq_queue);
 			smb_rput(req);
 		}
_

