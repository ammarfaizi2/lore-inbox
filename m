Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWHDOfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWHDOfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWHDOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:34:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33711 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161225AbWHDOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:34:51 -0400
Date: Fri, 4 Aug 2006 09:34:49 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: X86_64 monotonic_clock goes backwards
Message-ID: <20060804143449.GA13105@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

The following patch does correct this, and -seems- to be correct.
Some reording of code may still be desired.

Dimitri


Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -281,6 +281,7 @@ static void set_rtc_mmss(unsigned long n
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
  */
+static inline unsigned long long cycles_2_ns(unsigned long long cyc);
 unsigned long long monotonic_clock(void)
 {
 	unsigned long seq;
@@ -305,8 +306,7 @@ unsigned long long monotonic_clock(void)
 			base = monotonic_base;
 		} while (read_seqretry(&xtime_lock, seq));
 		this_offset = get_cycles_sync();
-		/* FIXME: 1000 or 1000000? */
-		offset = (this_offset - last_offset)*1000 / cpu_khz;
+		offset = cycles_2_ns(this_offset - last_offset);
 	}
 	return base + offset;
 }
