Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRG0WsH>; Fri, 27 Jul 2001 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRG0Wr6>; Fri, 27 Jul 2001 18:47:58 -0400
Received: from [192.216.221.8] ([192.216.221.8]:37767 "EHLO suntan.tandem.com")
	by vger.kernel.org with ESMTP id <S264329AbRG0Wrj>;
	Fri, 27 Jul 2001 18:47:39 -0400
Message-ID: <3B61EC39.43BA5F4A@compaq.com>
Date: Fri, 27 Jul 2001 15:33:29 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Brian J. Watson" <bwatson@sandbass.cpqcorp.net>
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.7 read/write semaphore trylock routines
In-Reply-To: <200107272214.f6RMEwY02829@sandbass.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Brian J. Watson" wrote:
> 
> David Howells wrote:
> >
> > > Is this patch ready to go into the kernel? Is there anything else I
> > > should do to get it ready? I noticed it didn't make it into
> > > 2.4.7-pre7.
> >
> > It looks reasonable, though I haven't tried it myself (I presume you
> > have
> > though). You might want to try sending it direct to Linus.
> >
> > David
> 
> Good thing I hammered on the trylock routines. The i386 version was fine, but
> in the generic version I wasn't dropping the spinlock under contention. My
> test machine was kind enough to deadlock to make my mistake painfully obvious.
> 
> The trylock patch with test code can be found below. Aside from fixing the
> deadlock above, I made sure the lock was behaving properly. I'll send the
> patch sans test code to Linus.
> 
> --
> Brian Watson                | "The common people of England... so
> Linux Kernel Developer      |  jealous of their liberty, but like the
> Open SSI Clustering Project |  common people of most other countries
> Compaq Computer Corp        |  never rightly considering wherein it
> Los Angeles, CA             |  consists..."
>                             |     -Adam Smith, Wealth of Nations, 1776
> 
> mailto:Brian.J.Watson@compaq.com
> http://opensource.compaq.com/
> 
> == cut ==
> --- ../generic-hash/linux-2.4.7/include/asm-i386/rwsem.h        Fri Apr 27 15:48:24 2001
> +++ linux/include/asm-i386/rwsem.h      Thu Jul 26 18:59:11 2001
> @@ -117,6 +117,24 @@
>  }
> 
>  /*
> + * trylock for reading -- returns 1 if successful, 0 if contention
> + */
> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +       signed long old, new;
> +
> +repeat:
> +       old = (volatile signed long)sem->count;
> +       if (old < RWSEM_UNLOCKED_VALUE)
> +               return 0;
> +       new = old + RWSEM_ACTIVE_READ_BIAS;
> +       if (cmpxchg(&sem->count, old, new) == old)
> +               return 1;
> +       else
> +               goto repeat;
> +}
> +
> +/*
>   * lock for writing
>   */
>  static inline void __down_write(struct rw_semaphore *sem)
> @@ -141,6 +159,19 @@
>                 : "+d"(tmp), "+m"(sem->count)
>                 : "a"(sem)
>                 : "memory", "cc");
> +}
> +
> +/*
> + * trylock for writing -- returns 1 if successful, 0 if contention
> + */
> +static inline int __down_write_trylock(struct rw_semaphore *sem)
> +{
> +       signed long ret = cmpxchg(&sem->count,
> +                                 RWSEM_UNLOCKED_VALUE,
> +                                 RWSEM_ACTIVE_WRITE_BIAS);
> +       if (ret == RWSEM_UNLOCKED_VALUE)
> +               return 1;
> +       return 0;
>  }
> 
>  /*
> --- ../generic-hash/linux-2.4.7/include/linux/rwsem-spinlock.h  Thu Jul 26 14:35:50 2001
> +++ linux/include/linux/rwsem-spinlock.h        Thu Jul 26 18:59:10 2001
> @@ -54,7 +54,9 @@
> 
>  extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
>  extern void FASTCALL(__down_read(struct rw_semaphore *sem));
> +extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
>  extern void FASTCALL(__down_write(struct rw_semaphore *sem));
> +extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
>  extern void FASTCALL(__up_read(struct rw_semaphore *sem));
>  extern void FASTCALL(__up_write(struct rw_semaphore *sem));
> 
> --- ../generic-hash/linux-2.4.7/include/linux/rwsem.h   Thu Jul 26 14:35:50 2001
> +++ linux/include/linux/rwsem.h Fri Jul 27 15:08:44 2001
> @@ -46,6 +46,18 @@
>  }
> 
>  /*
> + * trylock for reading -- returns 1 if successful, 0 if contention
> + */
> +static inline int down_read_trylock(struct rw_semaphore *sem)
> +{
> +       int ret;
> +       rwsemtrace(sem,"Entering down_read_trylock");
> +       ret = __down_read_trylock(sem);
> +       rwsemtrace(sem,"Leaving down_read_trylock");
> +       return ret;
> +}
> +
> +/*
>   * lock for writing
>   */
>  static inline void down_write(struct rw_semaphore *sem)
> @@ -53,6 +65,18 @@
>         rwsemtrace(sem,"Entering down_write");
>         __down_write(sem);
>         rwsemtrace(sem,"Leaving down_write");
> +}
> +
> +/*
> + * trylock for writing -- returns 1 if successful, 0 if contention
> + */
> +static inline int down_write_trylock(struct rw_semaphore *sem)
> +{
> +       int ret;
> +       rwsemtrace(sem,"Entering down_write_trylock");
> +       ret = __down_write_trylock(sem);
> +       rwsemtrace(sem,"Leaving down_write_trylock");
> +       return ret;
>  }
> 
>  /*
> --- ../generic-hash/linux-2.4.7/include/rwsem_test.h    Fri Jul 27 15:07:17 2001
> +++ linux/include/rwsem_test.h  Thu Jul 26 17:26:30 2001
> @@ -0,0 +1,82 @@
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +#include <linux/random.h>
> +#include <linux/rwsem.h>
> +
> +DECLARE_RWSEM(rst_lock);
> +
> +int
> +rst_daemon(void *ignore)
> +{
> +       while (1) {
> +               unsigned char sleep, style, ctr = 0;
> +
> +               get_random_bytes(&sleep, 1);
> +               __set_current_state(TASK_UNINTERRUPTIBLE);
> +               schedule_timeout((signed long)sleep);
> +
> +               for (; ctr < 10; ++ctr) {
> +                       get_random_bytes(&style, 1);
> +
> +                       if (style > 191) {
> +                               down_write(&rst_lock);
> +                               printk("[rst %d] down_write\n", current->pid);
> +                       } else if (style > 127) {
> +                               if (!down_write_trylock(&rst_lock)) {
> +                                       printk("[rst %d] down_write_trylock "
> +                                                       "failed\n",
> +                                                       current->pid);
> +                                       break;
> +                               }
> +                               printk("[rst %d] down_write_trylock "
> +                                               "succeeded\n", current->pid);
> +                       } else if (style > 63) {
> +                               down_read(&rst_lock);
> +                               printk("[rst %d] down_read\n", current->pid);
> +                       } else {
> +                               if (!down_read_trylock(&rst_lock)) {
> +                                       printk("[rst %d] down_read_trylock "
> +                                                       "failed\n",
> +                                                       current->pid);
> +                                       break;
> +                               }
> +                               printk("[rst %d] down_read_trylock "
> +                                               "succeeded\n", current->pid);
> +                       }
> +
> +                       if (style > 127)
> +                               printk("[rst %d] writing... [1]\n",
> +                                               current->pid);
> +                       else
> +                               printk("[rst %d] reading... [1]\n",
> +                                               current->pid);
> +
> +                       __set_current_state(TASK_UNINTERRUPTIBLE);
> +                       schedule_timeout(5);
> +
> +                       if (style > 127)
> +                               printk("[rst %d] writing... [2]\n",
> +                                               current->pid);
> +                       else
> +                               printk("[rst %d] reading... [2]\n",
> +                                               current->pid);
> +
> +                       if (style > 127) {
> +                               printk("[rst %d] up_write\n", current->pid);
> +                               up_write(&rst_lock);
> +                       } else {
> +                               printk("[rst %d] up_read\n", current->pid);
> +                               up_read(&rst_lock);
> +                       }
> +               }
> +       }
> +       return 0;
> +}
> +
> +void
> +rst_init(void)
> +{
> +       int ctr = 0;
> +       for (; ctr < 10; ++ctr)
> +               kernel_thread(rst_daemon, NULL, 0);
> +}
> --- ../generic-hash/linux-2.4.7/init/main.c     Thu Jul 26 18:33:53 2001
> +++ linux/init/main.c   Fri Jul 27 14:54:18 2001
> @@ -11,6 +11,8 @@
> 
>  #define __KERNEL_SYSCALLS__
> 
> +#include <rwsem_test.h>
> +
>  #include <linux/config.h>
>  #include <linux/proc_fs.h>
>  #include <linux/devfs_fs_kernel.h>
> @@ -799,6 +801,8 @@
>          * The Bourne shell can be used instead of init if we are
>          * trying to recover a really broken machine.
>          */
> +
> +       rst_init();
> 
>         if (execute_command)
>                 execve(execute_command,argv_init,envp_init);
> --- ../generic-hash/linux-2.4.7/lib/rwsem-spinlock.c    Wed Apr 25 13:31:03 2001
> +++ linux/lib/rwsem-spinlock.c  Fri Jul 27 15:08:44 2001
> @@ -149,6 +149,26 @@
>  }
> 
>  /*
> + * trylock for reading -- returns 1 if successful, 0 if contention
> + */
> +int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +       int ret = 0;
> +       rwsemtrace(sem,"Entering __down_read_trylock");
> +
> +       spin_lock(&sem->wait_lock);
> +       if (sem->activity>=0 && list_empty(&sem->wait_list)) {
> +               /* granted */
> +               sem->activity++;
> +               ret = 1;
> +       }
> +       spin_unlock(&sem->wait_lock);
> +
> +       rwsemtrace(sem,"Leaving __down_read_trylock");
> +       return ret;
> +}
> +
> +/*
>   * get a write lock on the semaphore
>   * - note that we increment the waiting count anyway to indicate an exclusive lock
>   */
> @@ -192,6 +212,26 @@
> 
>   out:
>         rwsemtrace(sem,"Leaving __down_write");
> +}
> +
> +/*
> + * trylock for writing -- returns 1 if successful, 0 if contention
> + */
> +int __down_write_trylock(struct rw_semaphore *sem)
> +{
> +       int ret = 0;
> +       rwsemtrace(sem,"Entering __down_write_trylock");
> +
> +       spin_lock(&sem->wait_lock);
> +       if (sem->activity==0 && list_empty(&sem->wait_list)) {
> +               /* granted */
> +               sem->activity = -1;
> +               ret = 1;
> +       }
> +       spin_unlock(&sem->wait_lock);
> +
> +       rwsemtrace(sem,"Leaving __down_write_trylock");
> +       return ret;
>  }
> 
>  /*

-- 
Brian Watson                | "The common people of England... so 
Linux Kernel Developer      |  jealous of their liberty, but like the 
Open SSI Clustering Project |  common people of most other countries 
Compaq Computer Corp        |  never rightly considering wherein it 
Los Angeles, CA             |  consists..."
                            |     -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
