Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933089AbWF2XKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbWF2XKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933083AbWF2XKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:10:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63129 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933081AbWF2XKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:10:04 -0400
Date: Fri, 30 Jun 2006 01:05:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-mm4
Message-ID: <20060629230517.GA18838@elte.hu>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com> <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629210950.GA300@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i'm too hunting use-after-free bugs - the ones fixed below fix certain 
> crashes, but i'm still seeing a nasty one.
> 
> the crash is independent on lockdep enabled or disabled. See:
> 
>   http://redhat.com/~mingo/misc/
> 
> for the config and the crash.log.

ok, managed to debug the reason for this crash via .config bisecting, 
it's caused by:

   CONFIG_SCSI_PATA_QDI=y

which is a new option in -mm4. Disabling it makes the -mm4 allyesconfig 
bzImage work again.

and running qdi_init() either causes memory corruption, or it causes 
something to be misprogrammed on the motherboard (something wrt. irq 
routing perhaps), which crashes the box afterwards. (but that happens 
dozens of initcalls later, so the breakage is subtle)

it does things like:

        static const unsigned long qd_port[2] = { 0x30, 0xB0 };
        static const unsigned long ide_port[2] = { 0x170, 0x1F0 };

        [...]
                unsigned long port = qd_port[i];
        [...]
                        r = inb_p(port);
                        outb_p(0x19, port);
                        res = inb_p(port);
                        outb_p(r, port);

so it reads/writes port 0x30 and 0xb0. Are those used by something else 
on modern hardware?

i know, i shouldnt be running an ancient Vesa Local Bus driver's init 
routine, but still, the allyesconfig bzImage is quite useful in finding 
various bugs ...

	Ingo
