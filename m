Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWGRBsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWGRBsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGRBsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 21:48:13 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:11696 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750748AbWGRBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 21:48:12 -0400
Subject: [PATCH] fix bad macro param in timer.c  (was: kernel/timer.c:
	next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2))
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
In-Reply-To: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 21:47:48 -0400
Message-Id: <1153187268.9932.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 20:53 +0200, Andreas Mohr wrote:
> Hi all,
> 
> next_timer_interrupt() contains the following gem:
> 
>         /* Check tv2-tv5. */
>         varray[0] = &base->tv2;
>         varray[1] = &base->tv3;
>         varray[2] = &base->tv4;
>         varray[3] = &base->tv5;
>         for (i = 0; i < 4; i++) {
>                 j = INDEX(i);
>                 do {
>                         if (list_empty(varray[i]->vec + j)) {
>                                 j = (j + 1) & TVN_MASK;
>                                 continue;
>                         }
>                         list_for_each_entry(nte, varray[i]->vec + j, entry)
>                                 if (time_before(nte->expires, expires))
>                                         expires = nte->expires;
>                         if (j < (INDEX(i)) && i < 3)

Looking at what INDEX is defined to be:

#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK

>                                 list = varray[i + 1]->vec + (INDEX(i + 1));

And this INDEX(i+1) is now a ... (TVR_BITS + i + 1 * TVN_BITS)) ...
This doesn't quite look like it suppose to be that way. Probably having
some funny results because of it.

Here's the patch to clean up the macro used to find the index of the
timer vector.

This is definitely a bug fix and should go into 2.6.18

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/kernel/timer.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/timer.c	2006-07-17 21:34:08.000000000 -0400
+++ linux-2.6.18-rc2/kernel/timer.c	2006-07-17 21:34:22.000000000 -0400
@@ -408,7 +408,7 @@ static int cascade(tvec_base_t *base, tv
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + (N) * TVN_BITS)) & TVN_MASK
 
 static inline void __run_timers(tvec_base_t *base)
 {


