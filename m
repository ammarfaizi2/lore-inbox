Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCNXQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCNXQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVCNXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:14:09 -0500
Received: from smtp220.tiscali.dk ([62.79.79.114]:1807 "EHLO
	smtp220.tiscali.dk") by vger.kernel.org with ESMTP id S262071AbVCNXNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:13:17 -0500
Subject: Re: pam and nice-rt-prio-rlimits
From: Vegard Lima <Vegard.Lima@hia.no>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050314214336.GG3163@waste.org>
References: <1110791657.1807.11.camel@pingvin.krs.hia.no>
	 <20050314214336.GG3163@waste.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 15 Mar 2005 00:13:15 +0100
Message-Id: <1110841995.3976.11.camel@tordenfugl.lima.heim>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 14.03.2005 Klokka 13:43 (-0800) skreiv Matt Mackall:
> On Mon, Mar 14, 2005 at 10:14:17AM +0100, Vegard Lima wrote:
> > Hello,
> > 
> > in the long thread on "[request for inclusion] Realtime LSM" there
> > doesn't appear to be too many people who has actually tested the
> > nice-and-rt-prio-rlimits.patch. Well, it works for me...
> > 
> > However, the patch to pam_limits posted here:
> >   http://lkml.org/lkml/2005/1/14/174
> > is a little bit aggressive on the semi-colon side.
> 
> It would be more helpful if you pointed out the exact bug. But I think
> I spotted the bug in question the first time around.

Sorry, the incremental patch looks like this

--- Linux-PAM-0.77/modules/pam_limits/pam_limits.c-rtprio	2005-03-15 00:04:30.000000000 +0100
+++ Linux-PAM-0.77/modules/pam_limits/pam_limits.c	2005-03-15 00:04:58.000000000 +0100
@@ -370,16 +370,15 @@
             limit_value *= 1024;
             break;
         case RLIMIT_NICE:
-            limit_value = 19 - limit_value;
             if (limit_value > 39)
 		limit_value = 39;
-	    if (limit_value < 0);
+	    if (limit_value < 0)
 		limit_value = 0;
             break;
         case RLIMIT_RTPRIO:
             if (limit_value > 99)
 		limit_value = 99;
-	    if (limit_value < 0);
+	    if (limit_value < 0)
 		limit_value = 0;
             break;
     }


The conversion
  limit_value = 19 - limit_value;
takes place in can_nice() in kernel/schec.c and had to be removed.

> Please double-check and test this patch from -mm, which will likely
> show up in mainline:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/broken-out/nice-and-rt-prio-rlimits.patch

Sound good.
I've tested with both 2.6.11-mm3 and 2.6.11-bk10 + patch above.
jackd starts OK with realtime scheduling and playing with nice seems OK
when I have positive values for "rt_priority" and "nice" in limits.conf.


Thanks,
-- 
Vegard Lima

