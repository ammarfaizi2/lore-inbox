Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVHYM0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVHYM0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVHYM0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:26:47 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:33160 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964957AbVHYM0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:26:46 -0400
Message-ID: <430DB8FA.4080009@cosmosbay.com>
Date: Thu, 25 Aug 2005 14:26:34 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain>	 <1124956563.3222.8.camel@laptopd505.fenrus.org>	 <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>	 <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>	 <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site>
In-Reply-To: <1124968309.5856.9.camel@npiggin-nld.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 14:26:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :
> On Thu, 2005-08-25 at 12:41 +0200, Eric Dumazet wrote:
> 
> 
>>OK, here is a new clean patch that address this problem (nothing assumed about 
>>atomics)
>>
> 
> 
> Would you just be able to add the atomic sysctl handler that
> Christoph suggested?
> 

Quite a lot of work indeed, and it would force to convert 3 int (nr_files, 
nr_free_files, max_files) to 3 atomic_t. I feel bad introducing a lot of 
sysctl rework for a tiny change (removing filp_count_lock)

> This introduces lost update problems. 2 CPUs may store to nr_files
> in the opposite order that they incremented atomic_nr_files.
> 

That's true, and the difference can be relatively important in case of preemption.

Each time the true and correct value  (atomic_nr_files) is updated, a copy is 
done on nr_files : as nr_files is only used to be a guard value against too 
many file allocations, a somewhat 'lazy' value has no impact at all.

> It is not terribly bad, because the drift is not cumulative and the
> field can't go negative... but its just ugly to add this hack
> because there is no atomic sysctl handler.
> 
> Eliminating the cli/sti is a good idea though, I think.
> 

