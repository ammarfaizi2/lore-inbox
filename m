Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWDYRxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWDYRxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWDYRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:53:12 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:60678 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750983AbWDYRxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:53:11 -0400
Message-ID: <444E61FD.7070408@argo.co.il>
Date: Tue, 25 Apr 2006 20:53:01 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <1145911546.1635.54.camel@localhost.localdomain>	 <444D3D32.1010104@argo.co.il>	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>	 <444DCAD2.4050906@argo.co.il>	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>	 <444E524A.10906@argo.co.il>	 <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>	 <444E5A3E.1020302@argo.co.il> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
In-Reply-To: <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 17:53:06.0607 (UTC) FILETIME=[1B694BF0:01C66891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>>>>>           
>>>> No, it's optimized out. gcc notices that &lock doesn't change and that
>>>> 'l' never escapes the function.
>>>>
>>>>         
>>> "l" that propects critical section gets thrown away???
>>>       
>> Calm down, the storage for 'l' is thrown away, but its effects remain.
>>     
>
> Would you mind explaining implemenation details a little bit?
>   
(I don't know how familiar you are with C++ so I'm explaining it from 
the basics, apologies if I'm repeating things you know)

Very often one needs to acquire a resource, do something with it, and 
then free the resource. Here, "resource" can mean a file descriptor, a 
reference into a reference counted object, or, in our case, a spinlock. 
And we want "free" to mean "free no matter what", e.g. on a normal path 
or an exception path.

In C++, you code it as a guard object:

struct spinlock_guard {
    spinlock_guard(spinlock_t *lock) { sl = lock; spin_lock(sl); }
    ~spinlock_guard() { spin_unlock(sl); }

    spinlock_t *sl;
};

(this would be coded differently, trying to keep it C-like)

To use it, create a spinlock_guard object that goes into scope before 
you use the data you want to protect:

spinlock_t some_lock.;

void f()
{
    blah();
     spinlock_guard guard(&some_lock);
     __f(); /* do nonatomic stuff */
     if (__g())
         return;
     __h()
}

C++ treats this as if you've written:

spinlock_t some_lock;

void f()
{
    spinlock_guard guard;

    blah();
    guard.sl = &some_lock;
    spin_lock(guard.sl);
    __f();
    if (__g())
        goto out;
    __h();
out:
    spin_unlock(guard.sl);
}

Additionally, C++ guarantees that if an exception is thrown after 
spin_lock() is called, then the spin_unlock() will also be called. 
That's an interesting mechanism by itself.

Now, the optimizer sees that guard.sl is a constant expression 
(&some_lock), and that guard.sl's address is not passed to any function, 
so it eliminates the variable entirely, leaving us with


spinlock_t some_lock;

void f()
{
    blah();
    spin_lock(&some_lock);
    __f();
    if (__g())
        goto out;
    __h();
out:
    spin_unlock(&some_lock);
}

(the original C++ compiler actually worked by writing out the C code and 
letting the C compiler compile it; nowadays both compilers use the same 
intermediate representation, optimizer, and code generator).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

