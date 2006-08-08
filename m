Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWHHPvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWHHPvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWHHPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:51:36 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:19591 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964972AbWHHPvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:51:35 -0400
Message-ID: <44D8B35D.2070908@sw.ru>
Date: Tue, 08 Aug 2006 19:53:01 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xemul@sw.ru,
       hch@infradead.org
Subject: Re: [PATCH] unserialized task->files changing (v2)
References: <44D87611.7070705@sw.ru> <200608081451.58305.dada1@cosmosbay.com>
In-Reply-To: <200608081451.58305.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

> Sorry but there is something I dont understand. You ignored my point.
Sorry, I missed it thinking that you are talking about another thing...
Pavel described the race in more details and why barrier doesn't help.
Hope, it became more clear now.

> +void reset_files_struct(struct task_struct *tsk, struct files_struct *files)
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
> If this patch corrects the 'bug', then a simpler fix would  be to use a memory 
> barrier between "tsk->files = files" and "put_files_struct(old);" 
> 
> No need to perform 2 atomics ops on the task lock.
> 
> old = tsk->files;
> tsk->files = files;
> smp_mb();
> put_files_struct(old);
> 
> That would be enough to guard against proc code (because this code only needs 
> to read tsk->files of course)
> 
> The same remark can be said for __exit_files() from kernel/exit.c
> 
> If this task_lock()/task_unlock() patch is really needed, then a comment in 
> the source would be very fair.

Kirill
