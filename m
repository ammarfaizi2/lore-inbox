Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTIOJXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTIOJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:23:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52496 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261686AbTIOJXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:23:14 -0400
Date: Mon, 15 Sep 2003 10:23:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jamie Lokier <jamie@shareable.org>,
       Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier
Message-ID: <20030915102306.A22451@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Jamie Lokier <jamie@shareable.org>,
	Felipe W Damasio <felipewd@terra.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030914140839.GC16525@mail.jlokier.co.uk> <20030915054300.947EB2C290@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030915054300.947EB2C290@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Sep 15, 2003 at 01:41:30PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 01:41:30PM +1000, Rusty Russell wrote:
> ....hiding the subtlety in wrapper functions is the wrong approach.  We
> have excellent wait_event, wait_event_interruptible and
> wait_event_interruptible_timeout macros in wait.h which these drivers
> should be using, which would make them simpler, less buggy and
> smaller.

"smaller and simpler" hmm.  And _more_ buggy.  Let's take this case:

	add_wait_queue(&wq, &wait);
	for (;;) {
		set_current_state(TASK_INTERRUPTIBLE);
		if (condition)
			break;
		if (file->f_flags & O_NONBLOCK) {
			ret = -EAGAIN;
			break;
		}
		if (signal_pending(current)) {
			ret = -ERESTARTSYS;
			break;
		}
		schedule();
	}
	__set_current_state(TASK_RUNNING);
	remove_wait_queue(&wq, &wait);

There are cases like the above which make the wait_event*() macros
inappropriate:

- needing to test for extra conditions to set "ret" accordingly (eg,
  non-blocking IO)
- needing to atomically dequeue some data

I've yet to see anyone using wait_event*() in these circumstances -
they're great for your simple "did something happen" case which the
majority of drivers use, but there are use cases where wait_event*()
is not appropriate.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
