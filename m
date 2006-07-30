Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWG3Owf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWG3Owf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWG3Owf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:52:35 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:23512 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750840AbWG3Owe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:52:34 -0400
Date: Sun, 30 Jul 2006 23:54:03 +0900 (JST)
Message-Id: <20060730.235403.108306254.anemo@mba.ocn.ne.jp>
To: johnstul@us.ibm.com
Cc: akpm@osdl.org, zippel@linux-m68k.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060305.021542.126141997.anemo@mba.ocn.ne.jp>
References: <20060302190408.1e754f12.akpm@osdl.org>
	<1141417048.9727.60.camel@cog.beaverton.ibm.com>
	<20060305.021542.126141997.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me restart this discussion after about 5 months interval.

On Sun, 05 Mar 2006 02:15:42 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> john> I'm not opposed to queuing it up as it seems like a logical
> john> cleanup. I'd be fine with it going in before my patch, however
> john> it still needs to address i386 lost tick compensation.  I worry
> john> that addressing that issue before my patchset (which makes the
> john> lost tick compensation unnecessary) might be a bit more
> john> complex. I think it would be easier going in after my patch. I
> john> do think the barrier fix (with a comment) is a good short term
> john> fix.
> 
> john> Atsushi: Your thoughts?
> 
> I agree.  I missed i386 lost tick case and it seems more complex than
> x86_64 case.  Your patchset looks to make this cleanup very easy.
> Then, here is an updated barrier fix patch.

Now it seems the conversion of the i386 timer code has been finished.
We can think this topic again.  Here is a patch against current git
tree.  How about this?  And I wonder if there are any point
maintaining wall_jiffies now.  It seems jiffies and wall_jiffies are
always synced.


[PATCH] simplify update_times

In kernel 2.6, update_times() is called directly from timer interrupt,
so there is no point calculating ticks here.  This also make a barrier
added by 5aee405c662ca644980c184774277fc6d0769a84 needless.

Also adjust x86_64 timer interrupt handler with this change.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7a9b182..298027f 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -423,7 +423,8 @@ #endif
 
 	if (lost > 0) {
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
+		while (lost--)
+			do_timer(regs);
 	}
 
 /*
diff --git a/kernel/timer.c b/kernel/timer.c
index 05809c2..3981cae 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1267,12 +1267,9 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
-	wall_jiffies += ticks;
+	wall_jiffies++;
 	update_wall_time();
-	calc_load(ticks);
+	calc_load(1);
 }
   
 /*
@@ -1284,8 +1281,6 @@ static inline void update_times(void)
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
-	/* prevent loading jiffies before storing new jiffies_64 value. */
-	barrier();
 	update_times();
 }
 
