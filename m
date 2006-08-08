Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHHKoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHHKoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWHHKnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:43:45 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:32190 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964789AbWHHKnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:43:06 -0400
Message-ID: <44D86ADA.5000904@sw.ru>
Date: Tue, 08 Aug 2006 14:43:38 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unserialized task->files changing
References: <44D86275.2080406@sw.ru> <20060808101208.GA25956@infradead.org> <200608081223.10434.dada1@cosmosbay.com>
In-Reply-To: <200608081223.10434.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> On Tuesday 08 August 2006 12:12, Christoph Hellwig wrote:
> 
>>On Tue, Aug 08, 2006 at 02:07:49PM +0400, Kirill Korotaev wrote:
>>
>>>Fixed race on put_files_struct on exec with proc.
>>>Restoring files on current on error path may lead
>>>to proc having a pointer to already kfree-d files_struct.
>>
>>This is three times the exact same code sequence, it should probably go
>>into a helper:
>>
>>void reset_current_files(struct files_struct *files)
>>{
>>	struct files_struct *old = current->files;
>>
>>	task_lock(current);
>>	current->files = files;
>>	task_unlock(current);
>>	put_files_struct(old);
>>}
> 
> 
> 
> More over I think you want to task_lock() before reading current->files 
> into 'old'
> 
> task_lock(current);
> old = current->files;
> current->files = files;
> task_unlock(current);
> put_files_struct(old);
> 
> or maybe a xchg() ?

yeah, never do assignments in declarations :)

BTW, not sure about kthread_exit_files() yet, but looks like it suffers too.

unshare_files() changes current->files w/o locking as well. but I can't see
where it puts the old files... hmm...

Kirill
