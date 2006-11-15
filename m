Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030830AbWKOSjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030830AbWKOSjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWKOSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:39:22 -0500
Received: from gw.goop.org ([64.81.55.164]:45464 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030830AbWKOSjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:39:21 -0500
Message-ID: <455B5ED8.5090005@goop.org>
Date: Wed, 15 Nov 2006 10:39:20 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu>
In-Reply-To: <20061115182613.GA2227@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> no, that's not what it does. It measures 50000000 switches of the _same_ 
> selector value, without using any of the selectors in the loop itself. 
> I.e. no mixing at all! But when the kernel and userspace uses %gs, it's 
> the cost of switching between two selector values of %gs that has to be 
> measured. Your code does not measure that at all, AFAICS.
>   
I think you're misreading it.  This is the inner loop:

        for(i = 0; i < COUNT; i++) {
                asm volatile("push %%gs; mov %1, %%gs; addl $1, %%gs:%0; popl %%gs"
                             : "+m" (*offset): "r" (seg) : "memory");
                sync();
        }
        return "gs";

On entry, %gs will contain the normal usermode TLS selector.  "seg" is
another selector allocated with set_thread_area().  The asm pushes the
old %gs, loads the new one, uses a memory address via the new segment,
then restores the previous %gs.

So given this output:

"Genuine Intel(R) CPU           T2400  @ 1.83GHz" @1000Mhz (6,14,8):
ds=7b fs=0 gs=33 ldt=f gdt=3b CPUTIME 
[...]

The initial %fs and %gs are 0 and 0x33 respectively, and it is using
0x3b as the other GDT selector (and 0xf as the other LDT selector).

    J
