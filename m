Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVALXZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVALXZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVALXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:23:27 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:7150 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S261524AbVALXOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:14:32 -0500
Date: Wed, 12 Jan 2005 17:14:05 -0600
From: DHollenbeck <dick@softplc.com>
Subject: Re: yenta_socket rapid fires interrupts
In-reply-to: <Pine.LNX.4.58.0501111557260.2373@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Message-id: <41E5AF3D.4050702@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
References: <41E2BC77.2090509@softplc.com>
 <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
 <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44738.2050606@softplc.com>
 <Pine.LNX.4.58.0501111340570.2373@ppc970.osdl.org>
 <41E45410.7070004@softplc.com>
 <Pine.LNX.4.58.0501111557260.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>And the dmesg output.  Please look at intctl.  Is this our unsatisfied 
>>noise maker?
>>    
>>
>
>Hmm. It has I365_PC_RESET set, which does indeed not look right. Could you 
>try just forcing it to zero in the initialization path? In fact, that's 
>there in the 16-bit card case, but not in the CBCARD case. Something like 
>this:
>
>--- 1.65/drivers/pcmcia/yenta_socket.c	2004-12-01 00:14:04 -08:00
>+++ edited/drivers/pcmcia/yenta_socket.c	2005-01-11 16:02:45 -08:00
>@@ -260,7 +260,7 @@
> 
> 		/* ISA interrupt control? */
> 		intr = exca_readb(socket, I365_INTCTL);
>-		intr = (intr & ~0xf);
>+		intr &= I365_RING_ENA | I365_INTR_ENA;
> 		if (!socket->cb_irq) {
> 			intr |= state->io_irq;
> 			bridge |= CB_BRIDGE_INTR;
>
>should hopefully take care of it.
>
>		Linus
>
>  
>

Linus, unfortunately that did not fix it.  And I no longer think the 
"cause" of the interrupt is this I365_PC_RESET bit being on.   At first 
after adding your patch, the same symptoms existed, and since both 
interrupts handlers were called in immediate sequence (because of the 
shared IRQ 11 for the two sockets),  the events printk mis-led me into 
believing that the I386_PC_RESET bit was still the cause.  (The 
interrupt stream begins towards the end of probing for the first socket, 
before the second socket is programmed. and in the events printk I could 
still see the I386_PC_RESET bit for the 2nd socket.)  Eventually I put 
code into the interrupt handler to turn off that bit whenever I saw it 
on, regardless of which socket's interrupt handler was executing.  Still 
the interrupt stream persists.

I thank you for your help.  I have done about all I can do here, and I 
think there could be a bug in the yenta driver's initialization 
scenario.   Before bailing on this card, I can go this bit further.  
While the list ponders this post, I am going to once again try this card 
in a different machine to see if it is still good.  It was at last 
check.  Please review the attached dmesg output, which I got by patching 
the debug printk's.  The format is:

<calling function> [ <source file line number> ] <io func> <io func data 
args>

see below for more hints on how to interpret...

Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0d.1
Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
   yenta_config_init[ 921]config_writel_ c187a400 0044 00000000
   yenta_config_init[ 922]config_writel_ c187a400 0010 fe002000
   yenta_config_init[ 927]config_writew_ c187a400 0004 0087
   yenta_config_init[ 930]config_writeb_ c187a400 000c 20
   yenta_config_init[ 931]config_writeb_ c187a400 000d a8
   yenta_config_init[ 936]config_writel_ c187a400 0018 b0040100
   yenta_config_init[ 944] config_readw_ c187a400 003e 0340
   yenta_config_init[ 947]config_writew_ c187a400 003e 0580
         yenta_probe[1013]    cb_writel_ c187a400 0004 00000000
  yenta_allocate_res[ 602] config_readl_ c187a400 001c 00000000
  yenta_allocate_res[ 603] config_readl_ c187a400 0020 00000000
  yenta_allocate_res[ 642]config_writel_ c187a400 001c 10000000
  yenta_allocate_res[ 643]config_writel_ c187a400 0020 103fffff
  yenta_allocate_res[ 602] config_readl_ c187a400 0024 00000000
  yenta_allocate_res[ 603] config_readl_ c187a400 0028 00000000
  yenta_allocate_res[ 642]config_writel_ c187a400 0024 10400000
  yenta_allocate_res[ 643]config_writel_ c187a400 0028 107fffff
  yenta_allocate_res[ 602] config_readl_ c187a400 002c 00000000
  yenta_allocate_res[ 603] config_readl_ c187a400 0030 00000000
  yenta_allocate_res[ 642]config_writel_ c187a400 002c 00004000
  yenta_allocate_res[ 643]config_writel_ c187a400 0030 000040ff
  yenta_allocate_res[ 602] config_readl_ c187a400 0034 00000000
  yenta_allocate_res[ 603] config_readl_ c187a400 0038 00000000
  yenta_allocate_res[ 642]config_writel_ c187a400 0034 00004400
  yenta_allocate_res[ 643]config_writel_ c187a400 0038 000044ff
     ti12xx_override[ 598] config_readl_ c187a400 0080 28449060
Yenta: Enabling burst memory read transactions
     ti12xx_override[ 602]config_writel_ c187a400 0080 2844d060
     ti12xx_override[ 619] config_readb_ c187a400 0093 60
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
ti12xx_irqroute_func0[ 335] config_readl_ c187a400 008c 00001022
ti12xx_irqroute_func0[ 336] config_readb_ c187a400 0092 64
Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
             ti_init[ 291]   exca_readb_ c187a400 0003 00
             ti_init[ 297]  exca_writeb_ c187a400 0003 10
  yenta_probe_cb_irq[ 866] config_readw_ c187a400 003e 05c0
  yenta_probe_cb_irq[ 868]config_writew_ c187a400 003e 0540
  yenta_probe_cb_irq[ 876]  exca_writeb_ c187a400 0005 01
  yenta_probe_cb_irq[ 877]    cb_writel_ c187a400 0000 ffffffff
  yenta_probe_cb_irq[ 878]    cb_writel_ c187a400 0004 00000001
  yenta_probe_cb_irq[ 879]    cb_writel_ c187a400 000c 00000001
 yenta_probe_handler[ 843]     cb_readl_ c187a400 0000 00000001
 yenta_probe_handler[ 844]    cb_writel_ c187a400 0000 ffffffff
 yenta_probe_handler[ 845]   exca_readb_ c187a400 0004 00
  yenta_probe_cb_irq[ 884]    cb_writel_ c187a400 0004 00000000
  yenta_probe_cb_irq[ 885]  exca_writeb_ c187a400 0005 00
  yenta_probe_cb_irq[ 886]    cb_writel_ c187a400 0000 ffffffff
  yenta_probe_cb_irq[ 887]   exca_readb_ c187a400 0004 00
Yenta: ti12xx_override(): socket->dev->device=ac55
Yenta: resetting I365_INTCTL's I365_RESET
     ti12xx_override[ 639]   exca_readb_ c187a400 0003 10
     ti12xx_override[ 641]  exca_writeb_ c187a400 0003 10
         ti_override[ 303]   exca_readb_ c187a400 0003 10
         ti_override[ 307]  exca_writeb_ c187a400 0003 00
     yenta_probe_irq[ 801] config_readw_ c187a400 003e 0540
     yenta_probe_irq[ 804]config_writew_ c187a400 003e 05c0
     yenta_probe_irq[ 811]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 812]    cb_writel_ c187a400 0004 00000001
     yenta_probe_irq[ 813]  exca_writeb_ c187a400 0005 00
     yenta_probe_irq[ 818]  exca_writeb_ c187a400 0005 31
     yenta_probe_irq[ 819]    cb_writel_ c187a400 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a400 0005 51
     yenta_probe_irq[ 819]    cb_writel_ c187a400 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a400 0005 61
     yenta_probe_irq[ 819]    cb_writel_ c187a400 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a400 0005 71
     yenta_probe_irq[ 819]    cb_writel_ c187a400 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a400 0005 a1
     yenta_probe_irq[ 819]    cb_writel_ c187a400 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a400 0000 ffffffff
     yenta_probe_irq[ 823]    cb_writel_ c187a400 0004 00000000
     yenta_probe_irq[ 824]  exca_writeb_ c187a400 0005 00
     yenta_probe_irq[ 829]config_writew_ c187a400 003e 0540
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
         yenta_probe[1044]     cb_readl_ c187a400 0008 30000006
Socket status: 30000006
     yenta_sock_init[ 523] config_readw_ c187a400 003e 0540
     yenta_sock_init[ 526]config_writew_ c187a400 003e 0540
     yenta_sock_init[ 528]  exca_writeb_ c187a400 001e 00
     yenta_sock_init[ 529]  exca_writeb_ c187a400 0016 00
     yenta_sock_init[ 532]     cb_readl_ c187a400 0008 30000006
     yenta_set_power[ 264]     cb_readl_ c187a400 0010 00000400
     yenta_set_power[ 265]    cb_writel_ c187a400 0010 00000000
    yenta_set_socket[ 275] config_readw_ c187a400 003e 0540
    yenta_set_socket[ 276]     cb_readl_ c187a400 0008 30000006
    yenta_set_socket[ 294]   exca_readb_ c187a400 0003 00
    yenta_set_socket[ 301]  exca_writeb_ c187a400 0003 40
    yenta_set_socket[ 303]   exca_readb_ c187a400 0002 00
    yenta_set_socket[ 307]   exca_readb_ c187a400 0002 00
    yenta_set_socket[ 308]  exca_writeb_ c187a400 0002 40
    yenta_set_socket[ 319]  exca_writeb_ c187a400 0005 08
    yenta_set_socket[ 320]   exca_readb_ c187a400 0004 00
    yenta_set_socket[ 324]config_writew_ c187a400 003e 0580
    yenta_set_socket[ 326]    cb_writel_ c187a400 0000 ffffffff
    yenta_set_socket[ 327]    cb_writel_ c187a400 0004 00000006
    yenta_set_io_map[ 343]   exca_readb_ c187a400 0006 00
    yenta_set_io_map[ 351]  exca_writew_ c187a400 0008 0000
    yenta_set_io_map[ 352]  exca_writew_ c187a400 000a 0001
    yenta_set_io_map[ 354]   exca_readb_ c187a400 0007 00
    yenta_set_io_map[ 358]  exca_writeb_ c187a400 0007 00
    yenta_set_io_map[ 343]   exca_readb_ c187a400 0006 00
    yenta_set_io_map[ 351]  exca_writew_ c187a400 000c 0000
    yenta_set_io_map[ 352]  exca_writew_ c187a400 000e 0001
    yenta_set_io_map[ 354]   exca_readb_ c187a400 0007 00
    yenta_set_io_map[ 358]  exca_writeb_ c187a400 0007 00
   yenta_set_mem_map[ 386]   exca_readb_ c187a400 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a400 0040 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a400 0010 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a400 0012 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a400 0014 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a400 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a400 0041 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a400 0018 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a400 001a 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a400 001c 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a400 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a400 0042 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a400 0020 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a400 0022 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a400 0024 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a400 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a400 0043 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a400 0028 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a400 002a 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a400 002c 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a400 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a400 0044 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a400 0030 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a400 0032 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a400 0034 0000
             ti_init[ 291]   exca_readb_ c187a400 0003 40
             ti_init[ 297]  exca_writeb_ c187a400 0003 10
     yenta_sock_init[ 543]    cb_writel_ c187a400 0004 00000006
     yenta_set_power[ 264]     cb_readl_ c187a400 0010 00000400
     yenta_set_power[ 265]    cb_writel_ c187a400 0010 00000000
    yenta_set_socket[ 275] config_readw_ c187a400 003e 05c0
    yenta_set_socket[ 276]     cb_readl_ c187a400 0008 30000006
    yenta_set_socket[ 294]   exca_readb_ c187a400 0003 10
    yenta_set_socket[ 301]  exca_writeb_ c187a400 0003 50
    yenta_set_socket[ 303]   exca_readb_ c187a400 0002 00
    yenta_set_socket[ 307]   exca_readb_ c187a400 0002 00
    yenta_set_socket[ 308]  exca_writeb_ c187a400 0002 40
    yenta_set_socket[ 319]  exca_writeb_ c187a400 0005 08
    yenta_set_socket[ 320]   exca_readb_ c187a400 0004 00
    yenta_set_socket[ 324]config_writew_ c187a400 003e 0580
    yenta_set_socket[ 326]    cb_writel_ c187a400 0000 ffffffff
    yenta_set_socket[ 327]    cb_writel_ c187a400 0004 00000006
PCI: Found IRQ 11 for device 0000:00:0d.1
PCI: Sharing IRQ 11 with 0000:00:0d.0
Yenta: CardBus bridge found at 0000:00:0d.1 [0000:0000]
   yenta_config_init[ 921]config_writel_ c187a000 0044 00000000
   yenta_config_init[ 922]config_writel_ c187a000 0010 fe003000
   yenta_config_init[ 927]config_writew_ c187a000 0004 0087
   yenta_config_init[ 930]config_writeb_ c187a000 000c 20
   yenta_config_init[ 931]config_writeb_ c187a000 000d a8
   yenta_config_init[ 936]config_writel_ c187a000 0018 b0080500
   yenta_config_init[ 944] config_readw_ c187a000 003e 0340
   yenta_config_init[ 947]config_writew_ c187a000 003e 0580
         yenta_probe[1013]    cb_writel_ c187a000 0004 00000000
  yenta_allocate_res[ 602] config_readl_ c187a000 001c 00000000
  yenta_allocate_res[ 603] config_readl_ c187a000 0020 00000000
  yenta_allocate_res[ 642]config_writel_ c187a000 001c 10800000
  yenta_allocate_res[ 643]config_writel_ c187a000 0020 10bfffff
  yenta_allocate_res[ 602] config_readl_ c187a000 0024 00000000
  yenta_allocate_res[ 603] config_readl_ c187a000 0028 00000000
  yenta_allocate_res[ 642]config_writel_ c187a000 0024 10c00000
  yenta_allocate_res[ 643]config_writel_ c187a000 0028 10ffffff
  yenta_allocate_res[ 602] config_readl_ c187a000 002c 00000000
  yenta_allocate_res[ 603] config_readl_ c187a000 0030 00000000
  yenta_allocate_res[ 642]config_writel_ c187a000 002c 00004800
  yenta_allocate_res[ 643]config_writel_ c187a000 0030 000048ff
  yenta_allocate_res[ 602] config_readl_ c187a000 0034 00000000
  yenta_allocate_res[ 603] config_readl_ c187a000 0038 00000000
  yenta_allocate_res[ 642]config_writel_ c187a000 0034 00004c00
  yenta_allocate_res[ 643]config_writel_ c187a000 0038 00004cff
     ti12xx_override[ 598] config_readl_ c187a000 0080 2844d060
     ti12xx_override[ 619] config_readb_ c187a000 0093 60
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
ti12xx_irqroute_func1[ 494] config_readl_ c187a000 008c 00001022
ti12xx_irqroute_func1[ 495] config_readb_ c187a000 0092 64
Yenta TI: socket 0000:00:0d.1, mfunc 0x00001022, devctl 0x64
             ti_init[ 291]   exca_readb_ c187a000 0003 00
             ti_init[ 297]  exca_writeb_ c187a000 0003 10
  yenta_probe_cb_irq[ 866] config_readw_ c187a000 003e 05c0
  yenta_probe_cb_irq[ 868]config_writew_ c187a000 003e 0540
  yenta_probe_cb_irq[ 876]  exca_writeb_ c187a000 0005 01
  yenta_probe_cb_irq[ 877]    cb_writel_ c187a000 0000 ffffffff
  yenta_probe_cb_irq[ 878]    cb_writel_ c187a000 0004 00000001
  yenta_probe_cb_irq[ 879]    cb_writel_ c187a000 000c 00000001
        yenta_events[ 430]     cb_readl_ c187a400 0000 00000000
        yenta_events[ 431]    cb_writel_ c187a400 0000 00000000
        yenta_events[ 433]   exca_readb_ c187a400 0004 00
        yenta_events[ 437]   exca_readb_ c187a400 0003 50
        yenta_events[ 441]  exca_writeb_ c187a400 0003 10
        yenta_events[ 463]     cb_readl_ c187a400 0008 30000006
yenta: c187a400 cb_event 00000000 state 30000006 csc 00 intctl 50 events 
00000040
 yenta_probe_handler[ 843]     cb_readl_ c187a000 0000 00000001
 yenta_probe_handler[ 844]    cb_writel_ c187a000 0000 ffffffff
 yenta_probe_handler[ 845]   exca_readb_ c187a000 0004 00
    yenta_get_status[ 161]     cb_readl_ c187a400 0008 30000006
    yenta_get_status[ 174]   exca_readb_ c187a400 0001 00
    yenta_get_status[ 176]   exca_readb_ c187a400 0003 10
  yenta_probe_cb_irq[ 884]    cb_writel_ c187a000 0004 00000000
  yenta_probe_cb_irq[ 885]  exca_writeb_ c187a000 0005 00
  yenta_probe_cb_irq[ 886]    cb_writel_ c187a000 0000 ffffffff
  yenta_probe_cb_irq[ 887]   exca_readb_ c187a000 0004 00
Yenta: ti12xx_override(): socket->dev->device=ac55
Yenta: resetting I365_INTCTL's I365_RESET
     ti12xx_override[ 639]   exca_readb_ c187a000 0003 10
     ti12xx_override[ 641]  exca_writeb_ c187a000 0003 10
         ti_override[ 303]   exca_readb_ c187a000 0003 10
         ti_override[ 307]  exca_writeb_ c187a000 0003 00
     yenta_probe_irq[ 801] config_readw_ c187a000 003e 0540
     yenta_probe_irq[ 804]config_writew_ c187a000 003e 05c0
     yenta_probe_irq[ 811]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 812]    cb_writel_ c187a000 0004 00000001
     yenta_probe_irq[ 813]  exca_writeb_ c187a000 0005 00
     yenta_probe_irq[ 818]  exca_writeb_ c187a000 0005 31
     yenta_probe_irq[ 819]    cb_writel_ c187a000 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a000 0005 51
     yenta_probe_irq[ 819]    cb_writel_ c187a000 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a000 0005 61
     yenta_probe_irq[ 819]    cb_writel_ c187a000 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a000 0005 71
     yenta_probe_irq[ 819]    cb_writel_ c187a000 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 818]  exca_writeb_ c187a000 0005 a1
     yenta_probe_irq[ 819]    cb_writel_ c187a000 000c 00000001
     yenta_probe_irq[ 821]    cb_writel_ c187a000 0000 ffffffff
     yenta_probe_irq[ 823]    cb_writel_ c187a000 0004 00000000
     yenta_probe_irq[ 824]  exca_writeb_ c187a000 0005 00
     yenta_probe_irq[ 829]config_writew_ c187a000 003e 0540
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
         yenta_probe[1044]     cb_readl_ c187a000 0008 30000020
Socket status: 30000020
     yenta_sock_init[ 523] config_readw_ c187a000 003e 0540
     yenta_sock_init[ 526]config_writew_ c187a000 003e 0540
     yenta_sock_init[ 528]  exca_writeb_ c187a000 001e 00
     yenta_sock_init[ 529]  exca_writeb_ c187a000 0016 00
     yenta_sock_init[ 532]     cb_readl_ c187a000 0008 30000020
     yenta_sock_init[ 535]    cb_writel_ c187a000 000c 00004000
     yenta_set_power[ 264]     cb_readl_ c187a000 0010 00000400
     yenta_set_power[ 265]    cb_writel_ c187a000 0010 00000000
    yenta_set_socket[ 275] config_readw_ c187a000 003e 0540
    yenta_set_socket[ 276]     cb_readl_ c187a000 0008 30000820
    yenta_set_socket[ 281]   exca_readb_ c187a000 0003 00
yenta: CBCARD: I365_INTCTL=00  state->io_irq=00
    yenta_set_socket[ 290]  exca_writeb_ c187a000 0003 00
    yenta_set_socket[ 324]config_writew_ c187a000 003e 0500
    yenta_set_socket[ 326]    cb_writel_ c187a000 0000 ffffffff
    yenta_set_socket[ 327]    cb_writel_ c187a000 0004 00000006
    yenta_set_io_map[ 343]   exca_readb_ c187a000 0006 00
    yenta_set_io_map[ 351]  exca_writew_ c187a000 0008 0000
    yenta_set_io_map[ 352]  exca_writew_ c187a000 000a 0001
    yenta_set_io_map[ 354]   exca_readb_ c187a000 0007 00
    yenta_set_io_map[ 358]  exca_writeb_ c187a000 0007 00
    yenta_set_io_map[ 343]   exca_readb_ c187a000 0006 00
    yenta_set_io_map[ 351]  exca_writew_ c187a000 000c 0000
    yenta_set_io_map[ 352]  exca_writew_ c187a000 000e 0001
    yenta_set_io_map[ 354]   exca_readb_ c187a000 0007 00
    yenta_set_io_map[ 358]  exca_writeb_ c187a000 0007 00
   yenta_set_mem_map[ 386]   exca_readb_ c187a000 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a000 0040 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a000 0010 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a000 0012 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a000 0014 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a000 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a000 0041 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a000 0018 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a000 001a 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a000 001c 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a000 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a000 0042 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a000 0020 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a000 0022 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a000 0024 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a000 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a000 0043 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a000 0028 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a000 002a 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a000 002c 0000
   yenta_set_mem_map[ 386]   exca_readb_ c187a000 0006 00
   yenta_set_mem_map[ 392]  exca_writeb_ c187a000 0044 00
   yenta_set_mem_map[ 399]  exca_writew_ c187a000 0030 0000
   yenta_set_mem_map[ 408]  exca_writew_ c187a000 0032 0000
   yenta_set_mem_map[ 415]  exca_writew_ c187a000 0034 0000
             ti_init[ 291]   exca_readb_ c187a000 0003 00
             ti_init[ 297]  exca_writeb_ c187a000 0003 10
     yenta_sock_init[ 543]    cb_writel_ c187a000 0004 00000006
     yenta_set_power[ 264]     cb_readl_ c187a000 0010 00000400
     yenta_set_power[ 265]    cb_writel_ c187a000 0010 00000000
    yenta_set_socket[ 275] config_readw_ c187a000 003e 0540
    yenta_set_socket[ 276]     cb_readl_ c187a000 0008 30000820
    yenta_set_socket[ 281]   exca_readb_ c187a000 0003 10
yenta: CBCARD: I365_INTCTL=10  state->io_irq=00
    yenta_set_socket[ 290]  exca_writeb_ c187a000 0003 10
    yenta_set_socket[ 324]config_writew_ c187a000 003e 0500
    yenta_set_socket[ 326]    cb_writel_ c187a000 0000 ffffffff
    yenta_set_socket[ 327]    cb_writel_ c187a000 0004 00000006
    yenta_get_status[ 161]     cb_readl_ c187a000 0008 30000820
    yenta_get_status[ 161]     cb_readl_ c187a000 0008 30000820
    yenta_get_status[ 161]     cb_readl_ c187a000 0008 30000820
     yenta_set_power[ 264]     cb_readl_ c187a000 0010 00000400
     yenta_set_power[ 265]    cb_writel_ c187a000 0010 00000033
    yenta_set_socket[ 275] config_readw_ c187a000 003e 0540
    yenta_set_socket[ 276]     cb_readl_ c187a000 0008 30000820
    yenta_set_socket[ 281]   exca_readb_ c187a000 0003 10
yenta: CBCARD: I365_INTCTL=10  state->io_irq=00
    yenta_set_socket[ 290]  exca_writeb_ c187a000 0003 10
    yenta_set_socket[ 324]config_writew_ c187a000 003e 0500
    yenta_set_socket[ 326]    cb_writel_ c187a000 0000 ffffffff
    yenta_set_socket[ 327]    cb_writel_ c187a000 0004 00000006
        yenta_events[ 430]     cb_readl_ c187a400 0000 00000000
        yenta_events[ 431]    cb_writel_ c187a400 0000 00000000
        yenta_events[ 433]   exca_readb_ c187a400 0004 00
        yenta_events[ 437]   exca_readb_ c187a400 0003 10
        yenta_events[ 463]     cb_readl_ c187a400 0008 30000006
yenta: c187a400 cb_event 00000000 state 30000006 csc 00 intctl 10 events 
00000000
        yenta_events[ 430]     cb_readl_ c187a000 0000 00000008
        yenta_events[ 431]    cb_writel_ c187a000 0000 00000008
        yenta_events[ 433]   exca_readb_ c187a000 0004 00
        yenta_events[ 437]   exca_readb_ c187a000 0003 10
        yenta_events[ 463]     cb_readl_ c187a000 0008 30000829
yenta: c187a000 cb_event 00000008 state 30000829 csc 00 intctl 10 events 
00000000
        yenta_events[ 430]     cb_readl_ c187a400 0000 00000000
        yenta_events[ 431]    cb_writel_ c187a400 0000 00000000
        yenta_events[ 433]   exca_readb_ c187a400 0004 00
        yenta_events[ 437]   exca_readb_ c187a400 0003 10
        yenta_events[ 463]     cb_readl_ c187a400 0008 30000006
yenta: c187a400 cb_event 00000000 state 30000006 csc 00 intctl 10 events 
00000000
        yenta_events[ 430]     cb_readl_ c187a000 0000 00000000
        yenta_events[ 431]    cb_writel_ c187a000 0000 00000000
        yenta_events[ 433]   exca_readb_ c187a000 0004 00
        yenta_events[ 437]   exca_readb_ c187a000 0003 10
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c012b752>] __report_bad_irq+0x22/0x90
 [<c012b868>] note_interrupt+0x78/0xc0
 [<c012b11d>] __do_IRQ+0x13d/0x160
 [<c0104aba>] do_IRQ+0x1a/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c012007b>] sys_getresgid+0xb/0xa0
 [<c0117750>] __do_softirq+0x30/0xa0
 [<c0120060>] sys_setresgid+0x120/0x130
 [<c01177f5>] do_softirq+0x35/0x40
 [<c012af65>] irq_exit+0x35/0x40
 [<c0104abf>] do_IRQ+0x1f/0x30
 [<c010337a>] common_interrupt+0x1a/0x20
 [<c01005b0>] default_idle+0x0/0x40
 [<c038007b>] ic_setup_if+0xcb/0xd0
 [<c01005d3>] default_idle+0x23/0x40
 [<c010064c>] cpu_idle+0x1c/0x50
 [<c036873c>] start_kernel+0x13c/0x160
handlers:
[<c284f5c0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
[<c284f5c0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #11
yenta: CBCARD: I365_INTCTL=10  state->io_irq=00
yenta: CBCARD: I365_INTCTL=10  state->io_irq=00
root@EMBEDDED[~]#
root@EMBEDDED[~]#


To make sense of the line numbers, you could take a copy of 
yenta_socket.c 2.6.10 out of tree to a tmp dir, and apply the following 
patch.  Some of the line numbers are header file relative, but most all 
are based in yenta_socket.c.

--- yenta_socket..orig    2004-12-24 15:35:00.000000000 -0600
+++ yenta_socket.c    2005-01-12 14:58:24.000000000 -0600
@@ -29,12 +29,6 @@
 #include "i82365.h"
 
 
-#if 0
-#define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
-#else
-#define debug(x,args...)
-#endif
-
 /* Don't ask.. */
 #define to_cycles(ns)    ((ns)/120)
 #define to_ns(cycles)    ((cycles)*120)
@@ -42,95 +36,120 @@
 static int yenta_probe_cb_irq(struct yenta_socket *socket);
 
 
+#if 1
+static int debugOn=1;
+#define debug(f,l,x,args...) do { if(debugOn) printk(KERN_DEBUG 
"%20s[%4d]%14s " x,f, l,__func__,##args); } while(0)
+#else
+#define debug(f,l,x,args...)
+#endif
+
+/* pass "line" numbers to inline static functions for debugging output */
+#define cb_readl(s, r)          cb_readl_(__func__,__LINE__,s,r)
+#define cb_writel(s,r,v)        cb_writel_(__func__,__LINE__,s,r,v)
+
+#define config_readb(s,o)       config_readb_(__func__,__LINE__,s,o)
+#define config_writeb(s,o,v)    config_writeb_(__func__,__LINE__,s,o,v)
+#define config_readw(s,o)       config_readw_(__func__,__LINE__,s,o)
+#define config_writew(s,o,v)    config_writew_(__func__,__LINE__,s,o,v)
+#define config_readl(s,o)       config_readl_(__func__,__LINE__,s,o)
+#define config_writel(s,o,v)    config_writel_(__func__,__LINE__,s,o,v)
+
+#define exca_readb(s,r)         exca_readb_(__func__,__LINE__,s,r)
+#define exca_readw(s,r)         exca_readw_(__func__,__LINE__,s,r)
+#define exca_writeb(s,r,v)      exca_writeb_(__func__,__LINE__,s,r,v)
+#define exca_writew(s,r,v)      exca_writew_(__func__,__LINE__,s,r,v)
+
+
 /*
  * Generate easy-to-use ways of reading a cardbus sockets
  * regular memory space ("cb_xxx"), configuration space
  * ("config_xxx") and compatibility space ("exca_xxxx")
  */
-static inline u32 cb_readl(struct yenta_socket *socket, unsigned reg)
+static inline u32 cb_readl_(const char* f, int line, struct 
yenta_socket *socket, unsigned reg)
 {
     u32 val = readl(socket->base + reg);
-    debug("%p %04x %08x\n", socket, reg, val);
+    debug(f,line, "%p %04x %08x\n", socket, reg, val);
     return val;
 }
 
-static inline void cb_writel(struct yenta_socket *socket, unsigned reg, 
u32 val)
+static inline void cb_writel_(const char* f, int line, struct 
yenta_socket *socket, unsigned reg, u32 val)
 {
-    debug("%p %04x %08x\n", socket, reg, val);
+    debug(f,line, "%p %04x %08x\n", socket, reg, val);
     writel(val, socket->base + reg);
 }
 
-static inline u8 config_readb(struct yenta_socket *socket, unsigned offset)
+static inline u8 config_readb_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset)
 {
     u8 val;
     pci_read_config_byte(socket->dev, offset, &val);
-    debug("%p %04x %02x\n", socket, offset, val);
+    debug(f,line, "%p %04x %02x\n", socket, offset, val);
     return val;
 }
 
-static inline u16 config_readw(struct yenta_socket *socket, unsigned 
offset)
+static inline u16 config_readw_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset)
 {
     u16 val;
     pci_read_config_word(socket->dev, offset, &val);
-    debug("%p %04x %04x\n", socket, offset, val);
+    debug(f,line, "%p %04x %04x\n", socket, offset, val);
     return val;
 }
 
-static inline u32 config_readl(struct yenta_socket *socket, unsigned 
offset)
+static inline u32 config_readl_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset)
 {
     u32 val;
     pci_read_config_dword(socket->dev, offset, &val);
-    debug("%p %04x %08x\n", socket, offset, val);
+    debug(f,line, "%p %04x %08x\n", socket, offset, val);
     return val;
 }
 
-static inline void config_writeb(struct yenta_socket *socket, unsigned 
offset, u8 val)
+static inline void config_writeb_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset, u8 val)
 {
-    debug("%p %04x %02x\n", socket, offset, val);
+    debug(f,line, "%p %04x %02x\n", socket, offset, val);
     pci_write_config_byte(socket->dev, offset, val);
 }
 
-static inline void config_writew(struct yenta_socket *socket, unsigned 
offset, u16 val)
+static inline void config_writew_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset, u16 val)
 {
-    debug("%p %04x %04x\n", socket, offset, val);
+    debug(f,line, "%p %04x %04x\n", socket, offset, val);
     pci_write_config_word(socket->dev, offset, val);
 }
 
-static inline void config_writel(struct yenta_socket *socket, unsigned 
offset, u32 val)
+static inline void config_writel_(const char* f, int line, struct 
yenta_socket *socket, unsigned offset, u32 val)
 {
-    debug("%p %04x %08x\n", socket, offset, val);
+    debug(f,line, "%p %04x %08x\n", socket, offset, val);
     pci_write_config_dword(socket->dev, offset, val);
 }
 
-static inline u8 exca_readb(struct yenta_socket *socket, unsigned reg)
+static inline u8 exca_readb_(const char* f, int line, struct 
yenta_socket *socket, unsigned reg)
 {
     u8 val = readb(socket->base + 0x800 + reg);
-    debug("%p %04x %02x\n", socket, reg, val);
+    debug(f,line, "%p %04x %02x\n", socket, reg, val);
     return val;
 }
 
-static inline u8 exca_readw(struct yenta_socket *socket, unsigned reg)
+static inline u8 exca_readw_(const char* f, int line, struct 
yenta_socket *socket, unsigned reg)
 {
     u16 val;
     val = readb(socket->base + 0x800 + reg);
     val |= readb(socket->base + 0x800 + reg + 1) << 8;
-    debug("%p %04x %04x\n", socket, reg, val);
+    debug(f,line, "%p %04x %04x\n", socket, reg, val);
     return val;
 }
 
-static inline void exca_writeb(struct yenta_socket *socket, unsigned 
reg, u8 val)
+static inline void exca_writeb_(const char* f, int line, struct 
yenta_socket *socket, unsigned reg, u8 val)
 {
-    debug("%p %04x %02x\n", socket, reg, val);
+    debug(f,line, "%p %04x %02x\n", socket, reg, val);
     writeb(val, socket->base + 0x800 + reg);
 }
 
-static void exca_writew(struct yenta_socket *socket, unsigned reg, u16 val)
+static void exca_writew_(const char* f, int line, struct yenta_socket 
*socket, unsigned reg, u16 val)
 {
-    debug("%p %04x %04x\n", socket, reg, val);
+    debug(f,line, "%p %04x %04x\n", socket, reg, val);
     writeb(val, socket->base + 0x800 + reg);
     writeb(val >> 8, socket->base + 0x800 + reg + 1);
 }
 
+
 /*
  * Ugh, mixed-mode cardbus and 16-bit pccard state: things depend
  * on what kind of card is inserted..
@@ -260,11 +279,14 @@
 
         /* ISA interrupt control? */
         intr = exca_readb(socket, I365_INTCTL);
-        intr = (intr & ~0xf);
+//        intr = (intr & ~0xf);
+                intr &= I365_RING_ENA | I365_INTR_ENA;               
         if (!socket->cb_irq) {
             intr |= state->io_irq;
             bridge |= CB_BRIDGE_INTR;
         }
+                printk("yenta: CBCARD: I365_INTCTL=%02x  
state->io_irq=%02x\n",
+                        intr, state->io_irq );
         exca_writeb(socket, I365_INTCTL, intr);
     }  else {
         u8 reg;
@@ -401,7 +423,7 @@
 static unsigned int yenta_events(struct yenta_socket *socket)
 {
     u8 csc;
-    u32 cb_event;
+    u32 cb_event, intctl;
     unsigned int events;
 
     /* Clear interrupt status for the event */
@@ -412,13 +434,41 @@
 
     events = (cb_event & (CB_CD1EVENT | CB_CD2EVENT)) ? SS_DETECT : 0 ;
     events |= (csc & I365_CSC_DETECT) ? SS_DETECT : 0;
-    if (exca_readb(socket, I365_INTCTL) & I365_PC_IOCARD) {
+    intctl = exca_readb(socket, I365_INTCTL);
+
+        if (intctl & I365_PC_RESET ) {
+                events |= SS_READY;     /* ensure a non-zero return */
+                exca_writeb(socket, I365_INTCTL, intctl & ~I365_PC_RESET);
+        }               
+       
+        if (intctl & I365_PC_IOCARD) {
         events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
+               
     } else {
         events |= (csc & I365_CSC_BVD1) ? SS_BATDEAD : 0;
         events |= (csc & I365_CSC_BVD2) ? SS_BATWARN : 0;
         events |= (csc & I365_CSC_READY) ? SS_READY : 0;
     }
+       
+/* RHH: per Linus */
+#if 1
+        {
+            u32 cb_state;
+           
+            static int intCount = 4;
+           
+            if( intCount > 0 )
+            {
+                --intCount;
+                cb_state = cb_readl(socket, CB_SOCKET_STATE);
+                printk("yenta: %p cb_event %08x state %08x csc %02x 
intctl %02x events %08x\n",
+                    socket, cb_event, cb_state, csc, intctl, events );
+            }
+            else
+                debugOn = 0;
+        }
+#endif       
+       
     return events;
 }
 

