Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUEJWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUEJWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUEJWcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:32:05 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:47262 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261706AbUEJWbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:31:39 -0400
Message-ID: <40A002CE.4020906@cosmosbay.com>
Date: Tue, 11 May 2004 00:31:42 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andre Ben Hamou <andre@bluetheta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com> <409FFADD.7050204@cosmosbay.com> <409FFE22.4050508@bluetheta.com>
In-Reply-To: <409FFE22.4050508@bluetheta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Ben Hamou wrote:

> Eric Dumazet wrote:
>
>> Your program is racy and have undefined behavior.
>>
>> A thread should not close a handle 'used by another thread blocked in 
>> a sytemcall'
>>
>> The race is : if a thread does a close(fd), then the fd value may be 
>> reused by another thread during an open()/socket()/dup()... syscall, 
>> and the first thread could issue the select() syscall (or 
>> read()/write()/...) on the bad file.
>
>
> Apologies, but I don't follow this.
>
> It was my understanding that the (potentially) many threads of a 
> single process all share a canonical file descriptor table. Hence as 
> long as the various calls you mention are issued in a guaranteed 
> order, maintaining state as you go (which is what the 1 second sleep 
> in the test code was a very quick and dirty way to almost do), I don't 
> see how a race condition arises.
>
> If I were to replace the sleep (1) with, say a global semaphore or 
> something similar, would your explanation still hold?
>
So please how do you guarantee that thread 1 runs *before* thread 2)

Thread 1)
        select( fd)

Thread 2)
        close(fd)

Thats not possible.

Only pthread synchronization  are mutexes (or rwlocks, or semaphore). 
And you cannot release mutex/rwlock/semaphore *after* entering Thread1) 
select()

So yes, there is a race condition.

In you example, it can happens that thread 1 must sleep 10 seconds 
before calling select(), because of system scheduling. Your sleep(1) 
cannot garant that the close() is done after the select() call blocked 
into kernel. You can try whatever semaphore you want, you wont be able 
to have a 100% reliable program (even on Solaris)

Eric

> Cheers,
>
> Andre Ben Hamou
> Imperial College London
>

