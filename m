Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUETXJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUETXJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUETXJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:09:49 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:43271 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265238AbUETXJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:09:43 -0400
Date: Thu, 20 May 2004 16:11:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: adi@hexapodia.org, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
Message-Id: <20040520161143.5677e9b7.akpm@osdl.org>
In-Reply-To: <20040520185745.GA7706@elte.hu>
References: <1XBEP-Mc-49@gated-at.bofh.it>
	<1XBXw-13D-3@gated-at.bofh.it>
	<1XWpp-zy-9@gated-at.bofh.it>
	<m3lljnnoa0.fsf@averell.firstfloor.org>
	<20040520151939.GA3562@elte.hu>
	<20040520155323.GA4750@elte.hu>
	<20040520161901.GD13601@hexapodia.org>
	<20040520185745.GA7706@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2004 23:09:03.0483 (UTC) FILETIME=[715D44B0:01C43EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> i've attached a new patch that does what Andi suggested too - 
> timestamping of the oopses. This way we will zap no sooner than 10 
> seconds after the first oops.

I think that will do the wrong thing between 23 and 47 days uptime because
time_after() will return an incorrect answer.

How's this look?




- Bump the timeout to 30 seconds - 9600 baud is slow.

- Handle jiffy wraps: change the logic so that we only skip the lockbust if
  the current time is within 30 seconds of the previous lockbusting attempt.



---

 25-akpm/kernel/printk.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -puN kernel/printk.c~mangled-printk-oops-output-fix-tweaks kernel/printk.c
--- 25/kernel/printk.c~mangled-printk-oops-output-fix-tweaks	Thu May 20 16:01:53 2004
+++ 25-akpm/kernel/printk.c	Thu May 20 16:10:32 2004
@@ -55,9 +55,6 @@ EXPORT_SYMBOL(console_printk);
 
 int oops_in_progress;
 
-/* zap spinlocks only once: */
-unsigned long oops_timestamp;
-
 /*
  * console_sem protects the console_drivers list, and also
  * provides serialisation for access to the entire console
@@ -479,10 +476,14 @@ static void emit_log_char(char c)
  * every 10 seconds, to leave time for slow consoles to print a
  * full oops.
  */
-static inline void zap_locks(void)
+static void zap_locks(void)
 {
-	if (!time_after(jiffies, oops_timestamp + 10*HZ))
+	static unsigned long oops_timestamp;
+
+	if (time_after_eq(jiffies, oops_timestamp) &&
+			!time_after(jiffies, oops_timestamp + 30*HZ))
 		return;
+
 	oops_timestamp = jiffies;
 
 	/* If a crash is occurring, make sure we can't deadlock */

_

