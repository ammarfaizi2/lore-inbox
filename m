Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWDKHup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWDKHup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWDKHup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:50:45 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:60363 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932333AbWDKHuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:50:44 -0400
Date: Tue, 11 Apr 2006 15:47:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
Message-ID: <20060411114753.GA1088@oleg>
References: <20060410174346.GA100@oleg> <20060411072722.0953A1809BB@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411072722.0953A1809BB@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Roland McGrath wrote:
>
> > So, de_thread() sets SIGNAL_GROUP_EXEC and sends SIGKILL to other thereads.
> > 
> > Sub-thread receives the signal, and calls get_signal_to_deliver->do_group_exit.
> > do_group_exit() calls zap_other_threads(SIGNAL_GROUP_EXIT) because there is no
> > SIGNAL_GROUP_EXIT set. zap_other_threads() notices SIGNAL_GROUP_EXEC, wakes up
> > execer, and changes ->signal->flags to SIGNAL_GROUP_EXIT.
> > 
> > de_thread() re-locks sighand, sees !SIGNAL_GROUP_EXEC and goes to 'dying:'.
> 
> That is what I intend.  The exec'ing thread backs out and processes its SIGKILL.
> It sounds like you are calling this scenario a problem, but I don't know why.

Oh, probably I missed something. But as I can see it, MT exec can never succeed!

Once again. Process starts exec, it has no pending signals. Execer thread sets
SIGNAL_GROUP_EXEC, sends SIGKILL to other threads, and waits them to die.
The first thread which dequeues SIGKILL will change SIGNAL_GROUP_EXEC to
SIGNAL_GROUP_EXIT, thus aborting exec.

Sorry for persistance if I really misunderstand this patch.

Oleg.

