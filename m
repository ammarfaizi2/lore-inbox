Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbSJMTuT>; Sun, 13 Oct 2002 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSJMTuT>; Sun, 13 Oct 2002 15:50:19 -0400
Received: from nameservices.net ([208.234.25.16]:20655 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261676AbSJMTuR>;
	Sun, 13 Oct 2002 15:50:17 -0400
Message-ID: <3DA9D0FC.B2BD34B8@opersys.com>
Date: Sun, 13 Oct 2002 16:01:00 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.41: Core infrastructure 1/3
References: <3DA5188A.D5436324@opersys.com> <20021013151520.A17134@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the feedback Christoph,

Here a couple of short replies:

Christoph Hellwig wrote:
> On Thu, Oct 10, 2002 at 02:04:58AM -0400, Karim Yaghmour wrote:
> > 1) We needed to define TRUE and FALSE for the tracer. A grep for
> > #define TRUE/FALSE in include/linux shows a few repeats. Shouldn't
> > these be globally defined somewhere?
> 
> No.  No core code uses it, and that's for a reason.  I suggest
> you simply use 1/0 instead.

OK,

> > +/* Structure packing within the trace */
> > +#if LTT_UNPACKED_STRUCTS
> who defines this?

OK, this is the second time the issues comes up, so I'll add the
following just above the #if:
/* Don't set this to "1" unless you really know what you're doing */
#define LTT_UNPACKED_STRUCTS 0

> But, yes, that looses some info.  When doing multi-line
> prototypes please at least use tabs and add the actual
> parameter names (like e.g. XFS does):
> 
> extern int trace_set_config(
>         int             do_depth,       /* Use depth to fetch eip */
>         int             do_bounds,      /* Use bounds to fetch eip */
>         int             depth,          /* Detph to fetch eip */
>         void            *lower,         /* Lower bound eip address */
>         void            *upper);        /* Upper bound eip address */
> 

OK.

> > +/* Generic function */
> > +static inline void TRACE_EVENT(u8 event_id, void* data)
> > +{
> > +     trace_event(event_id, data);
> > +}
> 
> Umm, why don't you just use trace_even in the actual code?

This macro is only there so that someone could insert a trace point like
this in his code:
 TRACE_EVENT(MY_ID, MY_DATA)

If trace_event() is used as-is in the code then the kernel fails to build
if tracing is disabled. If the macro is used, instead, then the kernel
builds fine and no code is added because the TRACE_EVENT() macro is:
#define TRACE_EVENT(ID, DATA)
when tracing is disabled.

Note that this macro is actually never used in the current patches. It's
only there for completeness. The actual macros being used are much more
specific (TRACE_FILE_SYSTEM(), TRACE_SCHECHANGE(), etc.)

...
> > +#define TRACE_EV_HEARTBEAT      22   /* Heartbeat event */
> 
> What about an enum?

Sure.

...
> > +#if defined (__i386__) || defined (__x86_64__)
> > +     if((using_tsc == TRUE) && cpu_has_tsc)
> > +             rdtscl(time_delta);
> > +     else {
> > +             do_gettimeofday(now);
> > +             time_delta = calc_time_delta(now, &buffer_start_time(cpu));
> > +     }
> > +#else
> > +     do_gettimeofday(now);
> > +     time_delta = calc_time_delta(now, &buffer_start_time(cpu));
> > +#endif
> > +
> > +     return time_delta;
> > +}
> 
> Instead of adding per-arch stuff here I'd suggest using asm/trace.h
> with an asm-generic/trace.h for the default version.

Yes. Actually we already do have asm/trace.h. We'll push those #if's in
there instead of having them in linux/trace.h.

Thanks again, the next update will include these changes.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
