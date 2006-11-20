Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966464AbWKTTXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966464AbWKTTXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966465AbWKTTXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:23:23 -0500
Received: from h155.mvista.com ([63.81.120.155]:35273 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S966464AbWKTTXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:23:22 -0500
Message-ID: <45620108.6020705@ru.mvista.com>
Date: Mon, 20 Nov 2006 22:24:56 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <20061119202348.GA27649@elte.hu>	<1163985380.5826.139.camel@localhost.localdomain>	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>	<20061120172642.GA8683@elte.hu>	<20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com>	<20061120191013.GA30828@elte.hu> <20061120191149.GA32537@elte.hu> <4561FF9D.9040903@ru.mvista.com>
In-Reply-To: <4561FF9D.9040903@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>>>  Hmm, that just won't do for PPC threaded fasteoi flows! What you'll 
>>>>get is a threaded IRQ with EOI *never ever* issued, unless my PPC 
>>>>patch is also in...

>>>ok, how about the patch below in addition?

>>or rather, the one below. Untested.

>     Actually, it's been tested since it's close to Daniel's original variant. 
> Should do it.

    Can't say that about the interrupt controllers without mask() method -- 
that *really* needs testing...

>>Index: linux/kernel/irq/chip.c
>>===================================================================
>>--- linux.orig/kernel/irq/chip.c
>>+++ linux/kernel/irq/chip.c
>>@@ -392,11 +394,12 @@ handle_fasteoi_irq(unsigned int irq, str
>> 	desc->status |= IRQ_INPROGRESS;
>> 
>> 	/*
>>-	 * In the threaded case we fall back to a mask+ack sequence:
>>+	 * In the threaded case we fall back to a mask+eoi sequence:
>> 	 */
>> 	if (redirect_hardirq(desc)) {
>>-		mask_ack_irq(desc, irq);
>>-		goto out_unlock;

    That label would generate a warning though. Should be gotten rid of now.

>>+		if (desc->chip->mask)
>>+			desc->chip->mask(irq);
>>+		goto out;
>> 	}
>> 
>> 	desc->status &= ~IRQ_PENDING;
>>
>>

WBR, Sergei
