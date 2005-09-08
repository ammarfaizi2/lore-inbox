Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVIHBgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVIHBgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVIHBgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:36:44 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:64367 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932545AbVIHBgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:36:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=v7gqAAYs5D8SJYuf1bCjnVl5ISHBi7QXYrkzeMPTDKcH1iUEZh2aNwgkazHNnrCFPBc43JYD/uja1Xp/Dsa6+xOFAd/4GXifIb1aAJsxFePKNXHMEb6MkH+ZUlLVWovf1a3Gq5qdud6MUQKjmAHpaAcW/Ugf6b0WfK1BG1SyRpA=  ;
Message-ID: <431F95C3.8010200@yahoo.com.au>
Date: Thu, 08 Sep 2005 11:37:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Janak Desai <janak@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] (repost) New System call, unshare (fwd)
References: <Pine.WNT.4.63.0509071350080.4008@IBM-AIP3070F3AM>
In-Reply-To: <Pine.WNT.4.63.0509071350080.4008@IBM-AIP3070F3AM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai wrote:


> -	tsk->min_flt = tsk->maj_flt = 0;
> -	tsk->nvcsw = tsk->nivcsw = 0;
> +	/*
> +	 * If the process memory is being duplicated as part of the
> +	 * unshare system call, we are working with the current process
> +	 * and not a newly allocated task strucutre, and should not
> +	 * zero out fault info, context switch counts, mm and active_mm
> +	 * fields.
> +	 */
> +	if (copy_share_action == MAY_SHARE) {
> +		tsk->min_flt = tsk->maj_flt = 0;
> +		tsk->nvcsw = tsk->nivcsw = 0;
>  

Why don't you just do this in copy_process?

> -	tsk->mm = NULL;
> -	tsk->active_mm = NULL;
> +		tsk->mm = NULL;
> +		tsk->active_mm = NULL;
> +	}
>  
>  	/*
>  	 * Are we cloning a kernel thread?
> @@ -1002,7 +1023,7 @@ static task_t *copy_process(unsigned lon
>  		goto bad_fork_cleanup_fs;
>  	if ((retval = copy_signal(clone_flags, p)))
>  		goto bad_fork_cleanup_sighand;
> -	if ((retval = copy_mm(clone_flags, p)))
> +	if ((retval = copy_mm(clone_flags, p, MAY_SHARE)))
>  		goto bad_fork_cleanup_signal;
>  	if ((retval = copy_keys(clone_flags, p)))
>  		goto bad_fork_cleanup_mm;
> @@ -1317,3 +1338,172 @@ void __init proc_caches_init(void)
>  			sizeof(struct mm_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>  }
> +
> +/*
> + * unshare_mm is called from the unshare system call handler function to
> + * make a private copy of the mm_struct structure. It calls copy_mm with
> + * CLONE_VM flag cleard, to ensure that a private copy of mm_struct is made,
> + * and with mm_copy_share enum set to UNSHARE, to ensure that copy_mm
> + * does not clear fault info, context switch counts, mm and active_mm
> + * fields of the mm_struct.
> + */
> +static int unshare_mm(unsigned long unshare_flags, struct task_struct *tsk)
> +{
> +	int retval = 0;
> +	struct mm_struct *mm = tsk->mm;
> +
> +	/*
> +	 * If the virtual memory is being shared, make a private
> +	 * copy and disassociate the process from the shared virtual
> +	 * memory.
> +	 */
> +	if (atomic_read(&mm->mm_users) > 1) {
> +		retval = copy_mm((unshare_flags & ~CLONE_VM), tsk, UNSHARE);
> +
> +		/*
> +		 * If copy_mm was successful, decrement the number of users
> +		 * on the original, shared, mm_struct.
> +		 */
> +		if (!retval)
> +			atomic_dec(&mm->mm_users);
> +	}
> +	return retval;
> +}
> +

What prevents thread 1 from decrementing mm_users after thread 2 has
found it to be 2?

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
