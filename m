Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSCRSVb>; Mon, 18 Mar 2002 13:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291279AbSCRSVV>; Mon, 18 Mar 2002 13:21:21 -0500
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:11952 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S291272AbSCRSVN>; Mon, 18 Mar 2002 13:21:13 -0500
Date: Mon, 18 Mar 2002 19:23:45 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Problems with debugging I/O port access in kdb on i386
Message-ID: <Pine.LNX.4.33.0203181908070.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Keith, everybody,

I have encountered the following problems with kdb 2.1 (2.4.18)
when trying to catch I/O port accesses in kdb (both can probably be fixed
easily):

1. This code in kdb/kdb_bp.c:

	if (kdba_verify_rw(addr, sizeof(kdb_machinst_t))) {
		kdb_printf("Invalid address for breakpoint, ignoring bp command\n");
		return(0);
	}

   forbids to set I/O breakpoints on low ports (e.g. 0x20), because the
   address check done by kdba_verify_rw is valid for memory addresses
   only. AFAICS, no check whatsoever is necessary for I/O port addresses.

   I would submit a patch for this, but the address check must be
   postponed after the architecture-dependent parsing, and the information
   whether this is an I/O port breakpoint must be passed to the checking
   code. I don't know what implications that may have for the
   other architectures.

2. The DE flag in the CR4 register must be set (for CPUs that have it)
   in order to use I/O breakpoints at all. Otherwise they will be simply
   ignored by the CPU.

   Thus, a line like

   	if (cpu_has_de)
		set_in_cr4 (X86_CR4_DE);

   must be put in kdba_init().
   That may not suffice because cpu_init() (kernel/setup.c) clears the DE
   bit for each CPU, I don't know which one is called first.

   Again, I do not oversee all possible implications, so I do not submit a
   patch.

   As a hack, I inserted the above line in kdba_installdbreg() after the
   line

   dr7 |= DR7_GE;

   This works fine, I can now trap the I/O accesses I want.

Cheers,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





