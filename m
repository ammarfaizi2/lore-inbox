Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVCNWE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVCNWE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVCNWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:03:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14038 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261964AbVCNV7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:59:44 -0500
Date: Mon, 14 Mar 2005 15:51:25 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org,
       amodra@bigpond.net.au
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-Id: <20050314155125.68dcff70.moilanen@austin.ibm.com>
In-Reply-To: <16949.25552.640180.677985@cargo.ozlabs.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 21:13:36 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Jake Moilanen writes:
> 
> > diff -puN fs/binfmt_elf.c~nx-user-ppc64 fs/binfmt_elf.c
> > --- linux-2.6-bk/fs/binfmt_elf.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
> > +++ linux-2.6-bk-moilanen/fs/binfmt_elf.c	2005-03-08 16:08:54 -06:00
> > @@ -99,6 +99,8 @@ static int set_brk(unsigned long start, 
> >  		up_write(&current->mm->mmap_sem);
> >  		if (BAD_ADDR(addr))
> >  			return addr;
> > +
> > +  		sys_mprotect(start, end-start, PROT_READ|PROT_WRITE|PROT_EXEC);
> 
> I don't think I can push that upstream.  What happens if you leave
> that out?

The bss and the plt are in the same segment, and plt obviously needs to
be executable.

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        10000154 000154 00000d 00   A  0   0  1
	...
	...
  [26] .plt              NOBITS          10013c5c 003c34 000210 00 WAX  0   0  4
  [27] .bss              NOBITS          10013e6c 003c34 000128 00  WA  0   0  4


 Segment Sections...
   00
   01     .interp
   02     .interp .note.ABI-tag .note.SuSE .hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .text .fini .rodata
   03     .data .eh_frame .got2 .dynamic .ctors .dtors .jcr .got .sdata .sbss .plt .bss
   04     .dynamic
   05     .note.ABI-tag
   06     .note.SuSE
   07

Anton mentioned that Alan was considering putting plt into a new segment. 
 
> More generally, we are making a user-visible change, even for programs
> that aren't marked as having non-executable stack or heap, because we
> are now enforcing that the program can't execute from mappings that
> don't have PROT_EXEC.  Perhaps we should enforce the requirement for
> execute permission only on those programs that indicate somehow that
> they can handle it?

Unless a program is compiled w/ pt_gnu_stacks we will set the
READ_IMPLIES_EXEC personality and those applications should still
work as normal.

Jake
