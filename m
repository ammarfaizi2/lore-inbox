Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264576AbSIVWdL>; Sun, 22 Sep 2002 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264577AbSIVWdL>; Sun, 22 Sep 2002 18:33:11 -0400
Received: from nameservices.net ([208.234.25.16]:55283 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264576AbSIVWdJ>;
	Sun, 22 Sep 2002 18:33:09 -0400
Message-ID: <3D8E470D.C76C459E@opersys.com>
Date: Sun, 22 Sep 2002 18:41:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209230021260.28641-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> +int trace_event(u8 pm_event_id,
> +               void *pm_event_struct)
> [...]
> +       read_lock(&tracer_register_lock);
> 
> ie. it's using a global spinlock. (sure, it can be made lockless, as other
> tracers have done it.)

It is, but this is separate from the trace driver. This global
spinlock is only used to avoid a race condition in the registration/
unregistration of the tracing function with the trace infrastructure.
The only case where the lock is taken in write mode is when a
tracer in being registered or unregistered (register_tracer() and
unregister_tracer()). Since tracing itself is NOT registeration/
unregistration intensive, there is no contention over this lock.

Any trace infrastructure that allows dynamic registration of tracers
needs this sort of lock in order to make sure that the function pointer
it has for the tracer is actually valid when it calls it. Of course if
the tracer itself was directly called from the inline trace statements,
then this would be a different story, but then the tracer has to be
in there all the time (which is exactly what happens with most, if
not all, the tracers already included in the kernel).

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
