Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUGAPt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUGAPt1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUGAPt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:49:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:13719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265946AbUGAPt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:49:26 -0400
Date: Thu, 1 Jul 2004 08:49:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <200407010706.i6176pTa019793@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0407010843450.11212@ppc970.osdl.org>
References: <200407010706.i6176pTa019793@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Roland McGrath wrote:
> 
> > .. since this information should be available anyway (we'll have woken up 
> > the tracer, and the tracer will see that the child is gone by simply 
> > seeing the ESRCH errorcode from ptrace).
> 
> When did you wake up the tracer?  I don't see how that happened.

exit_notify() will inform the tracer:

        if (tsk->exit_signal != -1 && thread_group_empty(tsk)) {
                int signal = tsk->parent == tsk->real_parent ? tsk->exit_signal : SIGCHLD;
                do_notify_parent(tsk, signal);
        } else if (tsk->ptrace) {
***             do_notify_parent(tsk, SIGCHLD);   *****
        }

so this should catch it. It even gets the pid of the child in the siginfo 
structure if it really wants to see that..

		Linus
