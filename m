Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWGLDqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWGLDqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGLDqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:46:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbWGLDqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:46:44 -0400
Date: Tue, 11 Jul 2006 20:46:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-Id: <20060711204637.bba6e966.akpm@osdl.org>
In-Reply-To: <20060712032647.GA24595@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
	<20060627054612.GA15657@sergelap.austin.ibm.com>
	<Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
	<20060711194932.GA27176@sergelap.austin.ibm.com>
	<20060711171752.4993903a.akpm@osdl.org>
	<20060712032647.GA24595@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 22:26:47 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> > If so, this should plug it.  The same race is not possible against the
> > loop_set_fd() wakeup because the thread isn't running at that stage, yes?
> 
> Right, it's not yet running at loop_set_fd().  However what about
> kthread_stop() called from loop_clr_fd()?  Unfortunately fixing
> that seems hairy.  Need to think about it...

Yes, there does seem to be a little race there.

I think it would be sufficient to do


diff -puN drivers/block/loop.c~a drivers/block/loop.c
--- a/drivers/block/loop.c~a
+++ a/drivers/block/loop.c
@@ -602,7 +602,8 @@ static int loop_thread(void *data)
 		}
 		__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&lo->lo_lock);
-		schedule();
+		if (lo->state != Lo_rundown)
+			schedule();
 	}
 
 	return 0;
@@ -888,12 +889,11 @@ static int loop_clr_fd(struct loop_devic
 	if (filp == NULL)
 		return -EINVAL;
 
+	kthread_stop(lo->lo_thread);
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
 	spin_unlock_irq(&lo->lo_lock);
 
-	kthread_stop(lo->lo_thread);
-
 	lo->lo_backing_file = NULL;
 
 	loop_release_xfer(lo);
_

where the tweak to loop_clr_fd() is just there to prevent loop_thread()
from going into a very brief busyloop.

I'm not sure why it's all so tricky in there, really.  Loop is doing a
pretty conventional stop, wakeup, stick-things-on-lists operation and we do
that all over the kernel using pretty well-understood idioms.  But for some
reason, loop is all difficult about it.  I wonder why.  hm.
