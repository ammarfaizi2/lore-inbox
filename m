Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbULMLmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbULMLmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbULMLmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:42:07 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:57527 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262232AbULMLmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:42:02 -0500
Date: Mon, 13 Dec 2004 12:39:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Hans Kristian Rosbach <hk@isphuset.no>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213113954.GU16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local> <20041213112229.GS6272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213112229.GS6272@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:22:29PM +0100, Pavel Machek wrote:
> I tried defining HZ to 10 once, and there are some #if arrays in the
> kernel that prevented me from doing that.

I guess you're right and the minimum is HZ=12. I'm pretty sure I could
go down to 25, perhaps the absolute minium was 12 and not 10.

There's also some side effect like this by setting strange HZ:

--- x-ref/net/sched/estimator.c	2003-03-15 03:25:19.000000000 +0100
+++ x/net/sched/estimator.c	2004-05-31 15:51:42.778909936 +0200
@@ -71,10 +71,6 @@
      at user level painlessly.
  */
 
-#if (HZ%4) != 0
-#error Bad HZ value.
-#endif
-
 #define EST_MAX_INTERVAL	5
 
 struct qdisc_estimator
@@ -136,6 +132,9 @@ int qdisc_new_estimator(struct tc_stats 
 	struct qdisc_estimator *est;
 	struct tc_estimator *parm = RTA_DATA(opt);
 
+	if (unlikely(HZ % 4))
+		return -EINVAL;
+
 	if (RTA_PAYLOAD(opt) < sizeof(*parm))
 		return -EINVAL;
 


If you boot with an HZ not divisible by 4 you get -EINVAL at runtime
(instead of a compile failure since we can't check it at compile time
anymore ;).

Anyway the major point of the patch is to get HZ switchable from 100 to
1000, those two values are really the only supported ones. The rest is a
bonus, and I'm sure at least 50 and 2000 will work flawlessy too.
