Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUIHO4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUIHO4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUIHO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:56:28 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2473 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268382AbUIHOwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:52:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Date: Wed, 8 Sep 2004 16:52:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20040908021637.57525d43.akpm@osdl.org.suse.lists.linux.kernel> <200409081451.55531.rjw@sisk.pl> <20040908130049.GA15444@wotan.suse.de>
In-Reply-To: <20040908130049.GA15444@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081652.43463.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 15:00, Andi Kleen wrote:
> On Wed, Sep 08, 2004 at 02:51:55PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday 08 of September 2004 14:01, Andi Kleen wrote:
> > > Pavel Machek <pavel@ucw.cz> writes:
> > > 
> > > > Hi!
> > > > 
> > > > > One for you guys on lkml ;)
> > > > 
> > > > It simply takes long to count pages (O(n^2) algorithm), so watchdog
> > > > triggers. I have better algorithm locally, but would like merge to
> > > > linus first. (I posted it to lkml some days ago, I can attach the
> > > > bigdiff).
> > > > 
> > > > Just disable the watchdog. Suspend *is* going to take time with
> > > > disabled interrupts.
> > > 
> > > 
> > > As a short term workaround you could also add touch_nmi_watchdog()s
> > > in that loop.
> > 
> > You mean like that:
> 
> I doubt this will help, because the number of zones is quite small.
> 
> Better check every N pages, e.g. N=100

I've done something like that:

--- swsusp.c.orig	2004-09-08 14:30:29.000000000 +0200
+++ swsusp.c	2004-09-08 15:56:55.000000000 +0200
@@ -38,6 +38,7 @@
 
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/nmi.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
@@ -556,14 +557,19 @@
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
+	unsigned nmi_cnt = 0;
 
 	nr_copy_pages = 0;
 
 	for_each_zone(zone) {
-		if (!is_highmem(zone)) {
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+		if (!is_highmem(zone))
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 				nr_copy_pages += saveable(zone, &zone_pfn);
-		}
+				if (nmi_cnt++ >= 100) {
+					touch_nmi_watchdog();
+					nmi_cnt = 0;
+				}	
+			}
 	}
 }
 
and it works, but it seems to me that something similar is necessary for 
resuming (I get an NMI watchdog report if it's not disabled).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
