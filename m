Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVKUF6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVKUF6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 00:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVKUF6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 00:58:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37080 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932201AbVKUF6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 00:58:31 -0500
Message-ID: <43816200.9060303@us.ibm.com>
Date: Sun, 20 Nov 2005 21:58:24 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com> <20051120230456.GE2556@spitz.ucw.cz>
In-Reply-To: <20051120230456.GE2556@spitz.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Fri 18-11-05 11:32:57, Matthew Dobson wrote:
> 
>>We have a clustering product that needs to be able to guarantee that the
>>networking system won't stop functioning in the case of OOM/low memory
>>condition.  The current mempool system is inadequate because to keep the
>>whole networking stack functioning, we need more than 1 or 2 slab caches to
>>be guaranteed.  We need to guarantee that any request made with a specific
>>flag will succeed, assuming of course that you've made your "critical page
>>pool" big enough.
>>
>>The following patch series implements such a critical page pool.  It
>>creates 2 userspace triggers:
>>
>>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>>for the critical pool into this file
>>
>>/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>>the system is in an emergency state and authorize the kernel to dip into
>>the critical pool to satisfy critical allocations.
>>
>>We mark critical allocations with the __GFP_CRITICAL flag, and when the
>>system is in an emergency state, we are allowed to delve into this pool to
>>satisfy __GFP_CRITICAL allocations that cannot be satisfied through the
>>normal means.
> 
> 
> Ugh, relying on userspace to tell you that you need to dip into emergency
> pool seems to be racy and unreliable. How can you guarantee that userspace
> is scheduled soon enough in case of OOM?
> 							Pavel

It's not really for userspace to tell us that we're about to OOM, as the
kernel is in a far better position to determine that.  It is to let the
kernel know that *something* has gone wrong, and we've got to keep
networking (or any other user of __GFP_CRITICAL) up for a few minutes, *no
matter what*.  We may not ever OOM, or even run terribly low on memory, but
the trigger allows the use of the pool IF that happens.

-Matt
