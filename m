Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVHVWfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVHVWfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVHVWe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53386 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751473AbVHVWe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:27 -0400
Date: Mon, 22 Aug 2005 09:13:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] race condition with drivers/char/vt.c (bug in vt_ioctl.c)
Message-ID: <20050822071330.GA18456@elte.hu>
References: <1124508087.18408.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124508087.18408.79.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I googled a little and found where this may have already happened in 
> the main line kernel:
> 
> http://seclists.org/lists/linux-kernel/2005/Aug/1603.html
> 
> So here's my proposal: 
> 
>   Instead of checking for tty->count == 1 in con_open, which we see is
> not reliable.  Just check for tty->driver_data == NULL.
> 
> This should work since it should always be NULL when we need to assign 
> it.  If we switch the events of the race, so that the init_dev went 
> first, the driver_data would not be NULL and would not need to be 
> allocated, because after init_dev tty->count would be greater than 1 
> (this is assuming the case that it is already allocated) and the 
> con_close would not deallocate it.  The tty_sem and console_sem and 
> order of events protect the tty->driver_data but not the tty->count.
> 
> Without the patch, I was able to get the system to BUG on bootup every 
> other time.  With the patch applied, I was able to bootup 6 out of 6 
> times without a single crash.

cool fix. I'm wondering, there's a whole lot of other 'tty->count == 1' 
checks in drivers/char/*.c, could some of those be racy too?

	Ingo
