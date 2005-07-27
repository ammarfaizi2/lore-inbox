Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVG0KNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVG0KNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVG0KKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:10:40 -0400
Received: from tim.rpsys.net ([194.106.48.114]:37004 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262189AbVG0KIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:08:47 -0400
Subject: Re: Should activate_page()/__set_page_dirty_buffers() use _irqsave
	locking?
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050726113817.147cc074.akpm@osdl.org>
References: <1122375384.7642.15.camel@localhost.localdomain>
	 <20050726113817.147cc074.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 11:08:33 +0100
Message-Id: <1122458914.7773.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 11:38 -0700, Andrew Morton wrote:
> Richard Purdie <rpurdie@rpsys.net> wrote:
> >
> > I've been experimenting with oprofile on an arm system without a PMU.
> > Whenever I enable callgraphing I see a BUG from run_posix_cpu_timers()
> > due to irqs being enabled when they should be disabled.
> > 
> > Tracing this back shows interrupts are enabled after the arm backtrace
> > code completes. Further tracing reveals its the call to
> > check_user_page_readable() (within an interrupt) that is causing the
> > problem.
> > 
> > Both the arm and i386 backtrace code would seem to be vulnerable to this
> > problem.
> 
> ow, yes, ug.
> 
> check_page_readable() won't actually call set_page_dirty() because it
> passes in `write = 0'.  So it should be sufficient to use
> spin_lock_irqsave() in mark_page_accessed().
> 
> But then again, that's fragile and obscure and it isn't even correct: if
> someone calls check_page_readable(), that doesn't imply an actual read of
> the page's contents.
> 
> So how about we add a new flag to __follow_page() telling it whether to
> consider this as an access to the page contents?

The patch looks good to me, I've tested it (on arm) and it all seems to
work. I'm happy :).

Thanks,

Richard

