Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVLFWyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVLFWyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVLFWyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:54:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19677 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965045AbVLFWyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:54:52 -0500
Message-ID: <439616B6.1020308@us.ibm.com>
Date: Tue, 06 Dec 2005 14:54:46 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com> <20051118195657.GI7991@shell0.pdx.osdl.net> <43815F64.4070502@us.ibm.com> <20051121132910.GA1971@elf.ucw.cz>
In-Reply-To: <20051121132910.GA1971@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>* Matthew Dobson (colpatch@us.ibm.com) wrote:
>>>
>>>
>>>>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>>>>for the critical pool into this file
>>>
>>>
>>>How do you size this pool?
>>
>>Trial and error.  If you want networking to survive with no memory other
>>than the critical pool for 2 minutes, for example, you pick a random value,
>>block all other allocations (I have a test patch to do this), and send a
>>boatload of packets at the box.  If it OOMs, you need a bigger pool.
>>Lather, rinse, repeat.
> 
> 
> ...and then you find out that your test was not "bad enough" or that
> it needs more memory on different machines. It may be good enough hack
> for your usage, but I do not think it belongs in mainline.
> 								Pavel

Way late in responding to this, but...

Apropriate sizing of this pool is a known issue.  For example, we want to
use it to keep the networking stack alive during extreme memory pressure
situations.  The only way to size the pool so as to *guarantee* that it
will not be exhausted during the 2 minute window we need would be to ensure
that the pool has at least (TOTAL_BANDWITH_OF_ALL_NICS * 120 seconds) bytes
available.  In the case of a simple system with a single GigE adapter we'd
need (1 gigbit/sec * 120 sec) = 120 gigabits = 15 gigabytes of reserve
pool.  That is obviously completely impractical, considering many boxes
have multiple GigE adapters or even 10 GigE adapters.  It is also
incredibly unlikely that the NIC will be hit with a continuous stream of
packets at a level that would completely saturate the link.  Starting with
an educated guess and some test runs with a reasonble workload should give
you a good idea of how much space you'd *realistically* need to reserve.
Given any reserve size less than the theoretical maximum you obviously
can't *guarantee* the pool won't be exhausted, but you can be pretty confident.

-Matt
