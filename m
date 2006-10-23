Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWJWOvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWJWOvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWJWOvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:51:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38052 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964905AbWJWOu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:50:59 -0400
Date: Mon, 23 Oct 2006 16:50:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Message-ID: <20061023145033.GB31273@elf.ucw.cz>
References: <200610221548.48204.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610221548.48204.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The purpose of the appended patch is to make swsusp work on i386 with PAE,
> but it should also allow i386 systems without PSE to use swsusp.
> 
> The patch creates temporary page tables located in resume-safe page frames
> during the resume and uses them for restoring the suspend image (the same
> approach is used on x86-64).
> 
> It has been tested on an i386 system with PAE and survived several
> suspend-resume cycles in a row, but I have no systems without PSE, so that
> requires some testing.

Thanks, looks okay to me. I guess Andi Kleen would be right person to
review it in detail?

Lack of assembly modifications is good.

I guess this should be now removed? (include/asm-i386/suspend.h)

arch_prepare_suspend(void)
{
        /* If you want to make non-PSE machine work, turn off paging
           in swsusp_arch_suspend. swsusp_pg_dir should have identity mapping, so
           it could work...  */
        if (!cpu_has_pse) {
                printk(KERN_ERR "PSE is required for swsusp.\n");
                return -EPERM;
        }

> +/*
> + * Create a middle page table on a resume-safe page and put a pointer to it in
> + * the given global directory entry.  This only returns the gd entry
> + * in non-PAE compilation mode, since the middle layer is folded.
> + */
> +static pmd_t *resume_one_md_table_init(pgd_t *pgd)
> +{
> +	pud_t *pud;
> +	pmd_t *pmd_table;
> +
> +#ifdef CONFIG_X86_PAE
> +	pmd_table = (pmd_t *)get_safe_page(GFP_ATOMIC);
> +	if (!pmd_table)
> +		return pmd_table;

I'd do plain old return NULL; here.

> +			/* Map with big pages if possible, otherwise create
> +			 * normal page tables.
> +			 * NOTE: We can mark everything as executable here
> +			 */
> +			if (cpu_has_pse) {
> +				set_pmd(pmd, pfn_pmd(pfn, PAGE_KERNEL_LARGE_EXEC));
> +				pfn += PTRS_PER_PTE;

Perhaps disabling PSE here can help getting some testing?

Okay, I guess I should really test this one... Seems good enough for
-mm to me, but it should preferably stay there for a _long_ time.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
