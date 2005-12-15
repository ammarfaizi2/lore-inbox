Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbVLOIoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbVLOIoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbVLOIoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:44:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:177 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161086AbVLOIoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:44:04 -0500
In-Reply-To: <20051214215613.70f9cafa@localhost.localdomain>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: ak@suse.de, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, mpm@selenic.com, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org, sri@us.ibm.com
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFB8B21C56.4F9E9A3C-ON882570D8.002CBD7B-882570D8.002FF8B1@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Thu, 15 Dec 2005 00:44:52 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 12/15/2005 01:44:54,
	Serialize complete at 12/15/2005 01:44:54
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, all this stuff is just a band aid because linux OOM behavior is so
> fucked up.

In our internal discussions, characterizing this as "OOM" came
up a lot, and I don't think of it as that at all. OOM is exactly what the
scheme is trying to avoid!

The actual situation we have in mind is a swap device management system
in a cluster where a remote system tells you (via socket communication to
a user-land management app) that a swap device is going to fail over and
it'd be a good idea not to do anything that requires paging out or
swapping for a short period of time. The socket communication must work,
but the system is not at all out of memory, and the important point is
that it never will be if you limit allocations to those things that are
required for the critical socket to work (and nothing/little else).
        Receiver side allocations are unavoidable, because you don't know
if you can drop the packet or not until you look at it. Some 
infrastructure
must work. But everything else can fail or succeed based on ordinary churn
in ordinary memory pools, until the "in_emergency" condition has passed.
        The critical socket(s) simply have to be out of the zero-sum game
for the rest of the allocations, because those are the (only) path to
getting a working swap device again.

If you're out of memory without a network mechanism to get you more,
this doesn't do anything for you (and it isn't intended to). And if you
mark any socket that isn't going to get you failed over or otherwise
get you more swap, it isn't going to help you, either. It isn't a priority
scheme for low-memory, it's a failover mechanism that relies on 
networking.
There are exactly 2 priorities: critical (as in "you might as well crash 
if
these aren't satisfied") and everything else.

Doing other, more general things that handle low memory, or OOM, or 
identified
priorities are great, but the problem we're interested in solving here is
really just about making socket communication work when the alternative is
a completely dead system. I think these patches do that in a reasonable 
way.
A better solution would be great, too, if there is one. :-)

                                                        +-DLS

