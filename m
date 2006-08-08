Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWHHNRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWHHNRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHHNRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:17:51 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:60499 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932568AbWHHNRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:17:36 -0400
Message-ID: <44D88F11.1010603@sw.ru>
Date: Tue, 08 Aug 2006 17:18:09 +0400
From: "Pavel V. Emelianov" <xemul@sw.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: [PATCH] unserialized task->files changing (v2)
References: <44D87611.7070705@sw.ru> <200608081451.58305.dada1@cosmosbay.com>
In-Reply-To: <200608081451.58305.dada1@cosmosbay.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Tuesday 08 August 2006 13:31, Kirill Korotaev wrote:
>> Fixed race on put_files_struct on exec with proc.
>> Restoring files on current on error path may lead
>> to proc having a pointer to already kfree-d files_struct.
>>
>> ->files changing at exit.c and khtread.c are safe as
>> exit_files() makes all things under lock.
>>
>> v2 patch changes:
>> - introduced reset_files_struct() as Christoph Hellwig suggested
>>
>> Found during OpenVZ stress testing.
>
> Sorry but there is something I dont understand. You ignored my point.
>
> +void reset_files_struct(struct task_struct *tsk, struct files_struct 
> *files)
> +{
> +       struct files_struct *old;
> +
> +       old = tsk->files;
> +       task_lock(tsk);
> +       tsk->files = files;
> +       task_unlock(tsk);
> +       put_files_struct(old);
> +}
>
> Its seems very strange to protect tsk->files = files with a
> task_lock()/task_unlock(). What is it supposed to guard against ???
>
> If this patch corrects the 'bug', then a simpler fix would be to use a 
> memory
> barrier between "tsk->files = files" and "put_files_struct(old);"
>
> No need to perform 2 atomics ops on the task lock.
>
> old = tsk->files;
> tsk->files = files;
> smp_mb();
> put_files_struct(old);

No. The race being discussed is:

proc code:                             resetting code:
=============================================================================
task_lock(tsk);
files = tsk->files;
                                       old = tsk->files;
                                       tsk->files = files;
                                       put_files_struct(old); /* dec to 0 */
                                            `- kmem_cache_free(files);
get_files_struct(file); /* already free */
task_unlock(tsk);

So having smp_mb() before put_files_struct() does not fix the problem.

>
> That would be enough to guard against proc code (because this code 
> only needs
> to read tsk->files of course)
>
> The same remark can be said for __exit_files() from kernel/exit.c
>
> If this task_lock()/task_unlock() patch is really needed, then a 
> comment in
> the source would be very fair.
>
> Eric



