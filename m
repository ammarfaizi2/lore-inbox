Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310119AbSCKOWu>; Mon, 11 Mar 2002 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310123AbSCKOWk>; Mon, 11 Mar 2002 09:22:40 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3850 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S310119AbSCKOWZ>; Mon, 11 Mar 2002 09:22:25 -0500
Date: Mon, 11 Mar 2002 17:10:58 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Kurt Garloff <garloff@suse.de>, Jochen Friedrich <jochen@scram.de>,
        linux-kernel@vger.kernel.org, Jay Estabrook <Jay.Estabrook@compaq.com>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <20020311171058.A9038@jurassic.park.msu.ru>
In-Reply-To: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de> <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl>; from garloff@suse.de on Mon, Mar 11, 2002 at 12:45:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:45:11PM +0100, Kurt Garloff wrote:
> Unfortunately, your ISA card does not seem to be able to address 32 bits.
> (I guess no non-on-chip ISA adapter will.)

No, the ability to address 32 bits is property of an ISA bridge, not
of any particular ISA card or device. Most alphas do have 32-bit ISA DMA.

For that particular driver the following hack should work.
However, ideally we should have ISA_DMA_MASK in asm/dma.h defined
for all architectures...

Ivan.

--- linux/drivers/net/tokenring/tms380tr.h.orig	Fri May 25 20:58:07 2001
+++ linux/drivers/net/tokenring/tms380tr.h	Mon Mar 11 15:52:06 2002
@@ -462,7 +462,12 @@ typedef struct {
 				  */
 
 /* XXX is there some better way to do this? */
+#if defined(__alpha__)
+#define ISA_MAX_ADDRESS	(MAX_DMA_ADDRESS - IDENT_ADDR - 1 < 0xffffffff ? \
+			 MAX_DMA_ADDRESS - IDENT_ADDR - 1 : 0xffffffff)
+#else
 #define ISA_MAX_ADDRESS 	0x00ffffff
+#endif
 #define PCI_MAX_ADDRESS		0xffffffff
 
 #pragma pack(1)
