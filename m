Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVHKKUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVHKKUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVHKKUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:20:45 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:35798 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S964862AbVHKKUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:20:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Thu, 11 Aug 2005 12:26:13 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, Daniel Phillips <phillips@arcor.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <200508100522.51297.phillips@arcor.de> <20050810215022.GA2465@elf.ucw.cz>
In-Reply-To: <20050810215022.GA2465@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111226.14457.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 10 of August 2005 23:50, Pavel Machek wrote:
> Hi!
> 
> > > Swsusp is the main "is valid ram" user I have in mind here. It
> > > wants to know whether or not it should save and restore the
> > > memory of a given `struct page`.
> > 
> > Why can't it follow the rmap chain?
> 
> It is walking physical memory, not memory managment chains. I need
> something like:
> 
> static int saveable(struct zone * zone, unsigned long * zone_pfn)
> {
>         unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
>         struct page * page;
> 
>         if (!pfn_valid(pfn))
>                 return 0;
> 
>         page = pfn_to_page(pfn);
>         BUG_ON(PageReserved(page) && PageNosave(page));
>         if (PageNosave(page))
>                 return 0;
>         if (PageReserved(page) && pfn_is_nosave(pfn)) {

This only is a trick to avoid calling pfn_is_nosave(pfn) for every single page
that is neither PageNosave nor PageNosaveFree, isn't it?

>                 pr_debug("[nosave pfn 0x%lx]", pfn);
>                 return 0;
>         }
>         if (PageNosaveFree(page))
>                 return 0;
> 
>         return 1;
> }

IMO it is safe to drop PageReserved from this function completely, which is
done in the following (experimental) patch (tested on x86-64).

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.13-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/kernel/power/swsusp.c
+++ linux-2.6.13-rc5-mm1/kernel/power/swsusp.c
@@ -674,15 +674,14 @@ static int saveable(struct zone * zone, 
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
-		return 0;
-	}
 	if (PageNosaveFree(page))
 		return 0;
+	if (pfn_is_nosave(pfn)) {
+		pr_debug("  [nosave pfn 0x%lx]\n", pfn);
+		return 0;
+	}
 
 	return 1;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
