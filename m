Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWFRIjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWFRIjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWFRIjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:39:22 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:22458 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932170AbWFRIjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:39:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH 1/4] sched: Add CPU rate soft caps
Date: Sun, 18 Jun 2006 18:38:35 +1000
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam@vilain.net>,
       Srivatsa <vatsa@in.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618082648.6061.62247.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060618082648.6061.62247.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181838.36389.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 18:26, Peter Williams wrote:
> 3. Thanks to suggestions from Con Kolivas with respect to alternative
> methods to reduce the possibility of a task being starved of CPU while
> holding an important system resource, enforcement of caps is now
> quite strict.  However, there will still be occasions where caps may be
> exceeded due to this mechanism vetoing enforcement.

I hate to do this to you again but the mutexes held count advice I gave was 
slightly off :|
>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>  {
> +	int ret;
> +
>  	might_sleep();
> -	return __mutex_fastpath_lock_retval
> +	ret = __mutex_fastpath_lock_retval
>  			(&lock->count, __mutex_lock_interruptible_slowpath);
> +
> +	if (!ret)
> +		inc_mutex_count();
> +
> +	return ret;
>  }
>
>  EXPORT_SYMBOL(mutex_lock_interruptible);
> @@ -357,8 +381,13 @@ static inline int __mutex_trylock_slowpa
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

See my track-mutexes-1.patch I recently posted.

 int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
 {
+	int ret;
+
 	might_sleep();
-	return __mutex_fastpath_lock_retval
+	ret = __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_slowpath);
+	if (likely(!ret))
+		inc_mutex_count();
+	return ret;
 }
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
@@ -308,8 +325,12 @@ static inline int __mutex_trylock_slowpa
  */
 int fastcall mutex_trylock(struct mutex *lock)
 {
-	return __mutex_fastpath_trylock(&lock->count,
+	int ret = __mutex_fastpath_trylock(&lock->count,
 					__mutex_trylock_slowpath);
+
+	if (likely(ret))
+		inc_mutex_count();
+	return ret;
 }

Note the if !ret in mutex_lock_interruptible vs the if ret in mutex_trylock(

I really should have given you the original debugging code that went with it, 
sorry.

-- 
-ck
