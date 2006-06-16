Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWFPAy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWFPAy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWFPAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:54:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:29117 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750815AbWFPAy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:54:29 -0400
X-IronPort-AV: i="4.06,139,1149490800"; 
   d="scan'208"; a="51607333:sNHT378092715"
Subject: Re: [PATCH] move do_suspend_lowlevel to correct segment
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060615091934.GG9423@elf.ucw.cz>
References: <1150342766.21189.14.camel@sli10-desk.sh.intel.com>
	 <20060615091934.GG9423@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 08:52:19 +0800
Message-Id: <1150419139.21189.21.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Thu, 2006-06-15 at 11:19 +0200, Pavel Machek wrote:
> > Move do_suspend_lowlevel to correct segment. If it is in the same hugepage
> > with ro data, mark_rodata_ro will make it unexecutable.
> 
> I guess I do not know enough about segments... Original code puts
> saved_magic into .data (and probably puts save_registers there by
> mistake, too -- so you are fixing things), but you put saved_magic
> code into .data, too, so how does its read-only status change?
No, mark_rodata_ro will call change_page_attr, which will split huge
page into small pages, and changes the attr of the pages to PAGE_KERNEL.
mark_rodata_ro just changes rodata to read-only page attr.

> Does x86-64 need similar fix?
It appears not needed

Thanks,
Shaohua
> 
> 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> > 
> >  linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S |    9 ++++-----
> >  1 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff -puN arch/i386/kernel/acpi/wakeup.S~wakeup arch/i386/kernel/acpi/wakeup.S
> > --- linux-2.6.17-rc5/arch/i386/kernel/acpi/wakeup.S~wakeup	2006-06-14 09:21:26.000000000 +0800
> > +++ linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S	2006-06-14 09:21:57.000000000 +0800
> > @@ -265,11 +265,6 @@ ENTRY(acpi_copy_wakeup_routine)
> >  	movl	$0x12345678, saved_magic
> >  	ret
> >  
> > -.data
> > -ALIGN
> > -ENTRY(saved_magic)	.long	0
> > -ENTRY(saved_eip)	.long	0
> > -
> >  save_registers:
> >  	leal	4(%esp), %eax
> >  	movl	%eax, saved_context_esp
> > @@ -304,7 +299,11 @@ ret_point:
> >  	call	restore_processor_state
> >  	ret
> >  
> > +.data
> >  ALIGN
> > +ENTRY(saved_magic)	.long	0
> > +ENTRY(saved_eip)	.long	0
> > +
> >  # saved registers
> >  saved_gdt:	.long	0,0
> >  saved_idt:	.long	0,0
> > _
> 
-- 
Shaohua Li <shaohua.li@intel.com>
