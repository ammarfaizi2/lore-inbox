Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRAPSdT>; Tue, 16 Jan 2001 13:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRAPSdC>; Tue, 16 Jan 2001 13:33:02 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:54790 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130855AbRAPScn>;
	Tue, 16 Jan 2001 13:32:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chad Miller <cmiller@surfsouth.com>
Date: Tue, 16 Jan 2001 19:31:33 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb on 2.4.0 / PCI: Failed to allocate...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <12C27D8E5537@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 01 at 13:22, Chad Miller wrote:
> On Tue, Jan 16, 2001 at 05:56:34PM +0000, Petr Vandrovec wrote:
> > What does 'lspci -v' say?
> 
> #00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if 00 \
> #[Normal decode])
> #        Flags: bus master, 66Mhz, medium devsel, latency 0
> #        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> #        Memory behind bridge: d4000000-d6ffffff
> #        Prefetchable memory behind bridge: d7000000-d8ffffff
                                                       ^^^^^^^^
> #        Capabilities: <available only to root>
> #
> #01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP \
> #(rev 05) (prog-if 00 [VGA])
> #        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
> #        Flags: bus master, VGA palette snoop, medium devsel, latency 64, IRQ 10
> #        Memory at d8000000 (32-bit, prefetchable) [size=16M]
> #        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
> #        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
> #        Expansion ROM at <unassigned> [disabled] [size=64K]
> #        Capabilities: <available only to root>

There is something wrong with your hardware. First region for G400 should
be 32MB, not 16MB (even if you have 16MB G400, which I doubt).

Prefetchable memory behind bridge on 0:01.0 should end at 0xd9ffffff.
This is probably what kernel wants to say - memory region is 32MB, but
there is only 16MB behind bridge, so region does not fit...

> > in such case, as matroxfb assumes that if request_mem_region failed,
> > it was because of some other driver already controls this hardware.
> 
> Is there a patch available, or should I go looking for it?

Search function initMatrox2() in drivers/video/matrox/matroxfb_base.c.
In this function, you'll find two calls to request_mem_region followed
by 'goto fail' (or 'goto failCtrlMR) without printk. You can try to add
printk() here. Second request_mem_region fails, because of PCI subsystem
reports only 16MB window, while matroxfb requests 32MB one.
You can workaround by changing first value in
'static struct video_board vbG400' from 0x2000000 to 0x1000000. But only
16MB are available then. I'd like to see what XFree does on your hardware...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
