Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWAFGfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWAFGfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWAFGfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:35:53 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:62519 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932643AbWAFGfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:35:53 -0500
Message-ID: <43BE0FC3.7030602@cosmosbay.com>
Date: Fri, 06 Jan 2006 07:35:47 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de> <43BBADD5.3070706@cosmosbay.com> <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang a écrit :
> On Wed, 4 Jan 2006, Eric Dumazet wrote:
>> Andi Kleen a écrit :
>>> Eric Dumazet <dada1@cosmosbay.com> writes:
>>>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
>>>> platforms, lowering kmalloc() allocated space by 50%.
>>>
>>> It should be probably a kmem_cache_alloc() instead of a kmalloc
>>> in the first place anyways. This would reduce fragmentation.
>>
>> Well in theory yes, if you really expect thousand of tasks running...
>> But for most machines, number of concurrent tasks is < 200, and using 
>> a special cache for this is not a win.
> 
> is it enough of a win on machines with thousands of concurrent tasks 
> that it would be a useful config option?

Well..., not if NR_CPUS is big too. (We just saw a thread on lkml about 
raising NR_CPUS to 1024 on ia64).

On a 1024 CPUS machine, a kmem cache could use at least 1 MB for its internal 
structures, plus 1024 pages (PAGE_SIZE) for holding the caches (one cache per 
CPU), if you assume at least one task was created on behalf each cpu.

if PAGE_SIZE is 64KB, you end up with 65 MB of ram for the cache. Even with 
100.000 tasks running on the machine, its not a win.

slab caches are very complex machinery that consume O(NR_CPUS) ram.

Eric
