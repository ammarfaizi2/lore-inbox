Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBRC0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBRC0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 21:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBRC0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 21:26:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6677
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261282AbVBRCZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 21:25:53 -0500
Date: Fri, 18 Feb 2005 03:25:51 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: seccomp for 2.6.11-rc4
Message-ID: <20050218022551.GN2071@opteron.random>
References: <20050121100606.GB8042@dualathlon.random> <20050215093244.GU13712@opteron.random> <20050216052503.GA24484@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216052503.GA24484@mail.13thfloor.at>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 06:25:03AM +0100, Herbert Poetzl wrote:
> hmm, just an idea, but have you thought about using
> an indirect syscall table for your purposes?
> 
>  current->syscall_table 
> 
> and have a table for every 'mode' you want to use ...

That would add an additional level of indirection for every syscall
(you'll have to potentially waste a cacheline to read the address of the
syscall table).

While my current approach is absolutely zero cost for the fast path on
x86-64 and it's a mere s/movb/movw/ for x86 (i.e. zero for x86 too).
Perahps I could even get away with a movb on x86 but frankly I didn't
even try ;)

My priority has been not to change the fast path at all, and clearly I
have to add a bitflag to achieve that. And once I've the bitflag it's
not worth it anymore to change the syscall table, and I can validate the
syscall number right away (this avoid building arrays and other more
complex stuff).

> or maybe have a 'mask' for every syscall (in a 
> separate table) which describes the allowed 'modes'
> 
> just because checking the syscall number in a loop
> doesn't look very scaleable to me ... 

You're right about it being O(N) if you use it for all modes, but it's
really O(1) since it's being used for mode 0 only, and the number of
syscalls in mode 0 is fixed so it's O(1) and more important the number
is so small that it's really like O(1) in practice too (and not only in
math terms just because the number of syscalls in mode 0 is fixed ;).

Each mode can implement the mask as it wishes, so if you were to allow
hundred of syscalls in mode 1 then you'd better implement the check as a
bitmask as you suggested and you can do that while implementing mode 1.

But seccomp isn't designed to allow a ton of syscalls, so there can be
tiny differences between mode 0/1/2 and they should all have very few
syscalls, so I doubt it'd worth implementing the bitmask thingy right now.

Thanks.
