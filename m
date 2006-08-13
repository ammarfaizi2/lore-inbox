Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHMHCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHMHCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 03:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWHMHCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 03:02:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbWHMHCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 03:02:45 -0400
Date: Sun, 13 Aug 2006 00:02:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH for review] [109/145] x86_64: Convert modlist_lock to be
 a raw spinlock
Message-Id: <20060813000231.1ef1e21e.akpm@osdl.org>
In-Reply-To: <200608130852.46300.ak@suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193707.9DE2013C0B@wotan.suse.de>
	<20060812224825.1da23a1a.akpm@osdl.org>
	<200608130852.46300.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 08:52:46 +0200
Andi Kleen <ak@suse.de> wrote:

> On Sunday 13 August 2006 07:48, Andrew Morton wrote:
> > On Thu, 10 Aug 2006 21:37:07 +0200 (CEST)
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > This is a preparationary patch for converting stacktrace over to the
> > > new dwarf2 unwinder. lockdep uses stacktrace and the new unwinder
> > > takes the modlist_lock so using a normal spinlock would cause a deadlock.
> > > Use a raw lock instead.
> > > 
> > 
> > It breaks the build on most architectures.
> 
> Hmm, I grepped and most architectures seem to have both __raw_spin_lock
> and local_save_flags.

box:/usr/src/25> grep -l raw_local_save_flags include/asm-*/*.h  
include/asm-avr32/irqflags.h
include/asm-i386/irqflags.h
include/asm-mips/irqflags.h
include/asm-powerpc/irqflags.h
include/asm-s390/irqflags.h
include/asm-x86_64/irqflags.h

> I didn't actually compile them because crosstool
> doesn't love me anymore since I use gcc 4.0.

crosstool is a bit of a bitch.

> What is the official portable interface to do a raw spinlock
> if this one doesn't work?

I don't see a way, really.  Apart from going in and implementing it on the
various architectures.

Perhaps x86_64-mm-module-locks-raw-spinlock-hack-hack-hack.patch could be
hoisted up to include/linux/spinlock.h and then at least only
lockdep-enabled architectures need to implement these things.

