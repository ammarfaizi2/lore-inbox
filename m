Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVKCRUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVKCRUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVKCRUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:20:18 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10001 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1751391AbVKCRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:20:17 -0500
Date: Thu, 3 Nov 2005 17:20:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
In-Reply-To: <436A3C10.9050302@vmware.com>
Message-ID: <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
 <436A3C10.9050302@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Zachary Amsden wrote:

> >disables code to retrieve the actual value of CR4 on 486-class systems
> >(which may or may not implement the register, depending on the exact CPU
> >type and stepping).  This seems suspicious to me, but I have to admit I
> >haven't followed the discussion on the issue if there was any.
> >  
> >
> 
> This was deliberate.  CR4 doesn't exist on standard 486 class systems, 
> and I'm not sure how you could make use of it anyway, since the features 
> used by Linux - machine check, page size extensions, time stamp counter, 
> global pages, are only available in Pentium and later class systems, and 
> identified by CPUID, which also doesn't exist on 486.

 Later Intel i486DX2 and i486DX4 processors (the so called "write-back
enhanced" ones) did support page size extensions (4MB pages) and as far as
I know we do use them on such chips.  They did implement the CPUID
instruction, too (as well as late i486SX and i486SX2 chips that did not
support PSE).  That's a counter-example that proves the actual value of
CR4 is going to be useful on these systems.  These chips also implemented
the VME feature (the PVI and VME bits of CR4), but they may not be
terribly useful for us.

 I used quite a few of such chips myself in mid 90s -- you may search
archives of various mailing lists for examples of "cpuinfo" dumps for such
processors.

> There may be some funky Cyrix or even Intel CPUs that have CR4 
> registers, but showing the output in a register dump seems very 
> useless.  I would also not recommend using undocumented features in CR4 
> even if you have such a freaky processor - there were bugs and/or 
> missing functionality with the early large page and global page 
> extensions that were not ironed out until the features became 
> documented, IIRC.  YMMV - please let me know if anyone has found ways to 
> make this useful.

 Please do always check the relevant datasheets before making such
assumptions -- these features of late Intel i486 processors were
documented to the expected extent, i.e. at least mentioned; though
depending on the exact document referred to, the exact details may have
been hidden behind these dreadful NDA-covered appendices.

 The implementation you have removed (using a fault trapper) has been
originally written using the KISS approach -- instead of trying to
determine which bits of the CPUID status imply presence of CR4, the
register is accessed unconditionally as the opcode of the instruction used
is guarateed not to clash with any post-286 vendor-specific proprietary
CPU extension.  As a result it may not be immediately obvious 486-class
chips are involved too.  Search LKML archives for the original discussion
several years ago.

> If I am wrong, I am happy to correct this, but I would like to do so 
> properly by adding safe_read_cr4() or equivalent rather than using raw 
> inlines assembler to catch the fault.

 Obviously -- I am not questioning the syntax, only the semantics.

  Maciej
