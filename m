Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDUSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDUSuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDUSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:50:20 -0400
Received: from mail.parknet.jp ([210.171.160.80]:13320 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750716AbWDUSuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:50:19 -0400
X-AuthUser: hirofumi@parknet.jp
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] X86_NUMAQ build fix
References: <87irp2x69s.fsf@duaron.myhome.or.jp>
	<1145643558.3373.34.camel@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Apr 2006 03:50:12 +0900
In-Reply-To: <1145643558.3373.34.camel@localhost.localdomain> (Dave Hansen's message of "Fri, 21 Apr 2006 11:19:18 -0700")
Message-ID: <874q0mwyor.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Sat, 2006-04-22 at 01:06 +0900, OGAWA Hirofumi wrote:
>> This patch fixes the build breakage of X86_NUMAQ. And this declares
>> xquad_portio on only X86_NUMAQ.
>
> What bug does this patch fix?  What is your .config?  I'm not having any
> compile problems on my NUMAQ lately.

Ah, sorry for stuipd description...

>>  obj-$(CONFIG_PCI_DIRECT)       += direct.o
>>  
>>  pci-y                          := fixup.o
>> -pci-$(CONFIG_ACPI)             += acpi.o
>>  pci-y                          += legacy.o irq.o
>>  
>>  pci-$(CONFIG_X86_VISWS)                := visws.o fixup.o
>>  pci-$(CONFIG_X86_NUMAQ)                := numa.o irq.o
>>  
>> +pci-$(CONFIG_ACPI)             += acpi.o
>
> Am I reading this wrong, or does this just move the option down a bit?
> Did you need to change the link order?  Why?

No, this is not link order. Note that CONFIG_X86_VISWS/CONFIG_X86_NUMAQ
uses ":=", not "+=".  In case of ACPI=y", it breaks build.

Maybe NUMAQ shouldn't allow ACPI=y in Kconfig (very old Makefile
doesn't allow to build acpi.o), but I think Makefile is ok with this,
and it also fixes CONFIG_X86_VISWS case (very old Makefile also allow to
build acpi.o).

>> +++ linux-2.6-hirofumi/arch/i386/boot/compressed/misc.c 2006-04-22 00:54:29.000000000 +0900
>> @@ -122,7 +122,9 @@ static int vidport;
>>  static int lines, cols;
>>  
>>  #ifdef CONFIG_X86_NUMAQ
>> -static void * xquad_portio = NULL;
>> +/* hack to avoid using xquad_portio=NULL */
>> +#undef outb_p
>> +#define outb_p         outb_local_p
>>  #endif
>
> It's really weird, but I'd hope that there was a reason for having two
> xquad_portio.  Are you sure that this has no other consequences?

Note that this is boot/compressed/misc.c. We can't share vmlinux's
data in here. However we can share macros, so probably, it's using
"static void * xquad_portio = NULL" hack.

But, in include/asm-i386/io.h, it is declared as "extern". At least,
gcc-4.0 doesn't allow "static" and "extern" mismatch.

> That said, it does boot on my 16-way NUMAQ, but I still have no real
> idea what problem this is solving or what it is actually doing ;)

Oh, good. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
