Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVKOQGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVKOQGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVKOQGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:06:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14735 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964772AbVKOQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:06:30 -0500
Message-ID: <437A0873.8030107@watson.ibm.com>
Date: Tue, 15 Nov 2005 11:10:27 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC][Patch 0/4] Per-task delay accounting
References: <4379658E.1020707@watson.ibm.com> <20051114201741.3d5496b3.akpm@osdl.org>
In-Reply-To: <20051114201741.3d5496b3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
>>They are made available through a connector interface which allows
>> - stats for a given <pid> to be obtained in response to a command
>> which specifies the <pid>. The need for dynamically obtaining delay
>> stats is the reason why piggybacking delay stats onto BSD process
>> accounting wasn't considered.
> 
> 
> I think this is the first time that anyone has come out with real code
> which does per-task accounting via connector.
> 
> Which makes one wonder where this will end up.  If numerous different
> people add numerous different accounting messages, presumably via different
> connector channels then it may all end up a bit of a mess.  Given the way
> kernel development happens, that's pretty likely.

Yes, thats quite likely. While doing this, it was pretty clear that the
connector interface part of the patch was relatively independent of the
collection of these specific delays. This is already apparent from the exporting
of per-task cpu data that wasn't collected by this patch and there's no reason
why other data (currently available from /proc/<tgid>/stats) shouldn't be
exported too if its needed with less overhead than /proc offers.

> For example, should the next developer create a new message type, or should
> he tack his desired fields onto the back of yours?  If the former, we'll
> end up with quite a lot of semi-duplicated code and a lot more messages and
> resources than we strictly need.  If the latter, then perhaps the
> versioning you have in there will suffice - I'm not sure.

The design I have assumes the latter. Hence the versioning.

Another bit of code thats being duplicated already is the registration/deregistration
of userspace listeners. Currently this is duplicated with Matt Helsley's process event
connector and it'll only get worse later.

> I wonder if at this stage we should take a shot at some overarching "how do
> do per-task accounting messages over connector" design which can at least
> incorporate the various things which people have been talking about
> recently?

Thats a good thought and I'd been sorely tempted to do that as part of this connector
patch but held back since it can quickly become quite elaborate.

The assumption here is that there will be a growing and varied set of per-task data
that userspace needs to get through a more efficient interface than /proc. We can limit
the discussion to accounting data since its logically related.

Here's a strawman:

Have userspace specify an "interest set" for the per-task stats that are available -
a bitmap of two u64's should suffice to cover all the stats available.

The interest set can be specified at registration time (when the first client starts
listening) so that any future task exits send the desired stats down to userspace.
Clients could also be allowed to override the default interest set whenever they send a
command to get data on a specific task.

The returned data would now need to be variable-sized to avoid unnecessary overhead.
So something like

	header including a bitmap of returned data
	data 1
	data 2
	....

That way we avoid versioning until we run of of bits in the bitmap.
If more per-task stats get added, they can be assigned bits and the bitmap also defines
the implicit order in which the data gets sent.













