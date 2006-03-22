Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWCVG7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWCVG7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWCVG7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:59:20 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:35757 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750996AbWCVG7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:59:19 -0500
Message-ID: <4420F5BF.7030701@cosmosbay.com>
Date: Wed, 22 Mar 2006 07:59:11 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] avoid some atomics in open()/close() for monothreaded
 processes
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com>	<20060314233138.009414b4.akpm@osdl.org>	<4417E047.70907@cosmosbay.com>	<441EFE05.8040506@cosmosbay.com>	<4420DB55.60803@cosmosbay.com>	<4420ED66.5060703@cosmosbay.com> <20060321224140.7e40a380.akpm@osdl.org>
In-Reply-To: <20060321224140.7e40a380.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> Goal : Avoid some locking/unlocking 'struct files_struct'->file_lock for mono 
>> threaded processes.
>>
>> We define files_multithreaded() function .
>>
>> static inline int files_multithreaded(const struct files_struct *files)
>> {
>>         return sizeof(files->file_lock) > 0 && atomic_read(&files->count) > 1;
>> }
> 
> That's bascially sizeof(spinlock_t).  That's architecture dependent and
> varies wildly according to the day of week.

I used sizeof(files->file_lock) instead of sizeof(spinlock_t) because I found 
it more explicit , while not using ugly ifdefs.

> 
> It _might_ work in all situations - probably you checked that.  But I still
> wouldn't do it because it might break in the future.  Let's be explicit and
> stick the appropriate ifdefs in there.
> 
> I'd also consider renaming it to files_shared() - processes are
> multithreaded, not data structures.

Thanks for the feedback, I will redo the patch and test it on various 
platforms before resubmit (including performance data :) )

> 
> Once you're done with that we should change fget_light() and fput_light() to
> use this helper.  Separate patch.

Hum... this discussion is not relevant with fget_light() unless I mistaken.

Nowadays, this function doesnt take spinlock thanks to RCU

Eric
