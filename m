Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTD2TaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTD2TaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:30:00 -0400
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:51881
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261580AbTD2T36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:29:58 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2003 12:41:12 -0700
MIME-Version: 1.0
Subject: Re: Crash in vm86() on SMP boxes with vesa driver?
Message-ID: <3EAE72E8.7176.1E3DFDF8@localhost>
In-reply-to: <CF69933E9@vcnet.vc.cvut.cz>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

> > 8.0 box with the latest 2.4.20 kernel on it (but the problem happened 
> > with the stock kernel and kernels lower then .20 as well). Unfortunately 
> > I don't have access to the box (it is in Australia), but I have access to 
> > the bug report information (and will try to configure a box soon to 
> > reproduce it here). Anyway the folowing is the error log produced by 
> > XFree86 when the crash occurs:
> 
> We told you before that you cannot trust VESA BIOS.

No, I do not agree with that statement at all. At present I would say 
that there is a problem with the vm86() services, or perhaps something 
wrong with the way we (and XFree86) are setting up the vm86 state for the 
BIOS. The reason I say that is because we use the BIOS all the time using 
vm86() services on OS/2 and we have not had any of these problems.  

Essentially what I am saying is that this problem is fixable somewhere 
(either in the kernel or in our/XFree86's vm86() code).  

> > (II) VESA(0): initializing int10
> > (WW) VESA(0): Bad V_BIOS checksum
> > (II) VESA(0): Primary V_BIOS segment is: 0xc000
> 
> Bad checksum? Sorry, your BIOS is not usable. Either XFree gets
> checksum wrong, or there is something I would not want in my
> computer there... 

I wish we stll had access to the machine so I could debug this. It is 
plausible that the BIOS has a bad checksum, but if it did, the system 
BIOS would have failed to POST the card. Hence I think there is something 
else going on here.  

> > Also from debugging our own code we have a bit more information about 
> > where the problem occurs, and it occurs on the return from the vm86() 
> > system call when the code tries to pop the EBX register from the stack. 
> > Which kind of indicates that the kernel screwed up the return stack of 
> > the program for some reason:
> 
> No. Crash happened inside VM, and it was shown as happening on
> return from int $0x80. But real problem is that in the VM you are
> executing code at 0xC000:0x800F. But there is no code there, it is
> garbage (bound bx,[bx+si]; xchg cx,ax; pusha; or dx,di ???) which
> generated bounds check interrupt. 

Ok, that makes sense. From experience with OS/2 and virtual machines, 
this generally happens when the video BIOS is confused by the state of 
the hardware, especially of I/O port access to certain registers has been 
incorrectly virtualised. ATI cards have been notorious for us on OS/2 for 
these types of problems, but the problem is solveable (most of the OS/2 
related problems are all specific to running in a window, where access to 
the hardware registers has to be restricted and correctly emulated).

> > Any ideas? I am not sure how to start debuging this (assuming I can get 
> > my SMP machine up and running and reproduce it) in the kernel. Also the 
> > machine that the problem occurs on goes to the customer tomorrow, so we 
> > won't be able to debug this much ourselves until I can get a new machine 
> > to reproduce it. But, it would seem to me that others may well have seen 
> > this problem already?
> 
> Make sure that videocard properly reports that it uses more than
> 32kB BIOS. Maybe card reports only 32kB, while it uses 48kB. System
> is free to do anything it wants with 32-48kB range including
> mapping another BIOS there, or writting zeroes, or garbage there...
> Also make sure that you have properly setup VM, that 0xC8000 is
> mapped to physical address 0xC8000... 

I will check into this. I am running into some strange problems on an 
NVIDIA GeForce4 integrated system right now, yet that same BIOS works 
perfectly in DOS and OS/2 so there is something up with the way the 
vm86() services are being handled. I will try to solve the problem I am 
seeing on this NVIDIA machine, and perhaps that will lead to a solution 
for both problems (assuming they are actually related of course ;-).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

