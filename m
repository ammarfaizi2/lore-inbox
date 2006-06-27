Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWF0RYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWF0RYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWF0RYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:24:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19592 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161233AbWF0RX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:23:59 -0400
Date: Tue, 27 Jun 2006 19:23:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <Pine.LNX.4.64.0606271903320.12900@scrub.home>
Message-ID: <Pine.LNX.4.64.0606271919450.17704@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>           
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jun 2006, Roman Zippel wrote:

> On Tue, 27 Jun 2006, Valdis.Kletnieks@vt.edu wrote:
> 
> > Sorry Roman... This may indeed be a legitimate bugfix, but it doesn't
> > fix the problem I'm seeing.  I've been doing the mm-bisect polka for a bit,
> > and have it narrowed down to this set of patches:
> 
> I'm afraid the problem is somehow related, in the longer boot log one can 
> see the edi counting down, so I think it's likely in timespec_add_ns().
> What's weird is that you can trigger it this easily...

Could you please try the patch below? This should better locate which of 
the values goes wrong.

bye, Roman

---
 kernel/timer.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-06-27 19:16:13.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-06-27 19:17:41.000000000 +0200
@@ -834,6 +834,8 @@ static inline void __get_realtime_clock_
 
 	} while (read_seqretry(&xtime_lock, seq));
 
+	if (ts->tv_nsec < 0 || nsecs < 0)
+		printk("unexpected nsec: %ld,%Ld\n", ts->tv_nsec, nsecs);
 	timespec_add_ns(ts, nsecs);
 }
 
