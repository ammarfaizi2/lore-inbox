Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWBWPRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWBWPRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWBWPRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:17:36 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:60594 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751339AbWBWPRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:17:36 -0500
Date: Thu, 23 Feb 2006 10:17:22 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Frank Ch. Eigler" <fche@redhat.com>
cc: linux-kernel@vger.kernel.org, etsman@cs.huji.ac.il
Subject: Re: Static instrumentation, was Re: RFC: klogger: kernel tracing
 and logging tool
In-Reply-To: <y0mbqwze1p8.fsf@ton.toronto.redhat.com>
Message-ID: <Pine.LNX.4.58.0602230942210.27901@gandalf.stny.rr.com>
References: <43FC8261.9000207@gmail.com> <y0mbqwze1p8.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Frank Ch. Eigler wrote:

>
> Yoav Etsion <etsman@gmail.com> writes:
>
> > [...]  I've developed a kernel logging tool called
> > Klogger: http://www.cs.huji.ac.il/~etsman/klogger
> > In some senses, it is similar to the LTT [...]
>
> It seems like several projects would benefit from markers being
> inserted into key kernel code paths for purposes of tracing / probing.
>
> Both LTTng and klogger have macros that expand to largish inline
> function calls that appear to cause a noticeable amount of work even
> for tracing requests are not actually active.  (klogger munges
> interrupts, gets timestamps, before ever testing whether logging was
> requested; lttng similar; icache bloat in both cases.)
>
> In other words, even in the inactive state, tracing markers like those
> of klogger and ltt impose some performance disruption.  Assuming that
> detailed tracing / probing would be a useful facility to have
> available, are there any other factors that block adoption of such
> markers in official kernels?  In other words, if they could go "fast
> enough", especially in the inactive case, would you start placing them
> into your code?
>
>

Have you taken a look at my logdev utility.  I usually use something like
the macro of this:

edprint("print my var %08lx", var);

which is defined as:

#ifdef CONFIG_LOGDEV
#  define LOGDEV(x,y...) logdev_##x(y)
#  define LOGTFPRINT(x...) do { if (atomic_read(&logdev_print_enabled)) \
     LOGDEV(print_time_func,__FUNCTION__,__LINE__,x); } while(0)

#  define _edprint(x,y...) do { \
    LOGTFPRINT(x "%s\n", y);} } while(0)
#  define edprint(x...) _edprint(x,"")

#else

#  define LOGTFPRINT(x...) do {} while(0)
#  define edprint(x...) do {} while(0)

#endif


This is just an idea of what is done.  This crazy macros are used because
I also have the logdev as a module, and if it is not compiled in, the
LOGTFPRINT turns into a spinlock holder  to safely load and unload
it.  I haven't used the module version in a few years, so I probably
should get rid of that feature.

Anyway, the atomic variable logdev_print_enabled is checked before doing
anything else, so it doesn't invade the code too much when disabled.  And
of course has no affect when not configured.

It also has ways to store everything binary.  The function name is saved
as a pointer and my read utility (which I don't know if I uploaded the
latest) does a mmap of /dev/mem to find the actual name. If you don't have
root, then it miss out, but the utility doesn't crash, it just doesn't
show the name.

 http://www.kihontech.com/logdev

-- Steve

