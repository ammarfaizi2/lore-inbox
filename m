Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVIYLWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIYLWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 07:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVIYLWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 07:22:07 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:5271 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750786AbVIYLWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 07:22:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KoTgU1A2Eqyw8JqrNHlr9h7fz9BFbtur1Z2GnUgL5r3BwsiD5acecbAmVQKesGNlvctc8vBpuYWynjRER6/FJCAF8rMBqBIBU/Tc9nl+QTfAOON0zo/fa2zjVZilS/FnIncqLygtVSMJqv1ibuYRp7M5NKQMjrf5IyQOD2Azobk=  ;
Message-ID: <43368887.2020008@yahoo.com.au>
Date: Sun, 25 Sep 2005 21:22:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.FF1C2BEC@htj.dyndns.org> <43364F70.7010705@yahoo.com.au> <43365BCA.6030904@gmail.com> <43365F82.1040801@yahoo.com.au> <433665A4.6010400@gmail.com> <43366CBA.5010306@yahoo.com.au> <43367676.1080308@gmail.com>
In-Reply-To: <43367676.1080308@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

>  I did a busy-loop microbenchmark, and I think it's informative enough. :-)
> 

Great!

>  The following command is run on three versions - vanilla version, one 
> with read_down/up(->s_umount) added to vfs_write(), and one with 
> brsem_read_down/up(->s_umount) added to vfs_write().
> 
> # time -p dd if=/dev/zero of=out bs=32 count=10M
> 
>  The test is run three times and the results are averaged.
> 
> a. vanilla
> 
> real 58.63
> user 5.61
> sys 52.37
> 
> b. rwsem
> 
> real 59.24
> user 6.06
> sys 52.29
> 
> c. brsem
> 
> real 61.74
> user 5.78
> sys 55.04
> 
>  I don't think brsem has any chance of being faster than rwsem if it's 
> slower in this micro benchmark.  One weird thing is that the result of 
> rwsem consistently showed higher user time and lower system time than 
> vanilla (no synchronization) case, maybe oprofiling will tell something.
> 

Yep, probably just some timing or cache anomaly, generally just
sum the user and system time in the case where you are running
identical userspace code... I wouldn't worry too much about it.

>  Anyways, you were absolutely right.  My brsem was a pretty stupid idea 
> after all.  Let's hope at least I learned something from it.  :-(
> 

I wouldn't say stupid. Implementation was too complex, but some
clever ideas were required to solve the problems you identified.

There are definitely a couple of possible places where a brsem
may be useful, and I think cpucontrol semaphore is one of those.

Al can probably comment on its use in the superblock. It seems
fair enough, though I think we'll want to slim down my naive
rwsem array and maybe think about using alloc_percpu.

Is the remount case much rarer than mount/unmount? Do we need to
be careful about bloating the size of the superblock on large
machines? In that case maybe a global remount brsem will be
enough to handle this race?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
