Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282187AbRKWRAz>; Fri, 23 Nov 2001 12:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282189AbRKWRAg>; Fri, 23 Nov 2001 12:00:36 -0500
Received: from ns.ithnet.com ([217.64.64.10]:43529 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282187AbRKWRAc>;
	Fri, 23 Nov 2001 12:00:32 -0500
Date: Fri, 23 Nov 2001 18:00:19 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)
Message-Id: <20011123180019.24c19be3.skraw@ithnet.com>
In-Reply-To: <3BFE8799.4070307@dmb.rug.ac.be>
In-Reply-To: <3BFE8799.4070307@dmb.rug.ac.be>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001 18:30:01 +0100
Didier Moens <Didier.Moens@dmb.rug.ac.be> wrote:

> 
> Hi all,
> 
> 
> This is my first oops report on lkml, so please be gentle with me.  :)
> 
> 
> Hardware : IBM A30p (P3-1.2 GHz) with Intel i830 and ATI M6 Radeon 
> Mobility LY
> 
> 
> Symptoms : oops when modprobing agpgart, both in the RedHat 2.4.13-0.6 
> kernel and in a vanilla 2.4.15pre7.

Hello,

could be that this code from /drivers/char/agp/agpgart_be.c is bogus:

                case PCI_DEVICE_ID_INTEL_830_M_0:
                        i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                          
PCI_DEVICE_ID_INTEL_830_M_1,
                                                                          
NULL);
===>                     if(PCI_FUNC(i810_dev->devfn) != 0) {
                                i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                               
   PCI_DEVICE_ID_INTEL_830_M_1,
                                                                               
   i810_dev);
                        }

                        if (i810_dev == NULL) {
                                printk(KERN_ERR PFX "Detected an "
                                           "Intel 830M, but could not find the"
                                           " secondary device.\n");
                                agp_bridge.type = NOT_SUPPORTED;
                                return -ENODEV;
                        }
                        printk(KERN_INFO PFX "Detected an Intel "
                                   "830M Chipset.\n");
                        agp_bridge.type = INTEL_I810;
                        return intel_i830_setup(i810_dev);

Try this patch:


--- agpgart_be.c-orig   Fri Nov 23 17:57:24 2001
+++ agpgart_be.c        Fri Nov 23 17:55:24 2001
@@ -3879,7 +3879,7 @@
                        i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                          
PCI_DEVICE_ID_INTEL_830_M_1,
                                                                          
NULL);
+                       if(i810_dev && ( PCI_FUNC(i810_dev->devfn) != 0) ) {
-                       if(PCI_FUNC(i810_dev->devfn) != 0) {
                                i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                               
   PCI_DEVICE_ID_INTEL_830_M_1,
                                                                               
   i810_dev);


