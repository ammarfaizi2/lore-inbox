Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288044AbSACADy>; Wed, 2 Jan 2002 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288031AbSACACD>; Wed, 2 Jan 2002 19:02:03 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:45188
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287976AbSACABY>; Wed, 2 Jan 2002 19:01:24 -0500
Date: Wed, 2 Jan 2002 17:01:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: jtv <jtv@xs4all.nl>
Cc: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020103004514.B19933@xs4all.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:45:14AM +0100, jtv wrote:
> On Wed, Jan 02, 2002 at 04:12:43PM -0700, Tom Rini wrote:
> > > 
> > > Obviously -ffreestanding isn't, because this problem could crop up pretty
> > > much anywhere.  The involvement of standard library functions is almost
> > > coincidence and so -ffreestanding would only fix the current symptom.
> > 
> > After thinking about this a bit more, why wouldn't this be the fix?  The
> > problem is that gcc is assuming that this is a 'normal' program (or in
> > this case, part of a program) and that it, and that the standard rules
> > apply, so it optimizes the strcpy into a memcpy.  But in this small bit
> > of the kernel, it's not.  It's not even using the 'standard library
> > functions', but what the kernel provides.  This problem can only crop up
> > in the time before we finish moving ourself around.
> 
> I'm not arguing your facts, but the "abnormality" is in the different
> workings of memory addresses, not in anything related to the standard
> library.  What if these functions were named differently but gcc were
> able to inline them?  AFAICS that might trigger the same problem--no 
> cstdlib confusion involved.  

I'm not sure..  We do:

#define RELOC(x)        (*PTRRELOC(&(x)))
#define PTRRELOC(x)     ((typeof(x))((unsigned long)(x) + offset))

unsigned long offset = reloc_offset();
...
strcpy(namep, RELOC("linux,phandle"));

Which is basically inlining, yes?

> Conversely, what if these were the real stdlib calls that they seem to 
> be?  Still the same bug.  Absence or presence of the standard library 
> is not essential to the problem, and so -ffreestanding can be a fragile
> workaround at best.

Yes, but doesn't -ffreestanding imply that gcc _can't_ assume this is
the standard library, and that strcpy _might_ not be what it thinks, and
to just call strpy?

> The bug just happens to get triggered by a 'builtin' optimization, because 
> gcc 3.0.3 is a little more aggressive with those.  We can't keep the 
> progress of gcc's optimizer back just for a kernel.  Asking for a new 
> option or #pragma, okay.  But weeding out otherwise valid assumptions that 
> help many inputs but break one?  Better to fix the one, even if it does
> cost you some speed there.

We aren't saying this is always a bad thing, but what if we want to turn
off a built-in optimization?  Unless -ffreestanding stops implying
-fno-builtin (maybe we could just add -fno-builtin for this one file..),
this line should be fine.

> Oh, and another suggestion: would having RELOC cast the pointer to the
> intermediate type "const volatile void *" make gcc drop its assumptions 
> on that one pointer, and avoid the optimization?  It may not be exactly 
> what the Standard had in mind when it defined "volatile," but then again 
> the definition was deliberately left vague.

I _think_ this is option 3 or so that I mentioned in another email.
Modify RELOC so that gcc will drop its assumptions and just do what we
explicitly say.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
