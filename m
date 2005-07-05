Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVGEWI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVGEWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGEWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:07:46 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:57249 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261994AbVGEWAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:00:30 -0400
Date: Tue, 5 Jul 2005 15:00:19 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: <Stuart_Hayes@Dell.com>
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-Id: <20050705150019.2d9d8f1c.rdunlap@xenotime.net>
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B4074360@ausx3mps305.aus.amer.dell.com>
References: <B1939BC11A23AE47A0DBE89A37CB26B4074360@ausx3mps305.aus.amer.dell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 16:35:51 -0500 Stuart_Hayes@Dell.com wrote:

| randy_dunlap wrote:
| > On Tue, 5 Jul 2005 15:02:26 -0500 Stuart_Hayes@Dell.com wrote:
| > 
| >> Andi--
| >> 
| >> I made another pass at this.  This does roughly the same thing, but
| >> it doesn't create the new "change_page_attr_perm()" functions.  With
| >> this patch, the change to init.c (cleanup_nx_in_kerneltext()) is
| >> optional. I changed __change_page_attr() so that, if the page to be
| >> changed is part of a large executable page, it splits the page up
| >> *keeping the executability of the extra 511 pages*, and then marks
| >> the new PTE page as reserved so that it won't be reverted.
| >> 
| >> So, basically, without the changes to init.c, the NX bits for data in
| >> the first two big pages won't get fixed until someone calls
| >> change_page_attr() on them.  If NX is disabled, these patches have
| >> no functional effect at all. 
| >> 
| >> How does this look?
| > 
| > Look?  It has lots of bad line breaks and other style issues.
| > 
| > But I'll let Andi comment on the technical issues.
| > 
| >> -----
| >> 
| >> diff -purN linux-2.6.12grep/arch/i386/mm/init.c
| >> linux-2.6.12/arch/i386/mm/init.c
| >> --- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
| >> 15:09:27.000000000 -0500 +++
| >> linux-2.6.12/arch/i386/mm/init.c	2005-07-05 14:32:57.000000000
| -0500
| >>  @@ -666,6 +666,28 @@ static int noinline do_test_wp_bit(void) 
| >> return flag; } 
| >> 
| >> +/*
| >> + * In kernel_physical_mapping_init(), any big pages that contained
| >> kernel text area were + * set up as big executable pages.  This
| >> function should be called + when the initmem
| >> + * is freed, to correctly set up the executable & non-executable +
| >> pages in this area.
| >> + */
| >> +static void cleanup_nx_in_kerneltext(void) {
| >> +	unsigned long from, to;
| >> +
| >> +	if (!nx_enabled) return;
| > 
| > return; on separate line.
| > 
| >> +	from = PAGE_OFFSET;
| >> +	to = (unsigned long)_text & PAGE_MASK;
| >> +	for (; from<to; from += PAGE_SIZE)
| > 	       from < to
| > 
| > (i.e., use the spacebar)
| > 
| >> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); +
| >> +	from = ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
| >> +	to = ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
| >> LARGE_PAGE_MASK; +	for (; from<to; from += PAGE_SIZE)
| > 
| > add spaces:    from < to
| > 
| >> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); }
| +
| >>  void free_initmem(void)
| >>  {
| >>  	unsigned long addr;
| > 
| > 
| > ---
| > ~Randy
| 
| Thanks for the feedback.  I know it looks like crap with the line
| wrapping, but I have no way of sending non-automatically-line-broken
| email right now, which is why I attached the file in addition to the
| inline text.  I apologize for that.

My apologies also, I completely missed seeing the attachment.

| I'll correct those cosmetic issues, thanks.

---
~Randy
