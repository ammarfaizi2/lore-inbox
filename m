Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWHTRGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWHTRGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHTRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:06:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24299 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750966AbWHTRGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:06:50 -0400
Date: Sun, 20 Aug 2006 19:06:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Andi Kleen <ak@suse.de>, Helge Hafting <helge.hafting@aitel.hist.no>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, thunder7@xs4all.nl
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed, bisect finished
In-Reply-To: <20060819105031.GA3190@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0608201859130.6762@scrub.home>
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de>
 <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de>
 <20060819105031.GA3190@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 19 Aug 2006, Helge Hafting wrote:

> > Can you narrow it down to a specific patch in -mm? 
> >
> The guilty patch is:
> ntp-add-ntp_update_frequency.patch

That's really weird, I don't really have an idea why it should go wrong 
there, could you please try the patch below and send me the kernel output?
Thanks.

bye, Roman

---
 kernel/time/ntp.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -46,12 +46,21 @@ long time_adjust;
 static void ntp_update_frequency(void)
 {
 	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
+	printk("%Lx,", tick_length_base);
 	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
+	printk("%Lx,", tick_length_base);
 	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
+	printk("%Lx,", tick_length_base);
 
 	do_div(tick_length_base, HZ);
+	printk("%Lx\n", tick_length_base);
 
 	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
+	printk("u: %u.%06u, %ld.%04lu\n",
+		(u32)(tick_length_base >> TICK_LENGTH_SHIFT),
+		(u32)(((tick_length_base & ((1ll << TICK_LENGTH_SHIFT) - 1)) * 1000000) >> TICK_LENGTH_SHIFT),
+		time_offset >> SHIFT_UPDATE,
+		((time_offset & ((1 << SHIFT_UPDATE) - 1)) * 1000) >> SHIFT_UPDATE);
 }
 
 /**
