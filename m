Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVCRJON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVCRJON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVCRJON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:14:13 -0500
Received: from indonesia.procaptura.com ([193.214.130.21]:12417 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S261523AbVCRJMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:12:07 -0500
Message-ID: <423A9B65.1020103@procaptura.com>
Date: Fri, 18 Mar 2005 10:12:05 +0100
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: insmod segfault in pci_find_subsys()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm having some major issues with a custom module I'm hacking on 
(actually maintained by someone else, but I've done odd bits of 
development.) I simply get a segfault at module install time, and the 
problem seems to occur while the module is scanning the PCI bus. The 
error log from one instance is included below. The actual error message 
varies - I have seen at least 3 different variants:

   1. Unable to handle kernel paging request
   2. Unable to handle kernel NULL pointer dereference
   3. general protection fault

As far as I can tell, the problem always occurs at the same point, 
however - or at list in the same function, namely pci_find_subsys(). 
Actually, I have a very simple module based on the original one, which 
I'm using to reproduce the problem - this is the "itifg8tst" mentioned 
in the log. Source code is included below. Try to build as module 
"itifg8tst.ko", then do "insmod itifg8tst.ko" and see what happens.

This originally happened on a Red Hat Linux EL system with Linux 2.6.9, 
but I've later reproduced it with 2.6.11.4 from kernel.org. I've seen it 
on two hosts with completely different hardware setup. "lspci" output 
from one of them is also included.

Am I seeing an issue with the PCI functions here, or is it just that I 
fail to spot an obvious mistake in the module itself?

- Toralf

------------------------------------------------------------------------

Mar 18 09:17:49 localhost kernel: itifg Scanning all devices...
Mar 18 09:17:49 localhost kernel: general protection fault: 0000 [#1]
Mar 18 09:17:49 localhost kernel: Modules linked in: itifg8tst video button battery ac uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tg3 floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod ata_piix libata sd_mod scsi_mod
Mar 18 09:17:49 localhost kernel: CPU:    0
Mar 18 09:17:49 localhost kernel: EIP:    0060:[<c021481a>]    Not tainted VLI
Mar 18 09:17:49 localhost kernel: EFLAGS: 00010286   (2.6.11.4-0.EL.toralf2) 
Mar 18 09:17:49 localhost kernel: EIP is at pci_find_subsys+0xaa/0x280
Mar 18 09:17:49 localhost kernel: eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000000
Mar 18 09:17:49 localhost kernel: esi: 000000ac   edi: 00000021   ebp: 00000000   esp: c23c1f30
Mar 18 09:17:49 localhost kernel: ds: 007b   es: 007b   ss: 0068
Mar 18 09:17:49 localhost kernel: Process insmod (pid: 2235, threadinfo=c23c0000 task=f7cc39f0)
Mar 18 09:17:49 localhost kernel: Stack: c03ae458 65636976 2e2e2e73 f7ef1000 00000000 00000000 ffffffff ffffffff 
Mar 18 09:17:49 localhost kernel:        ffffffff 00000000 00000021 c23c0000 c0214a2a ffffffff ffffffff ffffffff 
Mar 18 09:17:49 localhost kernel:        000006e9 47c12378 f892c053 ffffffff ffffffff 00000000 0804a018 f88f1580 
Mar 18 09:17:49 localhost kernel: Call Trace:
Mar 18 09:17:49 localhost kernel:  [<c0214a2a>] pci_find_device+0x3a/0x50
Mar 18 09:17:49 localhost kernel:  [<f892c053>] iti_os_attach+0x53/0x60 [itifg8tst]
Mar 18 09:17:49 localhost kernel:  [<c0144a42>] sys_init_module+0x1f2/0x330
Mar 18 09:17:49 localhost kernel:  [<c01799c8>] filp_close+0x48/0x90
Mar 18 09:17:49 localhost kernel:  [<c010397d>] sysenter_past_esp+0x52/0x75
Mar 18 09:17:49 localhost kernel: Code: 00 00 be ac 00 00 00 a3 00 56 3e c0 b8 50 34 3a c0 a3 0c 56 3e c0 a1 e8 52 3e c0 89 35 10 56 3e c0 89 44 24 0c 31 c0 85 db 74 02 <8b> 03 89 44 24 08 89 5c 24 04 c7 04 24 7c e4 3a c0 e8 40 cf f0 


------------------------------------------------------------------------

% /sbin/lspci
00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller
#1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller
#2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV18GL [Quadro4 380 XGL] (rev a2)
05:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5782 Gigabit Ethernet (rev 03)


------------------------------------------------------------------------


#include <linux/version.h>	/* LINUX_VERSION_CODE */

#include <linux/pci.h>		/* pci specific stuff */

#ifdef MODULE
#include <linux/module.h>	/* init_/cleanup_ module */


MODULE_DESCRIPTION("CorecoImaging device driver test");
MODULE_AUTHOR("Matthias Stein");
#if LINUX_VERSION_CODE >= 0x02040a /* 2.4.10 */
MODULE_LICENSE("GPL");
#endif


#define ITI_LOG_STRING "itifg "

int
iti_printi (const char *fmt, ...)
{
  int retval;
  char string[80] = KERN_INFO ITI_LOG_STRING;
  long a, b, c, d;
  va_list argptr;

  strcat (string, fmt);
  va_start (argptr, fmt);
  a = va_arg (argptr, long);
  b = va_arg (argptr, long);
  c = va_arg (argptr, long);
  d = va_arg (argptr, long);
  retval = printk (string, 'I', a, b, c, d);
  va_end (argptr);
  
  return retval;
}

static int __exit
iti_os_detach (void)
{  
  return 0;
}

static __init int
iti_os_attach (void)
{
  struct pci_dev *the_dev;
  
  iti_printi("Scanning all devices...\n");
  
  the_dev=NULL;
  while((the_dev=pci_find_device(PCI_ANY_ID, PCI_ANY_ID, the_dev))) {
    iti_printi("Slot %s: Device %04hx:%04hx\n",
	       the_dev->slot_name, the_dev->vendor, the_dev->device);
  }
  
  
  return 0;
}
#endif /* MODULE */

module_init(iti_os_attach);
module_exit(iti_os_detach);



