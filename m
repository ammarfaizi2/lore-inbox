Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWFHBJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWFHBJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWFHBJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:09:09 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:19844 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932520AbWFHBJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:09:08 -0400
Date: Wed, 7 Jun 2006 21:09:06 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Re: Interrupts disabled for too long in printk
Message-ID: <20060608010906.GE21490@Krystal>
References: <20060603111934.GA14581@Krystal> <1149371028.13993.171.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1149371028.13993.171.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 20:55:08 up 33 days,  4:04,  2 users,  load average: 1.24, 1.33, 1.28
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

* Steven Rostedt (rostedt@goodmis.org) wrote:
> So what's the problem?
> 
> printk is more for debugging. If you don't like the latency then disable
> printks.

I have not seen many systems where printk is totally disabled : it is useful to
have a trace of the kernel messages somewhere. 

> But turning the spin_lock_irqsave into a spin_lock means you
> need to do a trylock every time in printk.  Since printk can be called
> from interrupt handlers.  So what do you do when you fail? just return?

Yes the idea is to return, leaving the data in the buffers and not transferring
it to the console driver. As there is already another execution thread in the
relase_console_sem loop, it will take care of the data in its next pass in the
loop.

> So you just lost your printk that you needed, which could be of
> importance.
> 
No, it is not lost.

> Actually, the spin_lock is not your problem, since it is not held when
> the console drivers are being called. But...
> 
irq disabling is the problem. And if this function stays with a standard
spin_lock (not a try lock), disabling interrupts is required.

> There may be console drivers that grab spin_locks without turning off
> interrupts, which mean that you can again deadlock if an interrupt that
> calls printk happens in one of those drivers.
> 
Wait.. the release_console_sem calls the console drivers with interrupts
already disabled. I do not understand your last statement.

> If latency is your worry, then try out Ingo Molnar's -rt patch
> http://people.redhat.com/mingo/realtime-preempt/
> It isn't affected by this problem.
> 

My main concern is more than just latency : missing 3 timer interrupts in a row
has an impact on the kernel time keeping. On systems where NTP is not available,
it can be important. Linux, if I remember well, deals with cases where one timer
interrupt is missed, but not 2. So, if we get one printk message on the console
each minute on a system at 100HZ, we will suffer of a 14.40s drift every day.


Mathieu


> -- Steve
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
