Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTE3RJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTE3RJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:09:52 -0400
Received: from [196.25.143.130] ([196.25.143.130]:8976 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id S263817AbTE3RJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:09:50 -0400
Date: Fri, 30 May 2003 19:22:40 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: Kendrick Hamilton <hamilton@sedsystems.ca>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Problem Installing Linux Kernel Module compiled with gcc-3.2.x
Message-ID: <20030530192240.A7564@prism.co.za>
References: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not *exactly* on-topic for gcc@gcc.gnu.org I suppose, but here goes.

[Cc'ed to linux-kernel@vger.kernel.org]

On Fri, May 30, 2003 at 09:26:51AM -0600, Kendrick Hamilton wrote:
> 	I have a module for a custom developped PCI card. The device 
> driver is written for the Linux 2.4 series kernels. When I build the 
> module and the Linux kernel with gcc-2.95.3, the module installs 
> correctly. When I build the module and the Linux kernel with gcc-3.2.3 
> (also other gcc-3.2.x), the module installs but the Linux kernel crashes 
> in random places outside of the module. Do you have any suggestions of 
> what to look for? I can email you the complete module source code. I have 
> not tried gcc-3.3 because I cannot compile the current Linux kernel with 
> it (there is a known bug that is being fixed and should be out in 
> Linux-2.4.21).

Been there, done that, got the T-shirt.  I was lucky: while my module
installed, it broke in a fairly harmless way.  (It just didn't work; it
didn't screw with my system.)

If you look at linux/include/linux/spinlock.h, you'll see:

/*
 * Your basic spinlocks, allowing only a single CPU anywhere
 *
 * Most gcc versions have a nasty bug with empty initializers.
 */
#if (__GNUC__ > 2)
  typedef struct { } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
#else
  typedef struct { int gcc_is_buggy; } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
#endif

There are a couple of spinlock_t's (directly or through other structs) in
the task_struct.  So when your module accesses parts of the "current"
task_struct beyond the first spinlock_t, you better hope it's reading and
not writing (which was the case with my module).

I bet your module modifies "current".

Hmm, actually I thought the kernel had a mechanism to prevent a GCC 3.x
module from being loaded into a GCC 2.x kernel and vice versa?
