Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285316AbSACKp0>; Thu, 3 Jan 2002 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285327AbSACKpR>; Thu, 3 Jan 2002 05:45:17 -0500
Received: from [194.206.157.151] ([194.206.157.151]:6057 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S285316AbSACKpB>; Thu, 3 Jan 2002 05:45:01 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E3F9@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'paulus@samba.org'" <paulus@samba.org>, Joe Buck <jbuck@synopsys.COM>
Cc: dewar@gnat.com, velco@fadata.bg, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        trini@kernel.crashing.org
Subject: RE: [PATCH] C undefined behavior fix
Date: Thu, 3 Jan 2002 11:35:36 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]
> Sent: Thursday, January 03, 2002 4:12 AM
> To: Joe Buck
> Cc: dewar@gnat.com; velco@fadata.bg; gcc@gcc.gnu.org;
> linux-kernel@vger.kernel.org; linuxppc-dev@lists.linuxppc.org;
> trini@kernel.crashing.org
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> Joe Buck writes:
> 
> > There is already such a project under development: see
> > 
> > http://gcc.gnu.org/projects/bp/main.html
> > 
> > This is a modification to gcc that implements pointers as triples.
> > While there is a performance penalty for doing this, it can 
> completely
> > eliminate the problem of exploitable buffer overflows.  
> However, programs
> > that violate the rules of ISO C by generating out-of-range 
> pointers will
> > fail.
> 
> What will it do if I cast a pointer to unsigned long?  Or if I cast an
> unsigned long to a pointer?  The kernel does both of these things, and
> in a lot of places.
> 
> Part of my beef with what gcc-3 is doing is that I take a pointer,
> cast it to unsigned long, do something to it, cast it back to a
> pointer, and gcc _still_ thinks it's knows what I am doing.  It
> doesn't.

So say it to him: the problem is that the C language gives a quite precise
meaning to the RELOC macro code: When writing RELOC("some string") you say
to the C compiler: look, I want a pointer *in the string* at offset
0xC0000000. The GCC does exactly that. Afterwards it use this for optimizing
strcpy, but you fooled it before and it may be fooled for other cases (e.g.
if you do strlen(RELOC("xxx")) or RELOC("0123456789ABCDEF")[x] in a
"print_hexadecimal" function...).

There is ways in GCC to be sure the compiler forgets what it knows about a
value and use it as you provide it; one of the cleaner is using assembly
language. Note that someone proposed the use of a no-operation asm
instruction that just pretend to change the value returned. If the asm
instruction is furthermore declared "volatile" (I don't remember if it was)
then GCC guarantees that the instruction will not be optimzed away in any
case and so, as the kernel *knows* that RELOC("some string") is effectively
yielding the proper bit-level representation for a valid pointer to the
string th eprogrammer wants, GCC will trust the code and all will be OK.

And all this is just fixing ONE line in the kernel. Is that too much of a
job to do witout discussing it at will in several dozen messages?

Just my .02 euros

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
