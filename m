Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCZITZ>; Tue, 26 Mar 2002 03:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCZITE>; Tue, 26 Mar 2002 03:19:04 -0500
Received: from mail.epost.de ([64.39.38.76]:20633 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S292730AbSCZITC>;
	Tue, 26 Mar 2002 03:19:02 -0500
Message-ID: <3CA02E80.1000600@dlr.de>
Date: Tue, 26 Mar 2002 09:17:04 +0100
From: Martin Wirth <martin.wirth@dlr.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16pfLi-0001lX-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>   And on top of them:
>   futex_down(struct futex *);
>   futex_up(struct futex *);
>
Why not keep the simple one-sys-call interface for the fuxtexes. The 
code is so small that it is
 not worth to delete it.

>
>
>int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
>{
>	int ret, saved_errno;
>
>	uwaitq_add(cond);
>	futex_up(&mutex);
>	while ((ret = uwaitq_wait(NULL)) == 0 || errno == EINTR);
>	saved_errno = errno;
>	uwaitq_remove(cond);
>	futex_down(&mutex);
>
You should loop here in order catch signals:

	while ( futex_down(&mutex) < 0 && errno == EINTR)

>
>	if (ret < 0 && errno == EINTR)
>		goto again;
>
This assumes that you are allowed to do a double uwaitq_add.

>
>	saved_errno = errno;
>	uwaitq_remove(cond);
>	futex_down(&mutex);
>
Also loop here

>
>	errno = saved_errno;
>
>	return ret;
>}
>
Now whats interesting is the kernel part. I must admit that I haven't 
fully understood all
effects of the double use of the cookie in your first implementation. 
But if you use a memory
location as identifier you have to keep a separate flag within 
uwaitq_head that is zeroed
before you add to the waitqueue and set by the signal functions. Then 
uwaitq_wait has to check for it.
This is necessary in order not to loose a wakeup while you are on the 
queue but not sleeping.

uwaitq_remove also takes an argument, are you heading for waiting on 
multiple events?

Since you need to pin down the page between uwaitq_add and uwaitq_remove 
you will have to limit
the number of simultaneous add calls. Should this be configurable?

Cheers,
Martin
 

