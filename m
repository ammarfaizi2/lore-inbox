Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270750AbRHSUmv>; Sun, 19 Aug 2001 16:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270758AbRHSUml>; Sun, 19 Aug 2001 16:42:41 -0400
Received: from colorfullife.com ([216.156.138.34]:5 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S270750AbRHSUmh>;
	Sun, 19 Aug 2001 16:42:37 -0400
Message-ID: <000701c128ef$876dcf60$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Peter T. Breuer\"" <ptb@it.uc3m.es>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: scheduling with io_lock held in 2.4.6
Date: Sun, 19 Aug 2001 22:42:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll check if IRQs are really masked (how?).

__save_flags() and check IIRC bit 9 - but I doubt that this is your
problem.

> But how on earth
> could somebody else release the IRQs on the same CPU while the io
> spinlock is held? We'd have to schedule once to allow somebody else to
> release IRQs first .. (infinite mental regress follows).

Backtraces contain stale functions from previous calls.

The first entry is always correct, then you must manually check that the
calls are possible, i.e.
> Trace; c011b548 <do_exit+3b4/3d4>
> Trace; c0107a38 <do_divide_error+0/9c>
> Trace; c0113683 <do_page_fault+3f3/510>
> Trace; c0113290 <do_page_fault+0/510>

either do_page_fault or do_divide_error are stale.
+0 means that someone pushed the function address on the stack - if a
function calls another function, then the offset is at least +6 on i386.

check if do_page_fault+3f3 actually calls do_exit, and if do_exit+3b4
calls exit_notify etc. Try clear all stale entries from the callchain.
Note that the address pushed is behind the call instruction, and call
instructions are usually 5 or 6 bytes long. Disassemble from +3d0 and
check the call.

And are you sure that schedule() was actually called from within an
interrupt? I don't see the do_IRQ()//handle_IRQ_event.

I bet it was a schedule() within spin_lock_bh().

> Even when I rebooted
> with noapic (I seem to recall). Booting back to 2.4.3 cured it.

Which network card do you use?
Networking is the main user of spin_lock_bh(), and since 2.4.4 zero-copy
networking is merged.


Good luck,
    Manfred

