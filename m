Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTDYSjC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDYSjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:39:02 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:41182 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S263632AbTDYSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:39:00 -0400
Message-ID: <3EA983F3.2000306@sun.com>
Date: Fri, 25 Apr 2003 11:52:35 -0700
From: Duncan Laurie <duncan@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem with Serverworks CSB5 IDE
References: <3EA85C5C.7060402@sun.com> <20030423212713.GD21689@puck.ch>	 <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>	 <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch>	 <20030424080023.GG21689@puck.ch> <3EA85C5C.7060402@sun.com>	 <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>	 <3EA964D1.3070908@sun.com> <1051285350.5902.14.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051285350.5902.14.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2003-04-25 at 17:39, Duncan Laurie wrote:
> 
>>mode because the PCI interrupt pin register is hardwired to zero (don't
>>ask me why...) so it follows a codepath in do_ide_setup_pci_device()
>>where init_chipset isn't called.
> 
> 
> That would imply a problem in the PCI layer, since the IRQ should have 
> been assigned, and if the IRQ is not assigned we can't use the device.
> 
> I'll take a look. 
> 

It might just be another unfortunate serverworks chipset bug...

The CSB5 doesn't appear to fully support native mode--sure you can
put it in native mode (!) and you're free to assign the BARs any
way you want, but it still assumes IRQ14 for ide0 and IRQ15 for
ide1 when they should really be collapsed and shared on a single
PCI (non-compatibility) interrupt.

While it might be possible to re-route the interrupts using the
pirq table and a few different bits in the southbridge, that still
wouldn't solve the problem of PCI config reg 0x3c being read-only
and set to zero in the IDE function..

The best answer might be to not use native mode.  We can force it
into legacy mode with a pci quirk and it works, but its ugly:


--- quirks.c~   2003-04-25 11:37:46.000000000 -0700
+++ quirks.c    2003-04-25 11:46:45.000000000 -0700
@@ -631,6 +631,22 @@
                 interrupt_line_quirk = 1;
  }

+/*
+ *     Serverworks CSB5 IDE does not fully support native mode
+ */
+static void __init quirk_svwks_csb5ide(struct pci_dev *pdev)
+{
+       u8 prog;
+       pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+       if (prog & 5) {
+               prog &= ~5;
+               pdev->class &= ~5;
+               pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+               /* need to re-assign BARs for compat mode */
+               quirk_ide_bases(pdev);
+       }
+}
+
  /*
   *  The main table of quirks.
   */
@@ -702,6 +718,8 @@

         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_CYRIX,    PCI_DEVICE_ID_CYRIX_PCI_MASTER, 
quirk_mediagx_master },

+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS, 
PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide },
+
  #ifdef CONFIG_X86_IO_APIC
         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AMD,      PCI_DEVICE_ID_AMD_8131_APIC,
           quirk_amd_8131_ioapic },


-duncan

