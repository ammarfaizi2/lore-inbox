Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRCWPzo>; Fri, 23 Mar 2001 10:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRCWPzf>; Fri, 23 Mar 2001 10:55:35 -0500
Received: from www.microgate.com ([216.30.46.105]:12556 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S131191AbRCWPzW>; Fri, 23 Mar 2001 10:55:22 -0500
Message-ID: <003101c0b3b1$976fe550$013ca8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Andrew Morton" <andrewm@uow.edu.au>, "Kevin Buhr" <buhr@stat.wisc.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>	<15027.20462.682109.679714@argo.linuxcare.com.au>	<vbasnkblsvd.fsf@mozart.stat.wisc.edu>	<15034.53871.560040.366149@argo.linuxcare.com.au>,	Paul Mackerras's message of "Fri, 23 Mar 2001 15:34:55 +1100 (EST)" <vbalmpxyo7n.fsf@mozart.stat.wisc.edu> <3ABB2B4B.93515581@uow.edu.au>
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
Date: Fri, 23 Mar 2001 09:54:49 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew Morton" <andrewm@uow.edu.au>

> Your analysis is correct.  It's a bug.
> 
> Furthermore, n_hdlc_tty_open() (for example) can sleep prior to
> incrementing the module refcount, which means the module can be
> unloaded while it's running.  I cut a patch ages ago which fixes
> this one for both ttys and ldiscs.  I never got around to sending
> it to anyone.
> 
> > Does this mean that all line discipline implementations must use a
> > spinlock around critical code in "open", "close", and every other line
> > discipline function?  It looks like they must, and it looks like most
> > don't right now.

I have experienced essentially the same problem:
A line discipline can be switched while a user mode program is blocked
inside of a line discipline call.

In my case the call was ioctl() (select) which went through the ldisc
(n_hdlc) and was being serviced by (and blocked in) the tty layer. 

Two processes had the underlying serial device open. One process
restored the ldisc to N_TTY, exited, and the script that started
the process unloaded the ldisc driver (which had
a zero ref count as a result of being switched out).
When the select call of the other process tried to return
(to the n_hdlc ldisc), the code was already unloaded and an
oops occurred.

I was not too worried about this because it was caused by
a series of wrong (buggy) moves by the user mode processes.

But it goes back to the problem of allowing the ldisc to
change when there are existing calls blocked in (or through)
the ldisc. 

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


