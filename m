Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVCDNWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVCDNWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVCDNW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:22:28 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:3228 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262871AbVCDNNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:13:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Fri, 4 Mar 2005 14:15:34 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
References: <200502252237.04110.rjw@sisk.pl> <200503030902.48038.rjw@sisk.pl> <20050304110408.GL1345@elf.ucw.cz>
In-Reply-To: <20050304110408.GL1345@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200503041415.35162.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 4 of March 2005 12:04, Pavel Machek wrote:
> Hi!
> 
> > > IIRC kernel code/data is marked as PageReserved(), that's why we need
> > > to save that :(. Not sure what to do with data e820 marked as
> > > reserved...
> > 
> > Perhaps we need another page flag, like PG_readonly, and mark the pages
> > reserved by the e820 as PG_reserved | PG_readonly (the same for the areas
> > that are not returned by e820 at all).  Would that be acceptable?
> 
> This flags are little in the short supply, but being able to tell
> kernel code from memory hole seems like "must have", so yes, that
> looks ok.
> 
> You could get subtle and reuse some other pageflag. I do not think
> PG_reserved can have PG_locked... So using for example PG_locked for
> this purpose should be okay.

The following patch does this.  It is only for x86-64 without
CONFIG_DISCONTIGMEM, but it has no effect in other cases.


--- linux-2.6.11-rc5-mm1/arch/x86_64/mm/init.c	2005-03-04 12:19:29.000000000 +0100
+++ new/arch/x86_64/mm/init.c	2005-03-04 13:53:08.000000000 +0100
@@ -438,11 +438,14 @@
 	totalram_pages += free_all_bootmem();
 
 	for (tmp = 0; tmp < end_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
-			reservedpages++;
+		if (!page_is_ram(tmp))
+			SetPageLocked(pfn_to_page(tmp));
+		else
+			/*
+			 * Count reserved RAM pages
+			 */
+			if (PageReserved(pfn_to_page(tmp)))
+				reservedpages++;
 #endif
 
 	after_bootmem = 1;
--- linux-2.6.11-rc5-mm1/kernel/power/swsusp.c	2005-03-04 13:54:50.000000000 +0100
+++ new/kernel/power/swsusp.c	2005-03-04 13:57:37.000000000 +0100
@@ -531,9 +531,15 @@
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
-		return 0;
+	if (PageReserved(page)) {
+		if (pfn_is_nosave(pfn)) {
+			pr_debug("[nosave pfn 0x%lx]\n", pfn);
+			return 0;
+		}
+		if (PageLocked(page)) {
+			pr_debug("[locked pfn 0x%lx]\n", pfn);
+			return 0;
+		}
 	}
 	if (PageNosaveFree(page))
 		return 0;


I thought it would be more complicated. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
