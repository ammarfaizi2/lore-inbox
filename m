Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWBFVm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWBFVm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBFVm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:42:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:37323 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932384AbWBFVm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:42:58 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Prevent spinlock debug from timing out too early
Date: Mon, 6 Feb 2006 22:42:30 +0100
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200602062216.28943.ak@suse.de> <20060206213618.GA28566@elte.hu>
In-Reply-To: <20060206213618.GA28566@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062242.30897.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 22:36, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Index: linux-2.6.15/lib/spinlock_debug.c
> > ===================================================================
> > --- linux-2.6.15.orig/lib/spinlock_debug.c
> > +++ linux-2.6.15/lib/spinlock_debug.c
> > @@ -68,13 +68,13 @@ static inline void debug_spin_unlock(spi
> >  static void __spin_lock_debug(spinlock_t *lock)
> >  {
> >  	int print_once = 1;
> > -	u64 i;
> >  
> >  	for (;;) {
> > -		for (i = 0; i < loops_per_jiffy * HZ; i++) {
> > -			cpu_relax();
> > +		unsigned long timeout = jiffies + HZ;
> > +		while (time_before(jiffies, timeout)) {
> >  			if (__raw_spin_trylock(&lock->raw_lock))
> >  				return;
> > +			cpu_relax();
> 
> The reason i added a loop counter was to solve the case where we are 
> spinning with interrupts disabled - jiffies wont increase there! 

Yes but the NMI watchdog should catch it eventually

[we really should enable it by default on i386 too - local APIC 
NMI should work everywhere with APIC]

Oops I missed the write lock case. Thanks.

 
> a better solution would be to call __delay(1) after the first failed 
> attempt, that would make the delay at least 1 second long. It seems 
> __delay() is de-facto exported by every architecture, so we can rely on 
> it in the global spinlock code.
> 
> So how about the patch below instead?

Are you sure loops_per_jiffie is always in delay(1) units?


-Andi
