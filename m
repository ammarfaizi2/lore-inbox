Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUBCBEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUBCBCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:02:30 -0500
Received: from dp.samba.org ([66.70.73.150]:44710 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265631AbUBCBCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:02:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-reply-to: Your message of "Mon, 02 Feb 2004 07:45:32 CDT."
             <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com> 
Date: Tue, 03 Feb 2004 11:34:27 +1100
Message-Id: <20040203010224.459E32C252@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com> you wri
te:
> 
> On Mon, 2 Feb 2004, Rusty Russell wrote:
> 
> > Unfortunately the __migrate_task() check won't go away: someone may have
> > asked to move from CPU 0 to 1, and by the time migration thread on 0
> > gets to the request, 1 has gone down.  We don't want all the callers to
> > hold the cpucontrol lock, because now the NUMA scheduler uses migration
> > as a common case 8(
> 
> well, when a CPU goes down it could process the migration request queue as
> well. (this would be a pretty natural thing to do if CPU-down executes in
> the migration-thread context.)

Wrong migration thread.  The migration thread on CPU 1 has been asked
to push into CPU 0, which is now going down.

Now I've slept on the "do it atomically" idea, I think it's a good
one.  I've even worked out how to maintain the "last thread on CPU is
the idle thread", although I'd need to test in code.

> Another question is user-space semantics - if user-space relies on CPU
> affinity, is the kernel allowed to violate it or should the process be
> notified. Sending it a signal (SIGTERM or anything similar) if the
> affinity was non-generic might be a good thing to do.

We've been there: we used to send SIGPWR with a new si_info field to
say what CPU it was.  But it turns out not to be useful, so we took it
out.

In practice, any app which wants to scale with # CPUs needs to know
when CPUs are coming up, as well as going down.  Ditto memory, etc.
This means they need to listen for the hotplug event (DBUS anyone?),
or we introduce a SIGRECONF (default ignored).  But AFAICT,
introducing a new signal isn't possible (at least on x86) without
breaking glibc.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
