Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGYNV4>; Thu, 25 Jul 2002 09:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNV4>; Thu, 25 Jul 2002 09:21:56 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:47074 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S313305AbSGYNVx> convert rfc822-to-8bit; Thu, 25 Jul 2002 09:21:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Reinhard Moosauer <rm@moosauer.de>
To: linux-kernel@vger.kernel.org
Subject: Intel 845 Boards / 82801DB IDE Chipset / resource collisions
Date: Thu, 25 Jul 2002 15:24:15 +0200
User-Agent: KMail/1.4.1
Cc: tspinillo@linuxmail.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207251524.15920.rm@moosauer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please answer to directly to my email too. Thanks!)

Hello List,

some people had problems with
Intel IDE Chips on 845E Boards. ( "resource collisions" )

Yesterday I had the same problem.

Alan Cox said:
> If you look with lspci -v you will find your BIOS has mismapped or
> forgotten to map some of the control register space for that device.
>
> Alan

IMHO there must be a bios bug (latest rev.), because the io resources are left 
unassigned. But why does the kernel not fix it?
After reading many questions and no answers, I looked into the kernel source. 
 
I found this block in arch/i386/kernel/pci-i386.c:

==================
     /*
     *  Don't touch IDE controllers and I/O ports of video cards!
     */
      if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
           (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
                  continue;
====================

lspci shows indeed the first 4 resources unassigned.

To work around the problem I inserted these lines:
(just before the above block)

========================
                        /* HACK
                         * Reinhard Moosauer, 2002-07-25
                         */
                        if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) &&
                                (!r->start && r->end)) {
                          printk(KERN_ERR "HACK: INTEL IDE Workaround for"
                               " %s Resource %d\n",  dev->slot_name, idx);

			/* I ACCEPT NO RESPOSIBILITY FOR ANY DAMAGE */
                          pci_assign_resource(dev, idx);
                        }
==========================


It really works. 
As I saw on the list, many other people had the same problem
so I thought, the gurus should take a look at this.

Note1: Please do not use this before anybody gave an OK to it!
I am just playing sorcerer's apprentice.

Note2: You need a patch for kernels before 2.4.19 or so to use the new Intel 
Chipsets (when he says "unknown device 0x24cb" or so) . I have one for 
2.4.18.

I hope, this helps someone.

Kind regards,

Reinhard

