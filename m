Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTJTU11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTJTU11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:27:27 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:24336 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262730AbTJTU1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:27:24 -0400
Message-ID: <3F9446D3.6060209@kolumbus.fi>
Date: Mon, 20 Oct 2003 23:34:27 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Strange cleanups in -test8 kernel/acpi/wakeup.S
References: <Pine.LNX.4.44.0310201115270.13116-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0310201115270.13116-100000@cherise>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 20.10.2003 23:29:09,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 20.10.2003 23:28:26,
	Serialize complete at 20.10.2003 23:28:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>>Some more changes landed in -test8. I have not seen them
>>before. Patrick, please, if you change something, can you post patch
>>somewhere for review before merging with Linus?
>>    
>>
>
>Pavel, I wrote the code in the first place, before you littered your
>'debug hacks' throughout it. I have merely been trying to simplify it for 
>debugging on other processors that are known not to work. While I 
>understand your generic plea for review, I fail to see how it would help 
>with this assembly.. 
>
>  
>
>>bkcvs info is:
>>BitKeeper to RCS/CVS export
>>----------------------------
>>revision 1.5
>>date: 2003/10/08 22:55:45;  author: mochel;  state: Exp;  lines: +37
>>-89
>>[power] Clean up ACPI STR assembly.
>>    
>>
>
>It might help if you read the full changeset comments. 
>
>  
>
>>diff -Nru a/arch/i386/kernel/acpi/wakeup.S
>>b/arch/i386/kernel/acpi/wakeup.S
>>--- a/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
>>+++ b/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
>>@@ -172,14 +172,13 @@
>> .org   0x1000
>>
>> wakeup_pmode_return:
>>-       movl    $__KERNEL_DS, %eax
>>-       movl    %eax, %ds
>>-       movw    $0x0e00 + 'u', %ds:(0xb8016)
>>-
>>-       # restore other segment registers
>>-       xorl    %eax, %eax
>>+       movw    $__KERNEL_DS, %ax
>>+       movw    %ax, %ss
>>+       movw    %ax, %ds
>>+       movw    %ax, %es
>>        movw    %ax, %fs
>>        movw    %ax, %gs
>>+       movw    $0x0e00 + 'u', 0xb8016
>>
>>        # reload the gdt, as we need the full 32 bit address
>>        lgdt    saved_gdt
>>	~~~~~~~~~~~~~~~~~
>>
>>Notice lgdt here. You have moved setup of segment registers before
>>loading gdt. This is actually okay, if you can be sure that all such
>>registers are in gdt (and not in ldt, for example).
>>    
>>
>
>All segments are in the GDT, as we use the same GDT in real mode as we do 
>in protected mode. However, you must reload the GDT in protected mode 
>because the GDTR is only 24 bits in real mode, but 32 in protected mode. 
>
>  
>
To be exact, GDTR is always 48 bits in x86. Reloading it twice seems 
pretty pointless.

--Mika




