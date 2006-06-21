Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWFUQno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFUQno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFUQno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:43:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53261 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932250AbWFUQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:43:43 -0400
Date: Wed, 21 Jun 2006 17:43:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060621164336.GD24265@flint.arm.linux.org.uk>
Mail-Followup-To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20060613192829.3f4b7c34@home.brethil> <20060614152809.GA17432@flint.arm.linux.org.uk> <20060620161134.20c1316e@doriath.conectiva> <20060620193233.15224308.zaitcev@redhat.com> <20060621133500.18e82511@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621133500.18e82511@doriath.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:35:00PM -0300, Luiz Fernando N. Capitulino wrote:
> On Tue, 20 Jun 2006 19:32:33 -0700
> Pete Zaitcev <zaitcev@redhat.com> wrote:
> 
> | On Tue, 20 Jun 2006 16:11:34 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> | 
> | >  Pete, was it your original idea to completely move from the spinlock
> | > to a mutex?
> | 
> | I thought it was the cleanest solution. But perhaps I miss something.
> | I'll look at your reposted patch again, maybe it's all right as it is.
> 
>  Actually, that's the best solution from the USB-Serial's POV.
> 
>  The problem is that several serial drivers uses the uart_port's
> spinlock to implement their own locking, and some of them acquires the
> lock in its interrupt handler...
> 
>  Sh*t.

It all depends what you are locking.

In the uart_update_mctrl() case, the purpose of the locking is to
prevent two concurrent changes to the modem control state resulting
in an inconsistency between the hardware and the software state.  If
it's provable that it is always called from process context (and
it isn't called from a lock_kernel()-section or the lock_kernel()
section doesn't mind a rescheduling point being introduced there),
there's no problem converting that to a mutex.

I suspect that it needed to be a spinlock back in the days when
the low latency mode directly called into the ldisc, which could
then call back into the driver again from interrupt mode.

With get_mctrl(), the situation is slightly more complicated, because
we need to atomically update tty->hw_stopped in some circumstances
(that may also be modified from irq context.)  Therefore, to give
the driver a consistent locking picture, the spinlock is _always_
held.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
