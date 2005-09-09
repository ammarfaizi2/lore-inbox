Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbVIICHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbVIICHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbVIICHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:07:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39873 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965237AbVIICHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:07:00 -0400
Message-ID: <4320EE3E.8010902@us.ibm.com>
Date: Thu, 08 Sep 2005 22:06:54 -0400
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       viro@ZenIV.linux.org.uk
Subject: Re: [PATCH 1/2] (repost) New System call, unshare (fwd)
References: <Pine.WNT.4.63.0509071350080.4008@IBM-AIP3070F3AM> <431F95C3.8010200@yahoo.com.au>
In-Reply-To: <431F95C3.8010200@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Janak Desai wrote:
> 
> 
>> -    tsk->min_flt = tsk->maj_flt = 0;
>> -    tsk->nvcsw = tsk->nivcsw = 0;
>> +    /*
>> +     * If the process memory is being duplicated as part of the
>> +     * unshare system call, we are working with the current process
>> +     * and not a newly allocated task strucutre, and should not
>> +     * zero out fault info, context switch counts, mm and active_mm
>> +     * fields.
>> +     */
>> +    if (copy_share_action == MAY_SHARE) {
>> +        tsk->min_flt = tsk->maj_flt = 0;
>> +        tsk->nvcsw = tsk->nivcsw = 0;
>>  
> 
> 
> Why don't you just do this in copy_process?
> 

I was trying to avoid changing interface of copy_process since it
is also used by do_fork() and fork_idle().

>> -    tsk->mm = NULL;
>> -    tsk->active_mm = NULL;
>> +        tsk->mm = NULL;
>> +        tsk->active_mm = NULL;
>> +    }
>>  
>>      /*
>>       * Are we cloning a kernel thread?
>> @@ -1002,7 +1023,7 @@ static task_t *copy_process(unsigned lon
>>          goto bad_fork_cleanup_fs;
>>      if ((retval = copy_signal(clone_flags, p)))
>>          goto bad_fork_cleanup_sighand;
>> -    if ((retval = copy_mm(clone_flags, p)))
>> +    if ((retval = copy_mm(clone_flags, p, MAY_SHARE)))
>>          goto bad_fork_cleanup_signal;
>>      if ((retval = copy_keys(clone_flags, p)))
>>          goto bad_fork_cleanup_mm;
>> @@ -1317,3 +1338,172 @@ void __init proc_caches_init(void)
>>              sizeof(struct mm_struct), 0,
>>              SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>>  }
>> +
>> +/*
>> + * unshare_mm is called from the unshare system call handler function to
>> + * make a private copy of the mm_struct structure. It calls copy_mm with
>> + * CLONE_VM flag cleard, to ensure that a private copy of mm_struct 
>> is made,
>> + * and with mm_copy_share enum set to UNSHARE, to ensure that copy_mm
>> + * does not clear fault info, context switch counts, mm and active_mm
>> + * fields of the mm_struct.
>> + */
>> +static int unshare_mm(unsigned long unshare_flags, struct task_struct 
>> *tsk)
>> +{
>> +    int retval = 0;
>> +    struct mm_struct *mm = tsk->mm;
>> +
>> +    /*
>> +     * If the virtual memory is being shared, make a private
>> +     * copy and disassociate the process from the shared virtual
>> +     * memory.
>> +     */
>> +    if (atomic_read(&mm->mm_users) > 1) {
>> +        retval = copy_mm((unshare_flags & ~CLONE_VM), tsk, UNSHARE);
>> +
>> +        /*
>> +         * If copy_mm was successful, decrement the number of users
>> +         * on the original, shared, mm_struct.
>> +         */
>> +        if (!retval)
>> +            atomic_dec(&mm->mm_users);
>> +    }
>> +    return retval;
>> +}
>> +
> 
> 
> What prevents thread 1 from decrementing mm_users after thread 2 has
> found it to be 2?
> 

Yes, Chris pointed out that as well. I will be reviewing and reworking
this logic.

Thanks.

-Janak


