Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUFPNmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUFPNmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUFPNmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:42:39 -0400
Received: from [213.13.117.218] ([213.13.117.218]:51145 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S266274AbUFPNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:40:39 -0400
Date: Wed, 16 Jun 2004 14:40:36 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [2.4] build error with latest BK
Message-ID: <20040616134036.GA2969@hobbes.itsari.int>
References: <40CFB2A1.8070104@yahoo.com.au> <20040615164848.GA8276@hobbes.itsari.int> <3473.1087374022@redhat.com> <40D00828.8020303@yahoo.com.au> <16592.3188.448186.438659@alkaid.it.uu.se> <40D00D1F.8070109@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40D00D1F.8070109@yahoo.com.au> (from nickpiggin@yahoo.com.au on Wed, Jun 16, 2004 at 10:04:31 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.16 10:04, Nick Piggin wrote:
> Just simply replace put_task_struct with free_task_struct.

Like this, maybe? It applies on top of what's currently in BK -- it fixed 
it for me, compiled and boot tested, running for the last 20 minutes. 
Also, linux/mm.h is needed because of free_pages().

Marcelo, please apply.


--- linux-2.4-BK/lib/rwsem.c~fix-rwsem-race-fix	2004-06-16 14:14:02.187159768 +0100
+++ linux-2.4-BK/lib/rwsem.c	2004-06-16 14:14:28.905098024 +0100
@@ -5,6 +5,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
@@ -64,7 +65,7 @@ static inline struct rw_semaphore *__rws
 	mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
-	put_task_struct(tsk);
+	free_task_struct(tsk);
 	goto out;
 
 	/* grant an infinite number of read locks to the readers at the front of the queue
@@ -96,7 +97,7 @@ static inline struct rw_semaphore *__rws
 		mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		free_task_struct(tsk);
 	}
 
 	sem->wait_list.next = next;
