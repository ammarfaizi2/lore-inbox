Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVIYJXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVIYJXK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 05:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVIYJXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 05:23:09 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:7552 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750980AbVIYJXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 05:23:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=J6xhHFywDue6dsXmAGX+Uc1y3GUXgdZJN1DMJtUJJppS0jrLb+v6VKivtVc1dYw9BTGHkkjW+W8NWTNa4AtQJWFGHXQ/pXQfzFsaPxFoA/Nvl315PFim8tmxWi2cxytOVUwEEanaYHXWrnoyis7a/l5g4daSJTy/z/hlbKDGEyg=  ;
Message-ID: <43366CBA.5010306@yahoo.com.au>
Date: Sun, 25 Sep 2005 19:24:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au> <43365BCA.6030904@gmail.com> <43365F82.1040801@yahoo.com.au> <433665A4.6010400@gmail.com>
In-Reply-To: <433665A4.6010400@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

>  Other than local_bh_disable/enable(), all brsem read ops do are
> 
>  1. accessing sem->idx
>  2. calculate per-cpu rcnt address from sem->idx
>  3. do one branch on the value of per-cpu rcnt
>  4. inc/dec per-cpu rcnt
> 
>  So, it does access one more cachline and, yeap, there is one branch for 
> bh enabling and several more inside local_bh_enable.  I'll try to get 
> some benchmark numbers for comparison.
> 

Well local_bh_disable touches the preempt count too, although we
can probably assume that's hot in cache.

You might also find yours has a bigger icache footprint as well.

>  I'm thinking about adding down_read(&xxx->s_umount) to write(2) and 
> compare normal rwsem and brsem performance by repeitively writing short 
> data into a file on a UP machine.  Do you have better ideas?
> 

To be honest I'd say that you wouldn't be able to measure it if
you're going through a regular system call path, although such
a measurement certainly won't hurt.

I don't have a better idea though. I don't think a busy loop
microbenchmark is going to be very informative either, it might
actually give a measurable difference but that difference
probably won't be too representitive of real use :\

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
