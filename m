Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUISWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUISWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUISWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:36:26 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5508 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264704AbUISWgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:36:22 -0400
Message-ID: <414E0A95.2030701@sgi.com>
Date: Sun, 19 Sep 2004 17:39:17 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] lockmeter: fixes
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com> <1095592506.619.8.camel@boxen>
In-Reply-To: <1095592506.619.8.camel@boxen>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
>>Andrew,
>>
>>The first patch in this series is a replacement patch for the prempt-fix
>>patch I sent earlier this morning.  There was a missing paren in that
>>previous version.
>>
>>Adding this to 2.6.9-rc2-mm1 (just after lockmeter-2.patch) fixes the
>>preempt compile problem on ia64, at least.  However, I then started 
>>getting a missing symbol for generic_raw_read_trylock.  Hence the second
>>patch of this series.
> 
> 
> Hi Ray
> 
> I need the following to compile on x86-64, works fine otherwise.
> 
> 
> --- mm/kernel/lockmeter.c.orig	2004-09-19 12:49:52.000000000 +0200
> +++ mm/kernel/lockmeter.c	2004-09-19 12:50:25.000000000 +0200
> @@ -1510,3 +1510,13 @@ int __lockfunc _spin_trylock_bh(spinlock
>  	return 0;
>  }
>  EXPORT_SYMBOL(_spin_trylock_bh);
> +
> +int in_lock_functions(unsigned long addr)
> +{
> +	/* Linker adds these: start and end of __lockfunc functions */
> +	extern char __lock_text_start[], __lock_text_end[];
> +
> +	return addr >= (unsigned long)__lock_text_start
> +		&& addr < (unsigned long)__lock_text_end;
> +}
> +EXPORT_SYMBOL(in_lock_functions);
> --- mm/include/asm-x86_64/spinlock.h.orig	2004-09-19 12:31:32.000000000 +0200
> +++ mm/include/asm-x86_64/spinlock.h	2004-09-19 13:04:56.117109248 +0200
> @@ -232,16 +232,6 @@ static inline void _raw_write_lock(rwloc
>  #define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
>  #define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
>  
> -static inline int _raw_read_trylock(rwlock_t *lock)
> -{
> -	atomic_t *count = (atomic_t *)lock;
> -	atomic_dec(count);
> -	if (atomic_read(count) < RW_LOCK_BIAS)
> -		return 1;
> -	atomic_inc(count);
> -	return 0;
> -}
> -
>  static inline int _raw_write_trylock(rwlock_t *lock)
>  {
>  	atomic_t *count = (atomic_t *)lock;
> @@ -262,6 +252,16 @@ static inline int _raw_read_trylock(rwlo
>  	atomic_inc(count);
>  	return 0;
>  }
> +#else
> +static inline int _raw_read_trylock(rwlock_t *lock)
> +{
> +	atomic_t *count = (atomic_t *)lock;
> +	atomic_dec(count);
> +	if (atomic_read(count) < RW_LOCK_BIAS)
> +		return 1;
> +	atomic_inc(count);
> +	return 0;
> +}
>  #endif
>  
>  #if defined(CONFIG_LOCKMETER) && defined(CONFIG_HAVE_DEC_LOCK)
>  
> 
> 

Hi Alex,

There were a flurry of spinlock and corresponding lockmeter changes on 
Thursday and Friday.  One of the patches was to make in_lock_functions()
an inline, so that solves the first problem you found above.  A second
one that Andrew found was the duplicate definition of _raw_read_trylock(),
which is what I think the second part of your patch is.

I'm currently working on testing a lockmeter rollup patch.  I'll add the 
x86_64 _raw_read_trylock() fix unless Andrew has already got that covered.

Thanks,

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

