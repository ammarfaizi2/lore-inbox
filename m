Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUKODNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUKODNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUKODMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:12:37 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22665 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261516AbUKODFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:05:00 -0500
Date: Mon, 15 Nov 2004 12:06:53 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: Futex queue_me/get_user ordering
In-reply-to: <20041115020148.GA17979@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl
Message-id: <41981D4D.9030505@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
References: <20041113164048.2f31a8dd.akpm@osdl.org>
 <20041114090023.GA478@mail.shareable.org>
 <20041114010943.3d56985a.akpm@osdl.org>
 <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com>
 <20041115020148.GA17979@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Third possibility: your test is buggy.  Do you actually use a mutex in
> your test when you call pthread_cond_wait, and does the waker hold it
> when it calls pthread_cond_signal?
> 
> If you don't use a mutex as you are supposed to with condvars, then it
> might not be a kernel or NPTL bug.  I'm not sure if POSIX-specified
> behaviour is defined when you use condvars without a mutex.
> 
> If you do use a mutex (and you just didn't mention it), then the code
> above is not enough to decide if there's an NPTL bug.  We need to look
> at pthread_cond_wait as well, to see how it does the "atomic" wait and
> mutex release.
> 
> -- Jamie

Now I'm asking our test team about that.

Again, from glibc-2.3.3(RHEL4b2):

[nptl/sysdeps/pthread/pthread_cond_wait.c]
   85 int
   86 __pthread_cond_wait (cond, mutex)
   87      pthread_cond_t *cond;
   88      pthread_mutex_t *mutex;
   89 {
   90   struct _pthread_cleanup_buffer buffer;
   91   struct _condvar_cleanup_buffer cbuffer;
   92   int err;
   93
   94   /* Make sure we are along.  */
   95   lll_mutex_lock (cond->__data.__lock);
   96
   97   /* Now we can release the mutex.  */
   98   err = __pthread_mutex_unlock_usercnt (mutex, 0);
   99   if (__builtin_expect (err, 0))
  100     {
  101       lll_mutex_unlock (cond->__data.__lock);
  102       return err;
  103     }
  104
  105   /* We have one new user of the condvar.  */
  106   ++cond->__data.__total_seq;
  107   ++cond->__data.__futex;
  108   cond->__data.__nwaiters += 1 << COND_CLOCK_BITS;
  109
  110   /* Remember the mutex we are using here.  If there is already a
  111      different address store this is a bad user bug.  Do not store
  112      anything for pshared condvars.  */
  113   if (cond->__data.__mutex != (void *) ~0l)
  114     cond->__data.__mutex = mutex;
  115
  116   /* Prepare structure passed to cancellation handler.  */
  117   cbuffer.cond = cond;
  118   cbuffer.mutex = mutex;
  119
  120   /* Before we block we enable cancellation.  Therefore we have to
  121      install a cancellation handler.  */
  122   __pthread_cleanup_push (&buffer, __condvar_cleanup, &cbuffer);
  123
  124   /* The current values of the wakeup counter.  The "woken" counter
  125      must exceed this value.  */
  126   unsigned long long int val;
  127   unsigned long long int seq;
  128   val = seq = cond->__data.__wakeup_seq;
  129   /* Remember the broadcast counter.  */
  130   cbuffer.bc_seq = cond->__data.__broadcast_seq;
  131
  132   do
  133     {
  134       unsigned int futex_val = cond->__data.__futex;
  135
  136       /* Prepare to wait.  Release the condvar futex.  */
  137       lll_mutex_unlock (cond->__data.__lock);
  138
  139       /* Enable asynchronous cancellation.  Required by the standard.  */
  140       cbuffer.oldtype = __pthread_enable_asynccancel ();
  141
  142       /* Wait until woken by signal or broadcast.  */
  143       lll_futex_wait (&cond->__data.__futex, futex_val);
  144
  145       /* Disable asynchronous cancellation.  */
  146       __pthread_disable_asynccancel (cbuffer.oldtype);
  147
  148       /* We are going to look at shared data again, so get the lock.  */
  149       lll_mutex_lock (cond->__data.__lock);
  150
  151       /* If a broadcast happened, we are done.  */
  152       if (cbuffer.bc_seq != cond->__data.__broadcast_seq)
  153         goto bc_out;
  154
  155       /* Check whether we are eligible for wakeup.  */
  156       val = cond->__data.__wakeup_seq;
  157     }
  158   while (val == seq || cond->__data.__woken_seq == val);
  159
  160   /* Another thread woken up.  */
  161   ++cond->__data.__woken_seq;
  162
  163  bc_out:
  164
  165   cond->__data.__nwaiters -= 1 << COND_CLOCK_BITS;
  166
  167   /* If pthread_cond_destroy was called on this varaible already,
  168      notify the pthread_cond_destroy caller all waiters have left
  169      and it can be successfully destroyed.  */
  170   if (cond->__data.__total_seq == -1ULL
  171       && cond->__data.__nwaiters < (1 << COND_CLOCK_BITS))
  172     lll_futex_wake (&cond->__data.__nwaiters, 1);
  173
  174   /* We are done with the condvar.  */
  175   lll_mutex_unlock (cond->__data.__lock);
  176
  177   /* The cancellation handling is back to normal, remove the handler.  */
  178   __pthread_cleanup_pop (&buffer, 0);
  179
  180   /* Get the mutex before returning.  */
  181   return __pthread_mutex_cond_lock (mutex);
  182 }

I'm not sure but it seems that the pseudo-code could be:

(mutex must be locked before calling pthread_cond_wait.)
-A01 pthread_cond_wait {
+A01 pthread_cond_wait (futex,mutex) {
+A0*   mutex_unlock(mutex);
  A02   timeout = 0;
  A03   lock(counters);
  A04     total++;
  A05     val = get_from(futex);
  A06   unlock(counters);
  A07
  A08   sys_futex(futex, FUTEX_WAIT, val, timeout);
  A09
  A10   lock(counters);
  A11     woken++;
  A12   unlock(counters);
+A1*   mutex_lock(mutex);
  A13 }

(and it's better to replace var "futex" to "cond".)

Is it possible that NPTL shut the window between mutex_unlock()
and actual queueing in futex_wait?


Thanks,
H.Seto

