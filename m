Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWEXSBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWEXSBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEXSBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:01:04 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:10325 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751044AbWEXSBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:01:02 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: tglx@linutronix.de
Cc: Esben Nielsen <simlo@phys.au.dk>, Steven Rostedt <rostedt@goodmis.org>,
       Yann.LEPROVOST@wavecom.fr, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148490374.5239.81.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
	 <1148490374.5239.81.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Date: Wed, 24 May 2006 11:00:25 -0700
Message-Id: <1148493625.17131.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 19:06 +0200, Thomas Gleixner wrote:
> On Wed, 2006-05-24 at 18:43 +0200, Esben Nielsen wrote:
> > I am working on patchset dealing with this problem. It still needs clean
> > up. The basic idea is to add a SA_MUSTTHREAD along with SA_NODELAY. Under
> > PREEMPT_RT all interrupthandlers, which doesn't have SA_NODELAY, will get
> > SA_MUSTTHREAD unless the driver is changed. In irq_request() it is checked
> > if the handler has SA_NODELAY and an old has SA_MUSTTHREAD and visa
> > versa.
> > 
> > I have also made a lock type which can be changed from rt_mutex to
> > raw_spin_lock runtime. And I have made a system with a call-back from the
> > irq-layer to the driver so they can change their spinlocks on the fly when
> > needed.
> 
> That sounds scary. 
> 

> If you want your handler to be SA_NODELAY then you did this for a
> reason. Simply refuse to share if the other device requests the
> interrupt without SA_NODELAY.
> 

This is apparently difficult with COTS hardware in some cases.

> A real solution for that problem needs more thought and the only thing
> which comes to my mind is to have split handler functionality, which
> allows to implement real cascaded interrupts. The short first stub would
> just query, mask/ack the interrupt in the device and return the
> appropriate information, so the real handler can be invoked at any given
> time.
> 
> I know it would be a large pile of hacking, but it would be a clean
> solution. OTOH it might be done gradually on a per driver base once the
> basic infrastucture is in place.
> 

The problem with the per-driver approach to porting, is that this is
only possible if you have a limited (known) number of devices in your
system.

There is code which promotes any IRQ shared with SA_NODELAY to
SA_NODELAY, and at least on PCI, that is where you get cascading
collisions between the drivers that have been adapted with the ones that
have not. 

Sven

> 	tglx
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
2901 Patrick Henry Drive, Suite 150
Santa Clara, CA 95054-1831 
 
Direct: 408.572.7870
Main: 408.572.8000
Fax: 408.572.8005

www.mvista.com
Platform To Innovate
*********************************** 

