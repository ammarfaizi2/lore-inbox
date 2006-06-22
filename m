Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWFVI3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWFVI3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWFVI3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:29:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40971 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964912AbWFVI3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:29:52 -0400
Date: Thu, 22 Jun 2006 09:29:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060622082939.GA25212@flint.arm.linux.org.uk>
Mail-Followup-To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20060613192829.3f4b7c34@home.brethil> <20060614152809.GA17432@flint.arm.linux.org.uk> <20060620161134.20c1316e@doriath.conectiva> <20060620193233.15224308.zaitcev@redhat.com> <20060621133500.18e82511@doriath.conectiva> <20060621164336.GD24265@flint.arm.linux.org.uk> <20060621181513.235fc23c@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621181513.235fc23c@doriath.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:15:13PM -0300, Luiz Fernando N. Capitulino wrote:
> On Wed, 21 Jun 2006 17:43:36 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> | In the uart_update_mctrl() case, the purpose of the locking is to
> | prevent two concurrent changes to the modem control state resulting
> | in an inconsistency between the hardware and the software state.  If
> | it's provable that it is always called from process context (and
> | it isn't called from a lock_kernel()-section or the lock_kernel()
> | section doesn't mind a rescheduling point being introduced there),
> | there's no problem converting that to a mutex.
> 
>  Ok, then I can submit my debug patch to answer these questions.
> 
>  might_sleep() can catch the lock_kernel()-section case right?
> 
> | With get_mctrl(), the situation is slightly more complicated, because
> | we need to atomically update tty->hw_stopped in some circumstances
> | (that may also be modified from irq context.)  Therefore, to give
> | the driver a consistent locking picture, the spinlock is _always_
> | held.
> 
>  Is it too bad (wrong?) to only protect the tty->hw_stopped update
> by the spinlock? Then the call to get_mctrl() could be protected by
> a mutex, or is it messy?

Consider this scenario with what you're proposing:

	thread				irq

	take mutex
	get_mctrl
					cts changes state
					take port lock
					mctrl state read
					tty->hw_stopped changed state
					release port lock
	releaes mutex
	take port lock
	update tty->hw_stopped
	release port lock

Now, tty->hw_stopped does not reflect the hardware state, which will be
buggy and can cause a loss of transmission.

I'm not sure what to suggest on this one since for USB drivers you do
need to be able to sleep in this method... but for UARTs you must not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
