Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVGOUbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVGOUbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGOUbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:31:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33548 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262001AbVGOUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:31:03 -0400
Date: Fri, 15 Jul 2005 21:30:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
Message-ID: <20050715213058.B23709@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050715082249.A23102@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com>; from karl@petzent.com on Fri, Jul 15, 2005 at 01:11:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:11:33PM -0700, karl malbrain wrote:
> > -----Original Message-----
> > From: Russell King
> > Sent: Friday, July 15, 2005 12:23 AM
> > To: karl malbrain
> > Cc: Linux-Kernel@Vger. Kernel. Org
> > Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
> >
> >
> > On Thu, Jul 14, 2005 at 04:50:00PM -0700, karl malbrain wrote:
> > > chrdev_open issues a lock_kernel() before calling uart_open.
> > >
> > > It would appear that servicing the blocking open request
> > uart_open goes to
> > > sleep with the kernel locked.  Would this shut down subsequent access to
> > > opening "/dev/tty"???
> >
> > No.  lock_kernel() is automatically released when a process sleeps.
> 
> Drilling down between the uart_open and chrdev_open into tty_open is a
> semaphore tty_sem that is being held during the sleep cycle in uart_open.

chrdev_open() calls tty_open(), which then calls init_dev().  init_dev()
takes tty_sem, does its stuff, and then releases tty_sem.  A little
later on, tty_open() calls the uart driver's uart_open() function.

So it does this with tty_sem unlocked.

> N.b. I don't pretend to understand how uart_change_pm, uart_startup, and
> uart_block_til_ready could ALL be on the call stack.  Uart_open calls them
> sequentially.  Perhaps you might explain how this works?  Thanks, karl m

The stack traces on x86 are very hap-hazard - the code just scans the
stack for anything which looks like it may be in kernel text and dumps
the result.  This means that stale words on the stack which may have
been return addresses at one time may still look like return addresses.

Don't believe everything you see in an x86 stacktrace!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
