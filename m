Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQLGTwC>; Thu, 7 Dec 2000 14:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbQLGTvw>; Thu, 7 Dec 2000 14:51:52 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:49932 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130423AbQLGTvf>;
	Thu, 7 Dec 2000 14:51:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Thu, 7 Dec 2000 20:20:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Why is double_fault serviced by a trap gate?
CC: "Richard B. Johnson" <root@chaos.analogic.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F02E6C85A2D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Dec 00 at 19:04, Maciej W. Rozycki wrote:
> On Thu, 7 Dec 2000, Petr Vandrovec wrote:
> 
> > No. If interrupt uses task gate, task switch happens. Nothing is stored
> > in context of old process except registers into TSS. There is only one
> > (bad) problem. If you want to get it 100% proof (it is not needed for double
> > fault, but it is definitely needed for NMI, as NMI is very often on SMP
> > ia32), each CPU's IRQ vector must point to different task, otherwise you
> > can get TSS in use during doublefault, leading to triplefault again...
> 
>  Well, I expect wasting a descriptor and a page of memory for the purpose
> of a TSS is not a big problem.

It is architectural problem. Each CPU must have its own IDT or GDT table.
If (for real example) you'll use task gate for NMI, both NMIs are currently
(AFAIK) delivered to both CPUs at same time. Both CPUs find in IDT that
they should switch to task 0x1230. So one of them finds TSS 0x1230 (in GDT
entry 0x1230 / 8) as not busy (busy is field in TSS GDT descriptor), marks 
it busy and starts executing in new context. But other one finds 0x1230 as 
busy. And fault during doublefault is triplefault. Which is hardwired to 
reset and we are where we were before...

<fiddling through manuals>

Well, Intel recommends 'Invalid TSS' exception to be handled through TSS
too, for obvious reason that CPU state may be half-old and half-new...
But I'm not sure that all vendors handle TSS fault during doublefault
correctly and I do not want to rely on that. 

So either each CPU must have its own IDT, pointing to different slots
in GDT, or each CPU must have its own GDT... I preffer IDT, as having
per-CPU GDT could create some really nasty problems (f.e. synchronizing
LDT entries between CPUs) (*) (**).

> > Yes. Currently if any ESP related problem happens in kernel, machine silently
> > reboots without any message. With task gate (as Jeff Merkey proposed
> 
>  You might handle the stack fault with a task gate, actually, but I'm not
> sure it's worth the hassle.  Handling just the double fault should be
> sufficient. 

Yes, it is. Directing stackfault to task gate is wrong, as userspace
faults ar handled by stackfault. Most of kernelspace stackfaults are 
handled by doublefault ;-)

                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
(*) I have even per-process IDT patch at 
ftp://platan.vc.cvut.cz/pub/linux/idt/idts-0.00.tar.gz, so per-cpu
IDTs should be doable too... Patch is for 2.3.11-pre3, so it will
need some tweaking if someone wants to try it...

(**) On other hand, it could allow leaking information. Currently
you can find on which CPU you run with:

void main(void) {
    int x;
    
    while (1) {
        asm ( "str %%ax\n" : "=a"(x));
        printf("CPU %u\n", (x - 0x60) / 0x20);
    }
}

With per-CPU GDT we could have same value of TR accross all CPUs...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
