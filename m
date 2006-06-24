Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWFXBuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWFXBuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFXBun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:50:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51177 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750763AbWFXBun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:50:43 -0400
Message-ID: <449C9A53.7040204@zytor.com>
Date: Fri, 23 Jun 2006 18:50:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
Subject: Re: i386 ABI and the stack
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
In-Reply-To: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> I just saw git commit 21528454f6dd18231ae20102f98aa8f51b6ec1b9
> go in with this:
> 
> + * Accessing the stack below %esp is always a bug.
> + * The large cushion allows instructions like enter
> + * and pusha to work. ("enter $65535,$31" pushes
> + * 32 pointers and then decrements %esp by 65535.)
> 
> Exactly how is an access below %esp a bug if we just added support?
> It looks like we now have a 65664-byte red zone on i386, and probably
> on x86-64 once the matching patch goes in. (the space reserved by
> signal handlers may differ, though perhaps it should not)

No, we don't.  The enter instruction is special because it *atomically* 
drops the stack and probes the stack pointer; if the instruction fails, 
then the stack pointer is rolled back, which is why the kernel needs to 
be aware of it.

We could add a redzone to i386 (and then get compilers to know about 
it), but we haven't already done so.  The difference is that we'd have 
to adjust the stack pointer before writing a signal stack frame. 
However, libc probably needs to be aware of this, because this zone 
needs to also be reserved for every stack in a threaded program.

> This is water under the bridge anyway, because of gcc 2.xx.x bugs.
> 
> It seems that we're throwing away performance if we discourage
> the compiler from taking advantage of this area to optimize
> leaf functions and perhaps improve instruction scheduling.

Probably, although likely not much; x86 processors tend to need to 
optimize push/pop anyway.  However, as x86-64 shows, having a small 
redzone might be worth it.

	-hpa

