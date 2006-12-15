Return-Path: <linux-kernel-owner+w=401wt.eu-S1750992AbWLOAYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWLOAYL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWLOAXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:23:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42228 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbWLOAXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:42 -0500
Message-Id: <20061215000820.372869000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:08:04 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: Prefetch hint
Content-Disposition: inline; filename=task-watchers-prefetch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prefetch the entire array of function pointers.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

---
 kernel/task_watchers.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.19/kernel/task_watchers.c
===================================================================
--- linux-2.6.19.orig/kernel/task_watchers.c
+++ linux-2.6.19/kernel/task_watchers.c
@@ -1,6 +1,7 @@
 #include <linux/init.h>
+#include <linux/prefetch.h>
 
 /* Defined in include/asm-generic/vmlinux.lds.h */
 extern const task_watcher_fn __start_task_init[],
 		__start_task_clone[], __start_task_exec[],
 		__start_task_uid[], __start_task_gid[],
@@ -30,10 +31,11 @@ int notify_task_watchers(unsigned int ev
 
 	tw_call = twtable[ev];
 	tw_end = twtable[ev + 1];
 
 	/* Call all of the watchers, report the first error */
+	prefetch_range(tw_call, tw_end - tw_call);
 	for (; tw_call < tw_end; tw_call++) {
 		err = (*tw_call)(val, tsk);
 		if (unlikely((err < 0) && (ret_err == 0)))
 			ret_err = err;
 	}

--
