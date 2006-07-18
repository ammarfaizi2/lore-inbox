Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWGRKcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWGRKcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWGRKcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:32:03 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:59318 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932168AbWGRKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:32:01 -0400
In-Reply-To: <1153218278.3038.43.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091956.653901000@sous-sol.org> <1153218278.3038.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <da1d1533798a6bdb9930f6d59201aeab@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 27/33] Add the Xen virtual console driver.
Date: Tue, 18 Jul 2006 11:31:42 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2006, at 11:24, Arjan van de Ven wrote:

> hmm somehow I find this code scary; we had similar code recently
> elsewhere where this turned out to be a real issue; you now sleep for
> "1" time, so you sleep for a fixed time if you aren't getting wakeups,
> but if you are getting wakeups your code is upside down, I would expect
> it to look like
>
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	while (DRV(tty->driver)->chars_in_buffer(tty))
> +		schedule_timeout(1);
> +		if (signal_pending(current))
> +			break;
> +		if (timeout && time_after(jiffies, orig_jiffies + timeout))
> +			break;
> +		set_current_state(TASK_INTERRUPTIBLE);
> +	}
>
> instead, so that you don't have the wakeup race..

There's no wakeup signal, so no possibility of a wakeup race. That's 
why we schedule_timeout() instead of wait_event() or similar. This code 
is only used to flush the console when the kernel crashes, so we can 
get the full oops, so waiting a little bit too long is acceptable.

Your suggested change is perhaps more idiomatic though, and less 
jarring for reviewers. :-)

Thanks for your comments by the way. Reviewing lots of patches isn't 
much fun.

  -- Keir

