Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWJJRRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWJJRRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWJJRRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:9866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964870AbWJJRQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:16:06 -0400
Date: Tue, 10 Oct 2006 10:15:19 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, bunk@stusta.de,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/19] SPARC64: Fix serious bug in sched_clock() on sparc64
Message-ID: <20061010171519.GM6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-serious-bug-in-sched_clock-on-sparc64.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David S. Miller <davem@davemloft.net>

[SPARC64]: Fix sched_clock() wrapping every ~17 seconds.

Unfortunately, sparc64 doesn't have an easy way to do a "64 X 64 -->
128" bit multiply like PowerPC and IA64 do.  We were doing a
"64 X 64 --> 64" bit multiple which causes overflow very quickly with
a 30-bit quotient shift.

So use a quotientshift count of 10 instead of 30, just like x86 and
ARM do.

This also fixes the wrapping of printk timestamp values every ~17
seconds.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/sparc64/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.13.orig/arch/sparc64/kernel/time.c
+++ linux-2.6.17.13/arch/sparc64/kernel/time.c
@@ -1105,7 +1105,7 @@ static struct time_interpolator sparc64_
 };
 
 /* The quotient formula is taken from the IA64 port. */
-#define SPARC64_NSEC_PER_CYC_SHIFT	30UL
+#define SPARC64_NSEC_PER_CYC_SHIFT	10UL
 void __init time_init(void)
 {
 	unsigned long clock = sparc64_init_timers();

--
