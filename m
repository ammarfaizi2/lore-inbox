Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUG0FKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUG0FKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUG0FKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:10:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52368 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266316AbUG0FKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:10:01 -0400
Subject: Re: [patch] kernel events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Robert Love <rml@ximian.com>
Cc: Tim Hockin <thockin@hockin.org>, dsaxena@plexity.net,
       Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1090782501.25479.23.camel@lucy>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
	 <20040724174636.GA29367@hockin.org> <1090693183.12088.21.camel@localhost>
	 <20040725181139.GC1269@hockin.org>  <1090782501.25479.23.camel@lucy>
Content-Type: text/plain
Message-Id: <1090904941.1753.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 26 Jul 2004 22:09:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 12:08, Robert Love wrote:
> On Sun, 2004-07-25 at 11:11 -0700, Tim Hockin wrote:
> > So, when I was at Sun (no, I'm not at Sun anymore) there was lots of talk
> > of driver hardening and fault management.  At the time, the team in
> > question looked at the various event systems that currently exist in the
> > kernel or in some patches.  This list might be incomplete, but it's off
> > the top of my head.
> > 
> > - Netlink
> > - ACPI (/proc/acpi/event)
> > - hotplug
> > - IPMI (not merged maybe?)
> > - relayfs (not merged)
> > - evlog (last I saw, this was in big flux)
> > 
> > Now you're proposing netlink as the kevent subsystem.
> > 
> > Wouldn't it be nice if everything could converge?  Ok maybe not
> > EVERYTHING, but some of these?
> 
> Yup.
> 
> So the last two are not being merged.  It seems unlikely that they will
> be, but if they were, we could use them as the backbone of the event
> system.  The medium is not really what interests me (or you, either - I
> think we both are interested in the results, right?).  Technically
> speaking, though, netlink does seem the best choice.  I look at kevent
> as serving the same purpose as these last two.
> 
> I don't know much about IPMI, but I thought it was a hardware spec.  I'm
> not sure it counts here.  If it communicates with user-space, it would
> be nice if it used netlink or /proc or even kevent and not its own
> thing.
> 
> So that leaves ACPI and hotplug.  ACPI absolutely should switch to using
> kevent.  It is the perfect user, right?  Send the ACPI events out via
> kevent.  You wouldn't even need acpid - just have policy agents
> listening on D-BUS or directly on the netlink socket or whatever.
> 
> As for hotplug, I'll leave that one to Greg.  He has some thoughts here.
> 
> > These are the things I can see kevents being used for:
> > 
> > - Stateless messages which only matter if someone is listening.  Examples
> >   of this are "media changed" and stuff like that.
> > 
> > - Fault and error that matter no matter what, and can not afford to be
> >   dropped.  Examples are things like ECC errors, significant
> >   driver/subsystem errors, etc.
> > 
> > - System state messages, which really do want someone to be listening, but
> >   are otherwise discoverable.  Examples of this are "disk full" and
> >   similar.
> > 
> > So can kevents be used for all of these?  The fact that netlink does not
> > buffer events if there are no listeners (not saying it should..) makes it
> > unreliable for fault events.  Can these all be converged?
> 
> I think kevents can (and should) be used for all of these.  But the lack
> of buffering is something we need to look into.


There are other issues that we may need to look into as well, like:

1) How do we handle events that occur in a hardware interrupt context?
One thing that has been suggested in the past was to delay broadcast and
schedule a tasklet to do the broadcast. Or, can we make the netlink
broadcast interrupt safe?

2) What about the recent thread on firmware errors for ppc64 systems?
They have errors at early boot and those error messages may be in binary
format? Should we buffer messages until netlink becomes available and
then send the messages and remove the buffer? As for the binary format,
should we change kevents so format and args are kept separate to User
Space? This would have other benefits as well.

Just some thoughts....

Thanks,

Dan

