Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVLMSZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVLMSZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVLMSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:25:10 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:40865 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932528AbVLMSZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:25:08 -0500
Message-ID: <439F11F9.8070300@cosmosbay.com>
Date: Tue, 13 Dec 2005 19:24:57 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
References: <121a28810511282317j47a90f6t@mail.gmail.com> <20051129000916.6306da8b.akpm@osdl.org> <438C7218.8030109@cosmosbay.com> <20051213180315.GB14158@us.ibm.com>
In-Reply-To: <20051213180315.GB14158@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney a écrit :
> On Tue, Nov 29, 2005 at 04:22:00PM +0100, Eric Dumazet wrote:
> 
>>Hi Andrew
>>
>>Could you add this patch to mm ?
>>
>>Thank you
>>
>>[PATCH] shrinks dentry struct
>>
>>Some long time ago, dentry struct was carefully tuned so that on 32 bits 
>>UP, sizeof(struct dentry) was exactly 128, ie a power of 2, and a multiple 
>>of memory cache lines.
>>
>>Then RCU was added and dentry struct enlarged by two pointers, with nice 
>>results for SMP, but not so good on UP, because breaking the above tuning 
>>(128 + 8 = 136 bytes)
>>
>>This patch reverts this unwanted side effect, by using an union (d_u), 
>>where d_rcu and d_child are placed so that these two fields can share their 
>>memory needs.
>>
>>At the time d_free() is called (and d_rcu is really used), d_child is known 
>>to be empty and not touched by the dentry freeing.
>>
>>Lockless lookups only access d_name, d_parent, d_lock, d_op, d_flags (so 
>>the previous content of d_child is not needed if said dentry was unhashed 
>>but still accessed by a CPU because of RCU constraints)
>>
>>As dentry cache easily contains millions of entries, a size reduction is 
>>worth the extra complexity of the ugly C union.
> 
> 
> Looks sound to me!  Some opportunities for simplification below.
> 
> (Please accept my apologies for the delay -- some diversions turned out
> to be more consuming than I had expected.)
> 
> 							Thanx, Paul
> 

Hi Paul

My patch only address the layout of dentry structure, basically a 'global 
substitute' on various places.

Adding some 'optimizations' or simplifications was not the goal, so please 
submit a patch if you feel the need for it :)

Thank you

Eric
