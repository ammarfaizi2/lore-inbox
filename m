Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWJLSZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJLSZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJLSZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:25:23 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:48812 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750784AbWJLSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:25:21 -0400
Message-ID: <452E888D.6040002@comcast.net>
Date: Thu, 12 Oct 2006 14:25:17 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <20061012171929.GB24658@flint.arm.linux.org.uk>
In-Reply-To: <20061012171929.GB24658@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Russell King wrote:
> On Thu, Oct 12, 2006 at 11:44:56AM -0400, John Richard Moser wrote:
>> Can context switches be made faster?  This is a simple question, mainly
>> because I don't really understand what happens during a context switch
>> that the kernel has control over (besides storing registers).
> 
> They can be, but there's a big penalty that you pay for it.  You must
> limit the virtual memory space to 32MB for _every_ process in the
> system, and if you have many processes running (I forget how many)
> you end up running into the same latency problems.

Interesting information; for the rest of this discussion let's assume
that we want the system to remain functional.  :)

> 
> The latency problem comes from the requirement to keep the cache
> coherent with the VM mappings, and to this extent on Linux we need to
> flush the cache each time we change the VM mapping.

*OUCH*

Flushing cache takes time, doesn't it?  Worse, you can't have happy
accidents where cache remains the same for various areas (i.e. I1's
caching of libc and gtk) between processes.

I guess on x86 and x86-64 at least (popular CPUs) the cache is not tied
to physical memory; but rather to virtual memory?  Wikipedia:

  Multiple virtual addresses can map to a single physical address. Most
  processors guarantee that all updates to that single physical address
  will happen in program order. To deliver on that guarantee, the
  processor must ensure that only one copy of a physical address resides
  in the cache at any given time.

  ...

  But virtual indexing is not always the best choice. It introduces the
  problem of virtual aliases -- the cache may have multiple locations
  which can store the value of a single physical address. The cost of
  dealing with virtual aliases grows with cache size, and as a result
  most level-2 and larger caches are physically indexed.

    -- http://en.wikipedia.org/wiki/CPU_cache

So apparently most CPUs virtually address L1 cache and physically
address L2; but sometimes physically addressing L1 is better.. hur.

I'd need more information on this one.

  - Is L1 on <CPU of choice> physically aliased or physically tagged
    such that leaving it in place between switches will cause the CPU to
    recognize it's wrong?

  - Is L2 on <CPU of choice> in such a manner?

  - Can L1 be flushed without flushing L2?

  - Does the current code act on these behaviors, or just flush all
    cache regardless?

> 
> There have been projects in the past which have come and gone to
> support the "Fast Context Switch" approach found on these CPUs, but
> patches have _never_ been submitted, so I can only conclude that the
> projects never got off the ground.
> 

A shame.

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS6IiQs1xW0HCTEFAQJTwRAAlpf3+FRxxRkpIEiWMV3k7Prauj8uZEFK
I6eITkNAe7kYt2q+TqTSjSaDI106iFUFXa/D20fbaykQ5mRio9nqIxNfGlqZdYyq
f62CrEzt6gfHdS4KSA7uIz8v+N6D/aUscxxPXr/LTGfZms1WWsDA/hBPZFtUL3cH
8/ydOwVa/23mGcuOnf8yAP9yzvK2k0XJPbHJo4JnZh11bf9ttLF5+pxLIxWrvZgL
eAp5QuwcQ7Rg7MJ50sSUBtbCHPpsRvC0KsROdLltGWxyEXMOlwfOn0UNBd0GhWRB
O2B91x4elGBESwWpIJ+cB6gzCRIbuJcVuwgn73RDVi3hWg+suxa6IR7+lJ+Jv6tA
/iTbnr6Um4X+Dv4WISYxiB3vYuSuTKmzq75iqpRj+9KOOCHMnkxx7qUdy8qEiSoB
vuO3LuRMGwahOqe9gqUFNwdM7X4cOuoayKe1hZR36ocjC0rHXaDCH9t+UBn+iFyo
sCDnfq6RbKvxFZTiShdhv3Qb6tHNaOzwaIhO29rY9RvD5fkQYFK/DBdcQHa6Pc+Q
SHoS8lJ2/uU4BpzioHO4GqwsqOl4jUjgg7/zzeuK6JWVnihowK3/1BgPKJ50K0e5
7yQ1yC1FiWiwO584rp5qrm3lJPwVjdf9cWxzaZqtl6WT4QE3wb6BI9rvwrEEhddk
IrJbcFEjS00=
=i0Ac
-----END PGP SIGNATURE-----
