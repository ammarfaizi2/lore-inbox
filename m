Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVISRLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVISRLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVISRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:11:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:54966 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932505AbVISRLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:11:33 -0400
Date: Mon, 19 Sep 2005 10:11:20 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
In-Reply-To: <200509110911.22212.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0509190958470.25549@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de> <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com>
 <20050910235139.4a8865c2.akpm@osdl.org> <200509110911.22212.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005, Andi Kleen wrote:

> On Sunday 11 September 2005 08:51, Andrew Morton wrote:
> 
> > Certainly I can see value in that.  How can a developer test his
> > code without any form of runtime feedback?
> 
> There are already several ways to do that: first the counters output
> by numastat (local_node, other_node, interleave_hit etc.), which tells you 
> exactly how the allocation strategy ended up. And a process can find out
> on which node a specific page is using get_mempolicy()

get_mempolicy only works from inside the thread that is executing. This 
means all applications would need some specialized library to dump the 
memory allocation information and you would need some external means of 
triggering the dump of node information.

The other methods via numastat gives aggregate values that not useful at 
all if multiple processes are running. Yes, on a bare machine with one 
process running one could determine the memory allocated by searching 
through all nodes in order to guess where the memory was allocated (try 
that on a box with hundreds of nodes!).

However, one still does not know which memory section (vma) is allocated 
on which nodes. And this may be important since critical data may need to 
be interleaved whereas other massive amounts of data may be organized in a 
different way.

> If you really want to know what's going on you can use performance counters
> of the machine to tell you the amount of cross node traffic
> (e.g. see numamon in the numactl source tree as an example) 

Cross node traffic is not the same as memory use. Performance counters are 
a debugging feature, they are complex to manage and only available in a 
limited way.  Its also not trivial figuring out a way to trigger these 
counters in order to get the data.
 
> All it does is to open the flood gates of external mempolicy management, which 
> is wrong.

It does not open those doors since the modification of memory policies is 
still not possible (IMHO this is one element of a series of problematic 
"features" in the policy layer).

External memory policy management is a necessary feature for system 
administration, batch process scheduling as well as for testing and 
debugging a system.
