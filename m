Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUHQOkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUHQOkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQOkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:40:49 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:48059 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268257AbUHQOkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:40:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 17 Aug 2004 16:22:55 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Duncan Sands <baldrick@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Oops at bttv_risc_packed (2.6.8-rc1)
Message-ID: <20040817142255.GA18704@bytesex>
References: <20040804212106.04f19bad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804212106.04f19bad.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> DEBUG_PAGEALLOC

Hmm, amd64 hasn't this one?

>  [pg0+543078197/1069322240] bttv_buffer_risc+0x4b5/0x5b0 [bttv]

Looks like the buffer for the risc instructions overflows.  No idea why
through, the size calculation looks ok.  Can you please apply the debug
patch below, load bttv with "bttv_debug=1" insmod option and try again?

What app triggers this btw, and which capture parameters (size, format)?

  Gerd

Index: bttv-risc.c
===================================================================
RCS file: /home/cvsroot/video4linux/bttv-risc.c,v
retrieving revision 1.3
diff -u -p -r1.3 bttv-risc.c
--- bttv-risc.c	6 Jul 2004 07:52:17 -0000	1.3
+++ bttv-risc.c	17 Aug 2004 14:17:14 -0000
@@ -55,6 +55,8 @@ bttv_risc_packed(struct bttv *btv, struc
 	instructions += 2;
 	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
 		return rc;
+	dprintk("bttv%d: risc packed: bpl %d lines %d instr %d size %d ptr %p\n",
+		btv->c.nr, bpl, lines, instructions, risc->size, risc->cpu);
 
 	/* sync instruction */
 	rp = risc->cpu;
@@ -99,8 +101,10 @@ bttv_risc_packed(struct bttv *btv, struc
 			offset += todo;
 		}
 		offset += padding;
+		dprintk("bttv%d: risc packed:   line %d ptr %p\n",
+			btv->c.nr, line, rp);
 	}
-	dprintk("bttv%d: risc planar: %d sglist elems\n", btv->c.nr, (int)(sg-sglist));
+	dprintk("bttv%d: risc packed: %d sglist elems\n", btv->c.nr, (int)(sg-sglist));
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
