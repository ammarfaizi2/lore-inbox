Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUFWKI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUFWKI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 06:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFWKI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 06:08:26 -0400
Received: from docsis224-219.menta.net ([62.57.224.219]:19377 "EHLO
	pof.eslack.org.") by vger.kernel.org with ESMTP id S265245AbUFWKIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 06:08:24 -0400
Subject: Re: 2.6.7-mm1 PCNet Problems under VMWare 4.5.2
From: Esteve =?ISO-8859-1?Q?Espu=F1a?= Sargatal <esteve@eslack.org>
Reply-To: esteve@eslack.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40D94C0F.6050400@exmsft.com>
References: <40D94C0F.6050400@exmsft.com>
Content-Type: text/plain
Message-Id: <1087985288.16504.5.camel@esteve.pofhq.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 12:08:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aren't bits 31-16 of CSR0 reserved on PCnet-II (79c970A) ?

>From 79c970A Datasheet page 108:

CSR0:
[SNIP] The register is designed so that these indicator bits are cleared
by writing ONESs to those bit locations. This means that the software
can read CSR0 and write back the value just read to clear the interrupt
condition. [SNIP]

bits 31-16 Rserved. Written as ZEROs and read as undefined.
[SNIP]
bit 6 is IENA Interrupt Enable.


Thanks.


On Wed, 2004-06-23 at 11:23, Keith Moore wrote:
> I'm seeing problems running a 2.6.7-mm1 kernel with Fedora Core 2 
> running in a VMWare Workstation 4.5.2 VM. The kernel hangs trying to 
> bring up the (dhcp-enabled) eth0 interface.
> 
> I dug through the -mm1 patch, and the problem seems to be the changes at 
> the end of the pcnet32_interrupt() function (in drivers/net/pcnet32.c). 
> The relevant patch fragment is:
> 
> -    /* Clear any other interrupt, and set interrupt enable. */
> -    lp->a.write_csr (ioaddr, 0, 0x7940);
> +    /* Set interrupt enable. */
> +    lp->a.write_csr (ioaddr, 0, 0x0040);
> 
> Reverting this one section of the patch makes eth0 happy again.
> 
> I poked around with the values written to the csr register, and it 
> appears the virtual PCNet-II adapter needs bit 0x0100 (initialzation 
> done) set. So, writing 0x0140 instead of 0x0040 seems to work well.
> 
> I have no idea how accurate VMWare's emulation of this adapter is, or if 
> this change may cause problems with other (physical) adapters.
> 
> 
> KM
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

