Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVAUKb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVAUKb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVAUKb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:31:28 -0500
Received: from gprs215-198.eurotel.cz ([160.218.215.198]:37053 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262287AbVAUKbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:31:11 -0500
Date: Fri, 21 Jan 2005 11:30:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: hugang@soulinfo.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121103028.GF18373@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121022348.GA18166@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Full patch still can get from
>  http://soulinfo.com/~hugang/swsusp/2005-1-21/

>From a short look:

core.eatmem.diff of course helps, but is wrong. You should talk to
akpm to find out why shrink_all_memory is not doing its job.

i386: +       repz movsl %ds:(%esi),%es:(%edi)
I do not think movsl has any parameters. What is repz? Repeat as long
as it is non-zero? I think this should be "rep movsl".


core:
@@ -576,92 +989,31 @@ static void copy_data_pages(void)
                for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
                        if (saveable(zone, &zone_pfn)) {
                                struct page * page;
+                               pbe = find_pbe_by_index(pagedir_nosave, nr_copy_pages-to_copy);
+                               BUG_ON(pbe == NULL);
                                page = pfn_to_page(zone_pfn + zone->zone_start_pfn);

Don't you introduce O(n^2) behaviour here? Should not it be something
like pbe_next? And it is the only user of find_pbe_by_index().

I think that read_one_pbe() is too short to be uninlined... Same for
read_one_pagedir and write_one_pbe().

alloc_one_pagedir: why not just alloc page as zeroed?

Okay, it is still too big to merge directly. Would it be possible to
get mod_printk_progress(), introduce *_for_each (but leave there old
implementations), introduce pagedir_free() (but leave old
implementation). Better collision code should already be there, that
should make patch smaller, too. Try not to move code around.

That may be mergeable before 2.6.11...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
