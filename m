Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269582AbUIRQ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269582AbUIRQ7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUIRQ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 12:59:38 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:62595 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S269582AbUIRQ7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 12:59:34 -0400
Date: Sat, 18 Sep 2004 18:59:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040918165932.GA15570@vana.vc.cvut.cz>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414C662D.5090607@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 08:45:33PM +0400, Stas Sergeev wrote:
> Hi Petr.
> 
> Petr Vandrovec wrote:
> >natural solution seems to be to create complete 16bit CPL1 
> >environment, return to it, load ESP as you want, and then do IRET 
> >to return to CPL2 or CPL3.  Fortunately V8086 mode is not affected, 
> >so there should be no problem with using CPL1 for this middle step.  
> >But of course it is not something you want to do on each return 
> >from interrupt handler...  Well, or maybe you want...
> Actually, this may indeed be what I want!
> I think this can be implemented with the checks
> that Denis Vlasenko suggests. Something like this
> can be added to entry.S, right before the "iret":
> ---
> if (!(old_EFLAGS & VM_MASK) && (descr_old_SS is 16bit one))
>  push_a_stack_frame_to_return_to_the_ring1_trampoline();
> ---
> This way the overhead for the normal case would be
> something about 4 asm insns (the check), and for the
> dosemu case - who cares? (and probably also the wine
> people will value that)
> 
> Does this look reasonable? If it does, I think I
> should just start implementing that.

Do not forget that you have to implement also return to CPL1, as
NMI may arrive while you are running on CPL1.  So it may not be
as trivial as it seemed.  Maybe all these programs survive that
their CPL3 stack changes, and then you could just push cs,eip and
esp on CPL3 stack, and return to user code (vsyscall page seems 
natural place for that code) which would do pop %esp; retf?

Only problem is how to find that old SS points to 16bit segment.
You need LAR and/or you have to peek GDT/LDT to find stack size, 
and AFAIK LAR is microcoded on P4.
						Petr Vandrovec

