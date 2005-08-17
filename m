Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVHQSZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVHQSZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVHQSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:25:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39107 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751192AbVHQSZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:25:48 -0400
Subject: [PATCH] nfsd to unlock kernel before exiting
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 14:25:23 -0400
Message-Id: <1124303123.5247.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nfsd holds the big kernel lock upon exit, when it really shouldn't.
Not to mention that this breaks Ingo's RT patch. This is a trivial fix
to release the lock.

Ingo, this patch also works with your kernel, and stops the problem with
nfsd.

Note, there's a "goto out;" where "out:" is right above svc_exit_thread.
The point of the goto also holds the kernel_lock, so I don't see any
problem here in releasing it.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git4/fs/nfsd/nfssvc.c.orig	2005-08-17 14:12:02.000000000 -0400
+++ linux-2.6.13-rc6-git4/fs/nfsd/nfssvc.c	2005-08-17 14:12:25.000000000 -0400
@@ -287,6 +287,7 @@ out:
 	svc_exit_thread(rqstp);
 
 	/* Release module */
+	unlock_kernel();
 	module_put_and_exit(0);
 }
 


