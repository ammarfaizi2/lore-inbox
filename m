Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289611AbSAJTOJ>; Thu, 10 Jan 2002 14:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289612AbSAJTOA>; Thu, 10 Jan 2002 14:14:00 -0500
Received: from [194.206.157.151] ([194.206.157.151]:22879 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289617AbSAJTNl>; Thu, 10 Jan 2002 14:13:41 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E41F@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'dewar@gnat.com'" <dewar@gnat.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        pkoning@equallogic.com
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, mrs@windriver.com
Subject: RE: [PATCH] C undefined behavior fix
Date: Thu, 10 Jan 2002 20:01:44 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dewar@gnat.com [mailto:dewar@gnat.com]
> Sent: Thursday, January 10, 2002 1:19 PM
> To: Dautrevaux@microprocess.com; dewar@gnat.com; 
> pkoning@equallogic.com
> Cc: gcc@gcc.gnu.org; linux-kernel@vger.kernel.org; mrs@windriver.com
> Subject: RE: [PATCH] C undefined behavior fix
> 
> 
> <<Note that this is not too much of a problem for system 
> programming, as you
> have a way to be sure they are not combined: just use 
> intermediate variables
> and set them separately; the nice thing there is that as you use these
> intermediate variables just once, the compiler will eliminate 
> them. But be
> careful: the sequence point MUST BE RETAINED, and then the 
> two loads cannot
> be combined (in case 1 of course).
> >>
> 
> Of course we all understand that sequence points myust be 
> retained, but this
> is a weak condition compared to the rule that all loads and stores for
> volatile variables must not be resequenced, and in 
> particular, you seem to
> agree that two loads *can* be combined if they both appear between two
> sequence points. I think that's unfortunate, and it is why in Ada we
> adopted a stricter point of view that avoids the notion of 
> sequence points.

What I said was that the C standard seems to allow two accesses to two
adjacent volatile variable with no intervening sequence point to be replaced
by one access to both variables together; and I think I was clear that,
IMHO, this should be avoided for volatile to be useful for system
programming.

My other remark was that by inserting a sequence point you solve this
possible problem without the need for any extension or specific
implementation defined behaviour.

Note that IMO volatile should be obeyed in C about like Volatile/Atomic is
in Ada; that is do exactly the access requested, no more, no less, with the
requested size.

> 
> It even seems that if you have two stores between two 
> sequence points then
> the compiler is free to omit one, and again that seems the 
> wrong decision
> for the case of volatile variables. If it can omit a store in 
> this way, can
> it omit a load, i.e. if we have:
> 
>    x := v - v;
> 
> can someone read the sequence point rule to mean that the compiler is
> free to do only one load here? I hope not, but we have 
> already seen how
> much confusion there is on this point.

Oh no; you would omit one side effect on v. What i said is that if we have
something like:

   union {
	struct {
	   volatile unsigned char x1;
	   volatile unsigned char x2;
	} X;
	volatile unsigned short Y;
   } u;

the compiler could be allowed to handle ((u.X.x1 << 256) | u.X.x2) as if
we've written (u.Y), on a big-endian architecture of course. However saying
that it seems standard-compliant does not mean we should do it in GCC; in
fact my all argument is that I would like we explicitely decide NOT to do
this or any other kind of wider/shorter access to volatile variable, as the
compiler does for now. 

Note that in fact it seems as while larger loads may be standard compilant
if the compiler ensures it is not reading another volatile object, shorter
writes, as those that gcc-3.95.3 generates, seems to be a genuine bug. I
would submit a bug-report if anybody can confirm the problem I already
mentioned here is there in 3.0 (or when I have time to install 3.0 and
test).

	Bernard

PS: perhaps as someone suggested this thread could be limited to gcc ML
instead of both GCC (which I subscribe to) and LKML (which I don't).

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
