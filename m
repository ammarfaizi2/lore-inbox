Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUITLUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUITLUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUITLUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:20:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5636 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266274AbUITLSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:18:22 -0400
In-Reply-To: <200409200125.57953.hfvogt@gmx.net>
References: <200409200125.57953.hfvogt@gmx.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C0CE7A64-0AF6-11D9-B155-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: felipe.alfaro@linuxmail.org, linux-kernel@vger.kernel.org, vojtech@suse.cz
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.9-rc2-mm1: i8042.c: Can't read CTR while initializing i8042
Date: Mon, 20 Sep 2004 13:18:09 +0200
To: hfvogt@gmx.net
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2004, at 01:25, Hans-Frieder Vogt wrote:

> Felipe Alfaro Solana wrote:
>> My keyboard has suddenly stopped working with 2.6.9-rc2-mm1-VP-S1 and
> 2.6.9-rc2-mm1. This is part of the output of dmesg:
>>
>> i8042: ACPI [P2KI] at I/O 0x0, 0x0, irq 1
>> i8042: ACPI [P2MI] at irq 12
>> i8042.c: Can't read CTR while initializing i8042.
>>
>> This does happen on 2.6.9-rc2-mm1-VP-S1 and 2.6.9-rc2-mm1 on a NEC 
>> Chrom@
> laptop, with a 440BX motherboard, Pentium III Mobile and integrated 
> PS/2
> keyboard and mouse. It doesn't happen in 2.6.8.1, not does it happen 
> on my
> Pentium 4 machine, however.
>>
>> Any ideas?
>
> I had the same problem on my AMD64 system (MSI K8T Neo board). The 
> reason, why
> the ioports are not recognised on this board (i.e., why they show up 
> as 0x0,
> 0x0) is, that the ACPI defines these ports as FixedIO () and not as IO 
> () as
> expected by the current linux code. FixedIO is perfectly fine and in 
> line
> with the ACPI standard. So the DSDT table is NOT bad but linux is 
> currently
> simply not flexible enough to cope with all possible (and allowable)
> combinations.
>
> With the small attached patch the i8042 IO-ports were recognised on my 
> board
> (only tested with keyboard).
>
> Voytech, could you include this patch into your next patch set?
>
> --- linux-2.6.9-rc1-mm5.orig/drivers/input/serio/i8042-x86ia64io.h 
> 2004-09-13
> 15:39:39.061522663 +0200
> +++ linux-2.6.9-rc1-mm5/drivers/input/serio/i8042-x86ia64io.h 
> 2004-09-20
> 01:10:32.124593201 +0200
> @@ -105,6 +105,7 @@ static acpi_status i8042_acpi_parse_reso
>  {
>   struct i8042_acpi_resources *i8042_res = data;
>   struct acpi_resource_io *io;
> + struct acpi_resource_fixed_io *fixed_io;
>   struct acpi_resource_irq *irq;
>   struct acpi_resource_ext_irq *ext_irq;
>
> @@ -119,6 +120,16 @@ static acpi_status i8042_acpi_parse_reso
>     }
>     break;
>
> +  case ACPI_RSTYPE_FIXED_IO:
> +   fixed_io = &res->data.fixed_io;
> +   if (fixed_io->range_length) {
> +    if (!i8042_res->port1)
> +     i8042_res->port1 = fixed_io->base_address;
> +    else
> +     i8042_res->port2 = fixed_io->base_address;
> +   }
> +   break;
> +
>    case ACPI_RSTYPE_IRQ:
>     irq = &res->data.irq;
>     if (irq->number_of_interrupts > 0)
>
>

Bingo!
This patch solves my problems with i8042.
Please, include it upstream.
Thanks!

