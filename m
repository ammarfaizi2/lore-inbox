Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWGHPta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWGHPta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWGHPta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:49:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:41834 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964875AbWGHPt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:49:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNobryY8Ph3rA9hbUL93Klh3iF77kKjzQywimwzToAx57BfdZALoQdIqg4DT0xbcc57NuYv6RH8xgR6TVKoP/sAu3SPdPl5gJbkoDpYvnbOKRP0FTrOXszcz2vAZpFa2dQZjx8D5RgWyDod7ObCwavBpX8ijPbFtme8JPImL57c=
Message-ID: <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
Date: Sat, 8 Jul 2006 11:49:26 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: tglx@linutronix.de
Subject: Re: [patch] spinlocks: remove 'volatile'
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <1152354244.24611.312.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
	 <1152354244.24611.312.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 2006-07-08 at 05:45 -0400, Joe Korty wrote:
> > On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > > That's all theoretical though. Today, gcc's volatile does
> > > not follow the C standard on modern hardware. Bummer.
> > > It'd be low-performance anyway though.
> >
> > But gcc would follow the standard if it emitted a 'lock'
> > insn on every volatile reference.  It should at least
> > have an option to do that.

That would do for x86 without MMIO.

> volatile works fine on trivial microcontrollers and for the basic C
> course lesson, but there is no way for the compiler to decide which of
> the 'lock' mechanisms should be used in complex situations.
>
> In low level system programming there is no fscking way for the compiler
> to figure out if this is in context of a peripheral bus, cross CPU
> memory or whatever. All those things have hardware dependend semantics
> and the only way to get them straight is to enforce the correct handling
> with handcrafted assembler code.

This can work. The compiler CALLS the assembly code.
Nothing new here: see all the libgcc functions if you aren't
used to the idea of the compiler calling functions behind
your back.

So we have assembly functions somewhat like this:

__volatile_read(void*dst, void*src, size_t size);
__volatile_write(void*dst, void*src, size_t size);

They probably have to look up the memory address to
determine if it belongs to a PCI device or not, etc.
For userspace code, they could even be system calls.

Without that, gcc just isn't correct on normal hardware.

I'm not suggesting this is fast, of course. Probably the
right answer is something like this:

-fvolatile=smp   # Add locks
-fvolatile=call   # Call custom functions
