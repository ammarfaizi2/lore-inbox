Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292778AbSCDTBk>; Mon, 4 Mar 2002 14:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292777AbSCDTB0>; Mon, 4 Mar 2002 14:01:26 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:57293 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292768AbSCDTAL>; Mon, 4 Mar 2002 14:00:11 -0500
Date: Mon, 4 Mar 2002 12:58:39 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <3C83A925.F93BF448@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203041230180.11370-100000@janetreno.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus Spake Jeff Garzik:

>I agree to the first part :)
>
>Set cache line size just like drivers/net/acenic.c does, and enable
>memory-write-invalidate...
>

  Ok, hopefully below is the section you were referring to:

-------

  pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
  cls <<= 2;
  if (cls != SMP_CACHE_BYTES) {
         printk(KERN_INFO "  PCI cache line size set incorrectly "
                "(%i bytes) by BIOS/FW, ", cls);
         if (cls > SMP_CACHE_BYTES)
                printk("expecting %i\n", SMP_CACHE_BYTES);
         else {
                printk("correcting to %i\n", SMP_CACHE_BYTES);
                pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
                                      SMP_CACHE_BYTES >> 2);
         }
  }
  
  pci_read_config_word (pdev, PCI_COMMAND, &pcr);

  /* Turn off Fast B2B enable */
  pcr &= ~PCI_COMMAND_FAST_BACK;
  /* Turn on SERR# enable and others */
  pcr |= (PCI_COMMAND_SERR | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
          PCI_COMMAND_IO   | PCI_COMMAND_MEMORY);

  pci_write_config_word (pdev, PCI_COMMAND, pcr);
  pci_read_config_word (pdev, PCI_COMMAND, &pcr);

------

 Out of curiosity, does it in fact make sense to use memory write and 
invalidate and set cache line size to 0 in some cases?  This seems to go 
against the PCI spec, which, if I'm reading it correctly, says that memory 
write and invalidate is the same as a memory write, but it guarantees that
at least 1 cache line will be written.  So, setting cacheline size =0 would 
negate this effect(?)  

Kent

>
>	Jeff
>
>
>

