Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbUKBOfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUKBOfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUKBOZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:25:12 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:6903 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262606AbUKBOP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:15:26 -0500
Message-ID: <4187967D.2090308@verizon.net>
Date: Tue, 02 Nov 2004 09:15:25 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net> <20041101084211.GA98600@stud.fit.vutbr.cz> <4186334E.40109@verizon.net> <20041101202730.GA49588@stud.fit.vutbr.cz>
In-Reply-To: <20041101202730.GA49588@stud.fit.vutbr.cz>
Content-Type: multipart/mixed;
 boundary="------------010101050408000500090807"
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [68.238.31.6] at Tue, 2 Nov 2004 08:15:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010101050408000500090807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Jez wrote:
>   Hi Jim,
> 
> 
>>Need to compile a new kernel for this thing w/o tridentfb - doesn't work 
>>right on my system for some reason.
>>
>><dmesg - haven't compiled a 2.6.9 for it yet>
>>
>>PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
>>PCI: Using configuration type 1
>>Linux Kernel Card Services
>>  options:  [pci] [cardbus] [pm]
>>PCI: Probing PCI hardware
>>PCI: Probing PCI hardware (bus 00)
> 
>   IRQ router is missing.
> 
> 
>>PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try 
>>using pci=biosirq.
>>PCI: No IRQ known for interrupt pin B of device 0000:00:02.1. Please try 
>>using pci=biosirq.
>>
>>00:00.0 Class 0600: 8086:1235 (rev 02)
>>00:01.0 Class 0601: 8086:122e (rev 02)
>>00:02.0 Class 0607: 104c:ac12 (rev 04)
>>00:02.1 Class 0607: 104c:ac12 (rev 04)
>>00:03.0 Class 0300: 1023:9660 (rev d3)
>>00:05.0 Class 0400: 1014:0057
>>
>>No PCI interrupt routing table was found.
>>
>>Interrupt router at 00:01.0: Intel 82371FB PIIX PCI-to-ISA bridge
>>  PIRQ1 (link 0x60): irq 11
>>  PIRQ2 (link 0x61): irq 11
>>  PIRQ3 (link 0x62): unrouted
>>  PIRQ4 (link 0x63): unrouted
>>  Serial IRQ: [disabled] [quiet] [frame=17] [pulse=4]
>>  Level mask: 0x0800 [11]
> 
>   It looks that you have same problem and kernel doesn't find IRQ
> router. So try attached patch (for 2.6.9 and added your bridge) if it helps.
> I think that it may help (look at dump_pirq results).
>   You can try turn on DEBUG (in file arch/i386/pci/pci.h) and see debug
> messages on screen.
> 
>   Dave
> 
> 

That patch comes too late in the PCI init sequence for my machine. 
pirq_find_router() (where your patch goes) depends on pirq_table being set up by 
pirq_find_routing_table().  When I put in the debug statement in the attached 
patch, I got the "PCI: No Interrupt Routing Table found" message.  Since 
pirq_table wasn't set up, pirq_find_router() is never called.  Let me look at this 
some more (got vacation this week, so I can finally devote some time to this.)

Jim

--------------010101050408000500090807
Content-Type: text/x-patch;
 name="pirq_fail_message.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pirq_fail_message.patch"

--- linux-2.6.9/arch/i386/pci/irq.c~~	2004-11-02 07:13:15.562669774 -0500
+++ linux-2.6.9/arch/i386/pci/irq.c	2004-11-02 09:01:05.911581344 -0500
@@ -80,6 +80,7 @@
 			return rt;
 		}
 	}
+	DBG("PCI: No Interrupt Routing Table found\n");
 	return NULL;
 }
 

--------------010101050408000500090807--
