Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSCYL4w>; Mon, 25 Mar 2002 06:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312405AbSCYL4n>; Mon, 25 Mar 2002 06:56:43 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:3849 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S312404AbSCYL4f>; Mon, 25 Mar 2002 06:56:35 -0500
Message-ID: <3C9F1074.6030902@loewe-komp.de>
Date: Mon, 25 Mar 2002 12:56:36 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Martin.Wirth@dlr.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <3C9E1A10.F7AA6D6E@loewe-komp.de>	<E16pKE0-0004Rb-00@wagner.rustcorp.com.au> <20020325154623.302f9e11.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> On Mon, 25 Mar 2002 13:28:44 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
>>So the summary is: futexes not sufficient to implement pthreads
>>locking.
>>
> 
> So let's go back to the more generic "exporting waitqueues to userspace" idea,
> with a twist: we use a userspace address as the identifier on the waitq, which
> gives us a unique identifier, but the kernel never actually derefs the
> pointer.  (And in my prior kernel code I optimized it so that waking did an
> implicit remove; not sure it's a win, so assumed that was removed here).
> 
> This gives code as below (Peter, Martin, please check):
> 
> /* Assume we have the following operations:
> 
>    uwaitq_add(void *uaddr);
>    uwaitq_remove(void *uaddr);
>    uwaitq_wake(void *uaddr, int wake_all_flag);
>    uwaitq_wait(relative timeout);
> */
> typedef struct
> {
> 	int counter;
> } pthread_mutex_t;
> 
> typedef struct 
> {
> 	int condition;
> } pthread_cond_t;
> 
 
> int pthread_cond_signal(pthread_cond_t *cond)
> {
> 	return uwaitq_wake(cond, 0 /* WAKE_ONE */);
> }
> 
> int pthread_cond_broadcast(pthread_cond_t *cond)
> {
> 	return uwaitq_wake(cond, 1 /* WAKE_ALL */);
> }
> 
> static int __pthread_cond_wait(pthread_cond_t *cond,
> 			       pthread_mutex_t *mutex,
> 			       const struct timespec *reltime)
> {
> 	int ret;
> 
> 	uwaitq_add(cond);
> 	futex_up(&mutex, 1);


Here another thread gets scheduled, calling signal/broadcast.
Since the former thread is already on the queue -> well done ;-)


> 	while ((ret = uwaitq_wait(reltime)) == 0 || errno == EINTR);
> 	uwaitq_remove(cond);
> 	futex_down(&mutex, NULL);
> 	return ret;
> }


I assume that uwaitq_wait() will modify the reltime (which is legal)
if signalled. Otherwise we would wait 2*retime, and so on

Then we have to be careful about errno and the return values:

static int __pthread_cond_wait(pthread_cond_t *cond,
			       pthread_mutex_t *mutex,
			       const struct timespec *reltime)
{
	int ret;

! 
if (uwaitq_add(cond) == -1)
+ 
	return -1;
! 
if (futex_up(&mutex, 1) == -1){
+ 
	uwaitq_remove(cond);
+ 
	return -1;
+ 
}
! 
while ((ret = uwaitq_wait(cond,reltime)) == -1 && errno == EINTR);
+ 
saverrno=errno;
	uwaitq_remove(cond);
	futex_down(&mutex, NULL);
+ 
if (ret == -1){
+ 
  	if (saverrno == ENOENT)
+ 
		return 0; /* there was a sig/broadc before we went to sleep*/
+ 
	errno=saverrno;
+ 
	return -1;
+ 
}
	return 0;
}

I assume that uwaitq_wait() will return -1 and errno==ENOENT or similar
if we are not on the queue (anymore), -1 and ETIMEDOUT on timeout,
-1 and EINVAL on illegal cond or reltime ,zero on wakeup?


