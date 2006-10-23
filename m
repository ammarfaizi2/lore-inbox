Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWJWP3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWJWP3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWJWP3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:29:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:31677 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964940AbWJWP3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:29:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Date: Mon, 23 Oct 2006 17:29:10 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200610221548.48204.rjw@sisk.pl> <20061023145033.GB31273@elf.ucw.cz>
In-Reply-To: <20061023145033.GB31273@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231729.10925.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 23 October 2006 16:50, Pavel Machek wrote:
> Hi!
> 
> > The purpose of the appended patch is to make swsusp work on i386 with PAE,
> > but it should also allow i386 systems without PSE to use swsusp.
> > 
> > The patch creates temporary page tables located in resume-safe page frames
> > during the resume and uses them for restoring the suspend image (the same
> > approach is used on x86-64).
> > 
> > It has been tested on an i386 system with PAE and survived several
> > suspend-resume cycles in a row, but I have no systems without PSE, so that
> > requires some testing.
> 
> Thanks, looks okay to me. I guess Andi Kleen would be right person to
> review it in detail?

Yes, I think so.

> Lack of assembly modifications is good.
> 
> I guess this should be now removed? (include/asm-i386/suspend.h)
> 
> arch_prepare_suspend(void)
> {
>         /* If you want to make non-PSE machine work, turn off paging
>            in swsusp_arch_suspend. swsusp_pg_dir should have identity mapping, so
>            it could work...  */
>         if (!cpu_has_pse) {
>                 printk(KERN_ERR "PSE is required for swsusp.\n");
>                 return -EPERM;
>         }

Yes, it should.  I though it went away when the Kconfig was changed ...

> > +/*
> > + * Create a middle page table on a resume-safe page and put a pointer to it in
> > + * the given global directory entry.  This only returns the gd entry
> > + * in non-PAE compilation mode, since the middle layer is folded.
> > + */
> > +static pmd_t *resume_one_md_table_init(pgd_t *pgd)
> > +{
> > +	pud_t *pud;
> > +	pmd_t *pmd_table;
> > +
> > +#ifdef CONFIG_X86_PAE
> > +	pmd_table = (pmd_t *)get_safe_page(GFP_ATOMIC);
> > +	if (!pmd_table)
> > +		return pmd_table;
> 
> I'd do plain old return NULL; here.

OK

> > +			/* Map with big pages if possible, otherwise create
> > +			 * normal page tables.
> > +			 * NOTE: We can mark everything as executable here
> > +			 */
> > +			if (cpu_has_pse) {
> > +				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
> > +				pfn += PTRS_PER_PTE;
> 
> Perhaps disabling PSE here can help getting some testing?

Well, I don't really want to make everyone test the !PSE scenario. ;-)

> Okay, I guess I should really test this one... Seems good enough for
> -mm to me, but it should preferably stay there for a _long_ time.

I think so too.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
