Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUHEMwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUHEMwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267218AbUHEMuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:50:02 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:60831 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267294AbUHEMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:48:07 -0400
Message-ID: <41122C82.3020304@eidetix.com>
Date: Thu, 05 Aug 2004 14:48:02 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <davidw@eidetix.com>
CC: linux-kernel@vger.kernel.org, Sascha Wilde <wilde@sha-bang.de>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4107E788.8030903@eidetix.com>
In-Reply-To: <4107E788.8030903@eidetix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me. ]

David N. Welton wrote:

> Before you hit reply or erase, no, I'm not talking about the machine not
> getting past the BIOS check complaining that there is no keyboard present.
> 
> Kernel 2.6.7
> 
> model name      : AMD Athlon(tm) XP 2400+
> 
> motherboard: http://www.ecsusa.com/products/km400-m2.html
> 
> ... not sure what else might be useful... apci=off added to boot
> options.  Preemptive kernel.
> 
> In any case, the machine in question does not reboot.  I traced the
> problem down to the mach_reboot but it doesn't get past those assembly
> instructions.  Things do seem to work alright if a keyboard is
> installed.  Otherwise, the machine just sits there, no longer responsive
> to pings or anything else.

....

> any ideas on what parts of the kernel to look at in order to determine
> what is causing this?  I need to fix it, and I don't know where to start 
> looking.

By putting a series of 'crashme/reboot' calls into the kernel, I 
narrowed a possibl cause of it down to this bit of code in 
drivers/input/serio.c:753

/*
  * Write CTR back.
  */

	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
		return -1;
	}

If I do the reboot instructions before this, it reboots fine. 
Afterwards, and it just sits there, no reboot.

Any ideas what to think/look for/do?

Sascha, to see if your problem is the same as mine, you might try 
putting this bit of code before the above call:

	{
	    static struct
	    {
		unsigned short       size __attribute__ ((packed));
		unsigned long long * base __attribute__ ((packed));
	    } no_idt = { 0, 0 };

	    /* That didn't work - force a triple fault.. */
	    __asm__ __volatile__("lidt %0": :"m" (no_idt));
	    __asm__ __volatile__("int3");
	}

It will cause your machine to reboot before it's even finished booting, 
so don't do it with your only available kernel!

Thanks,
-- 
David N. Welton
davidw@eidetix.com
