Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVKUFrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVKUFrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 00:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVKUFrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 00:47:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:21469 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932195AbVKUFrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 00:47:24 -0500
Message-ID: <43815F64.4070502@us.ibm.com>
Date: Sun, 20 Nov 2005 21:47:16 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com> <20051118195657.GI7991@shell0.pdx.osdl.net>
In-Reply-To: <20051118195657.GI7991@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Matthew Dobson (colpatch@us.ibm.com) wrote:
> 
>>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>>for the critical pool into this file
> 
> 
> How do you size this pool?

Trial and error.  If you want networking to survive with no memory other
than the critical pool for 2 minutes, for example, you pick a random value,
block all other allocations (I have a test patch to do this), and send a
boatload of packets at the box.  If it OOMs, you need a bigger pool.
Lather, rinse, repeat.


> Allocations are interrupt driven, so how to you
> ensure you're allocating for the cluster network traffic you care about?

On the receive side, you can't. :(  You *have* to allocate an skbuff for
the packet, and only a couple levels up the networking 7-layer burrito can
you tell if you can toss the packet as non-critical or keep it.  On the
send side, you can create a simple socket flag that tags all that socket's
SEND requests as critical.


>>/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>>the system is in an emergency state and authorize the kernel to dip into
>>the critical pool to satisfy critical allocations.
> 
> 
> Seems odd to me.  Why make this another knob?  How did you run to set this
> flag if you're in emergency and kswapd is going nuts?

We did this because we didn't want __GFP_CRITICAL allocations  dipping into
the pool in the case of a transient low mem situation.  In those cases we
want to force the task to do writeback to get a page (as usual), so that
the critical pool will be full when the system REALLY goes critical.  We
also open the in_emergency file when the app starts so that we can just
write to it and don't need to try to open it when kswapd is going nuts.

-Matt
