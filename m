Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWCDRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWCDRPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWCDRPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:15:47 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:44491 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932211AbWCDRPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:15:46 -0500
Date: Sun, 05 Mar 2006 02:15:42 +0900 (JST)
Message-Id: <20060305.021542.126141997.anemo@mba.ocn.ne.jp>
To: johnstul@us.ibm.com
Cc: akpm@osdl.org, zippel@linux-m68k.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1141417048.9727.60.camel@cog.beaverton.ibm.com>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<1141417048.9727.60.camel@cog.beaverton.ibm.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 03 Mar 2006 12:17:28 -0800, john stultz <johnstul@us.ibm.com> said:

john> I'm not opposed to queuing it up as it seems like a logical
john> cleanup. I'd be fine with it going in before my patch, however
john> it still needs to address i386 lost tick compensation.  I worry
john> that addressing that issue before my patchset (which makes the
john> lost tick compensation unnecessary) might be a bit more
john> complex. I think it would be easier going in after my patch. I
john> do think the barrier fix (with a comment) is a good short term
john> fix.

john> Atsushi: Your thoughts?

I agree.  I missed i386 lost tick case and it seems more complex than
x86_64 case.  Your patchset looks to make this cleanup very easy.
Then, here is an updated barrier fix patch.


Add an optimization barrier to prevent prefetching jiffies before
incrementing jiffies_64.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/kernel/timer.c b/kernel/timer.c
index fc6646f..decd19e 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -925,6 +925,8 @@ static inline void update_times(void)
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
+	/* prevent loading jiffies before storing new jiffies_64 value. */
+	barrier();
 	update_times();
 	softlockup_tick(regs);
 }
