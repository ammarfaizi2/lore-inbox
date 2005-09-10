Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbVIJCzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVIJCzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJCzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:55:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37002 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932601AbVIJCzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:55:38 -0400
Date: Fri, 9 Sep 2005 19:55:34 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050910025534.GE24225@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com> <20050910003525.GC24225@us.ibm.com> <20050909181658.221eb6f9.akpm@osdl.org> <20050910022330.GD24225@us.ibm.com> <20050909193621.5d578583.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909193621.5d578583.akpm@osdl.org>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.2005 [19:36:21 -0700], Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > +	/*
> >  +	 * We compare HZ with 1000 to work out which side of the
> >  +	 * expression needs conversion.  Because we want to avoid
> >  +	 * converting any value to a numerically higher value, which
> >  +	 * could overflow.
> >  +	 */
> >  +#if HZ > 1000
> >  +	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> >  +#else
> >  +	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
> >  +#endif
> >  +
> >  +	/*
> >  +	 * If we would overflow in the conversion or a negative timeout
> >  +	 * is requested, sleep indefinitely.
> >  +	 */
> >  +	if (overflow || timeout_msecs < 0)
> >  +		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
> 
> Do we need to test (timeout_msecs < 0) here?  If we make timeout_msecs
> unsigned long then I think `overflow' will always be correct.

Even though poll is explicitly allowed to take negative values, as per
my man-page:

"#include <sys/poll.h>

int poll(struct pollfd *ufds, unsigned int nfds, int timeout);

...

A negative value means infinite timeout."

Would we have a local variable to store timeout_msecs as well? Or do we
want to make a userspace-visible change like this? I don't have a
preference, I just want to make sure I understand.

Thanks,
Nish
