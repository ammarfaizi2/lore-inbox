Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVEXKRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVEXKRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVEXKNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:13:38 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:64479 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262058AbVEXJj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:39:28 -0400
Date: Tue, 24 May 2005 11:38:40 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
In-Reply-To: <20050524054722.GA6160@infradead.org>
Message-Id: <Pine.OSF.4.05.10505241123240.5002-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 May 2005, Christoph Hellwig wrote:

> On Mon, May 23, 2005 at 04:14:26PM -0700, Daniel Walker wrote:
> 
> Personally I think interrupt threads, spinlocks as sleeping mutexes and PI
> is something we should keep out of the kernel tree.  

A general threaded interrupt is not a good thing. Ingo made this to see
how far he can press it. But having serial drivers running in interrupt is
way overkill. Even network drivers can (provided they use DMA) run in
interrupt without hurting the overall latencies. It all depends on the
driver and how it interfaces with the rest of the kernel, especially what
locks are shared and how long the lock are taken. If they are small
enough, interrupt context and thus raw spinlocks are good enough.
In general, I think each driver ought to be configurable: Either it runs
in interrupt context or it runs in a thread. The locks have to be changed
accordingly from raw spinlocks to mutexes.

As for PI: Well, I don't think it will affect the overall stability to
have it as something you can switch on/off compile time. Will it even hurt
anyone except for a tiny overhead of checking wether there are RT waiters
or not?

I think the configuration space ought to be something like:
1) Server: No interrupt threads, raw spinlocks and no preemption.
2) RT: Preemption, mutexes with PI in almost all places,
interrupts are threaded per configuration per device.

Desktops ought to run as RT!! Most of all to force people to test the RT
setup, but also to make sure people can run a audio device etc.

> If you want such
> advanced RT features use a special microkernel and run Linux as user
> process, using RTAI or maybe soon some of the more sofisticated virtualization
> technologies.

I find that a bad approach:
1) You don't have RT in userspace.
2) You can't use Linux drivers for standeard hardware when you want it to
be part of your deterministic RT application.

Esben

