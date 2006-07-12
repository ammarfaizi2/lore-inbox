Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWGLOcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWGLOcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGLOb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:31:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59533 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750953AbWGLOb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:31:59 -0400
Date: Wed, 12 Jul 2006 09:31:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060712143107.GA25408@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com> <20060711194932.GA27176@sergelap.austin.ibm.com> <20060711171752.4993903a.akpm@osdl.org> <20060712032647.GA24595@sergelap.austin.ibm.com> <20060711204637.bba6e966.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711204637.bba6e966.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Tue, 11 Jul 2006 22:26:47 -0500
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > > If so, this should plug it.  The same race is not possible against the
> > > loop_set_fd() wakeup because the thread isn't running at that stage, yes?
> > 
> > Right, it's not yet running at loop_set_fd().  However what about
> > kthread_stop() called from loop_clr_fd()?  Unfortunately fixing
> > that seems hairy.  Need to think about it...
> 
> Yes, there does seem to be a little race there.
> 
> I think it would be sufficient to do
> 
> 
> diff -puN drivers/block/loop.c~a drivers/block/loop.c
> --- a/drivers/block/loop.c~a
> +++ a/drivers/block/loop.c
> @@ -602,7 +602,8 @@ static int loop_thread(void *data)
>  		}
>  		__set_current_state(TASK_INTERRUPTIBLE);
>  		spin_unlock_irq(&lo->lo_lock);
> -		schedule();
> +		if (lo->state != Lo_rundown)
> +			schedule();
>  	}
>  
>  	return 0;
> @@ -888,12 +889,11 @@ static int loop_clr_fd(struct loop_devic
>  	if (filp == NULL)
>  		return -EINVAL;
>  
> +	kthread_stop(lo->lo_thread);
>  	spin_lock_irq(&lo->lo_lock);
>  	lo->lo_state = Lo_rundown;
>  	spin_unlock_irq(&lo->lo_lock);
>  
> -	kthread_stop(lo->lo_thread);
> -
>  	lo->lo_backing_file = NULL;
>  
>  	loop_release_xfer(lo);
> _
> 
> where the tweak to loop_clr_fd() is just there to prevent loop_thread()
> from going into a very brief busyloop.

Why does this fix the problem?  Can't the wake_up_process() in
kthread_stop() still happen right before loop_thread's schedule()?

This also means that after loop_thread() has decided to stop,
make_request() has a chance to make a few more requests.  It
will see lo->lo_state as bound, assume all is well, but when it goes to
wake_up_thread(), the thread will have been put_task_struct()d.

If I'm not entirely wrong above, how about the following alternate fix?  
Unfortunately I guess it doesn't stop the brief busyloop...

> I'm not sure why it's all so tricky in there, really.  Loop is doing a
> pretty conventional stop, wakeup, stick-things-on-lists operation and we do
> that all over the kernel using pretty well-understood idioms.  But for some
> reason, loop is all difficult about it.  I wonder why.  hm.

Perhaps I should give completions another go.

thanks,
-serge

Subject: [PATCH 3/3] kthread: fix loop.c race at thread stop

The wake_up_process() from kthread_stop() could happen
between loop_thread's __set_current_state(TASK_INTERRUPTIBLE)
and schedule().  But we can't put kthread_stop() under the
spin_lock like we did the wake_up_process() in make_request().

So turn the thread stopping into a two-phase process.  Do
a wake_up_process() under spin_lock after setting the
lo_state to Lo_rundown, after which the loop_thread no
long sleeps.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

e972f09b6ca27a7ac3421ab49bde6dba33fca62c
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f944536..df38e05 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -600,9 +600,13 @@ static int loop_thread(void *data)
 			spin_unlock_irq(&lo->lo_lock);
 			break;
 		}
-		__set_current_state(TASK_INTERRUPTIBLE);
+		if (lo->lo_state != Lo_rundown)
+			__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&lo->lo_lock);
-		schedule();
+		if (lo->lo_state != Lo_rundown)
+			schedule();
+		else
+			__set_current_state(TASK_UNINTERRUPTIBLE);
 	}
 
 	return 0;
@@ -896,6 +900,7 @@ static int loop_clr_fd(struct loop_devic
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
+	wake_up_process(lo->lo_thread);
 	spin_unlock_irq(&lo->lo_lock);
 
 	kthread_stop(lo->lo_thread);
-- 
1.1.6
