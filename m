Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbVJMScZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbVJMScZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJMScZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:32:25 -0400
Received: from main.gmane.org ([80.91.229.2]:22765 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932158AbVJMScY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:32:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Thu, 13 Oct 2005 14:24:32 -0400
Message-ID: <dim8in$fe6$1@sea.gmane.org>
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

Actually this should work

void XXXX() {
   do {
     do_something();
   } while (!flag);
}

void YYY() {
   flag = 1;
}

flag doesn't even have to be atomic though you will want to
declare it volatile or use some other mechanism to keep the
compiler from optimizing it.

Other than that you don't need to do anything to make it be seen
by the other processor.  Strongly coherent cache does what you need.
Using a spin lock doesn't make it get seen any faster.  In fact the
spin lock slows you down if anything.

It may be on some hardware you may need to take explicit action to
force something to be seen by another processor.  Using a spin lock
may work in this case but that's only because the implementer of the
spin lock on that platform decided to add in some forward progress
semantics.  There's no formal definition of spin lock semantics
so whatever's in there is whatever the implementer thought there
should be.  This may not seem like a big deal since every thinks
lock semantics are obvious.  But somehow no one seems to know to
to state them formally.   Posix couldn't do it.  They gave up and
officially defined it as ... like you know ... obvious.  C++00x
is stuck on how to define thread memory model semantics.  They
haven't even gotten to locks yet.  All they know is it shouldn't
look like the Java memory model.  And although Java has formal
semantics, they don't define forward progress.  Java depends on
cooperative threading.  If you use a competative threading model,
you're on your own.  Which gets us back to Linux.  If you don't
have forward progress defined as part of your synchronization
semantics, then you depend on having a surplus of compute resources
for your code to work correctly as you found out by putting your
two cpu's in busy loops.

In that case above where you need to use a spin lock for force visibility,
just use the spin lock to read and write the flag value. Don't hold it
while you're executing do_something() which hopefully will be of
sufficient duration to prevent live lock.

--
Joe Seigh

