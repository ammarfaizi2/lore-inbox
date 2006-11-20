Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934267AbWKTQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934267AbWKTQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934270AbWKTQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:43:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60136 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934269AbWKTQnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:43:14 -0500
Date: Mon, 20 Nov 2006 17:42:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120164213.GA30350@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <1164039954.3028.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164039954.3028.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0112]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> It makes porting to powerpc for instance harder because some 
> controllers have ack(), and some don't.. Some have mask(), and some 
> don't.. So you end up with what Sergei is doing which is flat out make 
> ack == eoi .. Where you have multiple irq chip types each one really 
> needs an individual evaluation ..

this isnt really a problem. The current situation is simply hacky, 
because right now there's no 'threaded' flow type at all. The x86 code 
just moves the code away from fasteoi:

 #ifdef CONFIG_PREEMPT_HARDIRQS
                set_irq_chip_and_handler_name(irq, &ioapic_chip,
                                            handle_level_irq, "level-threaded");#else
                set_irq_chip_and_handler_name(irq, &ioapic_chip,
                                              handle_fasteoi_irq, "fasteoi");
 #endif

what should happen is a handle_thread_irq irq-flow handler that will 
first mask, and then ack or eoi (whichever callbacks is available), and 
thus can and will handle both fasteoi, edge and level irqs.

	Ingo
