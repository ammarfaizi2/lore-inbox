Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVJOK5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVJOK5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVJOK5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:57:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57611 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751104AbVJOK5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:57:32 -0400
Date: Sat, 15 Oct 2005 11:57:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gabriele Brugnoni <news@dveprojects.com>, linux-kernel@vger.kernel.org
Subject: Re: interruptible_sleep_on, interrupts and device drivers
Message-ID: <20051015105724.GC5724@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Gabriele Brugnoni <news@dveprojects.com>,
	linux-kernel@vger.kernel.org
References: <200510151229.37124.news@dveprojects.com> <1129372589.2908.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129372589.2908.8.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 12:36:29PM +0200, Arjan van de Ven wrote:
> On Sat, 2005-10-15 at 12:29 +0200, Gabriele Brugnoni wrote:
> > 		save_flags(flags); cli();
> 
> this is broken code; cli() cannot and should not be used. (and isn't
> even available on SMP kernels anymore)
> 
> > 		if( !rs.txdone ) {
> > 			if( arg < 0 ) arg = rs.ttimeout;
> > 			if( arg > 0 )
> > 				interruptible_sleep_on_timeout ( &rs.txwait, arg );
> > 			else
> > 				interruptible_sleep_on ( &rs.txwait );
> > 		}
> > 		restore_flags(flags);
> 
> and this is missing a sti()

Err, no, that's wrong.  sti() unconditionally enables interrupts - if
an sti() was placed here, it's pointless using save_flags() (which
saves the old interrupt enable state) and restore_flags() (which
restores the interrupt enable state).

Also remember that interruptible_sleep_* is only safe on UP machines
provided it's called with interrupts disabled.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
