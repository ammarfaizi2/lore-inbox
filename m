Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUAIBRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUAIBRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:17:37 -0500
Received: from waste.org ([209.173.204.2]:41109 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266408AbUAIBQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:16:52 -0500
Date: Thu, 8 Jan 2004 19:16:35 -0600
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@ximian.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040109011635.GM18208@waste.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071815320.12602@home.osdl.org> <20040108034906.A1409@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071854500.2131@home.osdl.org> <20040108043506.A1555@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071941390.2131@home.osdl.org> <1073608126.1228.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073608126.1228.16.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 07:28:47PM -0500, Robert Love wrote:
> On Wed, 2004-01-07 at 22:43, Linus Torvalds wrote:
> 
> > Yes. We _could_ do that, by just making a "we noticed the disk change" be
> > a hotplug event. However, I'm loath to do that, because some devices
> > literally don't even have an easily read disk change signal, so what they
> > do is
> 
> I like the idea of a hotplug event on media change (basically, a hotplug
> event for partitions).  And, in fact, I am loath not to do it.
> 
> The current direction with the kernel and udev is letting us move _away_
> from polling.  Projects such as HAL are helping to finally integrate
> hardware management throughout the system.  But HAL is going to be very
> confused by some of the alternative solutions for partitions: requiring
> that all of the partition device nodes preexist is going to really
> complicate things, and I really do not want to have to poll on all of
> them in order for HAL to have an idea of what partitions are valid.
> 
> But I hear you loud and clear about dumb devices that cannot detect
> media change.  They pose a problem.

If we have a hotplug media change event we can do:

   if new device x appears:
      x->device_nodes = all possible partition nodes
      start_media_change_timer()
   if media change on x:
      x->device_nodes = current media partitions
      clear_media_change_timer()
      create_nodes(x)
   if timeout: /* we didn't get media change so create all nodes */
      create_nodes(x)

Then the dumb devices (which should be a small minority) just show up
with a harmless excess of partitions.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
