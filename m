Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbTIRQC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTIRQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:02:26 -0400
Received: from fmr04.intel.com ([143.183.121.6]:41663 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261737AbTIRQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:02:21 -0400
Subject: Re: fix off-by-one error in ioremap()
From: Len Brown <len.brown@intel.com>
To: arjanv@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063872336.5026.1.camel@laptop.fenrus.com>
References: <200309172107.h8HL7UBf011628@hera.kernel.org>
	 <1063872336.5026.1.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063900980.2674.72.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Sep 2003 12:03:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-18 at 04:05, Arjan van de Ven wrote:
> On Fri, 2003-09-12 at 10:15, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1063.43.5, 2003/09/12 04:15:36-04:00, len.brown@intel.com
> > 
> > 	fix off-by-one error in ioremap()
> > 	fixes kernel crash in acpi mode: http://bugzilla.kernel.org/show_bug.cgi?id=1085
> 
> > diff -Nru a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
> > --- a/arch/i386/mm/ioremap.c	Wed Sep 17 14:07:31 2003
> > +++ b/arch/i386/mm/ioremap.c	Wed Sep 17 14:07:31 2003
> > @@ -140,7 +140,7 @@
> >  	 */
> >  	offset = phys_addr & ~PAGE_MASK;
> >  	phys_addr &= PAGE_MASK;
> > -	size = PAGE_ALIGN(last_addr) - phys_addr;
> > +	size = PAGE_ALIGN(last_addr+1) - phys_addr;
> >  
> 
> 
> A bit higher in that function is:
>                                                                                                         
>         /* Don't allow wraparound or zero size */
>         last_addr = phys_addr + size - 1;
>         if (!size || last_addr < phys_addr)
>                 return NULL;
>                                                                                                         
> 
> so why do you undo the deliberate -1 there ?

Because:

last_addr = phys_addr + size - 1
means that
size = last_addr - phys_addr + 1
not
size = last_addr - phys_addr

If you leave out this change, then a request for a page-aligned 4096+1
bytes will give you a single 4096 byte page, and the kernel will crash
when you access byte 4096+1.

As this bug has been in the kernel for years, it apparently isn't common
to access 4097-byte item starting on page boundaries;-)

However, ACPI maps tables that are left on arbitrary byte boundaries by
the BIOS.  In this case we got a table that started near the end of a
page and overflowed 1 byte into the next page -- which has the same
effect as the simpler case above.

cheers,
-Len

ps. this fix has been in 2.6 for several months -- sort of a bummer it
had to be debugged and fixed twice.



