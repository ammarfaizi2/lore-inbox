Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287869AbSABRp6>; Wed, 2 Jan 2002 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287873AbSABRpu>; Wed, 2 Jan 2002 12:45:50 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:65284 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S287880AbSABRpe>;
	Wed, 2 Jan 2002 12:45:34 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Paul Koning <pkoning@equallogic.com>
Date: Wed, 2 Jan 2002 18:40:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] C undefined behavior fix
CC: trini@kernel.crashing.org, velco@fadata.bg, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
X-mailer: Pegasus Mail v3.40
Message-ID: <DC4407B5751@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Jan 02 at 11:45, Paul Koning wrote:
> 
> It might be interesting for the compiler to warn about this coding
> error (since it presumably can detect it).  But "fixing" the behavior
> of undefined code seems like a strange thing to do.

It is even worse (gcc 2.95.4 20011223 (Debian prerelease), i386).
Test code:

#include <string.h>
char* dst;
void main(void) {
   strcpy(dst, "test"+CONSTANT);
}

# gcc -O2 -S test.c -DCONSTANT=10
test.c: In function `main':
test.c:4: warning: offset outside bounds of constant string
...
and compiler generated correct code (call to strcpy with "test"+10).

But:
# gcc -O2 -S test.c -DCONSTANT=0x80000000
test.c: In function `main':
test.c:4: warning: offset outside bounds of constant string
gcc: Internal compiler error: program cc1 got fatal signal 11

(and for CONSTANT < 5 it of course generated correct code to fill
dst with string contents; and yes, I know that code will sigsegv on
run because of dst is not initialized - but it should die at runtime,
not at compile time).

So we should definitely change RELOC(), or sooner or later gcc will
die on such code :-(

Debian's gcc 3.0.3-1 generates:
0 <= CONSTANT <= 4: fills dst directly with constant
5 <= CONSTANT <= 0x7FFFFFFF: emit warnings + use strcpy()
0x80000000U <= CONSTANT <= 0xFFFFFFFFU: use strcpy() silently
... and it does not die.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
