Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUCXHCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUCXHCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:02:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263010AbUCXHCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:02:39 -0500
Date: Wed, 24 Mar 2004 02:00:20 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: davidm@hpl.hp.com
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040324070020.GI31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de> <20040323154937.1f0dc500.akpm@osdl.org> <20040324002149.GT4677@tpkurt.garloff.de> <16480.55450.730214.175997@napali.hpl.hp.com> <4060E24C.9000507@redhat.com> <16480.59229.808025.231875@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16480.59229.808025.231875@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 05:41:49PM -0800, David Mosberger wrote:
>   Uli> First, the ELF bits are limited and very crowded on some archs.  There
>   Uli> is no central assignment so conflicts will happen.
> 
> Fair enough, but I don't see why this should imply that platforms that
> already do have support for no-exec data/stack should be forced into
> using PT_GNU_STACK.  Just for uniformity's sake?  Or is there a real
> benefit?

Note that PT_GNU_STACK program header is not generated on EM_IA_64 and
EM_PPC64 ATM, because initially I thought it shouldn't be needed
(these 2 arches are the only ones which don't need executable stack
for GCC trampolines).
But I think we should change the toolchain and generate it on IA64 and PPC64
as well (only GCC would need changing, emitting
.section .note.GNU-stack,"",@progbits
at the end of every compile unit, ld takes care of the rest) exactly for
uniformity's sake and because you get ld.so handling free.
GLIBC dynamic linker will take care of making the stack executable if
say a binary which doesn't need executable stack depends on a shared library
which needs executable stack or even dlopens a library which needs
executable stack.

>   Uli> And one single bit does not cut it.  If you'd take a look, the
>   Uli> PT_GNU_STACK entry's permissions field specifies what permissions the
>   Uli> stack must have, not the presence of the field.  So at least two bits
>   Uli> are needed which only adds to the problems of finding appropriate bits.
> 
> What stack protections other than RW- and RWX are useful?

At least RW- (read-write but not executable stack), RWX (rw and executable
stack) and no PT_GNU_STACK segment (unknown, not marked binary), but it is
certainly extendable.

	Jakub
