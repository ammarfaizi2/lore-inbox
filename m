Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTEQXh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTEQXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 19:37:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37806
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261890AbTEQXh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 19:37:58 -0400
Date: Sun, 18 May 2003 01:50:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dak@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030517235048.GB1429@dualathlon.random>
References: <x54r3tddhs.fsf@lola.goethe.zz> <20030517174100.GT1429@dualathlon.random> <x5r86x74ci.fsf@lola.goethe.zz> <20030517203045.GZ1429@dualathlon.random> <x565o9717j.fsf@lola.goethe.zz> <20030517215345.GA1429@dualathlon.random> <x53cjd5hf6.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x53cjd5hf6.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 12:37:01AM +0200, David Kastrup wrote:
> Of course it does.  I told it to do so.  But there is no necessity to
> do an immediate context switch: it would be completely sufficient if
> Emacs (which is waiting on select) were put in the run queue and
> scheduled when the time slice of dd was up.  Performance gets better

the switch happens because emacs has higher dynamic priority, as it was
sleeping for the longest time. without these special cases for the
interactive tasks we couldn't use these long timeslices without making
the system not responsive.

> (like garbage collection) and gets preempted outside of the select
> system call, and only _then_ can dd fill the pipe in a whiff.
> 
> > This has nothing to do with emacs, this is about dd writing 1 char
> > at time. If you don't write 1 char at time, emacs won't read 1 char
> > at time.
> 
> But if I am doing process communication with other processes, the I/O
> _will_ arrive in small portions, and when the generating processes are
> running on the same CPU instead of being I/O bound, I don't stand a
> chance of working efficiently, namely utilizing the pipes, if I do a

writing 1 byte per syscall isn't very efficient in the first place (no
matter if the cxt switch happens or not).

I see what you mean, but I still don't think it is a problem. If
bandwidth matters you will have to use large writes and reads anyways,
if bandwidth doesn't matter the number of ctx switches doesn't matter
either and latency usually is way more important with small messages.

you're applying small messages to a "throughput" test, this is why you
have a problem. If you really did interprocess communication (and not a
throughput benchmark) you would probably want the smallest delay in the
delivery of the signal/message.

Andrea
