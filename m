Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUKSOLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUKSOLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUKSOLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:11:18 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:43172 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261412AbUKSOLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:11:13 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041119100541.GA28243@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
	 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <419D13D3.8020409@stud.feec.vutbr.cz>
	 <20041119100541.GA28243@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 19 Nov 2004 09:11:12 -0500
Message-Id: <1100873472.4051.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a bug print (really a warning) from enable_irq spawned from
the e100 driver. The reason is that enable_irq is being called because
the irq depth is zero.

Looking into this, it is because the e100 uses a shared interrupt.  On
setup (see drivers/net/e100.c: e100_up) it disables the irq that it will
use, and then calls request_irq which calls setup_irq which zeros out
the depth of the irq if it is not shared.  So if the e100 is the first
to be loaded, then you get this message. 

I know that for now this doesn't hurt anything, but besides annoying me
in my print outs (I can't stop panicking when I see it ;-),  is this
really a bug and thus a design flaw of the e100? How else can a shared
irq initialize without turning off the irq before setting itself up?

Should it enable the irq before it requests it, and thus open the race
of a spurious interrupt, or just disable all interrupts?

Thanks,

-- 
Steven Rostedt
Senior Engineer
Kihon Technologies
