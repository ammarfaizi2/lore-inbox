Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHOJxx>; Thu, 15 Aug 2002 05:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHOJxx>; Thu, 15 Aug 2002 05:53:53 -0400
Received: from mail.ces.ch ([212.147.83.3]:64462 "EHLO lancy.ces.ch")
	by vger.kernel.org with ESMTP id <S316674AbSHOJxv>;
	Thu, 15 Aug 2002 05:53:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rupert Eibauer <Rupert@ces.ch>
Organization: Creative Electronic Systems
To: linux-kernel@vger.kernel.org
Subject: [RFC] Fwd: Re: Fwd: Linux Kernel: down_timeout
Date: Thu, 15 Aug 2002 11:57:17 +0200
X-Mailer: KMail [version 1.3.1]
Cc: rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208151157327.SM00152@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please reply to me directly, I am not
subscribed to the lkml.

----------  Forwarded Message  ----------

Subject: Re: Fwd: Linux Kernel: down_timeout
Date: Thu, 15 Aug 2002 10:44:55 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Rupert Eibauer <Rupert@ces.ch>

On Thu, 15 Aug 2002, Rupert Eibauer wrote:
> I found your thread
> [PATCH][RFC] Lightweight user-level semaphores
> (jan 2002)
> later, so please read on..

I'm no kernel guru, but this looks really useful.  You
should probably send it to the linux-kernel list and to
Rusty Russel -- it would be a particularly useful extra
feature for his futexes.

Cheers,
Matthew.

> ----------  Forwarded Message  ----------
>
> Subject: Linux Kernel: down_timeout
> Date: Thu, 15 Aug 2002 11:14:24 +0200
> From: Rupert Eibauer <Rupert@ces.ch>
> To: andrew.grover@intel.com, ingo.oeser@informatik.tu-chemnitz.de,
> robert.moore@intel.com
>
> Hi,
>
> I found your thread (Apr 2001) about down_timeout on the lkml.
> down_timeout is needed more often then you might think.
>
> Does anybody of you know why it hasnt been implemented in
> the kernel until now?
>
> My version of down_timeout is attached below.
>
>
> waiting for your answer,
>
> Rupert
>
>

----------  End of Forwarded Message  ----------


Here is the header snippet:
-8<--------------------------------------------------------------------------
extern int __down_timeout(struct semaphore * sem, int timeout);

extern inline int down_timeout(struct semaphore * sem, int timeout)
{
        int ret = 0;
        if (atomic_dec_if_positive(&sem->count) < 0)
                ret = __down_timeout(sem, timeout);
        smp_wmb();
        return ret;
}
-8<--------------------------------------------------------------------------



This is for the .c file:
-8<--------------------------------------------------------------------------
static void process_sema_timeout(unsigned long data) {
  struct task_struct *p = (struct task_struct *)data;

   wake_up_process(p);
}

extern int __down_timeout(struct semaphore * sem, int timeout)
{
        int ret = 0;
        unsigned long expire;
        struct timer_list timer;

        if (timeout > 0) {

                expire = jiffies + timeout;
                init_timer(&timer);
                timer.expires = expire;
                timer.data    = (unsigned long) current;
                timer.function = process_sema_timeout;
                add_timer(&timer);

                if (ret = __down_interruptible(sema)) {
                        /* check whether the timeout woke us up */
                        if (jiffies > expire)
                                ret = -ETIME;
                        else
                                del_timer_sync(&timer);
                } else
                        del_timer_sync(&timer);

        } else if (timeout == 0) { // timeout=0 means now
                /* our caller (inline int down_timeout) already tried to
                get the semaphore _now_ and it failed ! */
                ret = !0;
        } else { // timeout<0 means wait forever
                ret = __down_interruptible(sema)
        }
        return ret;
}
-8<--------------------------------------------------------------------------

-- 
+-----------------------------------------------------------------------------+
| CCCC EEEE SSSS  Creative Electronic Systems | Rupert Eibauer                |
| C    E    S     38 av. Eugene Lance         | Linux Kernel Hacker           |
| C    EEE  SSSS  PO Box 584                  |                               |
| C    E       S  CH-1212 Grand-Lancy 1       |                               |
| CCCC EEEE SSSS  Switzerland                 | email: rupert@ces.ch          |
+-----------------------------------------------------------------------------+
