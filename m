Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135976AbREBGne>; Wed, 2 May 2001 02:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbREBGnY>; Wed, 2 May 2001 02:43:24 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:57615 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135976AbREBGnO>;
	Wed, 2 May 2001 02:43:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105020642.f426gww379046@saturn.cs.uml.edu>
Subject: Re: Unknown HZ value! (2000) Assume 1024.
To: tomh@po.crl.go.jp (Tom Holroyd)
Date: Wed, 2 May 2001 02:42:58 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (kernel mailing list)
In-Reply-To: <Pine.LNX.4.30.0105021348480.27862-100000@holly.crl.go.jp> from "Tom Holroyd" at May 02, 2001 02:13:22 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/uptime:
> 4400586.27 150439.36
> 
> /proc/stat:
> cpu  371049158 3972370867 8752820 4448994822
>      (user,    nice,      system, idle)
> 
> In .../fs/proc/proc_misc.c:kstat_read_proc(), the cpu line is being
> computed by:
> 
>         len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
>                       jif * smp_num_cpus - (user + nice + system));

This is pretty bogus. The idle time can run _backwards_ on an SMP
system. What is "top" supposed to do with that, print a negative
number for %idle time? (some versions do, while others truncate
at zero or wrap around to 4 billion -- pick your poison)

> The user, nice, and system values add up to 4352172845 > 2^32, and jif is
> 4400586.27 * 1024 = 4506200340, leading to the incorrect idle time (1
> cpu).  It should be calculated this way:
>
>    len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
>             jif * smp_num_cpus - ((unsigned long)user + nice + system));
>
> or just declare those as unsigned longs instead of ints.  I notice also
> that since kstat.per_cpu_nice is an int, it's going to overflow in another
> 3.6 days anyhow.  I'll let you know what blows up then.  Any chance of
> making those guys longs?

That is good for the Alpha.

For 32-bit systems, we use 32-bit values to reduce overhead.
This causes problems at 495/smp_num_cpus days of uptime.

Proposed hack: set a very-log-duration timer (several days)
to check for the high bit changing. Count bit flips.
