Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTDKRGd (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTDKRGc (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:06:32 -0400
Received: from dp.samba.org ([66.70.73.150]:42682 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261359AbTDKRG3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:06:29 -0400
Date: Sat, 12 Apr 2003 03:15:06 +1000
From: Anton Blanchard <anton@samba.org>
To: Randolph Chung <tausq@parisc-linux.org>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][COMPAT] {get,set}affinity unification
Message-ID: <20030411171506.GA657@krispykreme>
References: <20030411062110.GS12993@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411062110.GS12993@tausq.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> +extern asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
> +					    unsigned long *user_mask_ptr);
> +
> +asmlinkage int compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
> +					    compat_ulong_t *user_mask_ptr)
> +{
> +	unsigned long kernel_mask;
> +	mm_segment_t old_fs;
> +	int ret;
> +
> +	old_fs = get_fs();
> +	set_fs(KERNEL_DS);
> +	ret = sys_sched_getaffinity(pid,
> +				    sizeof(kernel_mask),
> +				    &kernel_mask);
> +	set_fs(old_fs);
> +
> +	if (ret == 0) {
> +		if (put_user(kernel_mask, user_mask_ptr))
> +			ret = -EFAULT;
> +	}
> +
> +	return ret;
> +}

We should really return sizeof(compat_ulong_t) here. Can you check over
the ppc64 and sparc64 versions of these, I think there are some other
problems (getaffinity returns > 0 on success but you check for 0).

Anton
