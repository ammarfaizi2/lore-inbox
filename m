Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUINAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUINAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUINAV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:21:26 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:10423 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S269072AbUINAVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:21:24 -0400
Date: Mon, 13 Sep 2004 17:21:20 -0700
Message-Id: <200409140021.i8E0LKcB030581@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: fix posix-timers leak and pending signal loss
In-Reply-To: Andrew Morton's message of  Monday, 13 September 2004 16:26:45 -0700 <20040913162645.448e6131.akpm@osdl.org>
X-Zippy-Says: I can't decide which WRONG TURN to make first!!  I wonder if BOB
   GUCCIONE has these problems!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch comes at an awkward time - I'd prefer that the leak fix be merged
> up immediately, but the rest appears less serious.  And you're playing in
> an area which likes to explode in our faces.

Frankly, I think the old code is much more prone to unforeseen problems
than the new.  

> Had you not rolled three distinct patches into one (hint) I'd have
> forwarded along the leak fix and sat on the rest for post-2.6.9.

I don't like being an enabler of bad code.  So I didn't do a separate fix
inside something that I already knew needed to be ripped out.  If you want
an untested minimal fix for just the leak potential, leaving the semantics
frotzed in multiple ways, you can try the following.


Index: linux-2.6/exec.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/exec.c,v
retrieving revision 1.138
diff -u -b -B -p -r1.138 exec.c
--- linux-2.6/exec.c 27 Aug 2004 17:36:15 -0000 1.138
+++ linux-2.6/exec.c 14 Sep 2004 00:19:43 -0000
@@ -741,8 +741,10 @@ no_thread_group:
 	spin_unlock(&oldsighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 
-	if (newsig && atomic_dec_and_test(&oldsig->count))
+	if (newsig && atomic_dec_and_test(&oldsig->count)) {
+		exit_itimers(oldsig);
 		kmem_cache_free(signal_cachep, oldsig);
+	}
 
 	if (atomic_dec_and_test(&oldsighand->count))
 		kmem_cache_free(sighand_cachep, oldsighand);
