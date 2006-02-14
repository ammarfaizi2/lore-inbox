Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWBNK4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWBNK4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbWBNK4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:56:16 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:4135 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030567AbWBNK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:56:15 -0500
Date: Tue, 14 Feb 2006 11:56:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Hannes Reinecke <hare@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060214105608.GD19896@osiris.boeblingen.de.ibm.com>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu> <20060213234254.GA5368@suse.de> <20060214000807.GA6188@suse.de> <20060214080942.GC19896@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214080942.GC19896@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did a quick git bisect search. This is one is the hurting one:
> 
> Author: Ingo Molnar <mingo@elte.hu>  2006-02-07 21:58:54
> Committer: Linus Torvalds <torvalds@g5.osdl.org>  2006-02-08 01:12:33
> Parent: 8519fb30e438f8088b71a94a7d5a660a814d3872 ([PATCH] mm: compound release fix)
> Child:  0d4c3e7a8c65892c7d6a748fdbb4499e988880db ([PATCH] unshare system call -v5: Documentation file)
>
>     The fix is to include a __delay(1) call in the loop, to correctly approximate
>     the intended delay timeout of 1 second.  The code assumes that every
>     architecture implements __delay(1) to last around 1/(loops_per_jiffy*HZ)
>     seconds.
> 
> I guess we're once again suffering from being a virtualized platform: the
> formerly used call to cpu_relax() informed the underlying hypervisor that
> we want to give up the current cpu while __delay() keeps it.
> Unless we're scheduled away involuntarily.
> The "Detect Soft Lockups" option doesn't make too much sense too on our
> platform, since we get a lot of false positives.
> Quick fix: turn off the options CONFIG_DEBUG_SPINLOCK and
> CONFIG_DETECT_SOFTLOCKUP.

Wrong analysis. Our __delay() implementation is broken. This doesn't help for
the CONFIG_DETECT_SOFTLOCKUP case, but at least CONFIG_DEBUG_SPINLOCK works
again with this.

Andrew, could you pick this one up, or should I send it separately?

[PATCH] s390: fix __delay implementation

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix __delay implementation. Called with an argument "1" or "0" it
would loop nearly forever (since (1/2)-1 = 0xffffffff).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/lib/delay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index e96c35b..71f0a2f 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -30,7 +30,7 @@ void __delay(unsigned long loops)
          */
         __asm__ __volatile__(
                 "0: brct %0,0b"
-                : /* no outputs */ : "r" (loops/2) );
+                : /* no outputs */ : "r" ((loops/2) + 1));
 }
 
 /*
