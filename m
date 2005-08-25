Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVHYPNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVHYPNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVHYPNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:13:20 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:29364 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751114AbVHYPNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:13:20 -0400
Message-ID: <430DE001.8060604@cosmosbay.com>
Date: Thu, 25 Aug 2005 17:13:05 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
 atomic_t
References: <20050824214610.GA3675@localhost.localdomain>	 <1124956563.3222.8.camel@laptopd505.fenrus.org>	 <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>	 <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>	 <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com> <430DDAF2.6030601@yahoo.com.au>
In-Reply-To: <430DDAF2.6030601@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 25 Aug 2005 17:13:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :

> OK, well I would prefer you do the proper atomic operations throughout
> where it "really matters" in file_table.c, and do your lazy synchronize
> with just the sysctl exported value.
> 

But... I got complains about atomic_read(&counter) being 'an atomic op' 
(untrue), so my second patch just doesnt touch the path where nr_files was read.

Furthermore, a lazy sync would mean to change sysctl proc_handler for 
"file-nr" to perform a synchronize before calling proc_dointvec, this would be 
really obscure.

> Unless the fs people had a problem with that.
> 
> And you may as well get rid of the atomic_inc_return which can be more
> expensive on some platforms and doesn't buy you much.
>   atomic_inc;
>   atomic_read;
> Should be enough if you don't care about lost updates here, yeah?
> 

You mean :

atomic_inc(&counter);
lazeyvalue = atomic_read(&counter);

instead of

lazeyvalue = atomic_inc_return(&counter);

In fact I couldnt find one architecture where the later would be more expensive.

> Nick
> 

Eric
