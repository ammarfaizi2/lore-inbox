Return-Path: <linux-kernel-owner+w=401wt.eu-S964794AbXADTI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbXADTI7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbXADTI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:08:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:59437 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbXADTI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:08:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=RpHWtbeo7kuF1IlfE6xKa+3Uzu3SurrMmSru5EOAlBKcXDaKTQJ0UE57+EEOVhsQi2tR6+SsA6tdghExJCcjEkNHjSmmyeFK6gbSFUhWjajvPO6pfE3IIvzdqJYfCVUtONngpaCe0Wt4/So/NkcxQSsMbkvshVYl6shdeYVfnY8=
Date: Thu, 4 Jan 2007 19:07:00 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 8/8] user ns: implement user ns unshare
Message-ID: <20070104190700.GB17863@slug>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181310.GI11377@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104181310.GI11377@sergelap.austin.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 12:13:10PM -0600, Serge E. Hallyn wrote:
> From: Serge E. Hallyn <serue@us.ibm.com>
> Subject: [PATCH -mm 8/8] user ns: implement user ns unshare
> 
> Implement CLONE_NEWUSER flag useable at clone/unshare.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
  
>  int copy_user_ns(int flags, struct task_struct *tsk)
>  {
> -	struct user_namespace *old_ns = tsk->nsproxy->user_ns;
> +	struct user_namespace *new_ns, *old_ns = tsk->nsproxy->user_ns;
>  	int err = 0;
        ^^^^^^^^^^^^
The "= 0" is superfluous here.
>  
>  	if (!old_ns)
>  		return 0;
>  
>  	get_user_ns(old_ns);
> -	return err;
> +	if (!(flags & CLONE_NEWUSER))
> +		return 0;
> +	err = -EPERM;
> +	if (!capable(CAP_SYS_ADMIN))
> +		goto out;
> +	err = -ENOMEM;
> +	new_ns = clone_user_ns(old_ns);
> +	if (!new_ns)
> +		goto out;
> +
> +	tsk->nsproxy->user_ns = new_ns;
> +	err = 0;
> +out:
> +	put_user_ns(old_ns);
> +	return 0;
        ^^^^^^^^^
Should be "return err;"

Regards,
Frederik
>  }
>  
>  void free_user_ns(struct kref *kref)
> -- 
> 1.4.1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
