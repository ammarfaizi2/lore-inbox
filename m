Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVGNFWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVGNFWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 01:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVGNFWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 01:22:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27149 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262910AbVGNFWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 01:22:49 -0400
Date: Thu, 14 Jul 2005 07:16:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: multisyncfe991@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: About a change to the implementation of spin lock in 2.6.12 kernel.
Message-ID: <20050714051653.GP8907@alpha.home.local>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 13, 2005 at 07:20:06PM -0700, multisyncfe991@hotmail.com wrote:
> Hi,
> 
> I found _spin_lock used a LOCK instruction to make the following 
> operation "decb %0" atomic. As you know, LOCK instruction alone takes 
> almost 70 clock cycles to finish and this add lots of cost to the 
> _spin_lock. However _spin_unlock does not use this LOCK instruction and 
> it uses "movb $1,%0" instead since 4-byte writes on 4-byte aligned 
> addresses are atomic.

_spin_unlock does not need locked operations because when it is run, the
code is already known to be the only one to hold the lock, so it can
release it without checking what others do.

> So I want rewrite the _spin_lock defined spinlock.h 
> (/linux/include/asm-i386) as follows to reduce the overhead of _spin_lock 
> and make it more efficient.

It does not work. You cannot write an inter-cpu atomic test-and-set with
several unlocked instructions.

> #define spin_lock_string \
>        "\n1:\t" \
>        "cmpb $0,%0\n\t" \
>        "jle 2f\n\t" \

==> here, another thread or CPU can get the lock simultaneously.

>        "movb $0, %0\n\t" \
>        "jmp 3f\n" \
>        "2:\t" \
>        "rep;nop\n\t" \
>        "cmpb $0, %0\n\t" \
>        "jle 2b\n\t" \
>        "jmp 1b\n" \
>        "3:\n\t"
> 
> Compared with the original version as follows, LOCK instruction is 
> removed. I rebuilt the Intel e1000 Gigabit driver with this _spin_lock. 
> There is about 2% throughput improvement.
> #define spin_lock_string \
>            "\n1:\t" \
>            "lock ; decb %0\n\t" \
>            "jns 3f\n" \
>            "2:\t" \
>            "rep;nop\n\t" \
>            "cmpb $0,%0\n\t" \
>            "jle 2b\n\t" \
>            "jmp 1b\n" \
>            "3:\n\t"
> 
> Do you think I can get a better performance if I dig further?
> 
> Any ideas will be greatly appreciated,

well, of course with those methods you can improve performance, but you
lose the warranty that you're alone to get a lock, and that's bad.

another similar method to get a lock in some very controlled environment
is as follows :

  1:  cmp $0, %0
      jne 1b
      mov $CPUID, %0
      membar
      cmp $CPUID, %0
      jne 1b

This only works with same speed CPUs and interrupts disabled. But in todays
environments, this is very risky (hyperthreaded CPUs, etc...). However, this
is often OK for more deterministic CPUs such as microcontrollers.

Regards,
Willy

