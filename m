Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCCXaX>; Sat, 3 Mar 2001 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbRCCXaN>; Sat, 3 Mar 2001 18:30:13 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:7439 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129855AbRCCXaB>; Sat, 3 Mar 2001 18:30:01 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: drepper@cygnus.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context
In-Reply-To: <200103031047.CAA02916@adam.yggdrasil.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: "Adam J. Richter"'s message of "Sat, 3 Mar 2001 02:47:12 -0800"
Date: 03 Mar 2001 17:29:53 -0600
Message-ID: <vbaofviqvm6.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:
> 
> 	IEEE-754 floating point is available under glibc-based systems,
> including most current GNU/Linux distributions, by linking with -lieee.
> Your example program produces the "9 10" result you wanted when linked
> this way, even when compiled with -O2 

No, you've got it backwards.  The "9 10" result is the *wrong* result.
IEEE 64-bit arithmetic should give the result "10 10".  Also, I can't
duplicate your outcome.  I see no difference linking with "-lieee"
versus linking without it, at least under glibc-2.1.3:

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.2/specs
gcc version 2.95.2 20000220 (Debian GNU/Linux)
$ cat modified.c
#include <stdio.h>
#include <fpu_control.h>
int main()
{
        int a = 10;
        fpu_control_t foo;
        _FPU_GETCW(foo);
        printf("%04x %d %d\n",
                foo,
                (int)( a*.3 +  a*.7),   /* first expression */
                (int)(10*.3 + 10*.7));  /* second expression */
        return 0;
}
$ gcc modified.c && ./a.out
037f 9 10
$ gcc -O2 modified.c && ./a.out
037f 10 10
$ gcc modified.c -lieee && ./a.out
037f 9 10
$ gcc -O2 modified.c -lieee && ./a.out
037f 10 10
$

As you can see, linking with "ieee" has no effect on the control word
setting or the results.  Perhaps this has changed post-glibc 2.1.3?
Looking at the 2.1.3 code, it appears that all "ieee" does is set a
variable that's referenced in the math library innards.  It has no
effect on startup code right now.

> 	When not linked with "-lieee", Linux personality ELF
> x86 binaries start with Precision Control set to 3, just because that
> is how the x86 fninit instruction sets it.

Yes.  I know.  In fact, the "fninit" instruction is executed in the
kernel's "init_fpu()" when the first FPU instruction is executed by
the program.  I just think the hardware default happens to be a bad
default on a system where most floating-point software is GCC-compiled
with GCC's 64-bit doubles (and its 64-bit clean but 80-bit dirty
floating point optimizations), so I'm proposing adding an instruction
to "init_fpu()" to change the default hardware control word.

> In general, I think most real uses of floating point are for "fast and
> sloppy" purposes, and programs that want to use floating point and
> care about exact reproducibility will link with "-lieee".

However, this doesn't seem to work.  Nor does "-ffloat-store".

Kevin <buhr@stat.wisc.edu>
