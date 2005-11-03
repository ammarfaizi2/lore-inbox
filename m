Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVKCVaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVKCVaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVKCVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:30:19 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:17547
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030497AbVKCVaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:30:18 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: initramfs for /dev/console with udev?
Date: Thu, 3 Nov 2005 15:29:59 -0600
User-Agent: KMail/1.8
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511031313.47820.rob@landley.net> <52mzkl4i8y.fsf@cisco.com>
In-Reply-To: <52mzkl4i8y.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031529.59529.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 13:57, Roland Dreier wrote:
>  > On Thursday 03 November 2005 12:51, Robert Schwebel wrote:
>  > > [...] klibc didn't compile for ARCH=um.
>  >
>  > I repeat my question: what is it that didn't compile, klibc or the
>  > kernel?
>
> come on, dude -- how much clearer can he be?

Ah, I see.  The linux kernel headers you feed it were from a kernel compiled 
with ARCH=um.  Right.  It's been a while since I tried feeding any libc 
actual kernel headers.  (I build uClibc against the cleaned up userspace ones 
here: http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ .)

It's also been a while since I played with klibc, and I notice that it doesn't 
work with Maszur's headers.  (It sort of works, with lots of warnings, until 
about halfway through when it wants to touch "asm/signal.h", when Maszur's 
just has linux/signal.h, and symlinking the two still isn't happy because 
sigset_t is never defined...  In klibc there's definitions for ia64, sparc, 
and parisc.  But nothing for x86...

Ok, checking 2.6.14/include/asm-i386 it's an unsigned long, so typedef that...  
Nope, still not happy, wants numerous other symbols now...  Okay, try 
grabbing asm-i386/signal.h from libc...  And asm-generic/signal.h which 
_that_ includes...  And now there's a "previous declaration of 'wait3"' 
conflicting.  Beautiful...)

Ok, I remember why I stopped playing with klibc now.  It's still deep in 
alpha-test stage, requires way more incestuous knowledge of the kernel 
headers than anything not bundled with the kernel itself has any excuse for, 
and I'm still not sure what advantage it claims to have over uClibc except 
for being BSD licensed.

If you have to make it work, I'd suggest extracting a fresh kernel tarball, do 
"make allyesconfig" (without ARCH=um), and use _those_ headers.  Or just 
accept that it doesn't work and try uClibc. :)

Rob
