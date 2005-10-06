Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVJFOqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVJFOqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVJFOqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:46:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751021AbVJFOqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:46:23 -0400
Date: Thu, 6 Oct 2005 07:45:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
In-Reply-To: <434520FF.8050100@sw.ru>
Message-ID: <Pine.LNX.4.64.0510060741000.31407@g5.osdl.org>
References: <434520FF.8050100@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Kirill Korotaev wrote:
> 
> The question raised because the situation we observe on AMD processors is
> really strange and makes us believe that something is wrong in kerne/in
> processor or our minds. Below goes an explanation:

Your code is buggy.

> The whole story started when we wrote the following code:
> 
> void XXX(void)
> {
> 	/* ints disabled */
> restart:
> 	spin_lock(&lock);
> 	do_something();
> 	if (!flag)
> 		need_restart = 1;
> 	spin_unlock(&lock);
> 	if (need_restart)
> 		goto restart;	<<<< LOOPS 4EVER ON AMD!!!
> }
> 
> void YYY(void)
> {
> 	spin_lock(&lock);	<<<< SPINS 4EVER ON AMD!!!
> 	flag = 1;
> 	spin_unlock(&lock);
> }

If you want to notify another CPU that you want the spinlock, then you 
need to set the "flag" variable _outside_ of the spinlock.

Spinlocks are not fair, not by a long shot. They never have been, and they 
never will. Fairness would be extremely expensive indeed.

> Other observations:
> - This does not happen on Intel processors, more over on Intel 2 CPUs take
> locks in a fair manner, exactly one by one!

It depends entirely on the cache coherency protocol. I bet you'd find 
differences even within Intel CPU's.

		Linus
