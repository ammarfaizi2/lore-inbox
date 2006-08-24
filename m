Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWHXV3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWHXV3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWHXV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:29:20 -0400
Received: from outbound-mail-47.bluehost.com ([70.96.188.16]:42979 "HELO
	outbound-mail-47.bluehost.com") by vger.kernel.org with SMTP
	id S1422665AbWHXV3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:29:19 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure
Date: Thu, 24 Aug 2006 14:29:45 -0700
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <200608241408.03853.jbarnes@virtuousgeek.org> <44EE1801.3060805@linux.intel.com>
In-Reply-To: <44EE1801.3060805@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241429.45791.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 24, 2006 2:20 pm, Arjan van de Ven wrote:
> Jesse Barnes wrote:
> > On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
> >> The reason for adding this infrastructure is that power management
> >> in the idle loop needs to make a tradeoff between latency and power
> >> savings (deeper power save modes have a longer latency to running
> >> code again).
> >
> > What if a processor was already in a sleep state when a call to
> > set_acceptable_latency() latency occurs?
>
> there's nothing sane that can be done in that case; any wake up
> already will cause the unwanted latency! A premature wakeup is only
> making it happen *now*, but now is as inconvenient a time as any...
> (in fact it may be a worst case time scenario, say, an audio
> interrupt...)

Depends on what's going on.  What if you have a two socket machine, and 
one CPU is in C3 when the latency setting occurs?  Shouldn't you wake it 
up and prevent it from going that deep again?  But you're right, you 
won't necessarily improve anything...

>
> > Should there be a callback so
> > they can be woken up?  A callback would also allow ACPI to tell the
> > user "disabling C3 because of device <foo>" or somesuch, which might
> > be nice.
>
> printk'ing would be evil, changes like this will be "semi frequent",
> like every time you start or stop playing audio. What ACPI could
> easily do is indicate in /proc/acpi/processor/*/power that a state
> will not be reachable because it violates the latency constraints.
> That would be entirely reasonable.

Right, that's the idea.  A printk may be overkill but some kind of 
notification might be nice, for similar reasons to the below.

> > Also, should subsystems have the ability to set a lower bound on
> > latency?  That would mean set_acceptable_latency() could fail,
> > indicating that the user should buy a better device or a system with
> > better realtime guarantees, which is also valuable info.
>
> While it's valuable info.. there is nothing you can DO about it...
> While the kernel can even do a latency of 1us by just not going into
> C1 even... so the kernel CAN honor it, even if it thinks it might not
> be a good idea. Can you give a more concrete example of a situation
> where you think your idea would be useful?

Well, I was imagining a scenario where you didn't really want to disallow 
C3 for whatever reason (maybe some standard you're following requires 
it), so your minimum latency would be N usec.  You'd definitely want to 
know about any device that required < N usecs of latency (at boot or 
driver init time) so that you'd know you had a bad device or system.

Jesse
