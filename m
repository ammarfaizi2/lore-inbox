Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbSJOPxx>; Tue, 15 Oct 2002 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJOPxw>; Tue, 15 Oct 2002 11:53:52 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:415 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262825AbSJOPxv>; Tue, 15 Oct 2002 11:53:51 -0400
Date: Tue, 15 Oct 2002 10:59:41 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: arnd@bergmann-dalldorf.de
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390x build warnings from <linux/module.h>
In-Reply-To: <200210151936.34119.arndb@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0210151043570.10165-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Arnd Bergmann wrote:

> during 'make modules' on s390x, I see lots of warnings about 'ignoring 
> changed section attributes for __ksymtab' that I have found to be the 
> result of changeset 1.373.196.1, where Kai changed the defaults for module 
> exports to 'no symbols exported'.
> 
> The problem is that there is a section '__ksymtab,"a"', while s390x 
> requires it to be '__ksymtab,"aw"' because modules must be compiled with
> '-fpic' here, unlike afaics all the other architectures.

Hmmh, there's a couple of things I don't understand, though they're most 
likely there for a reason. First of all, why do you need -fpic at all? 
kernel modules are not shared, they should get properly relocated when 
insmod'ing them, so I don't see why you're doing that.

The next thing I do not understand is why -fpic has the effect of marking
the section writeable, does it make .text writeable as well? And what for?

> The patch below is a workaround for the Problem and should be
> correct on all architectures, but I'd prefer if there was a nicer
> way to do that.
> 
> 	Arnd <><
> 
> --- broken/include/linux/module.h      15 Oct 2002 07:55:01 -0000      1.8
> +++ ugly/include/linux/module.h      15 Oct 2002 15:30:39 -0000
> @@ -498,5 +498,9 @@
>   * "export all symbols" to modutils)
>   */
> +#ifndef __PIC__
>  __asm__(".section __ksymtab,\"a\"\n.previous");
> +#else
> +__asm__(".section __ksymtab,\"aw\"\n.previous");
> +#endif
>  #endif

Well, it's not too bad, and it's hidden away in a header, so it's fine 
with me. Still, I don't understand yet why all this happens in the first 
place.

--Kai


