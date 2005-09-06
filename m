Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVIFEh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVIFEh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIFEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:37:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:15580 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932290AbVIFEh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:37:27 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, vda@ilport.com.ua
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	<1125854398.23858.51.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 06 Sep 2005 06:37:23 +0200
In-Reply-To: <1125854398.23858.51.camel@localhost.localdomain>
Message-ID: <p73aciqrev0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2005-09-04 at 07:51 -0700, Alex Davis wrote:
> > I'm not asking you to debug crashes. I'm simply requesting that the
> > kernel stack size situation remain as it is: with 8K as the default
> > and 4K configurable. 
> 
> How about the relevant question - why hasn't someone fixed ndiswrapper
> yet - its been pending for months.

AFAIK with interrupt stacks it shouldn't be a big issue to switch
to a private bigger stack. ndiswrapper just needs to have its own private
way to do "current" which accesses thread_info at the bottom of the stack. 
The old problem used to be that interrupts use current too, but 
the i386 irq stack code solves this already.

I suppose the real reason is that most people who are capable
to do these are too scared of the general concept of ndiswrapper
and don't touch it with a fire pole, and the others are unable to do it.

BTW Windows actually seems to have 12k of stack so even 8k is not
quite safe (if that word can be applied to ndiswrapper at all) 

In general I think 4k stack is a bad move though - the VM stalls
argument is a red hering because if that really was such a big issue
(which my perception is that it is not) then it has to be fixed for
other architectures which need double page stack (like x86-64)
anyways. And the problem of running with tight stack is that you'll
always run into corner cases (e.g. involving more complicated stacking
cases or error handling paths etc.) where you overflow and which will
be hard to fix.

Running with tight stack is just a fundamentally fragile configuration
and will come back to bite you later. Even with 8k we regularly
had overflows reported and with 4k it will be much worse.

-Andi
