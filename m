Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUEJOz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUEJOz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUEJOz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:55:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:61406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264722AbUEJOzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:55:22 -0400
Date: Mon, 10 May 2004 07:55:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] WAIT_BIT_QUEUE
In-Reply-To: <409F668A.CEFD60F6@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0405100750430.3028@ppc970.osdl.org>
References: <409F668A.CEFD60F6@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 May 2004, Oleg Nesterov wrote:
> 
> so there is no need to recheck the bit in do/while loop, because
> there is no false wakeups now.

You should never assume this. You should assume that there are _always_
false wakeups.

Why? Because Linux has always allowed people to leave wait-queues active,
without being "atomic". For example, the tty read/write layer used to
(still does?)  add itself on the wait-queue _once_, and then leave itself
on the wait-queue while in a loop it does copies from/to user space.

Which means that you can get wake-ups from totally unrelated _other_
sources while you're doing IO.

Never EVER assume (and depend on) that you only get one wakeup. It may be 
the most common case by far, but it's not guaranteed. If you slept waiting 
for something, then you should re-check that something when you wake up.

		Linus
