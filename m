Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVBTRYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVBTRYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 12:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBTRYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 12:24:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:52677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbVBTRYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 12:24:04 -0500
Date: Sun, 20 Feb 2005 09:23:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <20050220082226.A7093@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
 <1108863372.8413.158.camel@localhost.localdomain> <20050220082226.A7093@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Feb 2005, Russell King wrote:
> On Sat, Feb 19, 2005 at 08:36:12PM -0500, Steven Rostedt wrote:
> >  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> >  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
> >  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
> >  BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
> >  BIOS-e820: 000000000f700000 - 000000003fef0000 (usable)
> >  BIOS-e820: 000000003fef0000 - 000000003fef8000 (ACPI data)
> >  BIOS-e820: 000000003fef8000 - 000000003fefa000 (ACPI NVS)
> >  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
> 
> Your BIOS is broken.  You probably have 1GB of RAM which extends from
> 0x00000000 to 0x40000000.  However, there's a hole in the ACPI map
> between 0x3fefa000 and 0x3ff00000.

Good point. And dammit, we've had that problem too many times before.

And I think the reason for that bug is that we use "max_low_pfn" to 
determine where we should start allocating PCI memory. We actually round 
it up to the next megabyte, which _should_ have made us not allocate in 
that small region (the last usable page is 0x3fef0000, rounded up to the 
nearest megabyte is 0x3ff00000, which is marked as "reserved", so we 
_should_ have allocated above that quite nicely).

However, we are screwed by the fact that "max_low_pfn" is actually limited
by MAXMEM_PFN, which is the kernel _mappable_ memory, so MAXMEM is
actually much less than one megabyte (it's one megabyte minus
"VMALLOC_RESERVE", which defaults to 128MB).

But the PCI allocations are not at all limited by MAXMEM - they want to be 
in the low 4GB, but that's the only real limit. So using "max_low_pfn" to 
determine where to start PCI allocations is pretty bogus.

I'll try to write something that actually looks at the e820 memory map 
properly.

		Linus
