Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbTH0Gue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTH0Gud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:50:33 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:4559 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S263193AbTH0Gu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:50:29 -0400
Date: Wed, 27 Aug 2003 08:50:16 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Futex minor fixes
Message-ID: <20030827065016.GA11214@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20030826092631.GN16080@Synopsys.COM> <20030827051853.1E6422C0EA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827051853.1E6422C0EA@lists.samba.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell, Wed, Aug 27, 2003 04:40:14 +0200:
> In message <20030826092631.GN16080@Synopsys.COM> you write:
> > Rusty Russell, Tue, Aug 26, 2003 05:05:56 +0200:
> > > Hi Andrew, Ingo,
> > > 
> > > 	This was posted before, but dropped.
> > > 
> > > Name: Minor futex comment tweaks and cleanups
> > > Author: Rusty Russell
> > > Status: Tested on 2.6.0-test4-bk2
> > > 
> > > D: Changes:
> > > D: 
> > > D: (1) don't return 0 from futex_wait if we are somehow
> > > D: spuriously woken up, return -EINTR on any such case,
> > 
> > Here. EINTR is often (if not always) assumed to be caused by a signal.
> > And someone may rightfully depend on it being that way.
> 
> Yes.  Changed code to loop in this case.  I don't know of anyone who
> actually randomly wakes processes, but just in case.  Returning "0"
> always means as "you were woken up by someone using FUTEX_WAKE", and
> some callers *need to know*.
> 
> How's this?

Now it's consistent with what EINTR conventionally mean :)

> Rusty.
> --
...
> +
> +	/* Were we woken up (and removed from queue)?  Always return
> +	 * success when this happens. */
>  	if (!unqueue_me(&q))
>  		ret = 0;
> -	put_page(q.page);
> +	else if (time == 0)
> +		ret = -ETIMEDOUT;
> +	else if (signal_pending(current))
> +		ret = -EINTR;
> +	else
> +		/* Spurious wakeup somehow.  Loop. */
> +		goto again;
>  
>  	return ret;

Btw, what could that spurious wakeups be?
It set to loop unconditionally, so if the source of wakeup insists on
wakeing up the code could result in endless loop, right?

-alex

