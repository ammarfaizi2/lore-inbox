Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVHZBAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVHZBAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVHZBAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:00:19 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53882 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964793AbVHZBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:00:19 -0400
To: akpm@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB: fix use-after-free in user verbs cleanup
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 25 Aug 2005 18:00:09 -0700
Message-ID: <52u0hdqzqe.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Aug 2005 01:00:10.0551 (UTC) FILETIME=[82179C70:01C5A9D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'd like to get this into 2.6.13 if possible.  If it's too late, it's
not the end of the world -- we can wait for 2.6.13.1.  But it's a
tiny, obvious patch that fixes a crash that at least one person
actually hit running a normal application:
http://openib.org/pipermail/openib-general/2005-August/010248.html

Thanks,
  Roland


Fix a use-after-free bug in userspace verbs cleanup: we can't touch
mr->device after we free mr by calling ib_dereg_mr().

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -130,13 +130,14 @@ static int ib_dealloc_ucontext(struct ib
 
 	list_for_each_entry_safe(uobj, tmp, &context->mr_list, list) {
 		struct ib_mr *mr = idr_find(&ib_uverbs_mr_idr, uobj->id);
+		struct ib_device *mrdev = mr->device;
 		struct ib_umem_object *memobj;
 
 		idr_remove(&ib_uverbs_mr_idr, uobj->id);
 		ib_dereg_mr(mr);
 
 		memobj = container_of(uobj, struct ib_umem_object, uobject);
-		ib_umem_release_on_close(mr->device, &memobj->umem);
+		ib_umem_release_on_close(mrdev, &memobj->umem);
 
 		list_del(&uobj->list);
 		kfree(memobj);
