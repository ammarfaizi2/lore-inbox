Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWBFXY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWBFXY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWBFXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:24:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36056 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932292AbWBFXY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:24:27 -0500
Date: Tue, 7 Feb 2006 00:22:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent spinlock debug from timing out too early
Message-ID: <20060206232254.GA13566@elte.hu>
References: <200602062216.28943.ak@suse.de> <20060206213618.GA28566@elte.hu> <200602062242.30897.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602062242.30897.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > a better solution would be to call __delay(1) after the first failed 
> > attempt, that would make the delay at least 1 second long. It seems 
> > __delay() is de-facto exported by every architecture, so we can rely on 
> > it in the global spinlock code.
> > 
> > So how about the patch below instead?
> 
> Are you sure loops_per_jiffie is always in delay(1) units?

there are a few explicit calls to __delay() in drivers/*, so i'd assume 
so. A grep also seems to suggest so:

 ./ppc/xmon/xmon.c:extern inline void __delay(unsigned int loops)
 ./x86_64/lib/delay.c:void __delay(unsigned long loops)
 ./sparc64/lib/delay.c:void __delay(unsigned long loops)
 ./sh64/lib/udelay.c:void __delay(int loops)
 ./m32r/lib/delay.c:void __delay(unsigned long loops)
 ./i386/lib/delay.c:void __delay(unsigned long loops)
 ./s390/lib/delay.c:void __delay(unsigned long loops)
 ./sh/lib/delay.c:void __delay(unsigned long loops)
 ./powerpc/kernel/time.c:void __delay(unsigned long loops)

but yes, this is a non-specified thing so far, so there could be 
problems on some platforms. Worst-case we never time out - which could 
be detected via the NMI watchdog or the soft-lockup watchdog - so it's 
not like they would go unnoticed.

	Ingo
