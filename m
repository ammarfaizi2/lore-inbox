Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263401AbUKZWKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbUKZWKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUKZWJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:09:10 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:9379 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263448AbUKZTvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:51:03 -0500
Subject: Re: Suspend 2 merge: 16/51: Disable cache reaping during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125181809.GF1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295167.5805.254.camel@desktop.cunninghams>
	 <20041125181809.GF1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420039.27250.51.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:00:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:18, Pavel Machek wrote:
> Hi!
> > I have to admit to being a little unsure as to why this is needed, but
> > suspend's reliability is helped a lot by disabling cache reaping while
> > suspending. Perhaps one of the mm guys will be able to enlighten me
> > here. Might be SMP related.
> 
> It would be good to understand it. Rather than slowing common code... why
> not down(&cache_chain_sem) in suspend2?

Didn't consider it, to be honest.

That said, if/when we start to use cpu hotplug for SMP, we'll deadlock
in cpuup_callback if we've got the sem.

> >  {
> >  	struct list_head *walk;
> >  
> > -	if (down_trylock(&cache_chain_sem)) {
> > +	if ((unlikely(test_suspend_state(SUSPEND_RUNNING))) ||
> > +		(down_trylock(&cache_chain_sem))) 
> > +	{
> >  		/* Give up. Setup the next iteration. */
> >  		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
> >  		return;
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

