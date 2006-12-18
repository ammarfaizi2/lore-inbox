Return-Path: <linux-kernel-owner+w=401wt.eu-S1754584AbWLRU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbWLRU7z (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbWLRU7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:59:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45606 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584AbWLRU7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:59:54 -0500
Date: Mon, 18 Dec 2006 12:59:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.osdl.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Message-Id: <20061218125949.cf5787c8.akpm@osdl.org>
In-Reply-To: <4586C99C.9020606@gmail.com>
References: <4586797B.3080007@gmail.com>
	<200612181646.23292.rjw@sisk.pl>
	<4586C99C.9020606@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 18:02:20 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, 18 December 2006 12:20, Jiri Slaby wrote:
> >> Hi.
> >>
> >> I got this oops while suspending:
> >> [  309.366557] Disabling non-boot CPUs ...
> >> [  309.386563] CPU 1 is now offline
> >> [  309.387625] CPU1 is down
> >> [  309.387704] Stopping tasks ... done.
> >> [  310.030991] Shrinking memory... -<0>divide error: 0000 [#1]
> >> [  310.456669] SMP
> >> [  310.456814] last sysfs file:
> >> /devices/pci0000:00/0000:00:1e.0/0000:02:08.0/eth0/statistics/collisions
> >> [  310.456919] Modules linked in: eth1394 floppy ohci1394 ide_cd ieee1394 cdrom
> >> [  310.457259] CPU:    0
> >> [  310.457260] EIP:    0060:[<c0150c9a>]    Not tainted VLI
> >> [  310.457261] EFLAGS: 00210246   (2.6.20-rc1-mm1 #207)
> >> [  310.457478] EIP is at shrink_slab+0x9e/0x169
> > 
> > Looks like we have a problem with slab shrinking here.
> > 
> > Could you please use gdb to check what exactly is at shrink_slab+0x9e?
> 
> Sure, but not till Friday, sorry (I am away).

I think there's only one divide in there which can do this, so...

--- a/mm/vmscan.c~shrink_slab-handle-bad-shrinkers
+++ a/mm/vmscan.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/kallsyms.h>
 #include <linux/vmstat.h>
 #include <linux/file.h>
 #include <linux/writeback.h>
@@ -190,7 +191,13 @@ unsigned long shrink_slab(unsigned long 
 		unsigned long total_scan;
 		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
 
-		delta = (4 * scanned) / shrinker->seeks;
+		if (!shrinker->seeks) {
+			print_symbol("shrinker %s has zero seeks\n",
+				(unsigned long)shrinker->shrinker);
+			delta = (4 * scanned) / DEFAULT_SEEKS;
+		} else {
+			delta = (4 * scanned) / shrinker->seeks;
+		}
 		delta *= max_pass;
 		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
_

A quick grep shows that all set_shrinker() callers are doing the right
thing, so something kooky has happened.

