Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVANTNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVANTNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVANTL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:11:56 -0500
Received: from thunk.org ([69.25.196.29]:59546 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261993AbVANTLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:11:02 -0500
Date: Fri, 14 Jan 2005 14:10:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050114191056.GB17481@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41E7509E.4030802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E7509E.4030802@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:54:54PM -0800, Ulrich Drepper wrote:
> The /dev/urandom device is advertised as always returning the requested 
> number of bytes.  Yet, it fails to do this under some situations. 
> Compile this
> 
> Note the -pg at the end to enable profiling.  Running this code fails 
> for me after less than a second.
> 
> The relevant code in the kernel is this 
> (drivers/char/random.c:extract_entropy)
> 
>         while (nbytes) {
>                 /*
>                  * Check if we need to break out or reschedule....
>                  */
>                 if ((flags & EXTRACT_ENTROPY_USER) && need_resched()) {
>                         if (signal_pending(current)) {
>                                 if (ret == 0)
>                                         ret = -ERESTARTSYS;
>                                 break;
>                         }
> 
> 
> Here the loop is left prematurely if a signal is pending.

The problem is that the code doesn't have the code to support
restartable system calls, so it only returns ERESTARTSYS if the nuber
bytes generated is zero.  What we should do is implement the full
restartable system calls, such that whether or not /dev/urandom
returns a short read is dependent on whether or not SA_RESTART is
passed to the sigaction() system call.  

Yeah, /dev/urandom was advertised as "always" returning the requested
number of bytes, but that was always an informal description, not a
formal one --- such as for example documented behavioiur of SA_RESTART
in sigaction().  So I believe the correct approach is to make
/dev/urandom honor the SA_RESTART flag, and then change the
documentation to match.  This is a bit of a compromise between "always
returning" and the current "never returning" behaviour.

What do you think?  Does gcc -pg calls sigaction with SA_RESTART, to
avoid changing the behaviour of the programs that it is profiling?  If
so, it would allow the program to work, while also being much more
consistent.  The flip side is that if there are programs that blindly
read from /dev/urandom for reading without checking its return count,
they could still lose, if their program had any signal handlers that
used System V semantics.  I'm not aware of any such programs, but they
certainly could exist.

						- Ted
