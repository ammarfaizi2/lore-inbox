Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317748AbSGKDZ2>; Wed, 10 Jul 2002 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317749AbSGKDZ1>; Wed, 10 Jul 2002 23:25:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317748AbSGKDZY>;
	Wed, 10 Jul 2002 23:25:24 -0400
Message-ID: <3D2CFCE0.3452F960@zip.com.au>
Date: Wed, 10 Jul 2002 20:34:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Jussi Laako <jussi.laako@kolumbus.FI>, linux-kernel@vger.kernel.org
Subject: Re: [CRASH] in tulip driver?
References: <3D2C92C0.658B954@kolumbus.fi> from "Jussi Laako" at Jul 11, 2 00:15:01 am <200207110259.GAA27698@sex.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Any ideas what is causing the following crash?
> 
> There is no BUG() in sched.c:579 or in vicinity of this line.
> 
> So, the only idea is that the crash is caused by patches which
> you applied to the kernel. :-)
> 

whoops.  I think the "-ll" means low-latency.  But the only
finger I have in that pie is:

--- 2.4.19-pre6/drivers/char/random.c~low-latency       Fri Apr  5 12:11:17 2002
+++ 2.4.19-pre6-akpm/drivers/char/random.c      Fri Apr  5 12:11:17 2002
@@ -1369,6 +1369,11 @@ static ssize_t extract_entropy(struct en
                buf += i;
                ret += i;
                add_timer_randomness(&extract_timer_state, nbytes);
+#if LOWLATENCY_NEEDED
+               /* This can happen in softirq's, but that's what we want */
+               if (conditional_schedule_needed())
+                       break;
+#endif
        }
 
        /* Wipe data just returned from memory */

So it's a bit of a mystery.  It seems to think that it has
EXTRACT_ENTROPY_USER.

-
