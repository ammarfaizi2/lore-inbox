Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTD1KbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 06:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTD1KbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 06:31:00 -0400
Received: from ltgp.iram.es ([150.214.224.138]:4231 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263129AbTD1Ka6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 06:30:58 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 Apr 2003 12:34:20 +0200
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: desc v0.61 found a 2.5 kernel bug
Message-ID: <20030428103420.GB7396@iram.es>
References: <200304271711_MC3-1-3647-1A8A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304271711_MC3-1-3647-1A8A@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 05:09:04PM -0400, Chuck Ebbert wrote:
> 
> 
> desc v0.61 running on Linux 2.5.68-rel:
> 
>  GDT at c0306300, 32 entries:
> 
> GDT# 12: base:00000000 limit:ffffffff  flags:c09b <P:1 DPL:0 32-bit Code>
> GDT# 13: base:00000000 limit:ffffffff  flags:c093 <P:1 DPL:0 RW Data>
> GDT# 14: base:00000000 limit:ffffffff  flags:c0fb <P:1 DPL:3 32-bit Code>
> GDT# 15: base:00000000 limit:ffffffff  flags:c0f3 <P:1 DPL:3 RW Data>
> GDT# 16: base:c0353800 limit:000eb     flags:008b <P:1 DPL:0 Busy TSS>
> 
>     TSS at c0353800, 236 bytes:
> 
>    CS:0000 <GDT#00,RPL0>   EIP:00000000   eflags:00000000
>   SS0:0068 <GDT#13,RPL0>  ESP0:c2806000
>    SS:0000 <GDT#00,RPL0>   ESP:00000000
>    DS:0000 <GDT#00,RPL0>  ES:0000 <GDT#00,RPL0>
>    FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
>   LDT:0011 <GDT#02,RPL1>   CR3:00000000
>       ^^^^                     ^^^^^^^^
> 
> 
>  The LDT in the kernel's TSS is wrong -- it's shifted right by three

It would only be used if we ever performed a hardware task switch
back to the kernel's default TSS. However, it's clearly wrong.
> 
> bits and should be 0088 <GDT entry #17, RPL 0>
> 
>  And shouldn't CR3 be intitialized in case anyone actually wants to
> switch back to the kernel TSS?

For now no, since the only task gate ever taken (double fault), never
returns (you don't want to update the TSS's CR3 field on every 
switch_to() so you would have to do it in the task gate return 
path, as well as having a correct LDT field).

However, returning from a task gate is so much fraught with races wrt 
segment registers that the best thing to do is to avoid it. Read out 
the details on how segment registers are reloaded on a hardware task 
switch to convince yourself.

	Gabriel

> 
> 
> ------
>  Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
