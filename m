Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTLPXxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLPXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:53:35 -0500
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:38355 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264394AbTLPXxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:53:33 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16351.39646.625093.191234@wombat.chubb.wattle.id.au>
Date: Wed, 17 Dec 2003 10:53:02 +1100
To: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI lib for 2.4 //kwds: pci, dma, mapping memory, kernel vs. user-space.
In-Reply-To: <93DFAFF4-2FEE-11D8-92AC-000393C76BFA@imag.fr>
References: <16350.12846.591123.874866@wombat.chubb.wattle.id.au>
	<93DFAFF4-2FEE-11D8-92AC-000393C76BFA@imag.fr>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Damien" == Damien Courouss <Damien> writes:

Damien> Hi Martin, Thanks for your answer.

Damien> I did not yet understand why I find two differents pci.h
Damien> files, and why I cannot use one of them (since my compiler
Damien> can't link with the lib)... Is there a specific way of using
Damien> the second one, which I did not understand?

/usr/include/pci/XXX.h are the header files to use with libpci.a
They are *all* you can use for a user-space driver.

/usr/include/linux and /usr/include/asm are copies from the kernel,
and should not be used directly in user code --- they document
internal kernel interfaces that are not accessible from user space.

You should be able to do high speed data streaming from user space --
we have a user-mode gigabit ethernet driver here that achieves
~700Mb/s for reasonable sized packets --- but latency may be a killer.
I'm measuring 10 microseconds from a PCI board asserting an interrupt
line until a driver can acknowledge it from user space; only a little lower
for a kernel driver.  (That seems about the same on P4 at 2.5GHz and
IA64 at 900MHz, BTW, so I suspect there are hardware-imposed delays
--- to acknowledge the interrupt, the driver has to do one inw and one
outw; these are slow).

You will however have to modify the kernel to allow mapping from your
address space into bus space, so that you can set up the devices's DMA
scatterlist; and to allow interrupts to be delivered to user space
(unless you plan to poll).  There are preliminary patches to do this at
http://www.gelato.unsw.edu.au/patches/usrdrivers for 2.6.0-testXXX
kernels; the work to support user drivers here is ongoing, and the
interfaces *will* change (currently they're what was easy to implement
fast (i.e., hack up) and do not correspond to production quality code)
We're not interested in 2.4 kernels for this; I'm hoping that when the
interfaces are cleaned up I can push it to 2.7.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

