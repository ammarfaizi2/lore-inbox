Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132819AbRDDNzP>; Wed, 4 Apr 2001 09:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132821AbRDDNzE>; Wed, 4 Apr 2001 09:55:04 -0400
Received: from mail.isl.tm.fr ([195.115.170.34]:47882 "EHLO mercure.isl.tm.fr")
	by vger.kernel.org with ESMTP id <S132819AbRDDNzA>;
	Wed, 4 Apr 2001 09:55:00 -0400
Message-ID: <3ACB26C6.29CC9DC@isl.tm.fr>
Date: Wed, 04 Apr 2001 15:51:02 +0200
From: "Armin L. Schneider" <schneider@isl.tm.fr>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange problem when printing to STDOUT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry, this might be a beginner question, but I couldn't find any
infos in the FAQ.

I'm writing a driver (module) for a PCI card with a neural processor
(NP-processor) on it for kernel 2.4.1. The registers of this processor
are mapped to a memory area. When I probe for the device, I request
that memory using:

    np.adr    = pci_resource_start (pcidev, 4);
    np.len    = pci_resource_len (pcidev, 4);

    if (!request_mem_region (np.adr, np.len, "NP")) {
        printk (KERN_INFO "NEURAL: Can't get memory region for NP!\n");
        return -EBUSY;
    }

    np.mem = ioremap (np.adr, np.len);

I save the addresses in a global structure:

    struct np_dev
    {
       unsigned long np_adr;       /* bus address of NP memory */
       unsigned char *np_mem;      /* pointer to mapped memory */
       unsigned long np_len;
    };

    struct muren_dev muren;

so that I can release the memory when I remove the device.

I access the different registers of the NP-processor with ioctl's
(there are 8bit and 16bit registers):

    switch (cmd) {
      case NP_IOCSGCR:
          get_user (b, (byte *) arg);
          writeb (b, np.mem + Z_GCR);
          break;
      case NP_IOCGGCR:
          b = readb (np.mem + Z_GCR);
          put_user (b, (byte *) arg);
          break;
      case NP_IOCSMIF:
          get_user (w, (word *) arg);
          writew (w, np.mem + Z_MIF);
          break;
      case NP_IOCGMIF:
          w = readw (np.mem + Z_MIF);
          put_user (w, (word *) arg);
          break;


When I load the module and init the device, I can read the registers.
Some of them have default values after a reset of the chip and they
ar ok. But when I load data to the registers and let the NP-processor
categorize the data, strange things happen:

I wrote a program to test the driver which loads some data to the
NP-processor and tries to categorize it. The program prints its
result to STDOUT.
  - everything works ok, results are correct, if I redirect STDOUT to a
file
  - if I don't redirect, I get reproducibly wrong results when I print
     to STDOUT

My first idea was to disable interrupts while reading/writing
to the register memory (using save_flags() and cli()), but it
didn't help.

Then I did something else for two weeks and came back to the
driver hoping to find a solution. I couldn't find any.
Has anybody ever seen something like this and knows a solution?

Thanks,

Armin.


