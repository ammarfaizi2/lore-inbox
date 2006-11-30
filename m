Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936224AbWK3Lxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936224AbWK3Lxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936225AbWK3Lxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:53:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53470 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936224AbWK3Lxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:53:37 -0500
Date: Thu, 30 Nov 2006 12:53:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130115327.GB2324@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130114346.GC23354@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130114346.GC23354@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> This is what is currently being done by cpufreq:

ok!

> a) get_some_cpu_hotplug_protection() [use either some global mechanism 
> 					or a persubsystem mutex]

this bit is wrong i think. Any reason why it's not a per-CPU (but 
otherwise global) array of mutexes that controls CPU hotplug - as per my 
previous mail?

that would flatten the whole locking. Only one kind of lock taken, 
recursive and scalable.

Then the mechanism that changes CPU frequency should take all these 
hotplug locks on all (online) CPUs, and then first stop all processing 
on all CPUs, and then do the frequency change, atomically. This is with 
interrupts disabled everywhere /first/, and /without any additional 
locking/. That would prevent any sort of interaction from other CPUs - 
they'd all be sitting still with interrupts disabled.

	Ingo
