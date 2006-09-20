Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWITWvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWITWvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWITWvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:51:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51907 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932439AbWITWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:51:52 -0400
Date: Wed, 20 Sep 2006 15:51:36 -0700
From: Paul Jackson <pj@sgi.com>
To: rohitseth@google.com
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920155136.c35c874f.pj@sgi.com>
In-Reply-To: <1158773208.8574.53.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wrote:
> But am not sure
> if this number of nodes can change dynamically on the running machine or
> a reboot is required to change the number of nodes.

The current numa=fake=N kernel command line option is just boottime,
and just x86_64.

I presume we'd have to remove these two constraints for this to be 
generally usable to containerize memory.

We also, in my current opinion, need to fix up the node_distance
between such fake numa sibling nodes, to correctly reflect that they
are on the same real node (LOCAL_DISTANCE).

And some non-trivial, arch-specific, zonelist sorting and reconstruction
work will be needed.

And an API devised for the above mentioned dynamic changing.

And this will push on the memory hotplug/unplug technology.

All in all, it could avoid anything more than trivial changes to the
existing memory allocation code hot paths.  But the infrastructure
needed for managing this mechanism needs some non-trivial work.


> Though when you want to have in access of 100 containers then the cpuset
> function starts popping up on the oprofile chart very aggressively.

As the linux-mm discussion last weekend examined in detail, we can
eliminate this performance speed bump, probably by caching the
last zone on which we found some memory.  The linear search that was
implicit in __alloc_pages()'s use of zonelists for many years finally
become explicit with this new usage pattern.


> Containers also provide a mechanism to move files to containers. Any
> further references to this file come from the same container rather than
> the container which is bringing in a new page.

I haven't read these patches enough to quite make sense of this, but I
suspect that this is not a distinction between cpusets and these
containers, for the basic reason that cpusets doesn't need to 'move'
a file's references because it has no clue what such are.


> In future there will be more handlers like CPU and disk that can be
> easily embeded into this container infrastructure.

This may be a deciding point.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
