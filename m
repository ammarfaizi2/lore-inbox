Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265088AbUEUXCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbUEUXCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUEUWmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:42:02 -0400
Received: from zero.aec.at ([193.170.194.10]:5 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265950AbUEUWdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:03 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it>
	<1XWpp-zy-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 20 May 2004 16:53:11 +0200
In-Reply-To: <1XWpp-zy-9@gated-at.bofh.it> (Ingo Molnar's message of "Thu,
 20 May 2004 16:10:16 +0200")
Message-ID: <m3lljnnoa0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Ricky Beam <jfbeam@bluetronic.net> wrote:
>
>> It looks like somewhere in the path of release_console_sem() more than
>> one CPU is running the log. [...]
>
> the problem is this code in printk:
>
>         if (oops_in_progress) {
>                 /* If a crash is occurring, make sure we can't deadlock */
>                 spin_lock_init(&logbuf_lock);
>                 /* And make sure that we print immediately */
>                 init_MUTEX(&console_sem);
>         }
>
> so two crashes on two separate CPUs can go on in parallel. The problem
> is not constrained to the serial line - i've seen it on VGA too (albeit
> there it's much more rare).

One alternative way would be to use locks with timeouts for these two
locks (e.g. checking the TSC on x86, since the timer interrupt 
may not be running anymore) and only break the lock when the 
wait time is too long.

Of course serial lines can be quite slow so even that may not help
always (for unknown reasons far too many people use 9600 baud for 
their serial line) 

-Andi


