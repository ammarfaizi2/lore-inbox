Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTANT6c>; Tue, 14 Jan 2003 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTANT6b>; Tue, 14 Jan 2003 14:58:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6661 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265140AbTANT63>; Tue, 14 Jan 2003 14:58:29 -0500
Date: Tue, 14 Jan 2003 20:07:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030114200719.B4077@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030113054708.GA3604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030113054708.GA3604@kroah.com>; from greg@kroah.com on Sun, Jan 12, 2003 at 09:47:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:47:09PM -0800, Greg KH wrote:
> In digging into the tty layer locking, I noticed that the tty layer
> doesn't handle module reference counting for any tty drivers.  Well, I've
> known this for a long time, just finally got around to fixing it :)
> Here's a patch against 2.5.56 that should fix this issue (works for
> me...)
> 
> Comments?  If no one objects, I'll send it on to Linus, and add support
> for this to a number of tty drivers that commonly get built as modules.

Firstly, I've proven my original suspicions about tty hangup wrong.
However, I'm concerned that we don't have sufficient locking present
(even in 2.4) to ensure that unloading tty driver modules is safe by
any means.

The first point where we obtain a driver structure is under the
BKL in tty_io.c:init_dev(), which calls get_tty_driver().
get_tty_driver() searches a list of drivers for the relevant
entry.  There are no locks here.

Now, consider tty_unregister_driver().  This is normally called from
a tty driver modules cleanup function.  Also note that there are no
locks here.

Also consider tty_register_driver() and note, again, that there are
no locks here.

Checking kernel/module.c, the BKL isn't held when calling the modules
init and cleanup functions.

So, all in all, we have a nice SMP race between loading tty driver
modules, unloading tty driver modules, and getting reference counts
on driver modules.

Since tty_register_driver() and tty_unregister_driver() are both
called from process context, the fix can be a semaphore.  However,
note carefully that any semaphore that can sleep in the open path
will drop the BKL and therefore could cause other races (wrt
driver->refcount?).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

