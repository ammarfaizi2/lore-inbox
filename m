Return-Path: <linux-kernel-owner+w=401wt.eu-S1423192AbWLVHOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423192AbWLVHOa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423196AbWLVHOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:14:30 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50434 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423192AbWLVHO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:14:29 -0500
Date: Fri, 22 Dec 2006 02:14:08 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alexander van Heukelum <heukelum@fastmail.fm>,
       Jean Delvare <khali@linux-fr.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221204408.GA7009@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166723157.29546.281560884@webmail.messagingengine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 06:45:57PM +0100, Alexander van Heukelum wrote:
> Hi,
> 
> Hmm. taking a peek at the bzImage there...
> 
> 00001d80  41 00 56 45 53 41 00 56  69 64 65 6f 20 61 64 61
> |A.VESA.Video ada|
> 00001d90  70 74 65 72 3a 20 00 00  00 b8 00 00 55 aa 5a 5a  |pter:
> ......U.ZZ|
> 00001da0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> |................|
> *
> 00001e00  4e 35 13 00 1f 8b 08 00  23 a4 89 45 02 03 b4 fd
> |N5......#..E....|
>           -- -- -- -- ^^ ^^ ^^
> 
> This is the end of the realmode kernel, and it should be followed by the
> 32-bit code that is to be executed at (normally) 0x100000, right? This
> is however not the case here. Where did arch/i386/boot/compressed/head.S
> go then? What is the significance of this value 0x0013354e? It is in
> fact
> exactly the size of the compressed kernel image.
> 
> I have no idea what went wrong, but it went wrong in the build process
> of the bzImage.
> 

Hi Alexander,

Excellent observation. I did an "od -Ax -tx1" on bzImage built by me and
I can see the right startup_32() code bytes at the end of real mode code.

001d20 74 65 72 3a 20 00 00 00 b8 00 00 55 aa 5a 5a 00
001d30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
001e00 fc fa b8 18 00 00 00 8e d8 8e c0 8e e0 8e e8 8e
       ^^^^^^^^^^^
Following is the disassembly of startup_32() in
arch/386/boot/compressed/head.S

00000000 <startup_32>:
   0:   fc                      cld
   1:   fa                      cli
   2:   b8 18 00 00 00          mov    $0x18,%eax

So I can see 0x18b8fafc being rightly placed immediately after real
mode code (setup.S). But that does not seem to be the case with Jean's
bzImage.

The only place where size of compressed kernel (vmlinux.bin.gz) is placed
is piggy.o. Look at arch/i386/boot/compressed/vmlinux.scr. Here we put
the size of vmlinux.bin.gz in .data.compressed section before we put
actual vmlinux.bin.gz in this section.

Does that mean that somehow .data.compressed section was placed before
.text.head section? But that would be contarary to what
arch/i386/boot/compressed/vmlinux.lds instructs to linker.

At the same time I tried to find the pattern 0x18b8fafc in Jean's bzImage
but I can't find that. Does that mean that arch/i386/boot/compressed/head.S
was never compiled  and linked? 

Jean, can you please upload some more files. Should give some more idea
about what happened in your environment.

arch/i386/boot/vmlinux.bin
arch/i386/boot/compressed/piggy.o
arch/i386/boot/compressed/head.o

Thanks
Vivek
