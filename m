Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269580AbUIRQoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269580AbUIRQoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 12:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269582AbUIRQoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 12:44:09 -0400
Received: from mail.aknet.ru ([217.67.122.194]:33544 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269580AbUIRQoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 12:44:04 -0400
Message-ID: <414C662D.5090607@aknet.ru>
Date: Sat, 18 Sep 2004 20:45:33 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz>
In-Reply-To: <3BFF2F87096@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr.

Petr Vandrovec wrote:
> natural solution seems to be to create complete 16bit CPL1 
> environment, return to it, load ESP as you want, and then do IRET 
> to return to CPL2 or CPL3.  Fortunately V8086 mode is not affected, 
> so there should be no problem with using CPL1 for this middle step.  
> But of course it is not something you want to do on each return 
> from interrupt handler...  Well, or maybe you want...
Actually, this may indeed be what I want!
I think this can be implemented with the checks
that Denis Vlasenko suggests. Something like this
can be added to entry.S, right before the "iret":
---
if (!(old_EFLAGS & VM_MASK) && (descr_old_SS is 16bit one))
  push_a_stack_frame_to_return_to_the_ring1_trampoline();
---
This way the overhead for the normal case would be
something about 4 asm insns (the check), and for the
dosemu case - who cares? (and probably also the wine
people will value that)

Does this look reasonable? If it does, I think I
should just start implementing that.

