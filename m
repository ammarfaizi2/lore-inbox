Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWH2ScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWH2ScJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWH2ScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:32:09 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:12492 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965246AbWH2ScH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:32:07 -0400
Message-ID: <44F48825.4050408@zabbo.net>
Date: Tue, 29 Aug 2006 11:32:05 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Yi Yang <yang.y.yi@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
References: <44F43F46.1070702@gmail.com>
In-Reply-To: <44F43F46.1070702@gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, we shouldn't merge this patch in its current form.

> In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
> and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
> does know them, I think the correct errno should be -EOPNOTSUPP which
> means they aren't be implemented or supported.

Like it or not, the sys_io_submit() interface returns -EINVAL when the
file descriptor doesn't support the requested command.  Changing the
binary interface is a big deal and should not be done lightly.  What is
the motivation for making this change?

Even if we decided to, we'd want to do it for all the commands.  This
patch only addresses F{D,}SYNC.  All the other commands would still
return -EINVAL if the descriptor doesn't have the corresponding ->aio_
method, leaving userspace do deal with more complexity.

> -static ssize_t aio_fdsync(struct kiocb *iocb)
> -{
> -	struct file *file = iocb->ki_filp;
> -	ssize_t ret = -EINVAL;
> -
> -	if (file->f_op->aio_fsync)
> -		ret = file->f_op->aio_fsync(iocb, 1);
> -	return ret;
> -}
> -
>  static ssize_t aio_fsync(struct kiocb *iocb)
>  {
>  	struct file *file = iocb->ki_filp;
> -	ssize_t ret = -EINVAL;
> +	ssize_t ret = -EOPNOTSUPP;
>  
>  	if (file->f_op->aio_fsync)
>  		ret = file->f_op->aio_fsync(iocb, 0);

>  	case IOCB_CMD_FDSYNC:
> -		ret = -EINVAL;
> +		ret = -EOPNOTSUPP;
>  		if (file->f_op->aio_fsync)
> -			kiocb->ki_retry = aio_fdsync;
> +			kiocb->ki_retry = aio_fsync;

Hmm, your most recent patch didn't mention this aio_f{d,}sync() change
though the earlier one did.  Please make sure all patch submissions have
complete descriptions.

These calls are not the same, notice that they differ in the second
argument to their ->aio_fsync() calls.  Cleaning up the ->aio_fsync()
interface might well be reasonable.  Missing that subtle difference
suggests that it should be more clear and there are precisely zero
merged ->aio_fsync() users.  But that kind of cleanup belongs in a
separate patch with its own justification.

Are you working with an ->aio_fsync() user that might be merged?

- z
