Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbUKZUi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbUKZUi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbUKZUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:24:06 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:28836 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264004AbUKZUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:00:41 -0500
Subject: Re: Suspend 2 merge: 21/51: Refrigerator upgrade.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125183332.GJ1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296026.5805.275.camel@desktop.cunninghams>
	 <20041125183332.GJ1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420616.27250.65.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:10:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:33, Pavel Machek wrote:
> Hi!
> 
> > Included in this patch is a new try_to_freeze() macro Andrew M suggested
> > a while back. The refrigerator declarations are put in sched.h to save
> > extra includes of suspend.h.
> 
> try_to_freeze looks nice. Could we get it in after 2.6.10 opens?

I'm hoping to get the whole thing in mm once all these replies are dealt
with. Does that sound unrealistic?

try_to_freeze() should certainly be possible, because it was Andrew's
idea to start with.

> > +++ 582-refrigerator-new/drivers/pnp/pnpbios/core.c	2004-11-24 17:58:33.769748640 +1100
> > @@ -179,6 +179,10 @@
> >  		 * Poll every 2 seconds
> >  		 */
> >  		msleep_interruptible(2000);
> > +
> > +		if(current->flags & PF_FREEZE)
> > +			refrigerator(PF_FREEZE);
> > +
> >  		if(signal_pending(current))
> >  			break;
> >  
> 
> Use new interface here?

Could do. Will change.

> >   */
> >  int fsync_super(struct super_block *sb)
> >  {
> > +	int ret;
> > +
> > +	/* A safety net. During suspend, we might overwrite
> > +	 * memory containing filesystem info. We don't then
> > +	 * want to sync it to disk. */
> > +	if (unlikely(test_suspend_state(SUSPEND_DISABLE_SYNCING)))
> > +		return 0;
> > +	
> 
> If it is safety net, do BUG_ON().

Could get triggered by user pressing SysRq. (Or via a panic?). I don't
think the SysRq should result in a panic; nor should a panic result in a
recursive call to panic (although I'm wondering here, wasn't the call to
syncing in panic taken out?).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

