Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSAIXgF>; Wed, 9 Jan 2002 18:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289083AbSAIXfv>; Wed, 9 Jan 2002 18:35:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44298 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289082AbSAIXfN>; Wed, 9 Jan 2002 18:35:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: system time issue
Date: 9 Jan 2002 15:35:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ik39$heg$1@cesium.transmeta.com>
In-Reply-To: <3C3CA078.52242C57@didntduck.org> <Pine.LNX.3.95.1020109145747.144A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020109145747.144A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> Kernel version 2.4.1 through 17 (last I checked 17) used a bunch of
> ways including the keyboard controller, the aux control port, then
> finaly a transition to 16-bit address space with direct execution
> of the reset vector. I found that the only reason the transition
> to 16-bits "worked" was because of coding errors which caused the
> processor reset.
> 

That is only invoked *IF REQUESTED BY USERSPACE*.

This is the real termination:

        if(!reboot_thru_bios) {
                /* rebooting needs to touch the page at absolute addr
                0 */
                *((unsigned short *)__va(0x472)) = reboot_mode;
                for (;;) {
                        int i;
                        for (i=0; i<100; i++) {
                                kb_wait();
                                udelay(50);
                                outb(0xfe,0x64);         /* pulse reset low */
                                udelay(50);
                        }
                        /* That didn't work - force a triple fault.. */
                        __asm__ __volatile__("lidt %0": :"m" (no_idt));
                        __asm__ __volatile__("int3");
                }
        }

Zero the IDT and force an interrupt -> triple fault.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
