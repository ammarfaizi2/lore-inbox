Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVIZKtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVIZKtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 06:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIZKtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 06:49:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45793 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750791AbVIZKtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 06:49:32 -0400
Date: Mon, 26 Sep 2005 12:49:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH][Fix] Prevent swsusp from corrupting page translation tables during resume on x86-64
Message-ID: <20050926104913.GC3554@elf.ucw.cz>
References: <200509241936.12214.rjw@sisk.pl> <20050925220738.GF2775@elf.ucw.cz> <200509261246.19085.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261246.19085.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The following patch fixes Bug #4959.  It creates temporary page translation
> > > tables located in the page frames that are not overwritten by swsusp while copying
> > > the image.
> > > 
> > > The temporary page translation tables are generally based on the existing ones
> > > with the exception that the mappings using 4KB pages are replaced with the
> > > equivalent mappings that use 2MB pages only.  The temporary page tables are
> > > only used for copying the image.
> > 
> > Would not it be simpler to create them from scratch? mm/init.c has
> > some handy functions, they should be applicable. [init_memory_mapping,
> > phys_pud_init]. Perhaps even initialize only simple direct mapping,
> > and place virt_to_phys() at strategic places?
> 
> Perhaps, but the outcome would be very much the same.  The problem is to what
> extent we can use the existing constructs, because I'd rather like to avoid the situation
> in which any future changes to the initialization code would have to be replicated
> in the swsusp code.  I'll have a look at that, but I'm not sure.  Also I don't really know
> what the Andi's preferences are with this respect.
> 
> Anyway do you think that creating temporary page tables at the beginning of
> swsusp_arch_resume() is a good idea?  If not, where do you think should they be
> created?

For i386, I simply let bootup code create them, and create "backup
copy" that is not damaged by any page splits... Result is in
mm/init.c:


#ifdef CONFIG_SOFTWARE_SUSPEND
/*
 * Swap suspend & friends need this for resume because things like the
intel-agp
 * driver might have split up a kernel 4MB mapping.
 */
char __nosavedata swsusp_pg_dir[PAGE_SIZE]
        __attribute__ ((aligned (PAGE_SIZE)));

static inline void save_pg_dir(void)
{
        memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
}
#else
static inline void save_pg_dir(void)
{
}
#endif

It is probably not as simple for x86-64 case, but some bootup code
reusal still should be neccessary...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
