Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271758AbTHMLGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTHMLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:06:34 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:9720 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271758AbTHMLGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:06:33 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: thunder7@xs4all.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813025542.32429718.akpm@osdl.org>
References: <20030813045638.GA9713@middle.of.nowhere>
	 <20030813014746.412660ae.akpm@osdl.org>
	 <20030813091958.GA30746@gates.of.nowhere>
	 <20030813025542.32429718.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060772769.8009.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 12:06:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 10:55, Andrew Morton wrote:
> Jurriaan on adsl-gate <thunder7@xs4all.nl> wrote:
> >
> > > Exactly what sort of CPU are you using?
> >  > -
> >  AMD Athlon XP2400+ on a VIA KT400 chipset, single CPU-system.
> 
> OK, thanks.  The word is that Athlons will, very occasionally,
> take a fault when prefetching from an unmapped address.

Page zero in the kernel is mapped in 4Mb paging mode (which is what the
Athlon uses). Also your likely(pos) pretty much wiped out the point of
prefetching and punishes other processors because it is in the wrong
place. For that matter we could add a LIST_NULL that pointed somewhere
safe and wasn't NULL per se in 2.7.

Put the likely(pos) in the asm/prefetch for Athlon until someone can
figure out what is going on with some specific Athlons, 2.6 and certain
kernels (notably 4G/4G).

Long term we really do need to start supporting a zero page mapped at
0->64K when not debugging the kernel, then you can let the compiler do
NULL dereferences which is a _huge_ win because you can move stuff
around a lot of natural C conditionals to get better unrolling and
instruction scheduling.

The alternative is to start doing multipointer lists which is messier
and uses more memory (ie each node has next, prev, "several nodes on")

Alan

