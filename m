Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVIWFdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVIWFdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIWFdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:33:11 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:56810 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751300AbVIWFdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:33:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 22 Sep 2005 22:34:09 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Vadim Lobanov <vlobanov@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] epoll
In-Reply-To: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
Message-ID: <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
References: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Vadim Lobanov wrote:

> 1. Size
> The size parameter to sys_epoll_create() is simply sanity-checked (has
> to be greater than zero) and then ignored. I presume the current
> implementation works perfectly without this parameter, so I am rather
> curious why it is even passed in. Historical reasons? Future code
> improvements? On the same note, I'd like to suggest that '0' also should
> be an allowed value, for the case when the application really does not
> know what the size estimate should be.

This born from the initial epoll implementation, that was using the size 
parameter to size the hash. Since now epoll uses rbtrees, the parameter is 
no more used. Changing the API to remove it, and break userspace, was/is 
not a good idea.



> 2. Timeout
> It seems that the timeout parameter in sys_epoll_wait() is not handled
> quite correctly. According to the manpages, a value of '-1' means
> infinite timeout, but the effect of other negative values is left
> undefined. In fact, if you run a userland program that calls
> epoll_wait() with a timeout value of '-2', the kernel prints an error
> into /var/log/messages from within schedule_timeout(), due to its
> argument being negative. It seems there are two ways to correct this
> behavior:
> - Check the passed timeout for being less than '-1', and return an
> error. A new errno value needs to be introduced into the epoll_wait()
> API.
> - Redefine the epoll_wait() API to accept any negative value as an
> infinite timeout, and change the code appropriately.

Yes, it is nicer if epoll behaves like poll. (*)



> 3. Wakeup
> As determined by testing with userland code, the sys_tgkill() and
> sys_tkill() functions currently will NOT wake up a sleeping
> epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
> cancellation point. There are two potential issues with this:
> - epoll_wait() meets the unofficial(?) definition of a "system call that
> may block".
> - epoll_wait() behaves differently from poll() and friends.

The epoll_wait() wait loop is the standard one that even poll() uses (prep 
wait, make interruptible, test signals, sched timeo). So if poll() is woke 
up, so should epoll_wait(). A minimal code snippet that proves poll() 
behing woke up, and epoll_wait() not, would help.



> 4. Code Duplication
> As sys_tgkill() and sys_tkill() are currently written, a large portion
> of the two functions is duplicated. It might make sense to pull that
> equivalent code out into a separate function.

This should be moved in "[RFC] something else" ;)



> Comments please? In particular, the pthread cancellation issue is
> worrysome. In the case that any of the above points turn into actual
> code TODOs, I'll be more than happy to cook up and submit the patches.

[*] No need, since it's a one liner.



- Davide


