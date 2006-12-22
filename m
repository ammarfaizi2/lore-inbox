Return-Path: <linux-kernel-owner+w=401wt.eu-S1946032AbWLVKkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946032AbWLVKkF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946031AbWLVKkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:40:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36962 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946032AbWLVKkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:40:02 -0500
Date: Fri, 22 Dec 2006 16:10:56 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061222104056.GB7009@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222090806.3ae56579.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 09:08:06AM +0100, Jean Delvare wrote:
> Hi Vivek,
> 
> On Fri, 22 Dec 2006 02:14:08 +0530, Vivek Goyal wrote:
> > Jean, can you please upload some more files. Should give some more idea
> > about what happened in your environment.
> >
> > arch/i386/boot/vmlinux.bin
> > arch/i386/boot/compressed/piggy.o
> > arch/i386/boot/compressed/head.o
> 
> Sure, here they are:
> http://jdelvare.pck.nerim.net/linux/relocatable-bug/
> 

Thanks Jean. Your compressed/head.o looks fine.

Disassembly of section .text.head:

00000000 <startup_32>:
   0:   fc                      cld
   1:   fa                      cli
   2:   b8 18 00 00 00          mov    $0x18,%eax

compressed/piggy.o also looks fine. In this relocatable object,
compressed kernel size is present at office 0x34.

000000 464c457f 00010101 00000000 00000000
000010 00030001 00000001 00000000 00000000
000020 0013358c 00000000 00000034 00280000
000030 00020005 00133526 00088b1f 458a914d
                ^^^^^^^

But vmlinux.bin is not good. It should have contained startup_32() code
bytes from compressed/head.S but it seems to basically cotain piggy.o data
at the beginning. Instead it should have had .text.head section in the
beginning.

000000 00133526 00088b1f 458a914d fdb40302
       ^^^^^^^ (compressed kernel size. Same as piggy.o)

boot/vmlinux.bin is made after stripping boot/compressed/vmlinux. And 
boot/compressed/vmlinux is made with the linking of head.o, misc.o and
piggy.o. So either objcopy did something wrong or linker itself did not
generate a proper compressed/vmlinux. 

Can you please also upload boot/compressed/vmlinux.

Another odd thing is that "file vmlinux.bin" shows following.

vmlinux.bin: Sendmail frozen configuration  - version \015\024\322\216\356\222X\2306\032H\220\303\270\006\007\003

I am not sure what does it mean. I had expected it to be a data blob.

"vmlinux.bin: data"

Can you please also compile the kernel in verbose mode "make V=1" and
upload the output. just wanted to make sure Makefiles are being
interpreted properly.

Thanks
Vivek
