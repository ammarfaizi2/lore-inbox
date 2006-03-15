Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWCOCJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWCOCJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWCOCJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 21:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751636AbWCOCJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 21:09:30 -0500
Date: Tue, 14 Mar 2006 18:06:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] 2.6.16-rc6 calls check_acpi_pci() on x86 with ACPI
 disabled
Message-Id: <20060314180651.5103928f.akpm@osdl.org>
In-Reply-To: <20060315015318.GA24945@MAIL.13thfloor.at>
References: <20060315013125.GA24402@MAIL.13thfloor.at>
	<20060314174540.5c138458.akpm@osdl.org>
	<20060315015318.GA24945@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> On Tue, Mar 14, 2006 at 05:45:40PM -0800, Andrew Morton wrote:
> > Herbert Poetzl <herbert@13thfloor.at> wrote:
> > >
> > > 
> > > Hi Andrew! Folks!
> > > 
> > > check_acpi_pci() is called form arch/i386/kernel/setup.c
> > > even if CONFIG_ACPI is not defined, but the code in
> > > include/asm/acpi.h doesn't provide it in this case, 
> > 
> > Well that's a shame.
> > 
> > > so either we need to move the declaration outside the 
> > > CONFIG_ACPI check, or alternatively move the call in
> > > setup.c inside the CONFIG_ACPI one
> > > 
> > > attached two patches which would do this
> > 
> > Prefer the first version.  But it'll break if CONFIG_X86_IO_APIC &&
> > !CONFIG_ACPI
> > 
> > So how's about this?
> 
> hmm, well, the comment around the check_acpi_pci() call
> says: "Checks more than just ACPI actually", so I didn't
> want to make it depend on ACPI in the 'first' version,
> which now would change semantics, but if it is fine to
> make it depend on ACPI, the second version might be the
> simpler solution (which should have the same semantic as
> your version ... I think
> 
> maybe the ACPI folks should clarify if this stuff has to
> be run if ACPI is off, in which case renaming the thing
> might be a good idea ...

Yes, actually I didn't check closely enough - arch/i386/kernel/acpi/* gets
built even if CONFIG_ACPI=n (!)

So the code will actualy compile and link OK if we do:

#ifdef CONFIG_X86_IO_APIC
extern void check_acpi_pci(void);
#else
static inline void check_acpi_pci(void) { }
#endif

But we'd need the acpi guys to tell us what's actually intended here,
please.  Does it make sense to be calling this function in a non-ACPI
kernel?



erk, your patch was against include/asm/...  - please don't do that - it
doesn't work very well if the patch receiver isn't using a setup-for-i386
tree.
