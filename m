Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWFNQFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWFNQFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWFNQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:05:14 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:36487 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965015AbWFNQFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:05:12 -0400
Message-ID: <449033B0.1020206@bull.net>
Date: Wed, 14 Jun 2006 18:05:04 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 18:08:55,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 18:08:56,
	Serialize complete at 14/06/2006 18:08:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> One way of making the light weight counters race free for x86_64 and
> i386 is to use local_t. With that those two platforms are fine.
> 
> However, the others fall back to atomic operations.
> 
> Maybe we could deal with that on per platform basis? Some platforms may 
> want to switch the local_t implementation away from atomics to regular 
> integers if preemption is not configured. Most commercial Linux distros 
> ship with preempt off. So this would preserve the speed of light weight 
> counters, while holding off the worst races. But it still could allow
> interrupts while the counter is being incremented and so it would not 
> be race free. This would no longer allow the use of local_t for 
> refcounts but I think those uses are not that performance critical
> and we may just switch to atomic. Maybe I am just off in fantasyland.
> 
> Andi?
> 
> Another thing to investigate (at least on ia64) is how significant the 
> impact of a fetchadd instruction is if none of the results are used. Maybe 
> it is tolerable and we can stay with the existing implementation.
> 
> On IA64 we we would trade an interrupt disable/ load / add / store /interrupt 
> enable against one fetchadd instruction with this patch. How bad/good a 
> trade is that?

On one hand, switching to local counters can be a good idea if they are not
evicted from the caches by the usual NRU/LRU cache replacement...

On the other hand, I do not think the ia64's fetchadd instruction is
expensive.
If your data is in L2, then it takes 11 clock cycles.

I do not think the counters have got much chance to stay in L1.
Anyway, L1 is write through, you'll need to copy the updated value
back into L2.
As the shortest L2 access takes 5 clock cycles...
You need 2 of them. (Assuming a counter is always in L2.)
And add interrupt disable/enable time...

Regards,

Zoltan Menyhart
