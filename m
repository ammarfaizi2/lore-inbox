Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSAIJQL>; Wed, 9 Jan 2002 04:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289287AbSAIJPx>; Wed, 9 Jan 2002 04:15:53 -0500
Received: from [194.206.157.151] ([194.206.157.151]:12734 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S289284AbSAIJPi>; Wed, 9 Jan 2002 04:15:38 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E40E@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'dewar@gnat.com'" <dewar@gnat.com>, mrs@windriver.com, paulus@samba.org
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: RE: [PATCH] C undefined behavior fix
Date: Wed, 9 Jan 2002 10:06:24 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dewar@gnat.com [mailto:dewar@gnat.com]
> Sent: Wednesday, January 09, 2002 1:52 AM
> To: dewar@gnat.com; mrs@windriver.com; paulus@samba.org
> Cc: gcc@gcc.gnu.org; linux-kernel@vger.kernel.org;
> trini@kernel.crashing.org; velco@fadata.bg
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> <<Hum, where in that standard does it say that the compiler won't
> scribble all over memory?  If it doesn't, does that mean that within
> the confines of the language standard that the compiler can?  If you
> produce an Ada compiler that did, do you think your users would feel
> better when you told them you were allowed to by the language
> standard?
> >>
> 
> YOu are appealing to the "intent" of the C standard to say that when
> referencing volatile memory, ONLY the volatile variable can be
> referenced and nothing else. OK, but where do you find this intent?
> Or do we just have to take Mike's word for it? If so, that's not
> very helpful (i.e. to consider that there is an implicit clause
> in the standard that says to consult Mike to learn the intent of
> anything not spelled out).
> 
> Seriously, I just don't see the requirement stated or implied in the
> standard. Perhaps I am missing some language, that's 
> certainly possible,
> it is not a document that I know by heart beginning to end.
> 
> As to your question above, the external effects of an Ada 
> program are very
> carefully stated in the standard, and no one is allowed to 
> try to extend
> this set of effects by appealing to "intent". Of course 
> marketing requirements
> say many things, e.g. you can obviously compute A+B by 
> recursive incrementing,
> and of course that satisfies the standard, but it is 
> obviously useless.
> 
> Now if you are claiming that generating efficient code to 
> access a 16-bit
> volatile quantity (by loading 32 bits) is in the same 
> category, I absolutely
> do not buy that at all.

I agree that in some cases reading a 32-bit word when needing a 16-bit
volatile short may be allowed by the standard. HOWEVER that suppose that gcc
makes a careful examination of all the memory layout for the program so that
to be sure that the 16 unneeded bits it reads for efficiency do NOT come
from some volatile object(s), or gcc will then BREAK the volatile semantics
for these objects.

So in any case this is not allowed in a lot of cases such as accessing
accessing an external "volatile short" (only the linker knwos for sure what
is near this short) or reading memory through a "volatile short*" (only GOD
knows if you can). And in fact it's WRONG to access in such a way if you
know that near this object you have other objects (such as is the case in a
volatile struct...). So even if it *may* be legal in some cases, such an
optimization that *may* be more efficient is not at all very interesting.

This is especially true as it is a nuisance for some uses of "volatile" that
were intended by the standard (as is clear in notes refering to the use of
volatile for memory mapped IO) and are broken by this optimization.

Regards,

	Bernard

PS: Note also that we have (at least on 2.95.3) the opposite "optimization"
or reading only 8-bits out of a 32-bit "volatile unsigned", something that
may be argued to be plain wrong (after all you are omitting reads that were
requested by the program). I've send a message about that earlier in this
thread but have no way right now to test what 3.0.3 will do about it so I
don't want to file a PR if this was already corrected. The program
generating an (incorrect?) byte load is:

	void f(volatile unsigned char* p, volatile unsigned short* q) {
		*p = *q;
	}

Perhaps I should start a new thread about this? this one is quite overlong
:-)

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
