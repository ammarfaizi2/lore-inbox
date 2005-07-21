Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVGUPiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVGUPiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVGUPiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:38:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33773 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261791AbVGUPiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:38:21 -0400
Date: Thu, 21 Jul 2005 17:38:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
Message-ID: <20050721153824.GB1896@elf.ucw.cz>
References: <1121923059.2936.224.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121923059.2936.224.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch implements freezer support for workqueues. The current
> refrigerator implementation makes all workqueues NOFREEZE, regardless of
> whether they need to be or not.
> 
> While this doesn't appear to have caused any problems with swsusp (ie
> Pavel's version) to date, this is no guarantee for the future.
> Furthermore, it seems better to me to treat kernel and userspace threads
> consistently, and it also enables us to err on the side of caution by
> default with new workqueues.
> 
> Queues can be made unfreezable via the new kthread_nonfreeze_run,
> create_nofreeze_workqueue and create_nofreeze_singlethread_workqueue
> calls, which take the same parameters as kthread_run, create_workqueue
> and create_singlethread_workqueue respectively. Existing call syntax is
> unchanged and the vast majority of current workqueue calls are therefore
> unaffected.
> 
> As far as Suspend2 goes, I don't rate this as critical. May save your
> hard disk partition one day, but that depends upon what workqueues get
> implemented in the future, what out of tree ones do and whether I've
> missed good rationale for having nofreeze on existing in tree instances.
> If you must flame me, call me overly careful :>.

> @@ -151,6 +158,20 @@ struct task_struct *kthread_create(int (
>  
>  	return create.result;
>  }
> +
> +struct task_struct *kthread_create(int (*threadfn)(void *data),
> +				   void *data,
> +				   const char namefmt[], ...)
> +{
> +	char result[TASK_COMM_LEN];
> +
> +	va_list args;
> +	va_start(args, namefmt);
> +	vsnprintf(result, TASK_COMM_LEN, namefmt, args);
> +	va_end(args);
> +	return _kthread_create(threadfn, data, 0, result);
> +}
> +

This is slightly ugly and uses lot of stack. Otherwise patch looks
okay. If you want me to apply it, be sure to put me into To: or at
least Cc:. Or perhaps you want to just mail it to akpm, noting that I
acked it (if you do something with the char result[] :-).

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
