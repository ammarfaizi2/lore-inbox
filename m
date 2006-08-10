Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWHJTwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWHJTwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWHJTv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:51:57 -0400
Received: from mail.suse.de ([195.135.220.2]:22417 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932673AbWHJThT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:19 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [119/145] x86_64: X86_64 monotonic_clock goes backwards
Message-Id: <20060810193718.4410713C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:18 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Dimitri Sivanich <sivanich@sgi.com>
I've noticed some erratic behavior while testing the X86_64 version
of monotonic_clock().

While spinning in a loop reading monotonic clock values (pinned to a
single cpu) I noticed that the difference between subsequent values
occasionally went negative (time going backwards).

I found that in the following code:
                this_offset = get_cycles_sync();
                /* FIXME: 1000 or 1000000? */
-->             offset = (this_offset - last_offset)*1000 / cpu_khz;
        }       
        return base + offset;

the offset sometimes turns out to be 0, even though
this_offset > last_offset.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/time.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -276,6 +276,7 @@ static void set_rtc_mmss(unsigned long n
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
  */
+static inline unsigned long long cycles_2_ns(unsigned long long cyc);
 unsigned long long monotonic_clock(void)
 {
 	unsigned long seq;
@@ -300,8 +301,7 @@ unsigned long long monotonic_clock(void)
 			base = monotonic_base;
 		} while (read_seqretry(&xtime_lock, seq));
 		this_offset = get_cycles_sync();
-		/* FIXME: 1000 or 1000000? */
-		offset = (this_offset - last_offset)*1000 / cpu_khz;
+		offset = cycles_2_ns(this_offset - last_offset);
 	}
 	return base + offset;
 }
@@ -405,8 +405,7 @@ void main_timer_handler(struct pt_regs *
 			offset %= USEC_PER_TICK;
 		}
 
-		/* FIXME: 1000 or 1000000? */
-		monotonic_base += (tsc - vxtime.last_tsc) * 1000000 / cpu_khz;
+		monotonic_base += cycles_2_ns(tsc - vxtime.last_tsc);
 
 		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
 
