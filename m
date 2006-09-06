Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWIFMdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWIFMdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIFMdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:33:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750801AbWIFMdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:33:43 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060906094301.GA8694@elte.hu> 
References: <20060906094301.GA8694@elte.hu>  <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, john stultz <johnstul@us.ibm.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Sep 2006 13:30:56 +0100
Message-ID: <13982.1157545856@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> btw., would be nice to convert it to genirq (and irqchips) too =B-) That 
> would solve the kind of disable_irq_lockdep() breakage that was reported 
> recently.

I can think of reasons for not using that stuff also.

 (1) Passing "struct pt_regs *regs" around is a complete waste of resources on
     FRV.  It's in GR28 at all times and can thus be accessed directly.

 (2) All the little operations functions cause unnecessary jumping, jumps that
     icache lookahead can't predict because they're register-indirect.

 (3) ACK'ing and controlling interrupts has to be done by groups.

 (4) No account is taken of interrupt priority.

 (5) The FRV CPU doesn't tell me which IRQ source fired.  Much of the code
     I've got is stuff to try and work it out.  I could just blindly poll all
     the sources attached to a particular interrupt level, but that seems
     somehow less efficient.

David

BTW, have you looked at my patch to fix lockdep yet?
