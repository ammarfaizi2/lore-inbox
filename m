Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbSLSCcI>; Wed, 18 Dec 2002 21:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbSLSCcI>; Wed, 18 Dec 2002 21:32:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:13300 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267578AbSLSCcG>;
	Wed, 18 Dec 2002 21:32:06 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA30@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	 state = (take 1)
Date: Wed, 18 Dec 2002 18:40:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > - any setting before a return should be barriered unless we 
> >   return to a place[s] known to be harmless
> 
> Not sure.

Well, I think it makes kind of sense. If we know we are
returning to some place where nothing bad could happen
with reordering ... well, so be it, don't use __set_...()
 
> > - any setting to TASK_RUNNING should be kind of safe
> 
> Yes, I agree.  It may race, but with what?

Hmmm ... I guess it could race, but it would not really
be that important [unless maybe certain constructs], as
the only setting it will go to would be [UN]INTERRUPTIBLE,
where it would be waken up afterwards, as it'd be out of the
rq, STOPPED, same thing, out of the rq, ZOMBIE or DEAD [gone].

I guess in this case, the only one I can come up with,
there would be an inconsistency between the actual state
of the task in task->state and the real one [or its position
in whatever rq or wq].

Could that have ugly consequences? I dunno ...

> > -		current->state = TASK_UNINTERRUPTIBLE;
> > +		__set_current_state(TASK_UNINTERRUPTIBLE);
> >  		spin_unlock_irq(&oldsig->siglock);
> > 
> >   Should be safe, as spin_unlock_irq() will do memory clobber
> >   on sti() [undependant from UP/SMP].
> 
> The memory clobber only acts as a compiler barrier and insures the
> compiler does not reorder the statements from the order in the C code.

while (1)
  printk ("Inaky, remember, clobber is a hint to gcc\n"); 

And that would now really work when CONFIG_X86_OOSTORE=1 is required
[after all, it is a write, so it'd need the equivalent of a wmb() or
xchg()]. 
Okay, changing that one too, just in case.


Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


