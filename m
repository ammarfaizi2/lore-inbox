Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWEXRbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWEXRbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWEXRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:31:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:12081 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932438AbWEXRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:31:52 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Yann.LEPROVOST@wavecom.fr,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
References: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Date: Wed, 24 May 2006 10:30:05 -0700
Message-Id: <1148491805.17131.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 18:43 +0200, Esben Nielsen wrote:
> On Wed, 24 May 2006, Steven Rostedt wrote:
> 
> > On Wed, 2006-05-24 at 10:06 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> > [...]
> >
> > Thomas or Ingo,
> >
> > Maybe the handling of IRQs needs to handle the case that shared irq can
> > have both a NODELAY and a thread.  The irq descriptor could have a
> > NODELAY set if any of the actions are NODELAY, but before calling the
> > interrupt handler (in interrupt context), check if the action is NODELAY
> > or not, and if not, wake up the thread if not done so already.
> >
> > thoughts?
> >
> 
> I am working on patchset dealing with this problem. It still needs clean
> up. The basic idea is to add a SA_MUSTTHREAD along with SA_NODELAY. Under
> PREEMPT_RT all interrupthandlers, which doesn't have SA_NODELAY, will get
> SA_MUSTTHREAD unless the driver is changed. In irq_request() it is checked
> if the handler has SA_NODELAY and an old has SA_MUSTTHREAD and visa
> versa.
> 

Its easy for some drivers to be divided into lockless portions, which
can run as SA_NODELAY. If these are kept short (minimum prevent the
device from re-asserting the IRQ once it is unmasked), then it should be
able to share certain devices on PCI, for example.

In a sense, this is how the drivers should be designed, 
but of course in practice its not always ideal...

> I have also made a lock type which can be changed from rt_mutex to
> raw_spin_lock runtime. And I have made a system with a call-back from the
> irq-layer to the driver so they can change their spinlocks on the fly when
> needed.
> 


Sven



