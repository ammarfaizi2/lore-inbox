Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVISXew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVISXew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVISXew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:34:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932654AbVISXew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:34:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
In-Reply-To: Linus Torvalds's message of  Monday, 19 September 2005 12:14:54 -0700 <Pine.LNX.4.58.0509191206040.2553@g5.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Mendacious eruption lips
   (2) Lousy brunch money
   (3) Static dissident sodium excitements
Message-Id: <20050919233440.AC5D8180E1D@magilla.sf.frob.com>
Date: Mon, 19 Sep 2005 16:34:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The test program is buggy.  Here is one clue:

	elm3b29:~ # strace -p 30023
	Process 30023 attached - interrupt to quit
	futex(0x2aaaaaddf118, FUTEX_WAIT, 2, NULL

It's not anywhere near wait4.  It's deadlocked in the rand() call inside
rand_delay, called from sigchld_handler.  You cannot safely call rand
inside a signal handler, for exactly this reason.  The signal came during
another rand call and attempted to reenter.  If this sort of deadlock is
the failure mode of your real-world case, then it is probably an
application bug.  If this deadlock is just a mistake in your test program
here, then you'll need to give us a corrected test program to pursue
whatever real kernel issue you may have.


Thanks,
Roland
