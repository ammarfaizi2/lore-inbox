Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWESCjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWESCjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWESCjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:39:32 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:32222 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932189AbWESCjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:39:31 -0400
Message-Id: <7.0.0.16.2.20060518171223.023cd660@llnl.gov>
X-Mailer: QUALCOMM Windows Eudora Version 7.0.0.16
Date: Thu, 18 May 2006 19:39:06 -0700
To: Andrew Morton <akpm@osdl.org>
From: Dave Peterson <dsp@llnl.gov>
Subject: Re: [PATCH] mm: avoid unnecessary OOM kills
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pj@sgi.com,
       ak@suse.de, linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov,
       dave_peterson@pobox.com
In-Reply-To: <20060518130510.29444628.akpm@osdl.org>
References: <200605181729.k4IHToRU025597@calaveras.llnl.gov>
 <20060518130510.29444628.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:05 PM 5/18/2006, Andrew Morton wrote: 
>>  /* linux/mm/oom_kill.c */
>> +extern volatile unsigned long oom_kill_in_progress;
>
>This shouldn't be volatile.

Yes, I'll fix that.

>> +/*
>> + * Attempt to start an OOM kill operation.  Return 0 on success, or 1 if an
>> + * OOM kill is already in progress.
>> + */
>> +static inline int oom_kill_start(void)
>> +{
>> +     return test_and_set_bit(0, &oom_kill_in_progress);
>> +}
>
>Suggest this be called oom_kill_trystart().

Sounds good.  I'll change the name.

>> +volatile unsigned long oom_kill_in_progress = 0;
>
>This shouldn't be initialised to zero.  The kernel zeroes bss at startup.

Ok, I'll fix this.

>>  /**
>>   * badness - calculate a numeric value for how bad this task has been
>>   * @p: task struct of which task we should calculate
>> @@ -260,27 +262,31 @@
>>       struct mm_struct *mm;
>>       task_t * g, * q;
>>  
>> +     task_lock(p);
>>       mm = p->mm;
>>  
>> -     /* WARNING: mm may not be dereferenced since we did not obtain its
>> -     * value from get_task_mm(p).  This is OK since all we need to do is
>> -     * compare mm to q->mm below.
>> +     if (mm == NULL || mm == &init_mm) {
>> +             task_unlock(p);
>> +             return 1;
>> +     }
>> +
>> +     set_bit(MM_FLAG_OOM_NOTIFY, &mm->flags);
>> +     task_unlock(p);
>
>Putting task_lock() in here would be a fairly obvious way to address the
>fragility which that comment describes.  But I have a feeling that we
>discussed that a couple of weeks ago and found a problem with it, didn't we?

I think task_lock() works fine.  That's what I have above.
When I generated the patch, it looks like I omitted the "-p" flag
to diff.  Thus it looks like the code changes above are in badness()
when they are actually in oom_kill_task().  My apologies (I know this
makes things hard to read).  I'll fix this when I repost.

>So if process A did a successful oom_kill_start(), and processes B, C, D
>and E all get into difficulty as well, they'll go into busywait loops.  The
>cond_resched() will eventually save us from locking up, but it's a bit
>unpleasant.

Hmm... that's a good point.  I kind of assumed the other processes
would go to sleep somewhere inside one of the calls to
get_page_from_freelist(), but it looks like this is not the case.
Without my changes, all of the processes would call out_of_memory()
and then loop back around to "restart".  However there's a call to
schedule_timeout_interruptible() in out_of_memory() that processes B,
C, D, and E will circumvent if my changes are applied.  I'll try to
work out a solution to this and then repost.

On somewhat of a tangent, it seems less than ideal for the allocator
to loop when memory is scarce (even if we may sleep on each
iteration).  An alternative might be something like this: When a task
calls __alloc_pages(), it goes through the zonelists looking for pages
to allocate.  If this fails, the task adds itself to a queue and goes
to sleep.  Then when kswapd() or someone else frees some pages, the
pages are given to queued tasks, which are then awakened with their
requests satisfied.  The memory allocator might optionally choose to
awaken a task without satisfying its request.  Then __alloc_pages()
would return NULL for that task.

I haven't thought through the details of implementing something like
this in Linux.  Perhaps there are issues I'm not aware of that would
make the above approach impractical.  However I'd be curious to hear
your thoughts.

>And I'm trying to work out where process A will run oom_kill_finish() if
>`cancel' ends up being 0 in out_of_memory().  afaict, it doesn't, and the
>oom-killer will be accidentally disabled?

In this case, mmput() will call oom_kill_finish() once the mm_users
count on the mm_struct of the OOM killer victim has reached zero and
the mm_struct has been cleaned out.  Thus additional OOM kills are
prevented until the victim has freed its memory.  Again, this is a bit
unclear because I messed up generating the patch.  Sorry about that.
Will fix shortly...

I should probably also do a better job of adding comments along with
my code changes.


