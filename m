Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVHLQXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVHLQXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVHLQXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:23:38 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:6878 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751220AbVHLQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:23:38 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=No7zQvyvrfY0dCHsDUGtdygk/cgGb9cSGhFDBlCa6qDdxeK49063424Fu32L6/8Dc
	CDb41hekfmlibELkJJxbw==
Date: Fri, 12 Aug 2005 09:23:15 -0700
From: david-b@pacbell.net
To: tpoynor@mvista.com, geoffrey.levand@am.sony.com
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
 <42F8D4C5.2090800@am.sony.com> <42F94B68.6060107@mvista.com>
In-Reply-To: <42F94B68.6060107@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050812162315.16671E2E9B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How well would _this_ notion of an operating point scale up?

I have this feeling that it's maybe better attuned to "scale down"
sorts of problems (maybe cell phones) than to a big NUMA box.  I can
see how a batch scheduled server might want to fire up only enough
components to run the next simulation, but I wonder if maybe systems
dynamically managing lots of resources might not be better off with
some other model ... where userspace makes higher level decisions,
and the kernel is adaptive within a potentially big solution space.
(Likewise, maybe some of the smaller systems would too.)

Also, I suspect everyone would be happier if cpufreq were left
responsible for the CPU-specific parts of an operating point.
That could mean system-specific hooks, e.g. to rule out certain
voltages based on available power or what devices are running.

Unfortunately, examples of non-CPUfreq part of an operating point
may be tricky to come by on desktop systems.


> Date: Tue, 09 Aug 2005 17:33:44 -0700
> From: Todd Poynor <tpoynor@mvista.com>
>
> Geoff Levand wrote:
>
> > I'm wondering if anything could be gained by having the whole 
> > struct powerop_point defined in asm/powerop.h, and treat it as an 
> > opaque structure at this level.  That way, things other than just 
> > ints could be passed between the policy manager and the backend, 
> > although I guess that breaks the beauty of the simplicity and would 
> > complicate the sys-fs interface, etc.  I'm interested to hear your 
> > comments.
>
> Making the "operating point" data structure entirely platform-specific 
> should be OK.  There's a little value to having generic pieces handle 
> some common chores (such as the sysfs interfaces), but even for integers 
> decimal vs. hex formatting is nicer depending on the type of value. 

Taking a more extreme position or two:

  - Why have any parsing at all?  It's opaque data; so insist that
    the kernel just get raw bytes.  That's the traditional solution,
    not having the kernel parse arrays of integers.

  - Why try to standardize a data-based abstraction at all?  Surely
    it'd be easier to use modprobe, and have it register operating
    points that include not just the data, but its interpretation.

  - If those numbers are needed, having single-valued sysfs attributes
    (maybe /sys/power/runstate/policy_name/XXX) would be preferable
    to relying on getting position right within a multivalued input.

What I've had in mind is that "modprobe" would register some code
implementing one or more named runtime policies.  Now one way to use
such code would be to equate "policy" and "operating point"; a static
mapping, as I think I see Todd suggesting, but compiled.  (Or maybe
tuned using individual sysfs attributes.)

But another way would be to have that code pick some operating point
that matches various constraints fed in from userspace ... maybe from
sysfs attribute files managed by that code.  It could use all sorts
of kernel APIs while choosing the point, and would clearly need to
use them in order to actually _set_ some new point.

It's easier for me to see how "echo policy_name > /sys/power/runtime"
would scale up and down (given pluggable policy_name components!)
than "echo 0 35 98 141 66 -3 0x7efc0 > /sys/power/foo" would.


> Since most values that have been managed using similar interfaces thus 
> far have been flags, register values, voltages, etc. using integers has 
> worked well and nicely simplified the platform backend, but if there's a 
> need for other data types then should be doable.

Sysfs already has all that infrastructure, if you adopt the policy
that such system-specific constraints show up in system-specific
attributes somewhere ... matching the system-specific knowledge that's
used to interpret them.  That'd also be less error prone than "whoops,
there wasn't supposed to be a space between 35 and 98" or "darn, I
switched the 141 and 66 around again".

- Dave


