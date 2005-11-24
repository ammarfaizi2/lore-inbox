Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbVKXAny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVKXAny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKXAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:43:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34032 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932606AbVKXAnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:43:53 -0500
In-Reply-To: <a36005b50511221740i6a80d59ay3983067e756cb5f6@mail.gmail.com>
References: <438381D4.5020904@mvista.com> <a36005b50511221740i6a80d59ay3983067e756cb5f6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61D3D308-5C83-11DA-9F3D-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: Re: Robust Futex patches available
Date: Wed, 23 Nov 2005 16:43:51 -0800
To: Ulrich Drepper <drepper@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 22, 2005, at 5:40 PM, Ulrich Drepper wrote:

> On 11/22/05, David Singleton <dsingleton@mvista.com> wrote:
>>     I'd also like some advice on the direction POSIX is heading with
>> respect to
>>     robust pthread_mutexes and priority inheritance.
>
> Robust mutexes are not in POSIX nor have they been proposed for
> inclusion in the next revision.  If a sane semantics can be determined
> I might submit it for inclusion.
>
> As for priority inheritance, there is nothing to add, the feature is
> fully described.
>
>
>> rt-nptl supports 'robust' behavior, there will be two robust modes,
>> one is PTHREAD_MUTEX_ROBUST_NP mode, the other is
>> PTHREAD_MUTEX_ROBUST_SUN_NP mode. When the owner of a mutex dies in
>> the first mode, the waiter will set the mutex to ENOTRECOVERABLE
>> state, while in the second mode, the waiter needs to call
>> pthread_mutex_setconsistency_np to change the state manually.
>>
>> Currently the PTHREAD_MUTEX_ROBUST_NP is providing
>> the fucntionality described by the PTHREAD_MUTEX_ROBUST_SUN_NP.
>
> This description makes no sense.  ENOTRECOVERABLE is the error code
> used if, surprise, the data/mutex cannot be recovered.  I.e., it is
> *not* consistent.  It is identical to calling pthread_mutex_unlock on
> a mutex which was locked when pthread_mutex_lock returned EDEADOWNER.
> All waiters are woken and subsequent locking attempts will fail in
> this case with ENOTRECOVERABLE.
>
> So, if PTHREAD_MUTEX_ROBUST_NP really causes ENOTRECOVERABLE to be
> returned then this form is useless as it is trivially achieved with
> the PTHREAD_MUTEX_ROBUST_SUN_NP form.  Plus: not defining it means
> less confusion since the semantics doesn't differ from Solaris (and
> there would be a bigger change to get the change added to POSIX).

Great, thanks for the help in understanding this.  The ENOTRECOVERABLE 
made
no sense to me either.

I'll keep things the way they are.  The code returns -EOWNERDIED to the 
waiter/
new lock owner and the owner can recover the mutex, if they so choose.

>
>
> I cannot really comment much on the kernel side.  For my taste the
> robust futex functionality is impacting the far more commen code path
> too much.  I would like to see much of the added code moved completely
> out of the fast path.  Robust mutexes are slow, this won't make it
> worse.
>

Yes, even in the kernel I'd like to see the performance penalty for 
robustness
be an option that the user can select if they want the trade off of
robustness for a slower exit path.

>
> The userlevel part is completely unacceptable.  It's broken and what
> is there in code has the same problem as the kernel code: it punishes
> code which does not require this new feature.  I don't worry about
> this part, though, since I would write this part myself in any case
> once there is an agreed upon kernel part.
>
>
> Having this said, I certainly would like to get the robust futex part
> in.  But not the priority handling part.  The two are completely
> independent in principal.  I don't agree at all with the current
> implementation of the priority inheritance.

I agree, the PI and Robustness are two logically separate functions and
could easily be separated out.  I'll start on that now.

>
> So, if you split out the robust futex still, eliminate all the support
> added for priority inheritance, you get my full support for adding the
> code to mainline.

Excellent!  I hope to have some patches for you in a while.

David

