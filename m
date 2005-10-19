Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJSAVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJSAVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJSAVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:21:03 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:33423 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932195AbVJSAVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:21:01 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: 7eggert@gmx.de, Guido Fiala <gfiala@s.netic.de>,
       lkml <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Tue, 18 Oct 2005 17:20:37 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: large files unnecessary trashing filesystem cache?
In-Reply-To: <1129676753.23632.90.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0510181710130.30700@qynat.qvtvafvgr.pbz>
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it><E1ERzTq-0001IA-Ba@be1.lrz>
 <1129676753.23632.90.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Badari Pulavarty wrote:

> On Tue, 2005-10-18 at 23:58 +0200, Bodo Eggert wrote:
>> Badari Pulavarty <pbadari@gmail.com> wrote:
>>> On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
>>
>> [large files trash cache]
>>
>>> Is there a reason why those applications couldn't use O_DIRECT ?
>>
>> The cache trashing will affect all programs handling large files:
>>
>> mkisofs * > iso
>> dd < /dev/hdx42 | gzip > imagefile
>> perl -pe's/filenamea/filenameb/' < iso | cdrecord - # <- never tried
>>
>
> Are these examples which demonstrate the thrashing problem.
> Few product (database) groups here are trying to get me to
> work on a solution before demonstrating the problem. They
> also claim exactly what you are saying. They want a control
> on how many pages (per process or per file or per filesystem
> or system wide) you can have in filesystem cache.
>
> Thats why I am pressing to find out the real issue behind this.
> If you have a demonstratable testcase, please let me know.
> I will be happy to take a look.
>
>
>> Changing a few programs will only partly cover the problems.
>>
>> I guess the solution would be using random cache eviction rather than
>> a FIFO. I never took a look the cache mechanism, so I may very well be
>> wrong here.
>
> Read-only pages should be re-cycled really easily & quickly. I can't
> belive read-only pages are causing you all the trouble.

the problem is that there are many sources of read-only pages (how many 
shared library pages are not read-only for example) and not all of them 
are of equal value to the system

the ideal situation would probably be something like the adaptive 
read-ahead approach where the system balances the saved pages between 
processes/files rather then just benifiting the process that uses pages 
the fastest.

I don't have any idea how to implement this sanely without a horrible 
performance hit due to recordkeeping, but someone else may have a better 
idea.

thinking out loud here, how bad would it be to split the LRU list based on 
the number of things that have a page mapped? even if it only split it 
into a small number of lists (say even just 0, 1+) and then evicted pages 
from the 0 list in prefrence to the 1+ list (or at least add a fixed value 
to the age of the 0 pages to have them age faster). this would limit how 
badly library and code pages get evicted by a large file access.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
