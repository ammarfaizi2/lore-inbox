Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWHJSrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWHJSrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWHJSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:47:46 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:14278 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1161082AbWHJSrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:47:45 -0400
Message-ID: <44DB7F29.3060901@colorfullife.com>
Date: Thu, 10 Aug 2006 20:47:05 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mpm@selenic.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com> <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com> <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com> <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:
>
>  
>
>>BTW, in recent Linux, many objects are freed by call_rcu(hoo, dealyed_free_foo).
>>Objects are freed far after it was touched.
>>I think catching this kind of freeing will not boost performance by cache-hit if
>>reuse freed page (object). 
>>    
>>
>
>Yes that is a general problem with RCU freeing. One can use the 
>SLAB_DESTROY_BY_RCU option to have RCU applied to the whole slab. In that 
>case on can use the cache hot effect but has the additional problem in RCU 
>of dealing with the issue that the object can be replaced at any time.
>  
>
No SLAB_DESTROY_BY_RCU is not equivalent to delayed_free_foo().
SLAB_DESTROY_BY_RCU just means that the slab allocator uses 
delayed_free_pages() instead of free_pages().
kmem_cache_free() does not delay the reuse, an object will be returned 
by the next kmem_cache_alloc, without any grace periods in between.

Independantly from that point, we need some benchmarks to test the 
allocator.

The last benchmarks  of the slab allocator (that I'm aware of) were done 
with packet routing - packet routing was the reason why the shared_array 
layer was added:
The shared_array layer is used to perform inter-cpu bulk object 
transfers. Without that cache, i.e. if a list_add() / list_del() was 
required to transfer one object from one cpu to another cpu, a 
significant amount of time was spent in the allocator.

Christoph, could you run a test? GigE routing with tiny packets should 
be sufficient. Two cpu bound nics, one does rx, the other one tx. Move 
the skb_head_cache to sslab.

--
    Manfred
