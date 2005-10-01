Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVJAHqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVJAHqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJAHqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:46:46 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:5094 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750774AbVJAHqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:46:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Sat, 1 Oct 2005 09:47:25 +0200
User-Agent: KMail/1.8.2
Cc: ak@suse.de, discuss@x86-64.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200509281624.29256.rjw@sisk.pl> <200509300851.09327.rjw@sisk.pl> <20050930182530.E28092@unix-os.sc.intel.com>
In-Reply-To: <20050930182530.E28092@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510010947.25841.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 1 of October 2005 03:25, Siddha, Suresh B wrote:
> On Fri, Sep 30, 2005 at 08:51:08AM +0200, Rafael J. Wysocki wrote:
> > On Friday, 30 of September 2005 07:26, Rafael J. Wysocki wrote:
> > > Of course.  The .config is attached.  Generally, it's a non-SMP box, and commenting
> > > out the zap_low_mappings((0) in setup_arch() makes the box boot again.
> > 
> > One more datapoint: The box boots if I move the zap_low_mappings((0)
> > in the following way:
> > 
> > --- linux-2.6.14-rc2-git7.orig/arch/x86_64/kernel/setup.c	2005-09-30 07:39:35.000000000 +0200
> > +++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c	2005-09-30 08:31:20.000000000 +0200
> > @@ -571,8 +571,6 @@
> >  
> >  	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
> >  
> > -	zap_low_mappings(0);
> > -
> >  #ifdef CONFIG_ACPI
> >  	/*
> >  	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
> > @@ -680,6 +678,8 @@
> >  		get_smp_config();
> >  	init_apic_mappings();
> >  #endif
> > +	zap_low_mappings(0);
> > +
> 
> Rafael, I still can't reproduce the issue. All of my EM64T systems are SMP
> and looks like this problem happens only on an UP system. Looks like
> there is some code flow which is still assuming the presence of low mappings.

I think so too.

> Andi, can you please see if you can reproduce this on one of your systems
> similar to Rafael's.
> 
> >  	/*
> >  	 * Request address space for all standard RAM and ROM resources
> > 
> > iHowever, if I place the zap_low_mappings((0) before the
> > #define CONFIG_X86_LOCAL_APIC in line 673, it doesn't boot.
> > 
> > Certainly init_apic_mappings() is at fault.  Could that be a reult of a call to
> > alloc_bootmem_pages()?.
> 
> I looked at init_apic_mappings() and didn't give me any clue.
> alloc_bootmem_pages() don't use low direct mappings.

OK, I'll try to narrow this a bit more.

> > And one more: I have to boot with "noapic".
> 
> Are you saying "noapic" is the second data point or you need to use "noapic"
> along with moving zap_low_mappings(0) 

It could be the second data point.  I always boot with "noapic", since otherwise
the sharing of IRQs is not handled properly on my box.

Greetings
Rafael
