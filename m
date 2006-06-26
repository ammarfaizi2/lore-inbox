Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932993AbWFZT71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbWFZT71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbWFZT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:59:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932993AbWFZT7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:59:25 -0400
Date: Mon, 26 Jun 2006 12:59:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: minyard@acm.org, linux-kernel@vger.kernel.org, peter@palfrader.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] IPMI: use schedule in kthread
Message-Id: <20060626125912.240587af.akpm@osdl.org>
In-Reply-To: <20060626194937.GA16528@lists.us.dell.com>
References: <20060626140819.GA17804@localdomain>
	<20060626120048.cff87fac.akpm@osdl.org>
	<20060626194937.GA16528@lists.us.dell.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 14:49:37 -0500
Matt Domsch <Matt_Domsch@dell.com> wrote:

> On Mon, Jun 26, 2006 at 12:00:48PM -0700, Andrew Morton wrote:
> > On Mon, 26 Jun 2006 09:08:19 -0500
> > MAILER-DAEMON@osdl.org wrote:
> > 
> > > The kthread used to speed up polling for IPMI was using udelay
> > > when the lower-level state machine told it to do a short delay.
> > > This just used CPU and didn't help scheduling, thus causing bad
> > > problems with other tasks.  Call schedule() instead.
> > > 
> > > Signed-off-by: Corey Minyard <minyard@acm.org>
> > > 
> > > Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> > > ===================================================================
> > > --- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
> > > +++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> > > @@ -809,7 +809,7 @@ static int ipmi_thread(void *data)
> > >  			/* do nothing */
> > >  		}
> > >  		else if (smi_result == SI_SM_CALL_WITH_DELAY)
> > > -			udelay(1);
> > > +			schedule();
> > >  		else
> > >  			schedule_timeout_interruptible(1);
> > >  	}
> > 
> > calling schedule() isn't a lot of use either.
> > 
> > If CONFIG_PREEMPT it's of no benefit and will just chew CPU.
> > 
> > If !CONFIG_PREEMPT && !need_resched() then it's a no-op and will chew CPU.
> > 
> > If !CONFIG_PREEMPT && need_resched() then yes, it'll schedule away.  This
> > is pretty much the only time that a simple schedule() is useful.
> > 
> > 
> > What are we actually trying to do in here?
> 
> Make up for a lack of poor hardware design.  Most IPMI controllers
> that use the standard-specified KCS interface don't implement
> interrupts to signal data availability, and its a character-at-a-time
> interface.

ah, OK, you're screwed ;) There's no fix for that, so blowing CPU while
offering reschedule opportunities is better than just blowing CPU.

