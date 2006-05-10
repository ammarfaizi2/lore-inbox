Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWEJKco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWEJKco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWEJKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:32:44 -0400
Received: from mail.gondor.com ([212.117.64.182]:62480 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S964909AbWEJKcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:32:43 -0400
Date: Wed, 10 May 2006 12:32:03 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andrew Morton <akpm@osdl.org>
Cc: urban@teststation.com, linux-kernel@vger.kernel.org, samba@samba.org
Subject: Re: [PATCH] smbfs: Fix slab corruption in samba error path
Message-ID: <20060510103202.GA5913@knautsch.gondor.com>
References: <20060505121856.GA20033@knautsch.gondor.com> <20060510022529.24e15d28.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510022529.24e15d28.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:25:29AM -0700, Andrew Morton wrote:
> I think the bug is actually that this code is accessing *req after having
> doen the smb_rput().  I worry that your patch "fixes" this by accidentally
> leaking the request.
> 
> We can fairly simply restructure this code so that it doesn't touch the
> request after that possible smb_rput().
> 
> How does this look?  If "OK", are you able to test it?

No, it doesn't look ok: The callers of smb_add_request (which are all in
fs/smbfs/proc.c) do touch the req structure after calling
smb_add_request, even if an error is returned. So your code would still
cause access after release and double frees on the req object.

As I understand the code smb_add_request is not allowed to completely 
release the req structure at all.

What smb_add_request should do is 
 - increase the req usage counter by one (by calling smb_rget), and add 
   the req to one of the work queues
 - or leave the usage counter alone, and don't add the req to one of the
   work queues

On error, one has to be careful: If we actively remove the req from the
work queues again, we have to decrease the usage counter (otherwise we
leak requests). But if some other function already removed the req from
the queue, that function already did decrease the counter, so we are not
allowed to do it again.

The original code did get the latter case partly wrong. It assumed that
the only way a req could be removed from the work queue would be in
smb_request_recv, where the SMB_REQ_RECEIVED flag gets set. But it did
miss the error cases in smbiod.c, eg. smbiod_flush(), where the req gets
removed from the queues (and the usage counter decreased), without the
SMB_REQ_RECEIVED flag being set.

Therefore I changed the code to not check SMB_REQ_RECEIVED, but test if
the req is still on one of the work queue linked lists.

After that change, smb_add_request never releases the req, so reordering
is not necessary.

Unfortunately it's not easy to test the patch: Of course I did check
that it properly compiles, but the bug is not easily reproducible.

Jan

