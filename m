Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSEKA5D>; Fri, 10 May 2002 20:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSEKA5C>; Fri, 10 May 2002 20:57:02 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:11016 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316185AbSEKA44>; Fri, 10 May 2002 20:56:56 -0400
Date: Fri, 10 May 2002 17:56:48 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.15 warnings
Message-ID: <20020510175648.C14698@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <26013.1021001169@kao2.melbourne.sgi.com> <26949.1021006885@kao2.melbourne.sgi.com> <15579.46584.447522.360378@kim.it.uu.se> <20020510142038.A7165@flint.arm.linux.org.uk> <15579.54308.729464.625414@kim.it.uu.se> <3CDBE92E.5060307@linuxhq.com> <20020510165124.D7165@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 04:51:24PM +0100, Russell King wrote:
> On Fri, May 10, 2002 at 11:37:18AM -0400, John Weber wrote:
> > Mikael Pettersson wrote:
> > > Russell King writes:
> > >  > On Fri, May 10, 2002 at 01:58:48PM +0200, Mikael Pettersson wrote:
> > >  > > This patch silences the sound/oss/emu10k1 warnings.
> > >  > 
> > >  > You probably want to think about these in context of 32bit vs 64bit
> > >  > machines.
> > >  > 
> > >  > > --- linux-2.5.15/sound/oss/emu10k1/efxmgr.h.~1~	Wed Feb 20 03:11:02 2002
> > >  > > +++ linux-2.5.15/sound/oss/emu10k1/efxmgr.h	Fri May 10 01:54:43 2002
> > >  > > @@ -50,10 +50,10 @@
> > >  > >          u16 code_start;
> > >  > >          u16 code_size;
> > >  > >  
> > >  > > -        u32 gpr_used[NUM_GPRS / 32];
> > >  > > -        u32 gpr_input[NUM_GPRS / 32];
> > >  > > -        u32 route[NUM_OUTPUTS];
> > >  > > -        u32 route_v[NUM_OUTPUTS];
> > >  > > +        unsigned long gpr_used[NUM_GPRS / 32];
> > >  > > +        unsigned long gpr_input[NUM_GPRS / 32];
> > >  > > +        unsigned long route[NUM_OUTPUTS];
> > >  > > +        unsigned long route_v[NUM_OUTPUTS];
> > >  > >  };
> > > 
> > > Ideally the emu10k1 maintainer should have fixed this by now. I'm just an emu10k user.
> > > 
> > > The problem is: 3 archs (i386, ppc, ppc64) require "unsigned long *" as the
> > > parameter type in bitops (set_bit et al), the others take "void *".
> > > "unsigned int *" triggers compiler warnings: on the 32-bitters the warnings
> > > are just portability hints, but for ppc64 I imagine int != long. (And
> > > consequently emu10k1 is already broken on ppc64.)
> > > 
> > > So what emu10k1 needs here is either
> > > (a) a fix to make these arrays work even if the element type is 64 bits
> > >     (I can't claim to understand the code so I don't want to do that), or
> > > (b) a typedef for a 32-bit type which is "unsigned long" on 32-bitters and
> > >     "unsigned int" on 64-bitters; I couldn't find a standard one but I could
> > >     certainly invent one for emu10k1's private use.
> > > 
> > > Suggestions?
> > > 
> > > /Mikael
> > 
> > Why wouldn't something like this be handled by declaring the variable as 
> > "void *"?  If the function is declared as taking "unsigned long *" then 
> > the cast is implicit, while if the function is declared as taking "void 
> > *" then it must explicitly cast the value anyway.  Either way, a "void 
> > *" would work.
> 
> Umm, 'void *gpr_used' is a pointer to some undefined data.
> 'u32 gpr_used[NUM_GPRS / 32]' is an array of 'u32's, where 'u32' is
> defined to be 32-bits.  Therefore, there are NUM_GPRS bits in the array.
> 
> 'unsigned long gpr_used[NUM_GPRS / 32]' is an array of 'unsigned long's,
> where 'unsigned long' is a platform defined number of bits.  Therefore
> you can't say anything about the number of bits in the array.  Typically,
> it's either 32bit or 64bit, but doesn't have to be.  You therefore should
> to adjust the 'NUM_GPRS / 32' according to the size of 'unsigned long'.
> 
> This is only a minor point I'm highlighting - the worst that will happen
> is the arrays will take up twice as much memory with an Alpha machine
> than they really need to.
> 
> Note that the change of type for the bitops occurred because they are
> defined to operate on 'unsigned long' quantities only.  Passing any
> other type into them is a bug.
> 

As for the array size, how about something like this:
-        unsigned long gpr_input[NUM_GPRS / 32];
+        unsigned long gpr_input[NUM_GPRS / (sizeof(long) * 8 )];

Then you can sort out what type it needs to be and as long
as you the sizeof arg matches the declaration gcc will get
it right regardless of the target platform.  If it looks too
ugly for you use a marcro
+#define BITARRAY(type, var, size) type var[size /(sizeof(type) * 8)]
-       unsigned long gpr_input[NUM_GPRS / 32];
+	BITARRAY(unsigned long, gpr_input, NUM_GPRS);

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
