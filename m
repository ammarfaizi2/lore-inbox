Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315995AbSEJOH6>; Fri, 10 May 2002 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315997AbSEJOH5>; Fri, 10 May 2002 10:07:57 -0400
Received: from kim.it.uu.se ([130.238.12.178]:8832 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315995AbSEJOHz>;
	Fri, 10 May 2002 10:07:55 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.54308.729464.625414@kim.it.uu.se>
Date: Fri, 10 May 2002 16:07:32 +0200
To: Russell King <rmk@arm.linux.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
In-Reply-To: <20020510142038.A7165@flint.arm.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
 > On Fri, May 10, 2002 at 01:58:48PM +0200, Mikael Pettersson wrote:
 > > This patch silences the sound/oss/emu10k1 warnings.
 > 
 > You probably want to think about these in context of 32bit vs 64bit
 > machines.
 > 
 > > --- linux-2.5.15/sound/oss/emu10k1/efxmgr.h.~1~	Wed Feb 20 03:11:02 2002
 > > +++ linux-2.5.15/sound/oss/emu10k1/efxmgr.h	Fri May 10 01:54:43 2002
 > > @@ -50,10 +50,10 @@
 > >          u16 code_start;
 > >          u16 code_size;
 > >  
 > > -        u32 gpr_used[NUM_GPRS / 32];
 > > -        u32 gpr_input[NUM_GPRS / 32];
 > > -        u32 route[NUM_OUTPUTS];
 > > -        u32 route_v[NUM_OUTPUTS];
 > > +        unsigned long gpr_used[NUM_GPRS / 32];
 > > +        unsigned long gpr_input[NUM_GPRS / 32];
 > > +        unsigned long route[NUM_OUTPUTS];
 > > +        unsigned long route_v[NUM_OUTPUTS];
 > >  };

Ideally the emu10k1 maintainer should have fixed this by now. I'm just an emu10k user.

The problem is: 3 archs (i386, ppc, ppc64) require "unsigned long *" as the
parameter type in bitops (set_bit et al), the others take "void *".
"unsigned int *" triggers compiler warnings: on the 32-bitters the warnings
are just portability hints, but for ppc64 I imagine int != long. (And
consequently emu10k1 is already broken on ppc64.)

So what emu10k1 needs here is either
(a) a fix to make these arrays work even if the element type is 64 bits
    (I can't claim to understand the code so I don't want to do that), or
(b) a typedef for a 32-bit type which is "unsigned long" on 32-bitters and
    "unsigned int" on 64-bitters; I couldn't find a standard one but I could
    certainly invent one for emu10k1's private use.

Suggestions?

/Mikael
