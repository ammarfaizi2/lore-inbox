Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319316AbSIGCzU>; Fri, 6 Sep 2002 22:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319325AbSIGCzU>; Fri, 6 Sep 2002 22:55:20 -0400
Received: from nameservices.net ([208.234.25.16]:2993 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S319316AbSIGCzS>;
	Fri, 6 Sep 2002 22:55:18 -0400
Message-ID: <3D796C80.C6A0E76C@opersys.com>
Date: Fri, 06 Sep 2002 23:03:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] 1/8 LTT for 2.5.33: Core infrastructure
References: <3D792919.C40A2F02@opersys.com> <20020907022848.A25996@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> On Fri, Sep 06, 2002 at 06:15:53PM -0400, Karim Yaghmour wrote:
> > +endif
> > +
> > +ifdef CONFIG_TRACE
> > +obj-y += trace.o
> >  endif
> 
> Please try to understand 2.4/2.5-style Makefile first.

Sure, I've been trying to replace this statement for a while, but I
haven't found an equivalent elsewhere (thought that doesn't mean
I haven't missed it; in which case I'd gladly be shown wrong). The
problem is that whether you set tracing as 'y' or 'm', then core
infrastructure has to be 'y'. The alternative is to add a "core
infrastucture" configuration item that can only be 'y' or 'n'. This,
however, implies the possibility of having the infrastructure without
the driver. I chose not to go down that path because of criticism in
the likes of your other e-mail:
> Umm, after LSM we get another bunch of totally undefined hooks??

"undefined" is really a stretch. All trace statements are clearly
marked as "TRACE_XYZ". Also, contrary to LSM, trace statements don't
influence the kernel's decisions in any way. For all practical
purposes, they only act as informational markers. In other words,
their use to tap into the kernel's behavior is limited, to say
the least.

> > +/* Structure packing within the trace */
> > +#if LTT_UNPACKED_STRUCTS
> > +#define LTT_PACKED_STRUCT
> > +#else                                /* if LTT_UNPACKED_STRUCTS */
> > +#define LTT_PACKED_STRUCT __attribute__ ((packed))
> > +#endif                               /* if LTT_UNPACKED_STRUCTS */
> 
> I can't see anything defining LTT_UNPACKED_STRUCTS in this patch.

True, and it's done on purpose to avoid having people setting this
unless they really know what they're doing. But if it is preferable,
then adding a "#define LTT_UNPACKED_STRUCTS 0" is not a problem.
Any preference?

> > +int unregister_tracer
> > + (tracer_call /* The tracer function */ );
> 
> Did you ever read Documentation/CodingStyle?

Yes I did. It just hasn't sinked-in totally yet because old habits die
hard. So help me out here, which part of it am I violating from your
point of view:
- Commenting
- Indenting
- Formating
-?

I'm known for having heavily commented code (because that's the way I
like code), so I'd guess it's the first. If it is, then deleting some
of it isn't really a problem.

> It would be helpful if you explain what exactly this patch doesm btw.
> It's not really obvious from the the patch.

I assumed people are fimiliar with what LTT (the Linux Trace Toolkit) is.
So here's for those who haven't heard about LTT before:

The core tracing infrastructure serves as the main rallying point for
all the tracing activity in the kernel. (Tracing here isn't meant in
the ptrace sense, but in the sense of recording key kernel events along
with a time-stamp in order to reconstruct the system's behavior post-
mortem.) Whether the trace driver (which buffers the data collected
and provides it to the user-space trace daemon via a char dev) is loaded
or not, the kernel sees a unique tracing function: trace_event().
Basically, this provides a trace driver register/unregister service.
When a trace driver registers, it is forwarded all the events generated
by the kernel. If no trace driver is registered, then the events go
nowhere.

In addition to these basic services, this patch allows kernel modules
to allocate and trace their own custom events. Hence, a driver can
create its own set of events and log them part of the kernel trace.
Many existing drivers who go a long way in writing their own trace
driver and implementing their own tracing mechanism should actually
be using this custom event creation interface. And again, whether the
trace driver is active or even present makes little difference for
the users of the kernel's tracing infrastructure.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
