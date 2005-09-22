Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVIVVZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVIVVZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVIVVZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:25:56 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:13441 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030391AbVIVVZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:25:56 -0400
Message-ID: <43332161.20806@vc.cvut.cz>
Date: Thu, 22 Sep 2005 23:25:53 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Lameter <clameter@engr.sgi.com>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz>	<20050916023005.4146e499.akpm@osdl.org>	<432AA00D.4030706@vc.cvut.cz>	<20050916230809.789d6b0b.akpm@osdl.org>	<432EE103.5020105@vc.cvut.cz>	<20050919112912.18daf2eb.akpm@osdl.org>	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>	<20050919122847.4322df95.akpm@osdl.org>	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>	<20050919221614.6c01c2d1.akpm@osdl.org>	<43301578.8040305@vc.cvut.cz>	<Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>	<4330B5C2.3080300@vc.cvut.cz>	<Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>	<Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com> <20050922130150.0822b882.akpm@osdl.org>
In-Reply-To: <20050922130150.0822b882.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> 
>>On Wed, 21 Sep 2005, Christoph Lameter wrote:
>>
>> > Hmm. This likely has something to do with debugging code. I was unable to 
>> > reproduce this on amd64 with your config. I get another failure with 
>> > 2.6.14-rc2 on ia64 if I enable all the debugging features that you have. 
>> > The system works fine if no debugging is configured:
>> > 
>> > kernel BUG at kernel/workqueue.c:541!
>> > swapper[1]: bugcheck! 0 [1]
>>
>> I fixed the above issue (a structure became larger than the maximum 
>> allowed by the slab allocator) and the kernel boots fine now on an 8 way 
>> ia64. Cannot reproduce the problem.
> 
> 
> Petr can.  I think we're still waiting for him to test the below (please):

Sorry, I've missed that half of email completely.  Yes, it seems to fix problem,
box has currently 8 min uptime, which is 7:55 more than it survived before.
							Thanks,
								Petr Vandrovec

> Could you try the following patch:
> 
> ---
> 
> The numa slab allocator may allocate pages from foreign nodes onto the lists
> for a particular node if a node runs out of memory. Inspecting the slab->nodeid
> field will not reflect that the page is now in use for the slabs of another node.
> 
> This patch fixes that issue by adding a node field to free_block so that the caller
> can indicate which node currently uses a slab.
> 
> Also removes the check for the current node from kmalloc_cache_node since the
> process may shift later to another node which may lead to an allocation on another
> node than intended.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

