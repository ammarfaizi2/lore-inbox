Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUIPSlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUIPSlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIPSiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:38:55 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:63169 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S268262AbUIPSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:38:09 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Stas Sergeev <stsp@aknet.ru>
Date: Thu, 16 Sep 2004 20:39:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ESP corruption bug - what CPUs are affected?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <3BFF2F87096@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 04 at 21:49, Stas Sergeev wrote:
> 
> There is a "semi-official" bug in Intel CPUs,
> which is described here:
> http://www.intel.com/design/intarch/specupdt/27287402.PDF
> chapter "Specification Clarifications"
> section 4: "Use Of ESP In 16-Bit Code With 32-Bit Interrupt Handlers".

Not a bug, but a feature.
 
> What I want to find out, is what CPUs are
> affected. I wrote a small test-case. It is
> attached. I tried it on Intel Pentium and
> on AMD Athlon - bug is present on both. But
> I'd like to know if it is also present on a
> Transmeta Crusoe, Cyrix and other CPUs.

AFAIK all.  There are products which depend on this behavior.

> I'd also like to know any thoughts on whether
> it is possible to work around the bug, probably
> in a kernel? Well, I am not hoping on such a
> possibility, but who knows...

IMHO you have to switch to 16bit stack, load upper bits of ESP 
with target value, and then execute IRET, while 16bit SS:SP points 
to same place where flat ESP pointed.  

This way IRET, as stack is 16bit, uses only SP instead of ESP, 
and so you can preload upper bits of ESP before executing IRET. 

And I do not think that linux NMI handler survives 16bit stack, so 
natural solution seems to be to create complete 16bit CPL1 
environment, return to it, load ESP as you want, and then do IRET 
to return to CPL2 or CPL3.  Fortunately V8086 mode is not affected, 
so there should be no problem with using CPL1 for this middle step.  
But of course it is not something you want to do on each return 
from interrupt handler...  Well, or maybe you want...

> Anyway, I'd be glad to get any info on that bug.
> Why it was not fixed for so many years, looks
> also like an interesting question, as for me.

It is part of architecture now...
                                                    Petr Vandrovec
                                                    

