Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWCLLVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWCLLVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCLLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:21:17 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:18422 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750748AbWCLLVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:21:16 -0500
Date: Sun, 12 Mar 2006 13:21:14 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
Message-ID: <20060312112114.GA20607@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <5NpZk-7wW-13@gated-at.bofh.it> <5NJ1x-1OE-15@gated-at.bofh.it> <5NPJk-3GD-3@gated-at.bofh.it> <5NRBv-6ze-9@gated-at.bofh.it> <E1FI11O-0000bK-8u@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FI11O-0000bK-8u@be1.lrz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 11:08:25AM +0100, Bodo Eggert wrote:
> Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> 
> >> The bttv driver/chip seems to cause random memory corruption sometimes,
> >> processes will just start dying...
> > 
> > There is a known buffer overflow in the bttv driver (when using
> > grabdisplay).  The fix is waiting on an audit of the rest of the
> > bttv (and similar) code, since it looks like the same mistake
> > occurs in several places.
> 
> Can you give me a hint on where exactly to shoot at? I'n still hoping it's
> not my VIA board giving me trouble (corrupting the first four bytes of a
> semi-random page).

check out this email to LKML

it might not be the Final Fix, but xawtv hasn't crashed on me yet

From:	Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: [PATCH] bttv: correct bttv_risc_packed buffer size
Date:	Wed, 25 Jan 2006 11:24:27 +0100
Cc:	Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cH11D22lqYSaiQl"
Message-Id: <200601251124.28392.duncan.sands@math.u-psud.fr>

--Boundary-00=_cH11D22lqYSaiQl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes the strange crashes I was seeing after using
my bttv card to watch television.  They were caused by a
buffer overflow in bttv_risc_packed.

The instruction buffer size calculation contains two errors:
(a) a non-zero padding value can push the start of the next bpl
section to just before a page border, leading to more scanline
splits and thus additional instructions.
(b) the first DMA region can be smaller than one page, so there can
be a scanline split even if bpl*lines is smaller than PAGE_SIZE.

For example, consider the case where offset is 0, bpl is 2, padding
is 4094, lines is smaller than 2048, the first DMA region has size 1
and all others have size PAGE_SIZE, assumed to equal 4096.  Then
all bpl regions cross page borders and the number of instructions
written is 2*lines+2, rather than lines+2 (the current estimate).
With this patch the number of instructions for this example is
estimated to be 2*lines+3.

Also, the BUG_ON that was supposed to catch buffer overflows contained
a thinko causing it fire only if the buffer was overrun by a factor of
16 or more.

I didn't check whether similar mistakes exist elsewhere in the bttv
code.

Signed-off-by: Duncan Sands <baldrick@free.fr>

PS: I'm sending the patch as an attachment because for some reason my
mailer crashes if I try to insert it into the email.

--Boundary-00=_cH11D22lqYSaiQl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bttv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bttv"

Index: Linux/drivers/media/video/bttv-risc.c
===================================================================
--- Linux.orig/drivers/media/video/bttv-risc.c	2006-01-24 10:09:21.000000000 +0100
+++ Linux/drivers/media/video/bttv-risc.c	2006-01-24 10:16:06.000000000 +0100
@@ -51,8 +51,10 @@
 	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
-	   one write per scan line + sync + jump (all 2 dwords) */
-	instructions  = (bpl * lines) / PAGE_SIZE + lines;
+	   one write per scan line + sync + jump (all 2 dwords).  padding
+	   can cause next bpl to start close to a page border.  First DMA
+	   region may be smaller than PAGE_SIZE */
+	instructions  = 1 + ((bpl + padding) * lines) / PAGE_SIZE + lines;
 	instructions += 2;
 	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
 		return rc;
@@ -104,7 +106,7 @@
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON(4 * (risc->jmp - risc->cpu + 2) > risc->size);
 	return 0;
 }
 

--Boundary-00=_cH11D22lqYSaiQl--

-- 
