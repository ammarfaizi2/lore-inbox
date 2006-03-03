Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752150AbWCCCc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbWCCCc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCCCc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:32:56 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:38850 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1752150AbWCCCcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:32:55 -0500
Date: Fri, 03 Mar 2006 11:32:46 +0900 (JST)
Message-Id: <20060303.113246.01208537.nemoto@toshiba-tops.co.jp>
To: ram.gupta5@gmail.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix potential jiffies overflow
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com>
References: <20060303.000306.08077845.anemo@mba.ocn.ne.jp>
	<728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 2 Mar 2006 10:43:12 -0600, "Ram Gupta" <ram.gupta5@gmail.com> said:
>> I found i386 timer_resume is updating jiffies, not jiffies_64.  It
>> looks there is a potential overflow problem.  Is this a correct
>> fix?

ram> The 64-bit jiffies value is not atomic. You need to hold
ram> xtime_lock to read it.

OK, and I guess wall_jiffies also needs xtime_lock.


I found i386 timer_resume is updating jiffies, not jiffies_64.  It
looks there is a potential overflow problem.  And jiffies_64 and
wall_jiffies should be protected by xtime_lock.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index a14d594..9d30747 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -412,9 +412,9 @@ static int timer_resume(struct sys_devic
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-	jiffies += sleep_length;
+	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	if (last_timer->resume)
 		last_timer->resume();
 	cur_timer = last_timer;
