Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRGDX7I>; Wed, 4 Jul 2001 19:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGDX67>; Wed, 4 Jul 2001 19:58:59 -0400
Received: from hose.mail.pipex.net ([158.43.128.58]:19160 "HELO
	hose.mail.pipex.net") by vger.kernel.org with SMTP
	id <S266582AbRGDX6n>; Wed, 4 Jul 2001 19:58:43 -0400
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Thu, 05 Jul 2001 00:41:15
Subject: Re: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
X-Mailer: ProNews/2 V1.51.ib104
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010704235854Z266582-17721+8482@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001 00:30:10, "Trevor Hemsley" 
<Trevor-Hemsley@dial.pipex.com> wrote:

> Somewhere between 2.4.2 and 2.4.5-ac13, PCMCIA card insertion and 
> removal appears to have broken on my Toshiba Libretto. On 2.4.2 all was 
> fine. On both 2.4.5-ac13 and ac22 it's broken. The whole machine freezes 
> solid, no SAK-s, SAK-u, SAK-b, no Ctrl-Alt-Fn to switch VC's. No messages 
> are issued. Problem occurs when inserting/removing any of YE-Data PCMCIA 
> floppy, TDK Smartmedia adapter (ide_cs), or 3c589 ethernet card.

[large snip]

OK, I've done quite a lot more work on this. It isn't 2.4.5, I'd 
compiled USB support in when I went to 2.4.5 and it's that that causes
the problems. I backed out all changes made between 2.4.2 and 2.4.5 in
drivers/pcmcia and that made no difference to the lockup so then I 
went back to the .config file from 2.4.2 and that worked.

My best guess is that the USB support is using IRQ 11 and that the 
PCMCIA card sockets are wired to use that as well. I have a bypass for
now - if I set the Toshiba BIOS up to use the slots in PCIC mode then 
it assigns them IRQ 15. In cardbus mode they get assigned IRQ 11 in 
Win9x but dmesg reports

Linux Kernel Card Services 3.1.22                                     
                                            
  options:  [pci] [cardbus] [pm]                                      
                                            
PCI: No IRQ known for interrupt pin A of device 00:06.0. Please try 
using pci=biosirq.                             
PCI: No IRQ known for interrupt pin B of device 00:06.1. Please try 
using pci=biosirq.

and

Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000007
Yenta IRQ list 0eb8, PCI irq0
Socket status: 30000007

Using pci=biosirq makes no difference when in cardbus mode.

Ah, got it, flipping the PCMCIA setup in the BIOS from "Auto-detect" 
to "Cardbus/16 bit" fixes it. lspci -vv now lists the cardbus ports as
having IRQ 11 assigned (instead of 0 before). Everything (famous last 
words) appears to be working.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

