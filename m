Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287968AbSABXR5>; Wed, 2 Jan 2002 18:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287972AbSABXQl>; Wed, 2 Jan 2002 18:16:41 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:25102 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287984AbSABXQO>;
	Wed, 2 Jan 2002 18:16:14 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.36909.387949.863222@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 09:56:45 +1100 (EST)
To: Momchil Velikov <velco@fadata.bg>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87ital6y5r.fsf@fadata.bg>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov writes:

> Well, you may discuss it again, but this time after actually reading
> the C standard:
> 
>     "6.3.6 Additive operators
>       ...  
>      
>      9 Unless both the pointer operand and the result point to
>        elements of the same array object, or the pointer operand
>        points one past the last element of an array object and the
>        result points to an element of the same array object, the
>        behavior is undefined if the result is used as an operand of a
>        unary * operator that is actually evaluated."

One of the reasons why C is a good language for the kernel is that its
memory model is a good match to the memory organization used by the
processors that linux runs on.  Thus, for these processors, adding an
offset to a pointer is in fact simply an arithmetic addition.  Combine
that with the fact that the kernel is far more aware of how stuff is
laid out in its virtual memory space than most C programs, and you can
see that it is reasonable for the kernel to do pointer arithmetic
which might be undefined according to the strict letter of the law,
but which in fact works correctly on the class of processors that
Linux runs on, for all reasonable compiler implementations.

The rules in the C standard are designed to allow a program to run
consistently on a wide variety of machine architectures, including
things like the DEC PDP-10 which weren't directly byte-addressable.
(Yes the PDP-10 had "byte pointers" but they were a different kind of
object from an ordinary pointer.)  The Linux kernel runs on a more
restricted range of machines and IMHO we are entitled to assume things
because of that.

> Why gcc shouldn't be making some optimization. Because a particular
> person doesn't like it or ?  What kind of statement is that anyway ?

This is the kernel.  If I say strcpy I want the compiler to call a
function called strcpy, not to try to second-guess me and do something
different.  If I want memcpy I'll write "memcpy".

> Although all uses of the RELOC macro violate the standard, this kind
> of pointer arithmetic is far too common and usually produces the
> expected behavior, thus it make sense to optimize the cases where ut
> breaks

If the gcc maintainers think they are entitled to change the memory
model so as to break pointer arithmetic that "violates" the standard,
then we will have to use a different compiler.

As for the original problem, my preferred solution at the moment is to
add an label in arch/ppc/lib/string.S so that string_copy() is the
same function as strcpy(), and use string_copy instead of strcpy in
prom.c.

Paul.
