Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWGLAOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWGLAOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGLAOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:14:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbWGLAOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:14:19 -0400
Date: Tue, 11 Jul 2006 17:17:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: hugh@veritas.com, serue@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-Id: <20060711171752.4993903a.akpm@osdl.org>
In-Reply-To: <20060711194932.GA27176@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
	<20060627054612.GA15657@sergelap.austin.ibm.com>
	<Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
	<20060711194932.GA27176@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> wrote:
>
> Convert loop.c from the deprecated kernel_thread to kthread.
>

I think you have a racelet here:

> +		}
>  		spin_unlock_irq(&lo->lo_lock);
>  
> -		BUG_ON(!bio);
> -		loop_handle_bio(lo, bio);
> -
> -		/*
> -		 * upped both for pending work and tear-down, lo_pending
> -		 * will hit zero then
> -		 */
> -		if (unlikely(!pending))
> -			break;
> +		__set_current_state(TASK_INTERRUPTIBLE);
> +		schedule();
>  	}
>  
> -	complete(&lo->lo_done);
>  	return 0;
>  }


:		if (kthread_should_stop()) {
:			spin_unlock_irq(&lo->lo_lock);
:			break;
:		}
:		spin_unlock_irq(&lo->lo_lock);
:
:		__set_current_state(TASK_INTERRUPTIBLE);
:		schedule();
:

If the wake_up_process() is delivered before the __set_current_state(),
we'll miss the wakeup.

If so, this should plug it.  The same race is not possible against the
loop_set_fd() wakeup because the thread isn't running at that stage, yes?


diff -puN drivers/block/loop.c~kthread-convert-loopc-to-kthread-race-fix drivers/block/loop.c
--- a/drivers/block/loop.c~kthread-convert-loopc-to-kthread-race-fix
+++ a/drivers/block/loop.c
@@ -525,8 +525,8 @@ static int loop_make_request(request_que
 		goto out;
 	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
-	spin_unlock_irq(&lo->lo_lock);
 	wake_up_process(lo->lo_thread);
+	spin_unlock_irq(&lo->lo_lock);
 	return 0;
 
 out:
@@ -600,9 +600,8 @@ static int loop_thread(void *data)
 			spin_unlock_irq(&lo->lo_lock);
 			break;
 		}
-		spin_unlock_irq(&lo->lo_lock);
-
 		__set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&lo->lo_lock);
 		schedule();
 	}
 
_

