Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULDIIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULDIIo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 03:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbULDIIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 03:08:44 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:56999 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261356AbULDIIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 03:08:41 -0500
Date: Sat, 4 Dec 2004 09:08:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Voluspa <lista4@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041204080840.GC32635@dualathlon.random>
References: <200412040700.iB4704311162@d1o405.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412040700.iB4704311162@d1o405.telia.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 08:00:04AM +0100, Voluspa wrote:
> 
> On 2004-12-03 23:08:55 Andrea Arcangeli wrote:
> 
> >You mean my patch is preventing your machine to boot? Then you're doing
> >something else wrong because it's impossible my patch is preventing 
> >your machine to boot.
> 
> Same experience as Thomas here. Full stop like his first log (no errors)
> . PIII (Celeron) 900@1 gig, 256 meg mem, 1 gig swap, preempt enabled.

The places I modified are never invoked during boot (except the below
one). It works like a charm here. I tried again building on top of
2.6.10-rc3 and it works again just fine here (previously I was on top of
the kernel CVS out of sync currently). No idea what's preventing you to
boot, but it's very hard to believe that my patch is to blame for it.

The only modified piece of code that may run during boot is this:

-       might_sleep_if(wait);
+       if (wait)
+               cond_resched();


You can try to put back a might_slee_if(wait), but if it deadlocks with
that change sure it's not a bug in my patch, it's instead a bug
somewhere else that calls alloc_pages w/o GFP_ATOMIC. Ingo's
lowlatency patch would expose the same bug too since they're aliasing
the might_sleep to cond_resched.

But I can't reproduce anything wrong here.

Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:...........................................................................................................................................
Table [DSDT](id F004) - 502 Objects with 45 Devices 139 Methods 29
Regions
ACPI Namespace successfully loaded at root c0503d40
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode
successful
CPU0: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.70 usecs.
[..]

machine boots and run just fine and the patch is definitely applied.

PREEMPT=n but it can't be a bug in my patch even if PREEMPT=y breaks.
