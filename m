Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130412AbRCBLVp>; Fri, 2 Mar 2001 06:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130413AbRCBLVg>; Fri, 2 Mar 2001 06:21:36 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:21200 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S130412AbRCBLVZ>; Fri, 2 Mar 2001 06:21:25 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <linuxppc-dev@lists.linuxppc.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Fri, 2 Mar 2001 12:20:28 +0100
Message-Id: <19350125045212.2780@mailhost.mipsys.com>
In-Reply-To: <15006.44863.375642.847562@pizda.ninka.net>
In-Reply-To: <15006.44863.375642.847562@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Many platforms, sparc64 included, do not have an ISA IO space nor do
>they provide VGA accesses at all.
>
>If things such as XFree86 are coded for such platforms to not require
>VGA accesses (the 'ati' driver is already like this when certain
>build time defines are set), this could become a non-issue in this
>case.

What I call ISA IOs here doesn't necessarily mean there's an ISA bridge
on the PCI. In fact, VGA cards usually don't live behind such a bridge
while still requiring occasionally access to the "legacy" ISA IO addresses. 

On PPC, we don't have an "IO" space neither, all we have is a range of
memory addresses that will cause IO cycles to happen on the PCI bus. But
we can have one per bus, thus causing this need for several "legacy" IO
spaces (each bus can have IO addresses in the range 0-64k).

The typical problem that happens right now is a VGA card in the AGP slot
and a VGA card in a PCI slot. Both may (depending on the card) need
access to the legacy VGA IO addresses on the PCI bus on which they are
located. So in this case, we clearly have 2 legacy busses, av ailable at
2 different physical memory addresses in the CPU space. What we can do is
use mapping tricks to map the contiguously in kernel virtual space so
that only an "offset" allows to go from tone to the other with inb/outb.
Without that, we need to create new versions of inb/outb that take a bus
number.


Ben.

