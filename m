Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSA1XWn>; Mon, 28 Jan 2002 18:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSA1XWf>; Mon, 28 Jan 2002 18:22:35 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:19462 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S287578AbSA1XW2>;
	Mon, 28 Jan 2002 18:22:28 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 29 Jan 2002 00:22:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.18-pre7 slow ... apm problem
CC: jchua@fedex.com (Jeff Chua), linux-kernel@vger.kernel.org (Linux Kernel),
        sfr@canb.auug.org.au (Stephen Rothwell), skraw@ithnet.com
X-mailer: Pegasus Mail v3.40
Message-ID: <1039F7D26FF8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 02 at 22:20, Alan Cox wrote:
> > Question to all: Would it be a good idea to de-idle the CPU
> > inside interrupt handlers?
> 
> If you call APM routines from inside APM routines weirdness occurs - so
> the answer is no. I'd say that unless this is shown to be occuring in
> non vmware stuff its up to vmware to handle the apm situation right

Hi,
  unfortunately, majordomo kicked me yesterday evening, so I had to
follow this discussion through web archives, and I have some problems
with understanding why problem happens...

  When vmmon switches out of the Linux to the virtual machine, it disables
all (APIC) NMI sources, disables IRQ on the CPU, completely replaces CPU 
context (GDT/IDT/...) and switches to VMM, which does not physically
access anything except main memory and things emulated inside VMM
(like accesses to VGA/SVGA framebuffers). When an IRQ arrives to virtual
machine, it disables all IRQs, restores Linux kernel contexts, reenables
NMI sources, and restarts IRQ from vmmon by using INT xx instruction. 
And everything this happens in process context (when VMM_RUN ioctl is
invoked).

  So this behavior should be completely transparent to Linux kernel,
it should just see VMware process as a HLT instruction executed in vmmon
module, which delays interrupt confirmation/delivery a bit. Only thing
which could cause troubles is SMI arrival - but SMI handler cannot notice
any difference (except that APIC IRQ sources delivered as a NMI to CPU
are disabled), as paging is turned off during SMI handler, and physical
memory contents is same under both vmware and Linux kernel.

  So I'm really puzzled.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
P.S.: I'm not trying to say that it is not VMware fault. It probably
is, as I saw same behavior on my old Pentium 120MHz notebook two years
ago - but as problem disappeared as it appeared...
