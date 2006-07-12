Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWGLD1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWGLD1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGLD1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:27:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:2011 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932361AbWGLD1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:27:33 -0400
Date: Tue, 11 Jul 2006 22:26:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060712032647.GA24595@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com> <20060711194932.GA27176@sergelap.austin.ibm.com> <20060711171752.4993903a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711171752.4993903a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> >
> > Convert loop.c from the deprecated kernel_thread to kthread.
> >
> 
> I think you have a racelet here:
> 
> > +		}
> >  		spin_unlock_irq(&lo->lo_lock);
> >  
> > -		BUG_ON(!bio);
> > -		loop_handle_bio(lo, bio);
> > -
> > -		/*
> > -		 * upped both for pending work and tear-down, lo_pending
> > -		 * will hit zero then
> > -		 */
> > -		if (unlikely(!pending))
> > -			break;
> > +		__set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule();
> >  	}
> >  
> > -	complete(&lo->lo_done);
> >  	return 0;
> >  }
> 
> 
> :		if (kthread_should_stop()) {
> :			spin_unlock_irq(&lo->lo_lock);
> :			break;
> :		}
> :		spin_unlock_irq(&lo->lo_lock);
> :
> :		__set_current_state(TASK_INTERRUPTIBLE);
> :		schedule();
> :
> 
> If the wake_up_process() is delivered before the __set_current_state(),
> we'll miss the wakeup.

Makes sense, and the patched kernel passes the parallel tests.

Thanks for the patch.

> If so, this should plug it.  The same race is not possible against the
> loop_set_fd() wakeup because the thread isn't running at that stage, yes?

Right, it's not yet running at loop_set_fd().  However what about
kthread_stop() called from loop_clr_fd()?  Unfortunately fixing
that seems hairy.  Need to think about it...

thanks,
-serge
