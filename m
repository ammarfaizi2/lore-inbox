Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbVJGUiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVJGUiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 16:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVJGUiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 16:38:12 -0400
Received: from main.gmane.org ([80.91.229.2]:28900 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030555AbVJGUiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 16:38:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Fri, 07 Oct 2005 16:38:56 -0400
Message-ID: <di6m79$38f$1@sea.gmane.org>
References: <434520FF.8050100@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <434520FF.8050100@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Hello Linus, Andrew and others,
> 
> Please help with a not simple question about spin_lock/spin_unlock on 
> SMP archs. The question is whether concurrent spin_lock()'s should 
> acquire it in more or less "fair" fashinon or one of CPUs can starve any 
> arbitrary time while others do reacquire it in a loop.
> 
> The question raised because the situation we observe on AMD processors 
> is really strange and makes us believe that something is wrong in 
> kerne/in processor or our minds. Below goes an explanation:
> 
> The whole story started when we wrote the following code:
> 
> void XXX(void)
> {
>     /* ints disabled */
> restart:
>     spin_lock(&lock);
>     do_something();
>     if (!flag)
>         need_restart = 1;
>     spin_unlock(&lock);
>     if (need_restart)
>         goto restart;    <<<< LOOPS 4EVER ON AMD!!!
> }
> 
> void YYY(void)
> {
>     spin_lock(&lock);    <<<< SPINS 4EVER ON AMD!!!
>     flag = 1;
>     spin_unlock(&lock);
> }
> 
> function XXX() starts on CPU0 and begins to loop since flag is not set, 
> then CPU1 calls function YYY() and it turns out that it can't take the 
> lock any arbitrary time.
> 
> Other observations:
> - This does not happen on Intel processors, more over on Intel 2 CPUs 
> take locks in a fair manner, exactly one by one!
> - If do_something() = usleep(3) we observed that XXX() loops forever, 
> while YYY spins 4EVER on the same lock...
> - cpu_relax() doesn't help after spin_unlock()...

Unilateral backoff isn't guaranteed to work as well as multilateral
backoff which can't be done in software AFAIK.

> - wbinvd() after spin_unlock() helpes and 2 CPUs began to take the lock 
> in a fair manner.
> 
> How can this happen? Is it regulated somehow by SMP specifications?

The hardware specs don't guarantee fairness.  The only architecture I
know of that did guarantee fairness was IBM's 370 architecture and that
guarantee only appeared in registered confidential copies of the
architecture as an engineering note.

What you can do is write your own FIFO spin lock based on the bakery
algorithm.  It will require two words instead of one, one for the
"next ticket" and one for the "current ticket".   To get the next
ticket value use LOCK XADD which should be guaranteed to work.  Then just
spin until the current value equals your ticket value.   You also
have the advantage that when a contended lock is released all the
waiting processors all don't try to grab the lockword cache line
exclusive all at once.  That stuff was spaced out earlier.   If you
have lots of storage you can put the two words in separate cache lines.
Also it's quite easy to make a FIFO read write upgradable spin lock
out of it without increasing the path length of the write lock part.
Bakery algorithms are fun.


--
Joe Seigh

