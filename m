Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUEARqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUEARqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUEARqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 13:46:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:34220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261530AbUEARqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 13:46:05 -0400
Date: Sat, 1 May 2004 10:45:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Gerd Knorr <kraxel@bytesex.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: gcc 2.95: cx88 __ucmpdi2 error
In-Reply-To: <20040501112432.GE2541@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0405011025410.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501112432.GE2541@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 1 May 2004, Adrian Bunk wrote:
> >...
> > WARNING: /lib/modules/2.6.6-rc3/kernel/drivers/media/video/cx88/cx8800.ko 
> > needs unknown symbol __ucmpdi2
> 
> I'm also seeing this, but only with gcc 2.95, not with gcc 3.3.3 .
> 
> It comes from drivers/media/video/cx88/cx88-video.c, more exactly from 
> the switch in set_tvaudio.

I don't see that set_tvaudio() uses any 64-bit comparisons at all, so I 
have this suspicion that the linker reports the wrong function or 
something. 

It might help to use "objdump" to disassemble the object file and see 
where the call to __ucmpdi2 really is - or just build the file as an asm 
file in the first place ("make drivers/media/video/cx88/cx88-video.s") and 
see if you see anything interesting there.

> But I have to admit I don't understand why exactly it does happen.

I'm susprised too. gcc has historically done all the "simple" 64-bit ops
in-line, since they usually are just two instructions or so, and doing
them out-of-line tends to be _more_ work with argument setup etc.

Also, most of the time when this happens, we didn't really want 64-bit
arithmetic in the first place ("long long" arithmetic generates not only
slower and bigger code, it's historically been pretty buggy in gcc, so
most of the kernel is pretty careful about minimizing it). I suspect that
this will end up being the same thing (ie we wanted a 64-bit temporary
result to avoid overflows, but didn't actually need to propagate it all
the way).

			Linus
