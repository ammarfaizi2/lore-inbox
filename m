Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289195AbSAGNeb>; Mon, 7 Jan 2002 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289204AbSAGNeW>; Mon, 7 Jan 2002 08:34:22 -0500
Received: from [194.206.157.151] ([194.206.157.151]:40037 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289200AbSAGNdp>; Mon, 7 Jan 2002 08:33:45 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E402@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: RE: [PATCH] C undefined behavior fix
Date: Mon, 7 Jan 2002 14:24:35 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dewar@gnat.com [mailto:dewar@gnat.com]
> Sent: Sunday, January 06, 2002 2:06 PM
> To: dewar@gnat.com; paulus@samba.org
> Cc: gcc@gcc.gnu.org; linux-kernel@vger.kernel.org;
> trini@kernel.crashing.org; velco@fadata.bg
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> <<* Given a pointer, I need a way to determine the address 
> (as an int of
>   the appropriate size) that the CPU will present to the MMU when I
>   dereference that pointer.
> >>
> 
> This is in general ill-defined, a compiler might generate 
> code that sometimes
> does byte access to a particular byte, anmd sometimes gets 
> the entire word
> in which the byte resides.
> 
> This is often a nasty issue, and is one of the few things in 
> this area that
> Ada does not properly address.
> 
> If you have a memory mapped byte, you really want a way of saying
> 
> "when I read this byte, do a byte read, it will not work to 
> do a word read"
> 
> pragma Atomic in Ada (volatile gets close in C, but is not 
> close enough) will
> ensure a byte store in practice, but may not ensure byte reads.
> 

Truly sure; In fact when writiong our Real Time Kernel in C++ we just had
this problem, and had to "hack" GCC C and C++ compilers so that volatile
acesses are guaranteed to be done with the right size, even in case of bit
fields in fact.

Anyway volatile is probably a solution for most of these kind of problems,
and adding some more implementation-defined semantics to volatile may
provide a sure fix for most problems. 

Note however that some may not have noticed, in the volatile-using examples,
that there is a difference between a "pointer to volatile char" and a
"volatile pointer to char"; the former, defined as "volatile char*" does not
help in the case of the RELOC macro, while the latter, written "char
*volatile" (note that volatile is now AFTER the '*', not before) is a sure
fix as the semantics of "volatile" ensure that the compiler will NO MORE use
the value it PREVIOUSLY knows was the one of the pointer. 

One of the lessons we learn while writing our C++ kernel was that you NEED
to be both a kernel-expert AND a compiler-expert to be successful, as some
parts of the kernel need to play some nasty tricks that the compiler may
misunderstand; so you must be able to find the proper way to inform the
compiler that you are playing these tricks and forget what it knows. Using
volatile (and expanding its semantics to mean: read and write with the
requested size) was a great help.

Just my .02euro

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
