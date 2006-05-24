Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWEXRF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEXRF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEXRF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:05:57 -0400
Received: from www.osadl.org ([213.239.205.134]:60637 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751147AbWEXRF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:05:57 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Yann.LEPROVOST@wavecom.fr,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
References: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
Content-Type: text/plain
Date: Wed, 24 May 2006 19:06:14 +0200
Message-Id: <1148490374.5239.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 18:43 +0200, Esben Nielsen wrote:
> I am working on patchset dealing with this problem. It still needs clean
> up. The basic idea is to add a SA_MUSTTHREAD along with SA_NODELAY. Under
> PREEMPT_RT all interrupthandlers, which doesn't have SA_NODELAY, will get
> SA_MUSTTHREAD unless the driver is changed. In irq_request() it is checked
> if the handler has SA_NODELAY and an old has SA_MUSTTHREAD and visa
> versa.
> 
> I have also made a lock type which can be changed from rt_mutex to
> raw_spin_lock runtime. And I have made a system with a call-back from the
> irq-layer to the driver so they can change their spinlocks on the fly when
> needed.

That sounds scary. 

If you want your handler to be SA_NODELAY then you did this for a
reason. Simply refuse to share if the other device requests the
interrupt without SA_NODELAY.

A real solution for that problem needs more thought and the only thing
which comes to my mind is to have split handler functionality, which
allows to implement real cascaded interrupts. The short first stub would
just query, mask/ack the interrupt in the device and return the
appropriate information, so the real handler can be invoked at any given
time.

I know it would be a large pile of hacking, but it would be a clean
solution. OTOH it might be done gradually on a per driver base once the
basic infrastucture is in place.

	tglx


