Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317490AbSFIAwy>; Sat, 8 Jun 2002 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317492AbSFIAwx>; Sat, 8 Jun 2002 20:52:53 -0400
Received: from [209.237.59.50] ([209.237.59.50]:44214 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317490AbSFIAwx>; Sat, 8 Jun 2002 20:52:53 -0400
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52vg8ta4ki.fsf@topspin.com> <20020608135845.GC4671@krispykreme>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 17:52:49 -0700
Message-ID: <52hekd9sta.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Anton" == Anton Blanchard <anton@samba.org> writes:

    Anton> I just checked 2.5 and noticed the scsi code is _still_
    Anton> DMAing to the stack! Maybe it would be worth having a debug
    Anton> option for x86 where it uses vmalloc for kernel stack
    Anton> allocation :)

Good catches, just a few comments on the patch.

    Anton> Anyway attached is a patch from Todd Inglett that I updated
    Anton> for 2.5.

===== drivers/scsi/scsi_scan.c 1.13 vs edited =====
-		/* Make sure we have something that is valid for DMA purposes */
-		scsi_result = ((!shpnt->unchecked_isa_dma)
-			       ? &scsi_result0[0] : kmalloc(512, GFP_DMA));
+		scsi_result = kmalloc(512, GFP_DMA);

I don't think you should always use GFP_DMA here... probably better to
do:

		scsi_result = kmalloc(512,
                                      shpnt->unchecked_isa_dma ? GFP_DMA : GFP_ATOMIC);

And similarly this:

===== drivers/scsi/sr_ioctl.c 1.13 vs edited =====
+	unsigned char *buffer = kmalloc(512, GFP_DMA);

should probably use GFP_KERNEL (or possibly a check of
unchecked_isa_dma as above, though this doesn't seem to be needed
based on the existing code).

Best,
  Roland
