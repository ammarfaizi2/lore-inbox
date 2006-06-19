Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWFSTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWFSTqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWFSTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:46:13 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:24819 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964868AbWFSTqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:46:13 -0400
Message-ID: <4496FD7E.3090804@comcast.net>
Date: Mon, 19 Jun 2006 15:39:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
In-Reply-To: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Andreas Mohr wrote:
> Hello all,
> 
> while looking for loop places to apply cpu_relax() to, I found the
> following gems:
> 
> arch/i386/kernel/crash.c/crash_nmi_callback():
> 
>         /* Assume hlt works */
>         halt();
>         for(;;);
> 
>         return 1;
> }
> 
> arch/i386/kernel/doublefault.c/doublefault_fn():
> 
>         for (;;) /* nothing */;
> }
> 
> Let's assume that we have a less than moderate fan failure that causes
> the CPU to heat up beyond the critical limit...
> That might result in - you guessed it - crashes or doublefaults.
> In which case we enter the corresponding handler and do... what?

Looks like it calls halt() to put the CPU into idle mode, and then
performs a nop?  (I think the null condition evaluates false.... not
sure, haven't tried this before!)

> Exactly, we accelerate the CPUs happy march into bit heaven by letting it
> execute a busy-loop under a non-working fan.
> Thanks, your users will be very happy, I think ;)
> (especially since it was "just" a simple fan failure that could have been
> entirely remedied by buying another fan for $3)
> 
> 
> The same thing applies to
> arch/i386/kernel/smp.c/stop_this_cpu(), albeit there it's less catastrophic
> due to most likely normal working conditions there.
> 
> IMHO on any critical CPU failure we should:
> - try to log it (might be difficult with a broken CPU, though)
> - optionally somehow directly alert the user
> - STOP the system, COMPLETELY (that way people WILL take notice, hopefully
>   before it's too late and actual damage will have occurred)
> - make DAMN SURE that the (possibly already broken) CPU won't have a
>   less than nice time once the system is stopped
> 
> Am I completely missing something here?
> 
> If this is an issue, then maybe we should consolidate those places into
> one function that safely(!) halts a CPU, optionally disabling APIC etc.
> 
> Oh, and once you finished processing my mail here, you could optionally
> also look at my report about almost unusably broken USB:
> http://lkml.org/lkml/2006/6/19/54
> (no replies yet despite advanced breakage)
> 
> Thanks!
> 
> Andreas Mohr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRJb9fAs1xW0HCTEFAQJdSQ/+OdfUJ9e43KruVLWofFGwEOcx0+PoUYfo
u7eEDMdIAGm8nCv8jfUr47svydmeiLHIQYQToWjyrVvm05FacgsTKPFWAzlWv8h0
8tnPyET2WU+r4+mzyvmPy5qStlUBh8Jh0XNq52Ayf3WCninoIx07B/Hv+lhHOrZK
m9dghJlJge1KMKgws5DYokuO7vMR8/+fLltMjALr/0IecJOlAR5LnBgKGgTyUXj5
9hr85nFcBdM37fQz8VJUfcsh62fgS3g75/hAPX79uwG0bhnmNthgdsrFbAWUcf3y
H/VDWs2d/F5x8mALhUp53dPkx8kjx/L7l6v9qOf/38+8mBrq1k88FuSY7r+/4sKK
7DqYQtVZynsLvfLTuc7rkHR8O0E4bkNSDenjzhaxWzHb3+5NTo7z8p5eBnGVbVQc
ou2XPIuH6n0yIU1scbmItMZ4iw9o/9i0oO4WkBQ5c4zxKJDxxUZZ1Lruc+8AWGPx
rbeg01PaXx133sTYfSDMa28hMvmqnwPTkmTysCpJEtW6UXqperBfEJuRdVcGLNHh
4uxSHdf6wU9sWYGtp2mUIXAsOLd6MXygAKUL90xARz42b8k5edTSJ1yEcpxiw5pr
fDpN+5niJR8s/DM1d6IwY72rONFV/Y71hIIuT6RBx90auwyq3WaUTLciJzdEAJRy
yXzZdFrVvp8=
=QwbH
-----END PGP SIGNATURE-----
