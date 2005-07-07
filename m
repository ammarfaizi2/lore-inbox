Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVGGTDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVGGTDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGGTBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:01:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53163 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261785AbVGGS7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:59:31 -0400
Date: Thu, 7 Jul 2005 14:59:29 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix use after free in smbfs.
Message-ID: <20050707185928.GA29413@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From code inspection it seems that after freeing 'req', in smb_request()
we continue to dereference it a dozen or so times.

That whole area of code looks suspect.
		...
        smb_lock_server(server);
        if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
            list_del_init(&req->rq_queue);
            smb_rput(req);
        }

smb_rput() also does a list_del_init, but only if its safe
to do so (ie, the refcount has dropped to 0).
To my not-smbfs-savvy eyes, it would seem that we could
potentially nuke the ->rq_queue list, and return from
smb_rput() if the request was still in use. What the rest
of the code does with such a buggered-up request, I've no
idea, but it probably isn't pretty.

Perhaps smb_rput should be taking a pointer to a request that can
be null'd on success ?

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/fs/smbfs/request.c~	2005-07-07 14:41:11.000000000 -0400
+++ linux-2.6.12/fs/smbfs/request.c	2005-07-07 14:41:22.000000000 -0400
@@ -348,6 +348,7 @@ int smb_add_request(struct smb_request *
 			smb_rput(req);
 		}
 		smb_unlock_server(server);
+		return -EINTR;
 	}
 
 	if (!timeleft) {



Looking further, we do exactly the same thing in smb_request_recv()

        smb_rput(req);
        wake_up_interruptible(&req->rq_wait);
    }

ditto in smbiod.c..

What am I missing here?  smb_rput() -> smb_free_request() does
a kmem_cache_free(req_cachep, req); making further use of that
cache item invalid.

		Dave

