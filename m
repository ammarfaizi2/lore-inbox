Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVCOWCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVCOWCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVCOWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:01:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18625 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261914AbVCOV7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:59:50 -0500
Date: Tue, 15 Mar 2005 15:51:35 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org,
       amodra@bigpond.net.au
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-Id: <20050315155135.11b942ef.moilanen@austin.ibm.com>
In-Reply-To: <16950.3484.416343.832453@cargo.ozlabs.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
	<20050314155125.68dcff70.moilanen@austin.ibm.com>
	<16950.3484.416343.832453@cargo.ozlabs.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 09:18:04 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Jake Moilanen writes:
> 
> > > I don't think I can push that upstream.  What happens if you leave
> > > that out?
> > 
> > The bss and the plt are in the same segment, and plt obviously needs to
> > be executable.
> 
> Yes... what I was asking was "do things actually break if you leave
> that out, or does the binfmt_elf loader honour the 'x' permission on
> the PT_LOAD entry for the data/bss region, meaning that it all just
> works anyway?"

It does not work w/o the sys_mprotect.  It will hang in one of the first
few binaries.

I believe the problem is that the last PT_LOAD entry does not have the
correct size, and we only mmap up to the sbss.  The .sbss, .plt, and
.bss do not get mmapped with the section.

Here is /bin/bash on SLES 9:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        10000174 000174 00000d 00   A  0   0  1
	...
	...
  [19] .data             PROGBITS        1008ca80 07ca80 001b34 00  WA  0   0  4
  [20] .eh_frame         PROGBITS        1008e5b4 07e5b4 0000b4 00   A  0   0  4
  [21] .got2             PROGBITS        1008e668 07e668 000010 00  WA  0   0  1
  [22] .dynamic          DYNAMIC         1008e678 07e678 0000e8 08  WA  6   0  4
  [23] .ctors            PROGBITS        1008e760 07e760 000008 00  WA  0   0  4
  [24] .dtors            PROGBITS        1008e768 07e768 000008 00  WA  0   0  4
  [25] .jcr              PROGBITS        1008e770 07e770 000004 00  WA  0   0  4
  [26] .got              PROGBITS        1008e774 07e774 000014 04 WAX  0   0  4
  [27] .sdata            PROGBITS        1008e788 07e788 0000d4 00  WA  0   0  4
  [28] .sbss             NOBITS          1008e860 07e860 000704 00  WA  0   0  8
  [29] .plt              NOBITS          1008ef64 07e860 000aa4 00 WAX  0   0  4
  [30] .bss              NOBITS          1008fa10 07e868 0062f0 00  WA  0   0 16


Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x10000034 0x10000034 0x00120 0x00120 R E 0x4
  INTERP         0x000174 0x10000174 0x10000174 0x0000d 0x0000d R   0x1
      [Requesting program interpreter: /lib/ld.so.1]
  LOAD           0x000000 0x10000000 0x10000000 0x7ca80 0x7ca80 R E 0x10000
  LOAD           0x07ca80 0x1008ca80 0x1008ca80 0x01ddc 0x09280 RWE 0x10000
  DYNAMIC        0x07e678 0x1008e678 0x1008e678 0x000e8 0x000e8 RW  0x4
  NOTE           0x000184 0x10000184 0x10000184 0x00020 0x00020 R   0x4
  NOTE           0x0001a4 0x100001a4 0x100001a4 0x00018 0x00018 R   0x4
  GNU_EH_FRAME   0x07ca54 0x1007ca54 0x1007ca54 0x0002c 0x0002c R   0x4
  STACK          0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4


 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .interp .note.ABI-tag .note.SuSE .hash .dynsym .dynstr .gnu.version .g
nu.version_r .rela.dyn .rela.plt .init .text text.unlikely text.hot .fini .rodat
a .eh_frame_hdr
   03     .data .eh_frame .got2 .dynamic .ctors .dtors .jcr .got .sdata .sbss .p
lt .bss
   04     .dynamic
   05     .note.ABI-tag
   06     .note.SuSE
   07     .eh_frame_hdr
   08

In the program headers section, the FileSiz for the last PT_LOAD is
0x1ddc.  If we go back to the Section Headers and look at .data it is at
0x1008ca80.  So the segment should end at 0x1008e85c.  We round up for
alignment and we get 0x1008e860 or .sbss.  The sbss, plt, and bss are
not mmapped.  So the sys_mprotect is used to pick it up.  

Did I miss something to explain this?  Can you think of another way to
fix it?

Jake


