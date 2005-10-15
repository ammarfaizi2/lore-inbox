Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVJOK1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVJOK1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJOK1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:27:31 -0400
Received: from mid-2.inet.it ([213.92.5.19]:47559 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S1750728AbVJOK1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:27:30 -0400
From: Gabriele Brugnoni <news@dveprojects.com>
Organization: DVE Progettazione Elettronica
To: linux-kernel@vger.kernel.org
Subject: Re: interruptible_sleep_on, interrupts and device drivers
Date: Sat, 15 Oct 2005 12:29:36 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510151229.37124.news@dveprojects.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> 
> don't.
> 
> interruptible_sleep_on() is a broken interface (see the comments in the
> header) and should not be used in any new code (where "new" is "since
> the year 2000" :)
> 
> Just use the wait_event() interfaces .... or just a simple semaphore
> even if what you want to do is simple and performance isn't too
> critical.
> 

OK, i'll not use, but the kernel has a lot of device drivers using it, that 
may present the problem explained in my message.

In my code i've try the following:

		save_flags(flags); cli();
		if( !rs.txdone ) {
			if( arg < 0 ) arg = rs.ttimeout;
			if( arg > 0 )
				interruptible_sleep_on_timeout ( &rs.txwait, arg );
			else
				interruptible_sleep_on ( &rs.txwait );
		}
		restore_flags(flags);
		return rs.txdone;

Before testing the flag, interrupt are closed and if the TX is not terminated, 
the interruptible_sleep_on_timeout will be called with interrupt DISABLED. 
This is not a problem, because the scheduler will switch to another process, 
and the new process will enable again the IRQ. When the scheduler will give 
back the control to my process, it will continue with interrupt disabled, and 
will be reenabled before exit.
This seems to work very fine.

Calling the waiting function with IRQ enabled may expose the device driver to 
the risk of infinite wait (until a signal, obvious).


Thanks
Gabriele

