Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTFSNd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265571AbTFSNd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:33:27 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:22502 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S265566AbTFSNdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:33:23 -0400
Subject: Re: matroxfb console oops in 2.4.2x
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
In-Reply-To: <4DB6BC835A7@vcnet.vc.cvut.cz>
References: <4DB6BC835A7@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1056030426.27851.234.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Thu, 19 Jun 2003 14:47:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 13:21, Petr Vandrovec wrote:
> On 19 Jun 03 at 11:06, David Woodhouse wrote:
> 
> > Below is a workaround which lets the machine boot. It's obviously not a
> > fix.

> It looks like that someone tried to print something on the console
> during fbcon initialization.

take_over_console() attempts to redraw the screen.

>  It is not allowed to call fbdev's putc 
> before mode set was issued (at least I always believed to it; before
> first mode set hardware is in VGA state)

In this case, the hardware is uninitialised -- it's not in a PeeCee.
Is that relevant?

> Do not you see some error message in dmesg with these fixes?

If I omit the fixes, I just get...

matroxfb: Matrox Mystique (PCI) detected
matroxfb: 1280x1024x8bpp (virtual: 1280x1635)
matroxfb: framebuffer at 0x1000000, mapped to 0xc017d000, size 2097152
matroxfb: Pixel PLL not locked after 5 secs
+$S07#ba

Include the hack I showed you in matroxfb_cfb*_putcs, and I get what I
expect instead of the crash...

Console: switching to colour frame buffer device 160x64
fb0: MATROX VGA frame buffer device

If I call matrox_init_putc() earlier as you suggest, then it seems to
end up busy-waiting in mga_fifo()...

0x8c0dba18 <matrox_cfbX_putcs+184>:     mov.l   @(r0,r3),r1
0x8c0dba1a <matrox_cfbX_putcs+186>:     extu.b  r1,r1
0x8c0dba1c <matrox_cfbX_putcs+188>:     cmp/hi  r2,r1
0x8c0dba1e <matrox_cfbX_putcs+190>:     bf.s    0x8c0dba18 <matrox_cfbX_putcs+184>

(gdb) regs
PC=8c0dba1c SR=40000100 PR=8c0dbb72 MACH=00000003 MACHL=00000780
GBR=f89858fb VBR=8c006000 SSR=00000000 SPC=00000000
R0-R7  b3020000 00000005 00000005 00001e10 07070707 8c164d0c 00000000 01800010
R8-R15 b3020000 00000010 002f0028 00000010 00000025 8c1d6948 8c2a3b14 8c2a3b14
(gdb)  list *$pc
0x8c0dba1c is in matrox_cfbX_putcs (matroxfb_accel.c:610).
605             fxbndry = ((xx + fontwidth(p) - 1) << 16) | xx;
606             mmio = ACCESS_FBINFO(mmio.vbase);
607             while (count--) {
608                     u_int8_t* chardata = p->fontdata + (scr_readw(s++) & p->charmask)*charcell;
609
610                     mga_fifo(6);
611                     mga_writel(mmio, M_FXBNDRY, fxbndry);
612                     mga_writel(mmio, M_AR0, ar0);
613                     mga_writel(mmio, M_AR3, 0);
614                     if (easy) {



-- 
dwmw2

