Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263964AbRFELky>; Tue, 5 Jun 2001 07:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263965AbRFELkp>; Tue, 5 Jun 2001 07:40:45 -0400
Received: from lotus.ariel.com ([204.249.107.2]:36319 "EHLO cranmail.ariel.com")
	by vger.kernel.org with ESMTP id <S263964AbRFELkb>;
	Tue, 5 Jun 2001 07:40:31 -0400
From: "Arthur Naseef" <arthur.naseef@ariel.com>
To: <linux-kernel@vger.kernel.org>
Subject: TTY kernel crashes
Date: Tue, 5 Jun 2001 07:39:29 -0400
Message-ID: <OIBBKHIAILDFLNOGGFMNGEHJCBAA.arthur.naseef@ariel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running linux 2.2.14 with a 96-modem board and have been getting kernel
oops'es.  These generally only occur when I am running the system under constant
swapping conditions.

After much diagnosis, I have found the following sequence of events causes the
oops:

	- do_tty_hangup called for the TTY
		- ldisc.open() called for the TTY
		- ldisc.open blocks (probably waiting for memory)
	- tty_release called for the same TTY
		- release_dev() called
		- release_dev() completes
	- tty_release completes

I know that ldisc.open is blocking because I never see the message that
indicates it has completed.

Then the oops occurs:

	>>EIP; 205d3335 Before first symbol   <=====
	Trace; c01a6e20 <reset_buffer_flags+5c/64>
	Trace; c01a8632 <n_tty_open+82/b0>
	Trace; c01a4826 <do_tty_hangup+18a/294>
	Trace; c02161a0 <NR_TYPES+7c0/1620>
	Trace; c01131fe <tq_sched_kthread+52/70>
	Trace; c01fcf2a <tvecs+2d6/41ec>
	Trace; c011327e <tq_sched_kthread_start+62/6c>
	Trace; c01fcf40 <tvecs+2ec/41ec>
	Trace; c0106000 <get_options+0/78>
	Trace; c0108853 <kernel_thread+23/38>

Note that the tq_scheduler list is being run out of a kernel thread here instead
of being executed directly by schedule(); this was necessary to eliminate a
kernel panic.

Given this, how should this race condition be avoided?  It seems that the TTY
structure has a life outside its use in the file structure since hangups can
occur on the TTY at any time.  Would it make sense to break the strong
association between the TTY structures and the file handling?  Then, the file
interface could be a client of the TTY service, as would the driver when it
wants to propagate asynchronous events.

As such, each would then do its own "get" and "put" operations on the TTY
structures.

Also, is there a short-term solution that would prevent the problem?

-art

P.S. Please CC: me on replies.
