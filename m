Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269401AbUIYT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269401AbUIYT2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbUIYT2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:28:12 -0400
Received: from ltgp.iram.es ([150.214.224.138]:31361 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S269398AbUIYT1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:27:50 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Sat, 25 Sep 2004 21:18:08 +0200
To: Stas Sergeev <stsp@aknet.ru>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040925191808.GA5901@iram.es>
References: <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es> <415563C7.8000701@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <415563C7.8000701@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 04:25:43PM +0400, Stas Sergeev wrote:
> Hello.
> 
> Gabriel Paubert wrote:
> >Maybe I miss something, but it seems that lret (or retl)
> >is not affected by this bug.
> Petr Vandrovec says (he forgot to CC that
> to LKML I think):

At least I did not see it.

> ---
> Looking at VMware's code it seems that RETF suffers from
> this bug too...
> ---
> 
> I tested that - he is right, and Intel docs
> make no sense as to not mentioning this.

I suspected that they behaved differently because the
pseudocode in iret's description is quite different 
(for iret, it even does not mention restoring ESP!).
But if you expect Intel's doc, or that of any manufacturer
for the matter, to tell the whole truth, you're naïve.

Is ESP really properly restored for V86 bmode or is it that 
it does not hit the case of a default 32 bit code segment with 
a 16 bit stack?

I'm absolutely amazed by the fact that this bug has been there
since the beginning and only seems to hit users right now.

I don't like adding an intermediate privilege level, but
it looks hard to do through the vdso, and you always have to 
push something on the final stack. A hardware task switch 
might work, but it has problems with races on the segment
descriptors. 

Anyway, I've just read again Intel's doc about mixing 16 and 32 bit 
code and I have found the understament of the day:

"For most efficient and trouble-free operation of the processor, 32-bit
                        ^^^^^^^^^^^^
programs or tasks should have the D flag in the code-segment descriptor
and the B flag in the stack-segment descriptor set, and 16-bit programs
or tasks should have these flags clear. Program control transfers from
16-bit segments to 32-bit segments (and vice versa) are handled most
efficiently through call, interrupt, or trap gates."


	Regards,
	Gabriel
