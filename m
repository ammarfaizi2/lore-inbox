Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUDXCat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDXCat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 22:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUDXCat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 22:30:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:63430 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261867AbUDXCan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 22:30:43 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brenden Matthews <brenden@rty.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Si3112 S-ATA bug preventing use of udma5.
References: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca>
	<1082771045.10727.46.camel@gaston>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 23 Apr 2004 19:30:41 -0700
In-Reply-To: <1082771045.10727.46.camel@gaston>
Message-ID: <52ad12qf8u.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Apr 2004 02:30:42.0077 (UTC) FILETIME=[2388F4D0:01C429A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Brenden> Incase the link is down/broken, to fix the bug change line 269
    Brenden> of drivers/ide/pci/siimage.c from:

    Brenden> u32 speedt = 0;

    Brenden> to: u16 speedt = 0;

    Brenden> The crux of the problem is that the first arguent to OUTW
    Brenden> (out WORD) was a doubleword. The arguments were getting
    Brenden> all screwed up on the stack.  The lower order 16-bit were
    Brenden> being used in the second argument of OUTW, and the upper
    Brenden> order word was being used as the whole first argument,
    Brenden> which was always 0000.

    Ben> Hrm... that's strange. I'd tend to think it's a bogus
    Ben> definition of outw on this architecture (x86 ?) instead. an
    Ben> u32 should be casted down to u16 without problem.

Assuming I'm reading the siimage.c code correctly, it's calling
default_hwif_mmiops() to set up its OUTW pointer, which sets the
function pointer to call

static void ide_mm_outw (u16 value, unsigned long port)
{
        writew(value, port);
}

In asm-i386/io.h, we have

#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))

Finally, siimage.c does

                hwif->OUTW(speedt, addr);

and speedt is a u32 -- however, as you say, the compiler should just
cast speedt down to a u16.  What am I missing?

 - R.
