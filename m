Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSAGT1A>; Mon, 7 Jan 2002 14:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSAGT0x>; Mon, 7 Jan 2002 14:26:53 -0500
Received: from [194.206.157.151] ([194.206.157.151]:1148 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S285484AbSAGT0c> convert rfc822-to-8bit; Mon, 7 Jan 2002 14:26:32 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E406@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'mike stump'" <mrs@windriver.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>, dewar@gnat.com,
        paulus@samba.org
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: RE: [PATCH] C undefined behavior fix
Date: Mon, 7 Jan 2002 20:17:11 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: mike stump [mailto:mrs@windriver.com]
> Sent: Monday, January 07, 2002 7:39 PM
> To: Dautrevaux@microprocess.com; dewar@gnat.com; paulus@samba.org
> Cc: gcc@gcc.gnu.org; linux-kernel@vger.kernel.org;
> trini@kernel.crashing.org; velco@fadata.bg
> Subject: RE: [PATCH] C undefined behavior fix
> 
> 
> > From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
> > To: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org
> > Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, 
> trini@kernel.crashing.org,
> >         velco@fadata.bg
> > Date: Mon, 7 Jan 2002 14:24:35 +0100 
> 
> > Truly sure; In fact when writiong our Real Time Kernel in C++ we
> > just had this problem, and had to "hack" GCC C and C++ compilers so
> > that volatile acesses are guaranteed to be done with the right size,
> > even in case of bit fields in fact.
> 
> Did your case include more than bitfields?  I recognize that bitfields
> have two possible semantics, and that you and gcc may have different
> opinions about the semantics of them.  I discount the alternative
> choice of semantic as being an example of this problem.  Roughly
> speaking, as I recall...  The two semantics are, the base type of the
> bitfield defines the mode in which memory is accessed and the smallest
> size supported that contains the bitfield defines the access.
> 
> struct { unsigned int field:8; };
> 
> would be a 32 bit access, versus
> 
> struct { unsigned int field:8; };
> 
> would be an 8 bit access.

AFAIR, we'd got an 8 bit access there, which was wrong in view of the fact
we use this to access memory mapped registers that only accept word
accesses. Also this was quite long ago (on gcc-2.95.3); we're in the process
of migrating to 3.0 but that takes some time as we have to make other
changes in the compiler.

Also note that even with the volatile keyword, it seems legal (although I
doubt that GCC does it) to access two adjacent, properly aligned, volatile
char as one word, especially if the result is placed in one resulting
variable as if you have:

	struct { unsigned short a; volatile unsigned char x; volatile
unsigned char y; } *p; 
	unsigned short z = x << 8 | y;

Here it seems that all the C standard requirements for volatile are
fulfilled if the compiler just read a word in z (and that's a big win on a
big-endian architecture); however from a system programmer point of view
this could cause headaches if the memory mapped register only accept byte
accesses... (hopefully this is quite rare; the opposite is more frequent:
only accept word access and get byte access due to bitfields or masking).

> 
> If gcc doesn't do one of them, it truly is broken (if the machine
> supports the access of course).  I would like to know if gcc is truly
> broken.

gcc obvioulsy does one of those; but using the smallest size access is a
nuisance for system programming and a very small win (if any) for standard
applications (who anyway seldom use the volatile keyword, except in
multithreaded code, but then often read/write from the cache).

> 
> > Using volatile (and expanding its semantics to mean: read and write
> > with the requested size) was a great help.
> 
> In gcc, it already means that.  If you think otherwise, I'd like to
> see the example that shows it.

I don't have access right now to a gcc-3.0 compiler, but I try it just now
on 2.95.3 (i386), compiling by "gcc -S -O2 test.c" (a quite common set of
options isn't-it?).

First case: 
===========

reading an 8-bits bitfield declared as unsigned int (32 bit mmio register),
GCC generate 8-bit access to the memory:

struct x {
 volatile unsigned int x1:8;
};

unsigned char f1(struct x* p) {
 return p->x1;
}

yields:
 .file "tst1.c"
 .version "01.01"
gcc2_compiled.:
.text
 .align 4
.globl f1
 .type  f1,@function
f1:
 pushl %ebp
 movl %esp,%ebp
 movl 8(%ebp),%eax
 movl %ebp,%esp
 popl %ebp
 movb (%eax),%al
 movzbl %al,%eax
 ret
.Lfe1:
 .size  f1,.Lfe1-f1
 .ident "GCC: (GNU) 2.95.3-5 (cygwin special)"


Second case:
============

Reading part of a volatile unsigned int (32 bits) with an 8-bit access:

void f(unsigned int* p, unsigned char* q) {
 *q = *p;
}

yields:

 .file "test2.c"
 .version "01.01"
gcc2_compiled.:
.text
 .align 4
.globl f
 .type  f,@function
f:
 pushl %ebp
 movl %esp,%ebp
 movl 8(%ebp),%eax
 movl 12(%ebp),%edx
 movl %ebp,%esp
 movb (%eax),%al
 movb %al,(%edx)
 popl %ebp
 ret
.Lfe1:
 .size  f,.Lfe1-f
 .ident "GCC: (GNU) 2.95.3-5 (cygwin special)"

Maybe 3.0 is avoiding the byte accesses? that would be fine, at least for me
:-)

Note that I were not able to cause gcc to collapse two byte accesses as one
16-bit one but I may not have tried hard enough...

Clearly the code generated by gcc above IS FULLY ANSI-C conforming.
Obviously when writing system code, one would like a bit more strict
interpretation of volatile.

Regards

	Bernard

--------------------------------------------
Bernard Dautrevaux
Microprocess Ingenierie
97 bis, rue de Colombes
92400 COURBEVOIE
FRANCE
Tel:	+33 (0) 1 47 68 80 80
Fax:	+33 (0) 1 47 88 97 85
e-mail:	dautrevaux@microprocess.com
		b.dautrevaux@usa.net
-------------------------------------------- 
