Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWFNQdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWFNQdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWFNQdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:33:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3783 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965028AbWFNQdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:33:17 -0400
Date: Wed, 14 Jun 2006 09:33:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
In-Reply-To: <449033B0.1020206@bull.net>
Message-ID: <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
 <449033B0.1020206@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006, Zoltan Menyhart wrote:

> > On IA64 we we would trade an interrupt disable/ load / add / store
> > /interrupt enable against one fetchadd instruction with this patch. How
> > bad/good a trade is that?
> 
> On one hand, switching to local counters can be a good idea if they are not
> evicted from the caches by the usual NRU/LRU cache replacement...
> 
> On the other hand, I do not think the ia64's fetchadd instruction is
> expensive.
> If your data is in L2, then it takes 11 clock cycles.
> 
> I do not think the counters have got much chance to stay in L1.
> Anyway, L1 is write through, you'll need to copy the updated value
> back into L2.
> As the shortest L2 access takes 5 clock cycles...
> You need 2 of them. (Assuming a counter is always in L2.)
> And add interrupt disable/enable time...

Could you do a clock cycle comparision of an 

atomic_inc(__get_per_cpu(var))
(the fallback of local_t on ia64)

vs.

local_irq_save(flags)
__get_per_cpu(var)++
local_irq_restore(flags)
(ZVC like implementation)

vs.

get_per_cpu(var)++
put_cpu()
(current light weight counters)
