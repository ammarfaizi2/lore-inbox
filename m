Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSHCWJv>; Sat, 3 Aug 2002 18:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHCWJv>; Sat, 3 Aug 2002 18:09:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20497 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317892AbSHCWJu>;
	Sat, 3 Aug 2002 18:09:50 -0400
Message-ID: <3D4C57BB.9D735B13@zip.com.au>
Date: Sat, 03 Aug 2002 15:22:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: question on dup_task_struct
References: <17b65z-1ERay0C@fmrl02.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> Hi,
> 
> why is GFP_ATOMIC used in fork.c::dup_task_struct?

Presumably so that the allocation of the task structure can
dip into the emergency pools, giving fork a better chance
of succeeding?

We don't need to do that now - we can run page reclaim in
there as well as dip into the emergency pools.

 fork.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- 2.5.30/kernel/fork.c~fork-alloc	Sat Aug  3 15:19:10 2002
+++ 2.5.30-akpm/kernel/fork.c	Sat Aug  3 15:19:54 2002
@@ -106,9 +106,10 @@ static struct task_struct *dup_task_stru
 	struct thread_info *ti;
 
 	ti = alloc_thread_info();
-	if (!ti) return NULL;
+	if (!ti)
+		return NULL;
 
-	tsk = kmem_cache_alloc(task_struct_cachep,GFP_ATOMIC);
+	tsk = kmem_cache_alloc(task_struct_cachep, GFP_KERNEL|__GFP_HIGH);
 	if (!tsk) {
 		free_thread_info(ti);
 		return NULL;

.
