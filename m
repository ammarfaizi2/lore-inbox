Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWEaTiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWEaTiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWEaTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:38:55 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:47242 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965125AbWEaTiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:38:54 -0400
Message-ID: <447DF0C8.7030507@cosmosbay.com>
Date: Wed, 31 May 2006 21:38:48 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory mapped files not updating timestamps
References: <446B3E5D.1030301@redhat.com> <447DD80C.2000408@redhat.com>
In-Reply-To: <447DD80C.2000408@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach a écrit :
> --- linux-2.6.16.i686/mm/msync.c.org
> +++ linux-2.6.16.i686/mm/msync.c
> @@ -206,12 +206,16 @@ asmlinkage long sys_msync(unsigned long 
>  		file = vma->vm_file;
>  		start = vma->vm_end;
>  		if ((flags & MS_ASYNC) && file && nr_pages_dirtied) {
> +			struct address_space *mapping = file->f_mapping;
> +
>  			get_file(file);
>  			up_read(&current->mm->mmap_sem);
> -			balance_dirty_pages_ratelimited_nr(file->f_mapping,
> +			balance_dirty_pages_ratelimited_nr(mapping,
>  							nr_pages_dirtied);
>  			fput(file);

<here>, another thread can perform an munmap(), and the file can be totally 
dismantled.

>  			down_read(&current->mm->mmap_sem);

So referencing 'mapping' is *buggy* here.
I believe that you have to move 'fput(file);' *after* the folloging two lines.

> +			if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
> +				inode_update_time(mapping->host);
>  			vma = find_vma(current->mm, start);
>  		} else if ((flags & MS_SYNC) && file &&
>  				(vma->vm_flags & VM_SHARED)) {


Eric
