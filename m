Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDDIy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDDIy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVDDIy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:54:59 -0400
Received: from fmr20.intel.com ([134.134.136.19]:1495 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261184AbVDDIyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:54:55 -0400
Subject: Re: [RFC 1/6]SEP initialization rework
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
In-Reply-To: <20050404084638.GB14642@elf.ucw.cz>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
	 <20050404084638.GB14642@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1112604746.4194.374.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 16:52:26 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-04 at 16:46, Pavel Machek wrote:
> > ---
> > 
> >  linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
> >  linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
> >  linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
> > --- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
> > +++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
> > @@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
> >  	int cpu = get_cpu();
> >  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
> >  
> > +	if (!boot_cpu_has(X86_FEATURE_SEP)) {
> > +		put_cpu();
> > +		return;
> > +	}
> > +
> >  	tss->ss1 = __KERNEL_CS;
> >  	tss->esp1 = sizeof(struct tss_struct) + (unsigned long) tss;
> >  	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
> > @@ -41,7 +46,7 @@ void enable_sep_cpu(void *info)
> >  extern const char vsyscall_int80_start, vsyscall_int80_end;
> >  extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
> >  
> > -static int __init sysenter_setup(void)
> > +int __init sysenter_setup(void)
> >  {
> >  	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
> >  
> 
> Can this still be __init? I think you are calling it from hotplug code
> now, right?
Only BP executes it. AP calls enable_sep_cpu.

> 
> > diff -puN arch/i386/kernel/smpboot.c~sep_init_cleanup arch/i386/kernel/smpboot.c
> > --- linux-2.6.11/arch/i386/kernel/smpboot.c~sep_init_cleanup	2005-03-28 09:33:49.972288952 +0800
> > +++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-03-28 09:46:01.814032096 +0800
> > @@ -415,6 +415,8 @@ static void __init smp_callin(void)
> >  
> >  static int cpucount;
> >  
> > +extern int sysenter_setup(void);
> > +extern void enable_sep_cpu(void *);
> >  /*
> >   * Activate a secondary processor.
> >   */
> 
> Perhaps these should go to header file somewhere?
in asm-i386/smp.h?

Thanks,
Shaohua

