Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUA2GWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbUA2GWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:22:25 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:19775 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266022AbUA2GWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:22:24 -0500
Date: Thu, 29 Jan 2004 17:20:52 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: Fix sleep_on abuse in XFS, Was: Re: 2.6.2-rc2-mm1 (Breakage?)
Message-ID: <20040129062052.GC2474@frodo>
References: <20040127233402.6f5d3497.akpm@osdl.org> <200401281313.03790.ender@debian.org> <200401281225.37234.s0348365@sms.ed.ac.uk> <20040128133357.A28038@infradead.org> <1075300114.1633.156.camel@hades.cambridge.redhat.com> <20040128150206.A28974@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128150206.A28974@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 03:02:06PM +0000, Christoph Hellwig wrote:
> ...
>  	INIT_LIST_HEAD(&tmp);
>  	do {
>  		/* swsusp */
>  		if (current->flags & PF_FREEZE)
>  			refrigerator(PF_IOTHREAD);
>  
> -		if (pbd_active == 1) {
> -			mod_timer(&pb_daemon_timer,
> -				  jiffies + pb_params.flush_interval.val);
> -			interruptible_sleep_on(&pbd_waitq);
> -		}
> -
> -		if (pbd_active == 0) {
> -			del_timer_sync(&pb_daemon_timer);
> -		}
> +		schedule_timeout(pb_params.flush_interval.val);

After a bit more testing, looks like we'll also need a

		current->state = TASK_INTERRUPTIBLE;

line before the schedule_timeout call, else pagebufd eats
a whole lot of system time on one CPU.

I'll send an XFS update to Linus and Andrew tomorrow after
some further testing.

thanks.

-- 
Nathan
