Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTDVE1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 00:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbTDVE1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 00:27:08 -0400
Received: from opersys.com ([64.40.108.71]:9481 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262908AbTDVE1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 00:27:06 -0400
Message-ID: <3EA4C65C.25B5C16E@opersys.com>
Date: Tue, 22 Apr 2003 00:34:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: [patch] printk subsystems
References: <A46BBDB345A7D5118EC90002A5072C780C263836@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Perez-Gonzalez, Inaky" wrote:
> > From: Tom Zanussi
> > relayfs actually uses 2 mutually-exclusive schemes internally -
> > 'lockless' and 'locking', depending on the availability of a cmpxchg
> > instruction (lockless needs cmpxchg).  If the lockless scheme is being
> > used, relay_lock_channel() does no locking or irq disabling of any
> > kind i.e. it's basically a no-op in that case.
>
> So that means you are using cmpxchg to do the locking. I mean, not the
> "locking" itself, but a similar process to that of locking. I see.
> 
> However, isn't it the almost the same as spinlocking? You are basically
> trying to "allocate" a channel idx with atomic cmpxchg; if it fails, you
> are retrying, spinning on the retry code until successful.
> 
> Not meaning to be an smartass here, but I don't buy the "lockless" tag,
> I would agree it is an optimized-lock scheme [assuming it works better
> than the spinlock case, that I am sure it does because if not you guys
> would have not gone through the process of implementing it], but it is
> not lockless.
> 
> Although it is not that important, no need to make a fuss out of that :)

I actually think this is important.

The meaning of "lockless" becomes quite clear when both relayfs logging
schemes are compared. In the locking scheme, one of the following must
be used:
local_irq_save()
spin_lock_irqsave()

[They "must" be used because the relay_write() function could be called
from within an interrupt handler and the only safe way to manipulate
buffers that are accessible in read-write both to interrupt handlers
and other code is to disable interrupts in one way or another.]

Both of these disable interrupts on the local processor (actually,
spin_lock_irqsave() has a local_irq_save() inside it.)

With the cmpxchg, there is no interrupt disabling whatsoever. The code tries
to allocate some space, and retries if it fails. The most likely reason
it may fail is in the case when an interrupt occurs and that interrupt's
handler tries and succeeds in allocating space in the buffer instead of
the interrupted code. To the best of my memory, the tests we've done show
that the code very rarely has to try more than two or three times.

While the code does the loop once or twice, however, the processor is
free to continue handling interrupts. None of the code instances is
actively spining in waiting for another instance to relinquish a lock.
There is, indeed, no lock here to be acquired or to be waited on.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
