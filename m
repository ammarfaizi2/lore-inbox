Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314179AbSDSFiY>; Fri, 19 Apr 2002 01:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSDSFiX>; Fri, 19 Apr 2002 01:38:23 -0400
Received: from harumscarum.mr.itd.umich.edu ([141.211.125.17]:27622 "EHLO
	harumscarum.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S314179AbSDSFiW>; Fri, 19 Apr 2002 01:38:22 -0400
Date: Fri, 19 Apr 2002 01:36:58 -0400 (EDT)
From: Arnar Mar Hrafnkelsson <addi@umich.edu>
To: linux-kernel@vger.kernel.org
cc: trond.myklebust@fys.uio.no
Subject: 2.4.18: nfs_create_request wiping current->policy
Message-ID: <Pine.LNX.4.21.0204190119100.16991-100000@steypa.ast.is>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This post applies to vanilla 2.4.18.

It looks to me like nfs_create_request() is assigning to policy 
instead of or'ing the yield bit effectively converting real time
tasks (SCHED_FIFO=2 and SCHED_RR=1) into normal tasks (SCHED_OTHER=0).

If I'm overlooking something trivial just hit me with the cluebat, 
otherwise trivial patch follows.




diff -r -u linux-2.4.18/fs/nfs/pagelist.c linux-fixed/fs/nfs/pagelist.c
--- linux-2.4.18/fs/nfs/pagelist.c      Fri Dec 21 12:41:55 2001
+++ linux-fixed/fs/nfs/pagelist.c       Fri Apr 19 01:10:02 2002
@@ -96,7 +96,7 @@
                        continue;
                if (signalled() && (server->flags & NFS_MOUNT_INTR))
                        return ERR_PTR(-ERESTARTSYS);
-               current->policy = SCHED_YIELD;
+               current->policy |= SCHED_YIELD;
                schedule();
        }






I'm not subscribed to lkml, please cc.
-- Thanks, Arnar.

