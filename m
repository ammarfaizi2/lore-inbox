Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVLOI4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVLOI4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVLOI4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:56:21 -0500
Received: from smtpout.mac.com ([17.250.248.46]:31211 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965179AbVLOI4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:56:20 -0500
In-Reply-To: <20051215.002120.133621586.davem@davemloft.net>
References: <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net> <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com> <20051215.002120.133621586.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E6D85FF-E546-4057-80EF-7479021AFAA1@mac.com>
Cc: sri@us.ibm.com, mpm@selenic.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC] Fine-grained memory priorities and PI
Date: Thu, 15 Dec 2005 03:55:53 -0500
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 15, 2005, at 03:21, David S. Miller wrote:
> Not when we run out, but rather when we reach some low water mark,  
> the "critical sockets" would still use GFP_ATOMIC memory but only  
> "critical sockets" would be allowed to do so.
>
> But even this has faults, consider the IPSEC scenerio I mentioned,  
> and this applies to any kind of encapsulation actually, even simple  
> tunneling examples can be concocted which make the "critical  
> socket" idea fail.
>
> The knee jerk reaction is "mark IPSEC's sockets critical, and mark  
> the tunneling allocations critical, and... and..."  well you have  
> GFP_ATOMIC then my friend.
>
> In short, these "seperate page pool" and "critical socket" ideas do  
> not work and we need a different solution, I'm sorry folks spent so  
> much time on them, but they are heavily flawed.

What we really need in the kernel is a more fine-grained memory  
priority system with PI, similar in concept to what's being done to  
the scheduler in some of the RT patchsets.  Currently we have a very  
black-and-white memory subsystem; when we go OOM, we just start  
killing processes until we are no longer OOM.  Perhaps we should have  
some way to pass memory allocation priorities throughout the kernel,  
including a "this request has X priority", "this request will help  
free up X pages of RAM", and "drop while dirty under certain OOM to  
free X memory using this method".

The initial benefit would be that OOM handling would become more  
reliable and less of a special case.  When we start to run low on  
free pages, it might be OK to kill the SETI@home process long before  
we OOM if such action might prevent the OOM.  Likewise, you might be  
able to flag certain file pages as being "less critical", such that  
the kernel can kill a process and drop its dirty pages for files in / 
tmp.  Or the kernel might do a variety of other things just by  
failing new allocations with low priority and forcing existing  
allocations with low priority to go away using preregistered handlers.

When processes request memory through any subsystem, their memory  
priority would be passed through the kernel layers to the allocator,  
along with any associated information about how to free the memory in  
a low-memory condition.  As a result, I could configure my database  
to have a much higher priority than SETI@home (or boinc or whatever),  
so that when the database server wants to fill memory with clean DB  
cache pages, the kernel will kill SETI@home for it's memory, even if  
we could just leave some DB cache pages unfaulted.

Questions? Comments? "This is a terrible idea that should never have  
seen the light of day"? Both constructive and destructive criticism  
welcomed! (Just please keep the language clean! :-D)

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



