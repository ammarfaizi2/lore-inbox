Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUG1V4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUG1V4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUG1Vz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:55:59 -0400
Received: from opersys.com ([64.40.108.71]:37380 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265060AbUG1VzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:55:17 -0400
Message-ID: <41081F34.7080507@opersys.com>
Date: Wed, 28 Jul 2004 17:48:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Lee Revell <rlrevell@joe-job.com>, Scott Wood <scott@timesys.com>,
       Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IRQ threads
References: <20040727225040.GA4370@yoda.timesys> <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe> <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe> <20040728202107.GA6952@nietzsche.lynx.com>
In-Reply-To: <20040728202107.GA6952@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> With that said, there's really two camps that are emerging in the real
> time Linux field, dual and single kernel. The single kernel work that's
> current being done could very well get Linux to being hard RT, assuming
> that you solve all of the technical problems with things like RCU,
> etc... in 2.6.
> 
> The dual kernels folks would be in less of position to VAR their own
> stuff and sell proprietary products if Linux were to get native hard RT
> performance if you accept that economic criteria. Who knows what the
> actual results will be.

Two things:
- What I'm suggesting is a nanokernel-based N kernel scheme, not the
dual kernel scheme (which is patented BTW).
- There's only one company out there that is known to sell proprietary
products around the dual kernel approach, and it isn't mine.

> It could be that all of this work with Linux could bury prioprietary
> OS product (such as LynxOS here) or it could open doors to other things
> unknown things that were never possible previous to Linux getting some
> kind of hard RT capability. It's certainly a scary notion to think about
> with many variables to consider. Linux getting hard RT is inevitable.
> It's just a question of how it'll be handled by proprietary OS vendors,
> witness IBM for a positive example. A negative one would be Sun.
> 
> Now that Windriver System (the idiot folks that never understood Linux
> before laying off tons of folks and disbanned the rather famous BSD/OS
> group which I was apart of, etc...) and Red Hat is in the picture, it's
> all starting to cook up.

Indeed. So the question now becomes: is it worth introducing that much
complexity inside the kernel to solve a problem that matters only
marginally to server and workstation users? It's already difficult as it
is to manage the preemption, do we really want to go the full way with
threaded int handlers and mutexes instead of locks?

What I'm suggesting is a very simple model that solves 90% of the time-
sensitive problems I have seen with Linux: Use the Adeos nanokernel to
implement the real-time component of drivers as a priority domain the
interrupt pipeline. Hence, instead of the current driver model:
1- Int handler
2- BH/SoftIRQ/etc.
We get:
1- Hard-rt handler
2- Normal Linux handler
3- BH/SoftIRQ/etc.

This is even without any RTAI/RTL or anything of that kind.

And for the rest, then you want to have a look at Philippe Gerum's
ongoing RTAI-fusion work. With RTAI-fusion, you get the same normal
Linux ABI for all user-space tasks, but you get hard-rt for free.
Practically, normal Linux calls are caught and run through RTAI
instead of Linux. Philippe has already got the standard nanosleep()
running in hard-rt. So the question is therefore straight-forward:
should we engineer a path for converting the entire kernel to hard-rt
or do we keep the kernel as it was designed and add the necessary
mechanisms for obtaining hard-rt using things that were made to
provide it by design?

I personally believe that the added complexity does not benefit
Linux. I may yet be shown wrong, but with what we can currently do
with plain vanilla Adeos, and where RTAI/fusion is heading, the
problem space of applications which can't be serviced by this
combination is getting increasingly limited.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

