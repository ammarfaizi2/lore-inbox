Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWFCRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFCRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWFCRf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 13:35:56 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:62686 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751140AbWFCRfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 13:35:55 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Jun 2006 10:35:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Willy Tarreau <willy@w.ods.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>
Subject: Re: [patch] epoll use unlocked wqueue operations ...
In-Reply-To: <20060603060438.GB30150@w.ods.org>
Message-ID: <Pine.LNX.4.64.0606031031030.17149@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com>
 <20060603060438.GB30150@w.ods.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006, Willy Tarreau wrote:

> Hi Davide,
>
> On Fri, Jun 02, 2006 at 04:28:25PM -0700, Davide Libenzi wrote:
>>
>> A few days ago Arjan signaled a lockdep red flag on epoll locks, and
>> precisely between the epoll's device structure lock (->lock) and the wait
>> queue head lock (->lock). Like I explained in another email, and directly
>> to Arjan, this can't happen in reality because of the explicit check at
>> eventpoll.c:592, that does not allow to drop an epoll fd inside the same
>> epoll fd. Since lockdep is working on per-structure locks, it will never
>> be able to know of policies enforced in other parts of the code. It was
>> decided time ago of having the ability to drop epoll fds inside other
>> epoll fds, that triggers a very trick wakeup operations (due to possibly
>> reentrant callback-driven wakeups) handled by the ep_poll_safewake()
>> function.
>> While looking again at the code though, I noticed that all the operations
>> done on the epoll's main structure wait queue head (->wq) are already
>> protected by the epoll lock (->lock), so that locked-style functions can
>> be used to manipulate the ->wq member. This makes both a lock-acquire
>> save, and lockdep happy.
>> Running totalmess on my dual opteron for a while did not reveal any
>> problem so far:
>>
>> http://www.xmailserver.org/totalmess.c
>
> Shouldn't we notice a tiny performance boost by avoiding those useless
> locks, or do you consider they are not located in the fast path anyway ?

Well, we take a lock less but I can't say if it'll be measureable. The 
test program above is not a performance thing though, just some code to 
verify multiple threads doing waits on the same epoll fd.


- Davide


