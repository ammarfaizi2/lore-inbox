Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSBGAHw>; Wed, 6 Feb 2002 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290977AbSBGAHh>; Wed, 6 Feb 2002 19:07:37 -0500
Received: from ns.suse.de ([213.95.15.193]:261 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290966AbSBGAGT>;
	Wed, 6 Feb 2002 19:06:19 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <3C6192A5.911D5B4F@nortelnetworks.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: Chris Friesen's message of "6 Feb 2002 21:30:28 +0100"
X-Mailer: Gnus v5.7/Emacs 20.6
Date: 07 Feb 2002 01:06:15 +0100
Message-ID: <p73it9a9mvc.fsf@oldwotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> I've been looking around in the 2.4 networking stack, and I noticed that when
> the tulip (and no doubt many other) driver cannot put any more outgoing packets
> on the queue, it calls netif_stop_queue().  Then, in dev_queue_xmit() we check
> this flag by calling netif_queue_stopped().  My concern is that if this flag is
> true, we return -ENETDOWN.  Is this really the proper return code for this? If
> anything, the network is too active.  It seems to me that it would make more
> sense to have some kind of congestion return code rather than claiming that the
> network is down.

The ENETDOWN path you're seeing only applies to queueless devices (like
loopback or a tunnel device). These should only set the queued stopped
flag when something is terrible wrong. 
 
All real network devices have a queue and go through the qdisc. 

> 
> I think it would make sense to return -ENOBUFS in this case, as its already
> listed in the sendto() man page, and the description matches the error because
> the command could succeed if retried.
> 
> I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
> was calling sendto() on 217000 packets/sec, even though the wire could only
> handle about 127000 packets/sec.  I got no errors at all in sendto, even though
> over a third of the packets were not actually being sent.

The qdisc queue acts like an IP network and deletes unnecessary packets. 
There is no provision to block when it fills because that would have
many sideeffects and complicate the stack a lot. There is an return
code though that is passed up when the queue fills (NET_XMIT_DROP or
NET_XMIT_CN), but it's currently only used by TCP but not passed to 
user space for UPD/RAW. It could be probably done with a special
socket option if there is a clear need.

-Andi
