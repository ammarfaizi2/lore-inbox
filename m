Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUFYTLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUFYTLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266842AbUFYTLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:11:21 -0400
Received: from waste.org ([209.173.204.2]:20946 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266839AbUFYTLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:11:15 -0400
Date: Fri, 25 Jun 2004 14:11:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] teach netconsole how to do syslog
Message-ID: <20040625191101.GD25826@waste.org>
References: <16604.26514.243458.631948@segfault.boston.redhat.com> <20040625183935.GC25826@waste.org> <16604.29494.41418.239128@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16604.29494.41418.239128@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 02:47:18PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: [patch] teach netconsole how to do syslog; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Fri, Jun 25, 2004 at 01:57:38PM -0400, Jeff Moyer wrote:
> >> Hello,
> >> 
> >> Here's a patch which adds the option to send messages to a remote
> >> syslog, enabled via the do_syslog= module parameter.  Currently logs
> >> everything at info (as did the original netconsole module).  Patch is
> >> against 2.6.6, though should apply to later.
> 
> mpm> Well as it stands, it's already syslog compatible, as the priority
> mpm> level component of the syslog protocol is optional. I've made a point
> mpm> of _defining_ the netconsole protocol as syslog (note the default
> mpm> port) so that this could be done at a later date. Thus, I don't think
> mpm> a new command line option is necessary.
> 
> Well, the way it is coded currently does not usually give a full line of
> output on each line in my system log:
> 
> Jun 25 14:41:18 remote-host HELP : 
> Jun 25 14:41:18 remote-host SysRq : 
> Jun 25 14:41:18 remote-host loglevel0-8 
> Jun 25 14:41:18 remote-host reBoot 
> Jun 25 14:41:18 remote-host Crash 
> Jun 25 14:41:18 remote-host tErm 
> Jun 25 14:41:18 remote-host kIll 
> Jun 25 14:41:18 remote-host saK 
> Jun 25 14:41:18 remote-host showMem 
> Jun 25 14:41:18 remote-host powerOff 
> Jun 25 14:41:18 remote-host showPc 
> Jun 25 14:41:18 remote-host unRaw 
> Jun 25 14:41:18 remote-host Sync 
> Jun 25 14:41:18 remote-host showTasks 
> Jun 25 14:41:18 remote-host Unmount 
> Jun 25 14:41:18 remote-host  

Yep, we get one UDP packet per printk currently, which works for most
things, but not everything. This could be changed to a buffered
approach, but that breaks one of my favorite debugging techniques -
adding an alphabet soup of single-character printks to trace tricky
call paths. 

So we could add a __printk that doesn't flush to outputs for stuff
like the above, or just live with it.
 
> mpm> On the other hand, for this to have real value, we need to provide
> mpm> real priority levels. Which means we need to plug it in higher in the
> mpm> printk framework so that we a) get all messages by default and b) get
> mpm> them before the levels are stripped off. I had this in an earlier
> mpm> version but dropped it as being too intrusive for 2.6.0 merger.
> 
> And are you still in favor of this?  Want to post the code?

Yep, I still think it wants doing, but I'm probably a bit too busy at
the moment to revive the old code. Also I'm undecided on the best way
to do it. Part of me wants to push it all down into the console hooks,
so they get all messages and levels and do their own filtering (eg we
might want different log levels for serial vs tty vs netconsole), and
unify with the kmesg queue while we're at it. The other part wants to
just stick in another hook.

> mpm> Also, if we're going to go to the trouble of being more completely
> mpm> syslog-like, it's very useful (and trivial) to throw in the hostname
> mpm> as well. Timestamp is slightly more difficult, but also worth
> mpm> considering.
> 
> Hostname shows up by default with my syslogd.

Yeah, hostname and timestamp are likely added by most syslogds, but
I've worked with a couple that didn't. I suppose we can ignore this
for now.

-- 
Mathematics is the supreme nostalgia of our time.
