Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVJRCai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVJRCai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 22:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVJRCai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 22:30:38 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30893 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932386AbVJRCah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 22:30:37 -0400
Date: Tue, 18 Oct 2005 11:29:18 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
In-Reply-To: <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
References: <20051017184523.GB26239@granada.merseine.nu> <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051018101604.6795.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Linus-san.

> NOTE! Even if the machine has 4GB or more of memory, it's entirely likely 
> that the quick "use NODE(0)" hack will work fine. 
> 
> Why? Because the bootmem memory should still be allocated low-to-high by 
> default, which means that as logn as NODE(0) has _enough_ memory in the 
> DMA range, we should be ok.
> 
> So I _think_ the simple one-liner NODE(0) patch is sufficient, and should 
> work (and is a lot more acceptable for 2.6.14 than switching the node 
> ordering around yet again, or doing bigger surgery on the bootmem code).
> 
> So the only thing that worried me (and made me ask whether there might be 
> machines where it doesn't work) is if some machines might have their high 
> memory (or no memory at all) on NODE(0). It does sound unlikely, but I 
> simple don't know what kind of strange NUMA configs there are out there.
> 
> And I'm definitely only interested in machines that are out there, not 
> some theoretical issues.

In our making IA64 machine node 0 might not have any low-memory, and
another node can have low-memory instead.

This cause comes from hotplug whole of one node.
For example, please imagine following case.

1) In this case, firmware remembers pxm 1's node has low memory.

                 node 0             node 1 
               +--------------+  +-----------+
               |  pxm = 1     |  | pxm = 2   |
               |  low memory  |  |           |
               +--------------+  +-----------+


2) If one node is hot-added at pxm = 0 (pxm is decided from physical
   locate by firmware.), new node will be node 2.

  node 2          node 0          node 1 
+-----------+  +--------------+  +-----------+
| pxm = 0   |  |  pxm = 1     |  | pxm = 2   |
|           |  |  low memory  |  |           |
+-----------+  +--------------+  +-----------+

3) If user reboots the machine, Linux decides node id from pxm's order.
   But firmware still remembers which node has low memory.
   So, node 0 will not have any low memory.

  node 0          node 1          node 2
+-----------+  +--------------+  +-----------+
| pxm = 0   |  |  pxm = 1     |  | pxm = 2   |
|           |  |  low memory  |  |           |
+-----------+  +--------------+  +-----------+

So, just "use NODE(0)" is not enough hack for our machine.
If "use NODE(0)" is selected, kernel must sort pgdat link and
node id by memory address. I think that hot add code will be a 
bit messy instead.

Thanks.

-- 
Yasunori Goto 

