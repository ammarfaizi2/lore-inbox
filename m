Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUGYTHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUGYTHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUGYTHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:07:37 -0400
Received: from peabody.ximian.com ([130.57.169.10]:25497 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264278AbUGYTHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:07:33 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Tim Hockin <thockin@hockin.org>
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040725181139.GC1269@hockin.org>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
	 <20040724174636.GA29367@hockin.org> <1090693183.12088.21.camel@localhost>
	 <20040725181139.GC1269@hockin.org>
Content-Type: text/plain
Date: Sun, 25 Jul 2004 15:08:21 -0400
Message-Id: <1090782501.25479.23.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 11:11 -0700, Tim Hockin wrote:

> yeah.  I suppse that's true.  What's the meaning of the 'source' object,
> generically?

The source of the signal.  The object, in fact - very similar to kobject
in concept, but we cannot use that since one does not exist for all uses
(plus, Greg tells me it would be expensive to constantly build the
kobject path for each event).

The only hard requirement is that it is unique, like any URI.  But it
would be nice if it was self-descriptive and double nice if it looked
like URI's used by other object systems.  The "drivers/char/cdrom" style
fits that bill.

> So, when I was at Sun (no, I'm not at Sun anymore) there was lots of talk
> of driver hardening and fault management.  At the time, the team in
> question looked at the various event systems that currently exist in the
> kernel or in some patches.  This list might be incomplete, but it's off
> the top of my head.
> 
> - Netlink
> - ACPI (/proc/acpi/event)
> - hotplug
> - IPMI (not merged maybe?)
> - relayfs (not merged)
> - evlog (last I saw, this was in big flux)
> 
> Now you're proposing netlink as the kevent subsystem.
> 
> Wouldn't it be nice if everything could converge?  Ok maybe not
> EVERYTHING, but some of these?

Yup.

So the last two are not being merged.  It seems unlikely that they will
be, but if they were, we could use them as the backbone of the event
system.  The medium is not really what interests me (or you, either - I
think we both are interested in the results, right?).  Technically
speaking, though, netlink does seem the best choice.  I look at kevent
as serving the same purpose as these last two.

I don't know much about IPMI, but I thought it was a hardware spec.  I'm
not sure it counts here.  If it communicates with user-space, it would
be nice if it used netlink or /proc or even kevent and not its own
thing.

So that leaves ACPI and hotplug.  ACPI absolutely should switch to using
kevent.  It is the perfect user, right?  Send the ACPI events out via
kevent.  You wouldn't even need acpid - just have policy agents
listening on D-BUS or directly on the netlink socket or whatever.

As for hotplug, I'll leave that one to Greg.  He has some thoughts here.

> These are the things I can see kevents being used for:
> 
> - Stateless messages which only matter if someone is listening.  Examples
>   of this are "media changed" and stuff like that.
> 
> - Fault and error that matter no matter what, and can not afford to be
>   dropped.  Examples are things like ECC errors, significant
>   driver/subsystem errors, etc.
> 
> - System state messages, which really do want someone to be listening, but
>   are otherwise discoverable.  Examples of this are "disk full" and
>   similar.
> 
> So can kevents be used for all of these?  The fact that netlink does not
> buffer events if there are no listeners (not saying it should..) makes it
> unreliable for fault events.  Can these all be converged?

I think kevents can (and should) be used for all of these.  But the lack
of buffering is something we need to look into.

> Sorry for rambling - kernel events has been on my mind for some time.

Mine too.  All good input, thanks.

	Robert Love


