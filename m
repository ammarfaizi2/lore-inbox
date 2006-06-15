Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030725AbWFOP4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030725AbWFOP4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030731AbWFOP4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:56:11 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:17080 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030725AbWFOP4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:56:09 -0400
Message-ID: <449182FB.6020907@watson.ibm.com>
Date: Thu, 15 Jun 2006 11:55:39 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com>
In-Reply-To: <4490D515.8070308@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:


> 
> I was talking about turning off system-wise taskstats data preparation and
> delivery when every task exits. Sometimes customers like to do some
> benchmarking and need to turn off nonessential features.

Lets go through the implications of turning on/off collection, assembly and delivery
of the per-task accounting data.

Collection is defined by different subsystems using taskstats.
For atleast one of these (delay accounting), turning on/off dynamically has been tried
and deemed to cause a lot of overhead (due to accumalated nature of data) and also be
prone to races. Complexity of code added did not justify the value so on/off was restricted
to a boot time decision.

Assembly and delivery of data is done by the taskstats code, calling subsystem-specific functions to fill
the commonly used struct taskstats and relying on genetlink to do the delivery.
This can be turned on/off using a dynamic parameter such as /sys/kernel/taskstats_enable which sets
some internal variable that is used to do early exits from relevant functions (mainly taskstats_send_stats
and taskstats_exit_send)
Doing so will have impact on
a) queries sent to the kernel by monitoring applications
b) task exit data sent by kernel to apps listening on the multicast socket

For consistency, I'm assuming both a) and b) will have to be affected when taskstats is turned off.
Also, I'm assuming monitoring applications aren't aware of the turn off.

What happens to case a) ? Apps will need to get some error message as a reply. Some assembly overhead
is saved (since such an error reply can be sent right away as soon as a query command is seen) but no
substantial saving on the delivery part.

For case b), we can save on assembly and delivery by exiting early from taskstats_exit_send(). But won't
we need to send some message (if not periodically, atleast once) to listening apps that they shouldn't
expect any exit data ? Semantics of suddenly not seeing any exit data could be misinterpreted ?

Its easy enough to implement...just concerned about the semantics of doing so (as far as userspace
apps are concerned) and utility in general settings. Utility in case where only CSA is running (delay
accounting and other users turned off) is clear.

Thoughts ?

--Shailabh








