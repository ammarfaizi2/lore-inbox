Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTD2Fvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 01:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTD2Fvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 01:51:49 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22685 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261801AbTD2Fvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 01:51:48 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Kendall Bennett" <KendallB@scitechsoft.com>
Date: Tue, 29 Apr 2003 08:03:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Crash in vm86() on SMP boxes with vesa driver?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CF69933E9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Apr 03 at 16:12, Kendall Bennett wrote:

> 8.0 box with the latest 2.4.20 kernel on it (but the problem happened 
> with the stock kernel and kernels lower then .20 as well). Unfortunately 
> I don't have access to the box (it is in Australia), but I have access to 
> the bug report information (and will try to configure a box soon to 
> reproduce it here). Anyway the folowing is the error log produced by 
> XFree86 when the crash occurs:

We told you before that you cannot trust VESA BIOS.
 
> (II) VESA(0): initializing int10
> (WW) VESA(0): Bad V_BIOS checksum
> (II) VESA(0): Primary V_BIOS segment is: 0xc000

Bad checksum? Sorry, your BIOS is not usable. Either XFree gets checksum
wrong, or there is something I would not want in my computer there...

> (II) VESA(0): virtual address = 0x402d7000,
>         physical address = 0xf0000000, size = 33554432
> (II) VESA(0): VBESetVBEMode failed(EE) VESA(0): vm86() syscall generated
> signal 11. 
> (II) VESA(0): EAX=0x00000150, EBX=0x00000ba0, ECX=0x00000000, 
> EDX=0x00000000
> (II) VESA(0): ESP=0x00000fba, EBP=0x00000001, ESI=0x00000bc3, 
> EDI=0x00003ad7
> (II) VESA(0): CS=0xc000, SS=0x0100, DS=0x0000, ES=0xc000, FS=0x0000, 
> GS=0x0000 (II) VESA(0): EIP=0x0000800f, EFLAGS=0x00033006 
> (II) VESA(0): code at 0x000c800f:
>  62 18 91 60 09 fa 03 85 27 11 27 11 9d 0f f4 81
>  fe 06 d0 1a 68 74 99 a9 c6 39 f9 6d 04 b4 d6 6b
 
> Also from debugging our own code we have a bit more information about 
> where the problem occurs, and it occurs on the return from the vm86() 
> system call when the code tries to pop the EBX register from the stack. 
> Which kind of indicates that the kernel screwed up the return stack of 
> the program for some reason:

No. Crash happened inside VM, and it was shown as happening on return
from int $0x80. But real problem is that in the VM you are executing
code at 0xC000:0x800F. But there is no code there, it is garbage
(bound bx,[bx+si]; xchg cx,ax; pusha; or dx,di ???) which generated
bounds check interrupt.
 
> Any ideas? I am not sure how to start debuging this (assuming I can get 
> my SMP machine up and running and reproduce it) in the kernel. Also the 
> machine that the problem occurs on goes to the customer tomorrow, so we 
> won't be able to debug this much ourselves until I can get a new machine 
> to reproduce it. But, it would seem to me that others may well have seen 
> this problem already?

Make sure that videocard properly reports that it uses more than 32kB
BIOS. Maybe card reports only 32kB, while it uses 48kB. System is free
to do anything it wants with 32-48kB range including mapping another BIOS
there, or writting zeroes, or garbage there... Also make sure that
you have properly setup VM, that 0xC8000 is mapped to physical address
0xC8000...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

