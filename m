Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSKJTQK>; Sun, 10 Nov 2002 14:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265107AbSKJTQK>; Sun, 10 Nov 2002 14:16:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38674 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265096AbSKJTQI>; Sun, 10 Nov 2002 14:16:08 -0500
Date: Sun, 10 Nov 2002 20:22:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: swsusp critical code rewritten to assembly
Message-ID: <20021110192253.GE3068@atrey.karlin.mff.cuni.cz>
References: <20021110132122.GA364@elf.ucw.cz> <Pine.LNX.4.44.0211101117190.9581-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101117190.9581-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > do_magic was really too fragile to be written in C. This patch
> > rewrites it into assembly, to make sure C compiler does not generate
> > stack access and corrupt memory that way. Plus it cleans up suspend.c
> > a bit, makes it really free memory it needs, an no longer calls
> > drivers from atomic context.
> 
> But this still has stuff in C:
> 
> > +	asm volatile ("movl %0, %%esp" :: "m" (saved_context_esp));
> > +	asm volatile ("movl %0, %%ebp" :: "m" (saved_context_ebp));
> > +	asm volatile ("movl %0, %%eax" :: "m" (saved_context_eax));
> > +	asm volatile ("movl %0, %%ebx" :: "m" (saved_context_ebx));
> > +	asm volatile ("movl %0, %%ecx" :: "m" (saved_context_ecx));
> > +	asm volatile ("movl %0, %%edx" :: "m" (saved_context_edx));
> > +	asm volatile ("movl %0, %%esi" :: "m" (saved_context_esi));
> > +	asm volatile ("movl %0, %%edi" :: "m" (saved_context_edi));
> >  
> > -	fix_processor_context();
> > +	restore_processor_state();
> 
> What's up with that? There's no way you can safely restore regular 
> registers and _especially_ %%esp from C code, since the compiler may be 
> using them for other things.

After applying that patch, this stuff is no longer used for
suspend-to-disk. Its still there for suspend-to-ram; I'll fix that.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
