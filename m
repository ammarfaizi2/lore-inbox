Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSGHSvC>; Mon, 8 Jul 2002 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSGHSvB>; Mon, 8 Jul 2002 14:51:01 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:34823 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S317081AbSGHSvA>; Mon, 8 Jul 2002 14:51:00 -0400
Message-ID: <3D29DCBC.5ADB7BE8@opersys.com>
Date: Mon, 08 Jul 2002 14:41:00 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: John Levon <levon@movementarian.org>, Andrew Morton <akpm@zip.com.au>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> On Mon, 8 Jul 2002, John Levon wrote:
> > How do you see such dentry names being exported to user-space for the
> > profiling daemon to access ? The current oprofile scheme is, um, less
> > than ideal ...
> 
> Ok, I'll outline my personal favourite interface, but I'd also better
> point out that while I've thought a bit about what I'd like to have and
> how it could be implemented in the kernel, I have _not_ actually tried any
> of it out, much less thought about what the user level stuff really needs.

Sure. I've done some work on profiling using trace hooks. Hopefully the
following is useful.

> Anyway, here goes a straw-man:
> 
>  - I'd associate each profiling event with a dentry/offset pair, simply
>    because that's the highest-level thing that the kernel knows about and
>    that is "static".

dentry + offset: on a 32bit machine, this is 8 bytes total per event being
profiled. This is a lot of information if you are trying you have a high
volume throughput. You can almost always skip the dentry since you know scheduling
changes and since you can catch a system-state snapshot at the begining of
the profiling. After that, the eip is sufficient and can easily be correlated
to a meaningfull entry in a file in user-space.

>  - I'd suggest that the profiler explicitly mark the dentries it wants
>    profiled, so that the kernel can throw away events that we're not
>    interested in. The marking function would return a cookie to user
>    space, and increment the dentry count (along with setting the
>    "profile" flag in the dentry)

Or the kernel can completely ignore this sort of selection and leave it
all to the agent responsible for collecting the events. This is what is
done in LTT. Currently, you can select one PID, GID, UID, but this
is easily extendable to include many. Of course if you agree to having
the task struct have "trace" or "profile" field, then this would be
much easier.

>  - the "cookie" (which would most easily just be the kernel address of the
>    dentry) would be the thing that we give to user-space (along with
>    offset) on profile read. The user app can turn it back into a filename.

That's the typical scheme and the one possible with the data retrieved
by LTT.

> Whether it is the original "mark this file for profiling" phase that saves
> away the cookie<->filename association, or whether we also have a system
> call for "return the path of this cookie", I don't much care about.
> Details, details.
> 
> Anyway, what would be the preferred interface from user level?

The approach LTT takes is that no part in the kernel should actually care
about the user level needs. Anything in user level that has to modify
the tracing/profiling makes its requests to the trace driver, /dev/tracer.
No additional system calls, no special cases in the main kernel code. Only
3 main files:
kernel/trace.c: The main entry point for all events (trace_event())
drivers/trace/tracer.c: The trace driver
include/linux/trace.h: The trace hook definitions

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
