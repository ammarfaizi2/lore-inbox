Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWCWDsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWCWDsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWCWDsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:48:05 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:8406
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP id S965154AbWCWDsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:48:03 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Re: BIOS causes (exposes?) modprobe (load_module) kernel oops
Date: Wed, 22 Mar 2006 19:48:00 -0800
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <1143018365.2955.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1143018365.2955.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221948.00568.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:06, Arjan van de Ven wrote:
> On Tue, 2006-03-21 at 20:05 -0800, John Z. Bohach wrote:
> > Linux 2.6.14.2, yeah, I know, and sorry if this has been fixed...but read
> > on, please, this is a new take...
>
> at least enable CONFIG_KALLSYMS to get us a readable backtrace
>

I'll do you one better:  here's the failing line from module.c:

	/* Determine total sizes, and put offsets in sh_entsize.  For now
	   this is done generically; there doesn't appear to be any
	   special cases for the architectures. */
	layout_sections(mod, hdr, sechdrs, secstrings);

	/* Do the allocs. */
	ptr = module_alloc(mod->core_size);
	if (!ptr) {
		err = -ENOMEM;
		goto free_percpu;
	}
!!! --->	memset(ptr, 0, mod->core_size);
	mod->module_core = ptr;

The !!!---> memset() line is the one that fails.  In assembly, its:

c0127ae5:       f3 ab                   repz stos %eax,%es:(%edi)

eax is 0, and es is 0x7b with edi at 0xe0806000.  Everything looks fine.

Interestingly, and expectedly, I might add, these values are identical in both the
failing case and the succeeding case.  Here's the rest of the story:

I'm testing a different boot loader in the failing case.  The failing case loads

arch/i386/boot/compressed/vmlinux

 while the successful case loads

arch/i386/boot/bzImage.

Sorry I wasn't complete before, I was hoping not to
have to get this deep.  As far as I can tell, the bootloader (a very minimal one,
that uses no BIOS calls, sets up the linux params. area, as well as the MP table
and E820 table (in the cmdline area...).  Linux is happy with both, without
displaying any visible differences with either bootloader on either BIOS.

/proc/meminfo looks identical in both failing/succeeding cases...

However, in the failing case, the 16-bit setup.o stuff of the kernel never got run.
My bootloader takes care of the the useful work, and sets things up appropriately
without needing any BIOS calls (32-bit protected mode, initial GDT, etc.).
I've looked through setup.S, and can't see any major
differences between 2.4 and 2.6, but I'm starting to wonder....  I'm thinking that by
skipping the setup.S stuff,  some initialization related to paging and/or virtual
memory gets skipped?  Does anyone know if this is true?

I have a feeling that its some pre-kernel initialization (or lack thereof) that has some subtle
side-effect regarding paging and is triggered by the first modload.  Does the fact the the virtual
address is at 0xe0806000 have any significance?  Does the 0xexxxxxxx range only
get used for modules?  I'm trying to figure out what triggers this failed paging request...

