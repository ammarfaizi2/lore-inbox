Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFTCNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFTCNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:13:19 -0400
Received: from almesberger.net ([63.105.73.239]:56328 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262164AbTFTCNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:13:17 -0400
Date: Thu, 19 Jun 2003 23:26:54 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619232654.F6248@almesberger.net>
References: <3EF250EF.1010802@mvista.com> <Pine.LNX.4.44.0306191717120.1987-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306191717120.1987-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 19, 2003 at 05:43:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> This still isn't a global serialization thing, though. For example,
> there's no reason _another_ device should be serialized with the disk
> discovery.

Yes, that sounds a lot better. Let's hope nobody discovers such
a reason ...

> An easy way to do partial serialization is something like this:

That would work. It's in fact a per-class message queue, in which
sleeping processes play the role of messages ;-)

I thought a bit about what else one could do with this interface:

 - if you need loss/error handling, and are willing to keep one
   bit of information for each such class in the kernel, the it
   could register whether processing the previous event has
   succeeded, i.e. whether the kernel was able to launch a helper,
   and whether that helper has returned with exit status 0. This
   bit could be returned by the synchronization call.

 - in principle it would now be easy, and in many ways cleaner and
   more efficient, to turn this into a per-class event demon, with
   a "real" event queue. The problem is that you'd probably still
   want classes that are not serialized, and the kernel wouldn't
   know whether a given class needs serialization before
   /sbin/hotplug has run for a while. Neiter configuring class
   behaviour nor adding an "asychronous class" look particularly
   attractive to me.

   Too bad. A synchronous /sbin/hotplug as follows would certainly
   be nice, e.g. assuming that in each class only one event type
   can occur:

   #!/bin/sh
   agent=$1
   read event
   set $event
   <... normal /sbin/hotplug code ...>

   or, the high-performance variant:

   #!/bin/sh
   exec /etc/hotplug/$1.agent

   #!/bin/sh
   <... do really expensive initialization ...>
   while read event; do
       set $event
       <... normal /etc/hotplug/*.agent code ...>
   done

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
