Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIHM5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIHM5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUIHM4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:56:33 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9126 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267566AbUIHMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:51:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Date: Wed, 8 Sep 2004 14:51:55 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
References: <20040908021637.57525d43.akpm@osdl.org.suse.lists.linux.kernel> <20040908102652.GA2921@atrey.karlin.mff.cuni.cz.suse.lists.linux.kernel> <p73acw1hsvv.fsf@brahms.suse.de>
In-Reply-To: <p73acw1hsvv.fsf@brahms.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081451.55531.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 14:01, Andi Kleen wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Hi!
> > 
> > > One for you guys on lkml ;)
> > 
> > It simply takes long to count pages (O(n^2) algorithm), so watchdog
> > triggers. I have better algorithm locally, but would like merge to
> > linus first. (I posted it to lkml some days ago, I can attach the
> > bigdiff).
> > 
> > Just disable the watchdog. Suspend *is* going to take time with
> > disabled interrupts.
> 
> 
> As a short term workaround you could also add touch_nmi_watchdog()s
> in that loop.

You mean like that:

--- swsusp.c.orig	2004-09-08 14:30:29.049656984 +0200
+++ swsusp.c	2004-09-08 14:41:42.133332712 +0200
@@ -38,6 +38,7 @@
 
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/nmi.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
@@ -561,6 +562,7 @@
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			touch_nmi_watchdog();
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
@@ -576,6 +578,7 @@
 	
 	for_each_zone(zone) {
 		if (!is_highmem(zone))
+			touch_nmi_watchdog();
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 				if (saveable(zone, &zone_pfn)) {
 					struct page * page;
---

Just guessing. :-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
