Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288020AbSABXrH>; Wed, 2 Jan 2002 18:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288030AbSABXpn>; Wed, 2 Jan 2002 18:45:43 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:1029 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288024AbSABXpS>; Wed, 2 Jan 2002 18:45:18 -0500
Date: Thu, 3 Jan 2002 00:45:14 +0100
From: jtv <jtv@xs4all.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103004514.B19933@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 04:12:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 04:12:43PM -0700, Tom Rini wrote:
> > 
> > Obviously -ffreestanding isn't, because this problem could crop up pretty
> > much anywhere.  The involvement of standard library functions is almost
> > coincidence and so -ffreestanding would only fix the current symptom.
> 
> After thinking about this a bit more, why wouldn't this be the fix?  The
> problem is that gcc is assuming that this is a 'normal' program (or in
> this case, part of a program) and that it, and that the standard rules
> apply, so it optimizes the strcpy into a memcpy.  But in this small bit
> of the kernel, it's not.  It's not even using the 'standard library
> functions', but what the kernel provides.  This problem can only crop up
> in the time before we finish moving ourself around.

I'm not arguing your facts, but the "abnormality" is in the different
workings of memory addresses, not in anything related to the standard
library.  What if these functions were named differently but gcc were
able to inline them?  AFAICS that might trigger the same problem--no 
cstdlib confusion involved.  

Conversely, what if these were the real stdlib calls that they seem to 
be?  Still the same bug.  Absence or presence of the standard library 
is not essential to the problem, and so -ffreestanding can be a fragile
workaround at best.

The bug just happens to get triggered by a 'builtin' optimization, because 
gcc 3.0.3 is a little more aggressive with those.  We can't keep the 
progress of gcc's optimizer back just for a kernel.  Asking for a new 
option or #pragma, okay.  But weeding out otherwise valid assumptions that 
help many inputs but break one?  Better to fix the one, even if it does
cost you some speed there.

Oh, and another suggestion: would having RELOC cast the pointer to the
intermediate type "const volatile void *" make gcc drop its assumptions 
on that one pointer, and avoid the optimization?  It may not be exactly 
what the Standard had in mind when it defined "volatile," but then again 
the definition was deliberately left vague.

OTOH it may have to be cast away again to make strcpy() work at all, and
so that trick might still break...

Jeroen

