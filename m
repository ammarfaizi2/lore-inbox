Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282781AbRLLXuJ>; Wed, 12 Dec 2001 18:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLLXuD>; Wed, 12 Dec 2001 18:50:03 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:46352 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282781AbRLLXtp>; Wed, 12 Dec 2001 18:49:45 -0500
Date: Wed, 12 Dec 2001 23:49:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB not processing APM suspend event properly?
Message-ID: <20011212234916.A4606@flint.arm.linux.org.uk>
In-Reply-To: <1008200427.1134.29.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008200427.1134.29.camel@thanatos>; from jdthood@mail.com on Wed, Dec 12, 2001 at 06:40:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 06:40:26PM -0500, Thomas Hood wrote:
> I suppose that the reason why it is presently coded as
> it is is that the drivers can veto the suspend whereas
> the "listeners" can't, and the apm driver wants to tell
> the listeners about the event only if it isn't vetoed.
> With your change, the apm driver really should ignore
> a veto from the drivers since it has already told the
> listeners about the event.  Therefore, while your patch
> is an improvement, it still isn't the whole solution.

I think it does perform acceptable behaviour however - if the drivers
(in the unlikely event) refuse the event after we've told user space,
we tell user space we resumed.

> One possible solution is for the apm driver first to _ask_
> the device drivers whether a suspend is allowed; then
> to tell the listeners; then to tell the device drivers
> to suspend.

What if the condition of the suspend gets changed by the act of paging
in memory, or some other change that occured in user space?  It's a
chicken and egg problem. 8(

> Actually, it's not true that the original code sends PM_SUSPEND
> each time a listener on /dev/apm_bios replies.  The code 
> fragment is:
>                 if (as->suspends_read > 0) {
>                         as->suspends_read--;
>                         as->suspends_pending--;
>                         suspends_pending--;
>                 } else if (!send_event(APM_USER_SUSPEND))
>                         return -EAGAIN;
>                 else
>                         queue_event(APM_USER_SUSPEND, as);
> This only calls send_event() if the ioctl(suspend) is NOT a
> reply to a notification that was earlier read from the queue.

It is a minor point, but an unwanted one that just obfuscates the operation
of the APM system - only the first PM SUSPEND event causes a change.

Sending 'n' PM_SUSPEND events because you have 'n' listeners on
/dev/apm_bios seems to be a waste of time when it could be handled
more cleanly.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

