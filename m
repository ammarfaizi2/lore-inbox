Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSL0LWk>; Fri, 27 Dec 2002 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSL0LWk>; Fri, 27 Dec 2002 06:22:40 -0500
Received: from almesberger.net ([63.105.73.239]:58891 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264885AbSL0LWj>; Fri, 27 Dec 2002 06:22:39 -0500
Date: Fri, 27 Dec 2002 08:30:47 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Anomalous Force <anomalous_force@yahoo.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: holy grail
Message-ID: <20021227083047.B1406@almesberger.net>
References: <20021227010338.A1406@almesberger.net> <20021227072142.26177.qmail@web13208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227072142.26177.qmail@web13208.mail.yahoo.com>; from anomalous_force@yahoo.com on Thu, Dec 26, 2002 at 11:21:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anomalous Force wrote:
> what if the new kernel asked the old kernel to hand over the data in
> a form that was understood universally beginning at some kernel
> version X (earliest supported kernel in other words).

Yes, and that information would ideally just be what is visible
from user space. This gives you a well-defined abstraction, and
limits the dependency on kernel internals.

> im thinking of something along the lines of a data packet (tcp/ip
> comes to mind) that contains data about its data.

I guess you never looked at how much state TCP really carries
around :-) For a rough idea, you may want to have a look at
tcpcp (TCP Connection Passing), which does pretty much what you'd
have to do for this kind of checkpointing:
http://www.almesberger.net/tcpcp/

Now, there are a few things to consider:

 - tcpcp ignores several rare conditions, such as urgent mode
 - tcpcp doesn't even try (yet) to preserve congestion control
   information, which is about twice the current amount of
   information again
 - even with all those constraints, there are almost certainly
   some things I've overlooked
 - that's only TCP, i.e. one of several networking protocols. And
   networking is just one of many subsystems. And what tcpcp does
   is not even transparent to applications.
 - while TCP is certainly not trivial, there is a reasonably well
   defined abstraction of its state, which simplifies this kind of
   checkpointing

And remember, this is still only about what can be seen from user
space. No attempt is made to transplant timers, memory allocations,
cloned skbs, etc.

> yes, it would be extremely difficult. but, as with all fields of
> endevour, a holy grail is only such because it is. the question
> remains, is this do-able? perhaps not now, or in two years, but
> what about five? say, kernel 3.x.x or even 4.x.x?

For full direct kernel-to-kernel migration, I'm fairly confident
the answer is "never", simply because it doesn't make sense, and
because it would be completely unmaintainable (1,2). (I expect to
see some information passing for things like IDE or SCSI bus scan
results, though.)

(1) Okay, I'll reverse my prognosis when we've had, say, ten new
    kernels in a row, without any obvious major bugs or build
    problems :-)
(2) If you dig out IFS, you'll see a nice example of why you
    don't want to create too many dependencies on kernel
    internals :-) http://www.almesberger.net/epfl/ifs.html

For userspace-to-userspace, we can probably do some things already
today (e.g. "classical" batch jobs), and I guess we might be able
to migrate reasonably complete systems in maybe one or two years,
if somebody starts working on the corner cases that aren't of much
interest for process migration (e.g. video, audio, etc.).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
