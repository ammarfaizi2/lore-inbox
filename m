Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUDJTdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDJTdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:33:18 -0400
Received: from pxy3allmi.all.mi.charter.com ([24.247.15.42]:38031 "EHLO
	proxy3-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261296AbUDJTdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:33:16 -0400
Message-ID: <40784BF3.7080706@quark.didntduck.org>
Date: Sat, 10 Apr 2004 15:33:07 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
References: <20040410131028.A4221@flint.arm.linux.org.uk>
In-Reply-To: <20040410131028.A4221@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Hi,
> 
> I've checked the date, and it isn't April Fools day.  I wish it was
> though.
> 
> It appears that all binutils versions for ARM which are capable of
> building 2.6 kernels which have been tested so far contain a serious
> bug - it is possible to successfully link an object and still have
> various symbols undefined.  Currently, these binutils have been
> tested on ARM (as cross-compilers and/or native) and found wanting:
> 
> GNU assembler 2.13.90.0.18 20030206
> GNU assembler 2.14 20030612
> GNU assembler 2.14.90 20031229
> GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
> Assembleur GNU 2.15.90.0.1 20040303
> 
> So far, we have discovered two cases:
> 
> 1. When building a certain file, an undefined symbolic constant
>    (TI_USED_CP) ended up in the symbol table without a relocation,
>    and the value the assembler decided to use was '0'.  The effect
>    of this is that we ended up setting bits in thread_info->flags.
> 
>    This appears to be a binutils "as" error.
> 
> 2. When building the decompressor for ARM kernels, GCC appears to
>    inexplicably emit ".global" directives for symbols not defined
>    in the files being built, even though the symbols themselves are
>    not actually used.  I'm not sure whether this is a real bug;
>    binutils on x86 appears to accept and link such objects.
> 
> In both cases, the linker successfully created executable programs
> which ran.  In the first case, it is a silent error; the kernel had
> been linked, and able to run, but the program is not correct.
> 
> Obviously, the one true correct solution is to fix the toolchain and
> upgrade to the latest version.  However, since we have potentially
> multiple binutils versions spread across more than a year affected,
> I think we need to detect such errors as well.
> 
> Therefore, I propose the following patch to detect undefined symbols
> in the final image and force an error if this is the case.
> 
> Comments?

How about adding --no-undefined to LDFLAGS_vmlinux instead?

--
				Brian Gerst
