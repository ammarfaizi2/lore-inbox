Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVGEVik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVGEVik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVGEVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:38:39 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:24812 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261971AbVGEV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:27:51 -0400
Date: Tue, 5 Jul 2005 14:27:35 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: <Stuart_Hayes@Dell.com>
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-Id: <20050705142735.15daabb7.rdunlap@xenotime.net>
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B407435C@ausx3mps305.aus.amer.dell.com>
References: <B1939BC11A23AE47A0DBE89A37CB26B407435C@ausx3mps305.aus.amer.dell.com>
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

On Tue, 5 Jul 2005 15:02:26 -0500 Stuart_Hayes@Dell.com wrote:

| Hayes, Stuart wrote:
| >> So, if I understand correctly what's going on in x86_64, your fix
| >> wouldn't be applicable to i386.  In x86_64, every large page has a
| >> correct "ref_prot" that is the normal setting for that page... but in
| >> i386, the kernel text area does not--it should ideally be split into
| >> small pages all the time if there are both kernel code & free pages
| >> residing in the same 2M area. 
| >> 
| >> Stuart
| > 
| > (This isn't a submission--I'm just posting this for comments.)
| > 
| > Right now, any large page that touches anywhere from PAGE_OFFSET to
| > __init_end is initially set up as a large, executable page... but
| > some of this area contains data & free pages.  The patch below adds a
| > "cleanup_nx_in_kerneltext()" function, called at the end of
| > free_initmem(), which changes these pages--except for the range from
| > "_text" to "_etext"--to PAGE_KERNEL (i.e., non-executable).     
| > 
| > This does result in two large pages being split up into small PTEs
| > permanently, but all the non-code regions will be non-executable, and
| > change_page_attr() will work correctly.  
| > 
| > What do you think of this?  I have tested this on 2.6.12.
| > 
| > (I've attached the patch as a file, too, since my mail server can't
| > be convinced to not wrap text.) 
| > 
| > Stuart
| > 
| 
| Andi--
| 
| I made another pass at this.  This does roughly the same thing, but it
| doesn't create the new "change_page_attr_perm()" functions.  With this
| patch, the change to init.c (cleanup_nx_in_kerneltext()) is optional.  I
| changed __change_page_attr() so that, if the page to be changed is part
| of a large executable page, it splits the page up *keeping the
| executability of the extra 511 pages*, and then marks the new PTE page
| as reserved so that it won't be reverted.
| 
| So, basically, without the changes to init.c, the NX bits for data in
| the first two big pages won't get fixed until someone calls
| change_page_attr() on them.  If NX is disabled, these patches have no
| functional effect at all.
| 
| How does this look?

Look?  It has lots of bad line breaks and other style issues.

But I'll let Andi comment on the technical issues.

| -----
| 
| diff -purN linux-2.6.12grep/arch/i386/mm/init.c
| linux-2.6.12/arch/i386/mm/init.c
| --- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
| 15:09:27.000000000 -0500
| +++ linux-2.6.12/arch/i386/mm/init.c	2005-07-05 14:32:57.000000000
| -0500
| @@ -666,6 +666,28 @@ static int noinline do_test_wp_bit(void)
|  	return flag;
|  }
|  
| +/*
| + * In kernel_physical_mapping_init(), any big pages that contained
| kernel text area were
| + * set up as big executable pages.  This function should be called when
| the initmem
| + * is freed, to correctly set up the executable & non-executable pages
| in this area.
| + */
| +static void cleanup_nx_in_kerneltext(void)
| +{
| +	unsigned long from, to;
| +
| +	if (!nx_enabled) return;

return; on separate line.

| +	from = PAGE_OFFSET;
| +	to = (unsigned long)_text & PAGE_MASK;
| +	for (; from<to; from += PAGE_SIZE)
	       from < to

(i.e., use the spacebar)

| +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); 
| +	
| +	from = ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
| +	to = ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
| LARGE_PAGE_MASK;
| +	for (; from<to; from += PAGE_SIZE)

add spaces:    from < to

| +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); 
| +}
| +
|  void free_initmem(void)
|  {
|  	unsigned long addr;


---
~Randy
