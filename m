Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTDPPcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTDPPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:32:42 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:190 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S264530AbTDPPcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:32:41 -0400
Date: Wed, 16 Apr 2003 10:44:33 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: size of CRCs in module versions
In-Reply-To: <16028.63307.771533.129067@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0304161038001.5477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, David Mosberger wrote:

> >>>>> On Wed, 16 Apr 2003 00:43:06 -0500 (CDT), Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> said:
> 
>   Kai> You're right that 32 bits would be enough to hold the
>   Kai> CRC. However, we do not yet know the checksum at compile time,
>   Kai> so the trick I came up with is to use the linker to fill in the
>   Kai> crcs afterwards, using assignment to absolute values. So while
>   Kai> the crcs appear to be numbers to the C code, they are handled
>   Kai> like addresses from the linker side, and things would most
>   Kai> likely go badly wrong if the sizes aren't equal, though I have
>   Kai> to admit I didn't try.
> 
> Yes, it's not easy (possible) to do it in C, but I suspect most 64-bit
> assemblers/linkers can do it.  For example, on ia64, you can do:
> 
> 	.global foo
> 
> 	data4 foo
> 
> Which will yield a DIR32LSB relocation (32-bit direct value), which is
> exactly what we'd need here.

I looked at ppc64, since I have a cross-compile tool chain for that, it 
seems to have an appropriate relocation type (R_PPC64_UADDR32), but the
obvious way of doing

static const u32 __kcrctab_##sym				\
	__attribute__((section("__kcrctab" sec), unused))	\
	= (u32) &__crc_##sym;

and hoping for the compiler to generate appropriate assembler code doesn't 
work ("initializer element is not computable at load time"), so we'd need
to code this in asm explicitly, which I'd rather avoid at this time.

--Kai


