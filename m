Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWFDC2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWFDC2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWFDC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:28:36 -0400
Received: from mail32.syd.optusnet.com.au ([211.29.132.63]:12721 "EHLO
	mail32.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751445AbWFDC2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:28:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 1/4] sched: Add CPU rate soft caps
Date: Sun, 4 Jun 2006 12:27:54 +1000
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Sam Vilain <sam@vilain.net>,
       "Eric W.Biederman" <ebiederm@xmission.com>, Srivatsa <vatsa@in.ibm.com>,
       Balbir Singh <bsingharora@gmail.com>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060604010831.2648.37997.sendpatchset@heathwren.pw.nest> <20060604010841.2648.43027.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060604010841.2648.43027.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041227.55892.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 11:08, Peter Williams wrote:
> 3. Thanks to suggestions from Con Kolivas with respect to alternative
> methods to reduce the possibility of a task being starved of CPU while
> holding an important system resource, enforcement of caps is now
> quite strict.  However, there will still be occasions where caps may be
> exceeded due to this mechanism vetoing enforcement.

Transcription bug here:

>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>  {
> +	int ret;
> +
>  	might_sleep();
>  	return __mutex_fastpath_lock_retval
>  			(&lock->count, __mutex_lock_interruptible_slowpath);

should be ret = 

> +
> +	if (!ret)
> +		inc_mutex_count();
> +
> +	return ret;
>  }
>

compare with here:

>  EXPORT_SYMBOL(mutex_lock_interruptible);
> @@ -366,8 +390,13 @@ static inline int __mutex_trylock_slowpa
>   */
>  int fastcall __sched mutex_trylock(struct mutex *lock)
>  {
> -	return __mutex_fastpath_trylock(&lock->count,
> +	int ret = __mutex_fastpath_trylock(&lock->count,
>  					__mutex_trylock_slowpath);
> +
> +	if (!ret)
> +		inc_mutex_count();
> +
> +	return ret;
>  }
>
>  EXPORT_SYMBOL(mutex_trylock);

-- 
-ck
