Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317791AbSGKItJ>; Thu, 11 Jul 2002 04:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSGKItI>; Thu, 11 Jul 2002 04:49:08 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:13289 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317791AbSGKItH>; Thu, 11 Jul 2002 04:49:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Jesse Barnes <jbarnes@sgi.com>, Daniel Phillips <phillips@arcor.de>
Subject: Re: spinlock assertion macros
Date: Thu, 11 Jul 2002 12:51:38 +0200
User-Agent: KMail/1.4.2
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com>
In-Reply-To: <20020710233616.GA696482@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207111251.38481.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 01:36, Jesse Barnes wrote:

+#define spin_assert_unlocked(lock) if (spin_is_locked(lock)) { printk("lock assertion failure: lock at %s:%d should be unlocked!\n", __FILE__, __LINE__); }

I suppose what would at least be as helpful is to check if _any_ 
lock is held, e.g. when calling a potentially sleeping function.

Something along these lines:

#ifdef CONFIG_DEBUG_SPINLOCK
extern char *volatile last_spinlock[NR_CPUS];

#define spin_assert_unlocked_all() ({ \
	char *lock = last_spinlock[smp_processor_id()]; \
	if (lock) { \
		printk (KERN_CRIT "%s:%d: lock %s is held\n", \
			__func__, __LINE__, lock); \
		BUG(); \
	} \
})

#define spin_lock(lock) ({ \
	last_spinlock[smp_processor_id()] = __stringify(lock) "@" \
		__FILE__ ":" __stringify(__LINE__); \
	__really_spin_lock(lock); \
})
#endif

probably, a per-cpu lock depth should be used to also catch
spin_lock(foo_lock); 
spin_lock(bar_lock); 
spin_unlock(bar_lock);
spin_assert_unlock_all();

	Arnd <><
