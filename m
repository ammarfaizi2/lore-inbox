Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289354AbSAJJN0>; Thu, 10 Jan 2002 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289355AbSAJJNQ>; Thu, 10 Jan 2002 04:13:16 -0500
Received: from [194.206.157.151] ([194.206.157.151]:22765 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289354AbSAJJNI>; Thu, 10 Jan 2002 04:13:08 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E419@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'Paul Koning'" <pkoning@equallogic.com>, dewar@gnat.com
Cc: mrs@windriver.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] C undefined behavior fix
Date: Thu, 10 Jan 2002 10:03:42 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Paul Koning [mailto:pkoning@equallogic.com]
> Sent: Wednesday, January 09, 2002 10:44 PM
> To: dewar@gnat.com
> Cc: mrs@windriver.com; gcc@gcc.gnu.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> >>>>> "dewar" == dewar  <dewar@gnat.com> writes:
> 
> > <<Ah... so (paraphrasing) -- if you have two byte size
> > volatile objects, and they happen to end up adjacent in
> > memory, the compiler is explicitly forbidden from turning an
> > access to one of them into a wider access -- because that
> > would be an access to both of them, which is a *different*
> > side effect.  (Certainly that exactly matches the
> > hardware-centric view of why "volatile" exists.)  And the
> > compiler isn't allowed to change side effects, including
> > causing them when the source code didn't ask you to cause
> > them.
> 
>  dewar> Right, and as you see that is covered by the language on
>  dewar> external effects in the Ada standard (remember the intent in
>  dewar> Ada was to exactly match the C rules :-)
> 
>  dewar> But one thing in the Ada world that we consider left open is
>  dewar> whether a compiler is free to combine two volatile loads into
>  dewar> a single load. Probably the answer should be no, but the
>  dewar> language at least in the Ada standard does not seem strong
>  dewar> enough to say this.
> 
> Would ordering rules help answer that?  If you write two separate
> loads you have two separate side effects that are ordered in time,
> while for a single big load they occur concurrently.  If the construct
> where those two loads occur does not allow for side effects to be
> interleaved, then the "as if" principle seems to say you cannot
> legally merge the loads.


Of course ordering rules must be obeyed, and side effects cannot be moved
across sequence points. Thus if the two volatile loads are in separate
instructions, as in:

	int x1, x2;
	volatile unsigned char x1, x2;
	x1 = v1;
	x2 = v2;

Then you're NOT allowed to combined them. However if there is no sequence
points between them the compiler is free to do it (although I'm not sure it
will...) as in e.g.:

	x1 = v1 << 8 + v2;

Note that this is not too much of a problem for system programming, as you
have a way to be sure they are not combined: just use intermediate variables
and set them separately; the nice thing there is that as you use these
intermediate variables just once, the compiler will eliminate them. But be
careful: the sequence point MUST BE RETAINED, and then the two loads cannot
be combined (in case 1 of course).

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
