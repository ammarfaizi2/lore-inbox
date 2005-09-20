Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVITQuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVITQuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVITQuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:50:07 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7843 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932673AbVITQuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:50:06 -0400
Subject: Re: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050919233440.AC5D8180E1D@magilla.sf.frob.com>
References: <20050919233440.AC5D8180E1D@magilla.sf.frob.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 09:49:35 -0700
Message-Id: <1127234975.1586.41.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 16:34 -0700, Roland McGrath wrote:
> The test program is buggy.  Here is one clue:
> 
> 	elm3b29:~ # strace -p 30023
> 	Process 30023 attached - interrupt to quit
> 	futex(0x2aaaaaddf118, FUTEX_WAIT, 2, NULL
> 
> It's not anywhere near wait4.  It's deadlocked in the rand() call inside
> rand_delay, called from sigchld_handler.  You cannot safely call rand
> inside a signal handler, for exactly this reason.  The signal came during
> another rand call and attempted to reenter.  If this sort of deadlock is
> the failure mode of your real-world case, then it is probably an
> application bug.  If this deadlock is just a mistake in your test program
> here, then you'll need to give us a corrected test program to pursue
> whatever real kernel issue you may have.

Thank you for pointing out the problem with the testcase.

While running webserving benchmark (Zeus), we noticed that process is
not cleaning up its zombie childern. We end up with thousands of them
and eventually fork fails. Interesting thing to note in that case was,
moment we do strace -p <parent>, it suddenly seem to cleanup all its
zombie childern. I don't have access to the webserver source code, so we
tried the behaviour simulate it with a simple testcase. 

I will let you know, if I can come up with a *better* testcase to
reproduce the problem.

Thanks,
Badari

