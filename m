Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVIWDMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVIWDMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 23:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVIWDMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 23:12:15 -0400
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:61610 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751256AbVIWDMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 23:12:15 -0400
Date: Thu, 22 Sep 2005 20:12:14 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] epoll
Message-ID: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Lately, I've been exploring the epoll code in more detail, and have come
across a few questions/issues (I wouldn't call them problems) that I'd
like to solicit comments on. If everyone agrees, some of these might
turn into TODOs as code changes. Without further ado:

1. Size
The size parameter to sys_epoll_create() is simply sanity-checked (has
to be greater than zero) and then ignored. I presume the current
implementation works perfectly without this parameter, so I am rather
curious why it is even passed in. Historical reasons? Future code
improvements? On the same note, I'd like to suggest that '0' also should
be an allowed value, for the case when the application really does not
know what the size estimate should be.

2. Timeout
It seems that the timeout parameter in sys_epoll_wait() is not handled
quite correctly. According to the manpages, a value of '-1' means
infinite timeout, but the effect of other negative values is left
undefined. In fact, if you run a userland program that calls
epoll_wait() with a timeout value of '-2', the kernel prints an error
into /var/log/messages from within schedule_timeout(), due to its
argument being negative. It seems there are two ways to correct this
behavior:
- Check the passed timeout for being less than '-1', and return an
error. A new errno value needs to be introduced into the epoll_wait()
API.
- Redefine the epoll_wait() API to accept any negative value as an
infinite timeout, and change the code appropriately.

3. Wakeup
As determined by testing with userland code, the sys_tgkill() and
sys_tkill() functions currently will NOT wake up a sleeping
epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
cancellation point. There are two potential issues with this:
- epoll_wait() meets the unofficial(?) definition of a "system call that
may block".
- epoll_wait() behaves differently from poll() and friends.

4. Code Duplication
As sys_tgkill() and sys_tkill() are currently written, a large portion
of the two functions is duplicated. It might make sense to pull that
equivalent code out into a separate function.

Comments please? In particular, the pthread cancellation issue is
worrysome. In the case that any of the above points turn into actual
code TODOs, I'll be more than happy to cook up and submit the patches.

Thanks for reading. :-)
-Vadim Lobanov
