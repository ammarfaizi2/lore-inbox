Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbTFSTkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTFSTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:38:23 -0400
Received: from almesberger.net ([63.105.73.239]:48903 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265918AbTFSThw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:37:52 -0400
Date: Thu, 19 Jun 2003 16:51:35 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619165135.C6248@almesberger.net>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612225040.GA1492@kroah.com>; from greg@kroah.com on Thu, Jun 12, 2003 at 03:50:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jun 12, 2003 at 03:03:35PM -0700, Andrew Morton wrote:
> > This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
> > very interested in reading an outline of how you propose fixing it, without
> > waiting until OLS, thanks.
> 
> Sure, I knew someone would probably want to :)

An interesting problem, with a lot of potential for wrong
solutions ;-) A few comments from an interested bystander:

1) Reordering:

First of all, it doesn't seem to be clear whether the
ordering mechanism as a whole is supposed to be reliable.
E.g. your timeout-based approach would fix reordering with a
certain probability, but occasionally, reordering would still
occur.  (This is similar to IP networks: a little but of
reordering is okay, but if you do it a lot, TCP performance
will suffer.)

Also, you don't try to correct losses, right ? I.e. if we
get events A and B, A is lost, then B is handled without any
attempt to retry A first. Right ?

If you want a reliable reordering detection, /sbin/hotplug
needs to know what happens with concurrent events, e.g. if A
and B occur in parallel, B cannot be executed unless we know
that A has either succeeded or failed. Sequence numbers alone
don't help (you could, of course, combine them with timeouts,
and end up with a more efficent version of your original
timeout approach).

You can track concurrent events in a number of ways, e.g. by
going back to the kernel, and asking how many "older"
instances of /sbin/hotplug are running, or they could
communicate directly among each other.

E.g. the kernel could open a pipe for each /sbin/hotplug, and
give each /sbin/hotplug a duplicate of the reader end of the
pipe of each concurrently running /sbin/hotplug.
/sbin/hotplug could then poll them, and wail until all those
fds are closed.

What I don't quite understand is why you won't want to
serialize in the kernel. The overall resource footprint of
sleeping /sbin/hotplugs, and such, is certainly much larger
than a few queued event messages.

Furthermore, if you serialize in the kernel, you can easily
and reliably indicate how many events have been lost since
the last one.


2) Communication mechanism:

Given all these complications, I'm not so sure if just
sending messages (ASCII, EBCDIC, binary, Haiku, whatever ;-)
wouldn't be more convenient in the end. You could dispatch
them later to scripts easily enough.

But since time doesn't seem to be an issue (more about that
below), you could of course also use the same concept we use
for interrupts: make /sbin/hotplug a "fast" interface script,
which then delegates the real work to some other process.

Given that it's a bit of an uphill battle to write user-space
programs that absolutely never fail, it may also be good to
have some completion signal that can be used to keep track of
dropped events, and that can then be used to trigger a
recovery procedure.

A central dispatcher would also have the advantage of
possessing full information on the events being handled. That
way, events without interdependencies could still be
processed in parallel.


3) We're in no hurry at all:

Sorry, I don't buy this. You're of course right that bus
systems that need some slow, timeout-based scan won't
initialize quickly anyway. But it wouldn't be all that hard
to make them faster, and then the hotplug interface would
become the bottleneck.

Example: put 1000 SCSI drives in a cabinet with a door
switch. When the door is open, do things in the usual, slow
way. When the door is closed, no drives can be added or
removed, so the system could cache bus scan results and
synthesize NACKs for absent devices.

So I think it makes sense to avoid obvious bottlenecks in
this design. Therefore, as long as any kind of serialization
is required, and unless the kernel itself knows what can be
parallelized, and what not, a dispatcher demon looks like the
most light-weight solution.

If you're worried about having yet another rarely used demon
in the system, just make /sbin/hotplug persistent. If it is
idle for too long, it can exit, and when there are new
events, the kernel can launch it again.


4) Losses:

Actually, I'm not so sure what really ought to happen with
losses. If we have serialization requirements elsewhere,
proceeding after unrecovered losses would probably mean that
they're being violated. So if they can be violated then,
maybe there is some leeway in other circumstances too ?

On the other hand, if any loss means that major surgery is
needed, the interface should probably have a "in loss" state,
in which it just shuts down until someone cleans up the mess.
Also a partial shutdown may be interesting (e.g. implemented
by the dispatcher), where events with no interdependencies
with other events would still be processed.

The kernel could even provide some hints of what has been
lost. (I.e. aggregate any information in the lost events.)
That way, the partial shutdown would be even more efficient.
But I think I'm overdesining now :-)


Anyway, just my 2 centavos :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
