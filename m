Return-Path: <linux-kernel-owner+w=401wt.eu-S933024AbWLSXJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbWLSXJu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933058AbWLSXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:09:48 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:45275 "EHLO
	mx1.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933024AbWLSXJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:09:47 -0500
Date: Tue, 19 Dec 2006 15:09:32 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Bob Copeland <me@bobcopeland.com>, Dave Jones <davej@redhat.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <Pine.LNX.4.61.0612192240460.26276@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64N.0612191421550.27780@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
 <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
 <Pine.LNX.4.64N.0612191311590.24901@attu4.cs.washington.edu>
 <Pine.LNX.4.61.0612192240460.26276@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, Jan Engelhardt wrote:

> (1) Catch casts where they are usually not necessary, because the value
>     would be anyhow discarded
> 
>     (void)strcpy(b, a);
> 
>     (Does not apply to e.g. cmpxchg -- that's why I mentioned (b)!)
> 

Actually, there's a number of people out there who would like 
(void)strcpy(b, a) or even (void)printf(...) to be required, but the gcc 
manual addresses that point directly:

	10.10 Certain Changes We Don't Want to Make

	- Warning when a non-void function value is ignored

	  C contains many standard functions that return a value that
	  most programs choose to ignore.  One obvious example is printf.
	  Warning about this practice only leads the defensive programmer
	  to clutter programs with dozens of casts to void.  Such casts
	  are required so frequently that they become visual noise.
	  Writing these casts becomes so automatic that they no longer
	  convey useful information about the intentions of the
	  programmer.  For functions where the return value should never
	  be ignored, use the warn_unused_result function attribute.

So there _is_ a way to manipulate the warning behavior of gcc for this 
point.

> (2) Catch casts which do not change the type of an expression, e.g.
> 
>     void *x = (void *)kmalloc(...)
> 

And do what with it?  It's a no-op.  And when there's tokens such as this 
in source code that become no-ops on compile, it serves as an annotation 
to the code reader that kmalloc returns void*.

> (3) Catch casts which do not change the outcome, because from-to-void* is
>     warningless
> 
>     struct foo *bar = (struct foo *)kmalloc(...)
> 

So you would favor some sort of gcc warning such as "unnecessary cast" 
when this is compiled?  If so, then there's a _tons_ of other warnings you 
could generate when something exists in source code that does nothing.  
Should we warn on every lone semi-colon that appears or every empty {} 
block?

	int var = (int)(int)(int)13;

is compiled _exactly_ the same as:

	int var = 13;

> (4) extension and truncation, implicit conversions - unneessary casts
> 
>     func_taking_u32( (u32)some_u16 );
>     func_taking_u16( (u16)some_u32 );
> 

Again, these would be no-ops so the casts here actually don't do anything 
and serve as _annotation_ for the code reader since functions aren't 
typically named func_taking_u16.  The compiler knows that the function 
takes a u16 and can truncate the actual, but it serves to remind the 
programmer that this value can be truncated later.

	truncate(char ret)
	{
		return (int)ret;
	}

	main()
	{
		int var = 256;
		int ret = test(var);
		return ret;
	}

This compiles without warning.  So if there _was_ an "annotation" such as

	int ret = test((char)var);

then the programmer is going to catch the bug much easier especially when 
he doesn't check the API of the interface he's using first.

> (5) Slightly harder one: Where the evaluation process changes, but the
>     outcome is the same
> 
>     #define V_FL_BASE_HI(x)  ((x) << 8)
>     #define V_FL_INDEX_LO(x) (x)
>     #define M_FL_INDEX_LO    0xFF
> 
>     static void t3_write_reg(struct adapter *, u32, u32);
> 
>     int t3_sge_init_flcntxt(struct adapter *adapter, unsigned int id,
>                         int gts_enable, u64 base_addr, unsigned int size,
>                         unsigned int bsize, unsigned int cong_thres, int gen,
>                         unsigned int cidx)
>     {
>         t3_write_reg(adapter, A_SG_CONTEXT_DATA1,
>                      V_FL_BASE_HI((u32) base_addr) |
>                      V_FL_INDEX_LO(cidx & M_FL_INDEX_LO));
>     }
> 
>     (Note that this is not exactly code found in the cxgb3 driver, but
>     tweaked for this example)
> 
>     As far as I can see, even if base_addr was not truncated to u32, the end
>     result would be, when the u64 value is passed to t3_write_reg.
> 

You would get the same result regardless of whether the cast was there or 
not.  But, again, the u32 "cast" appears only as annotation so the 
programmer is aware that the upper 32-bits of base_addr are going to be 
discarded.

This is precisely why these lines emit the exact same assembly:

	auto int var = (int)(char)256;
	auto int var = (char)256;

Now, if you wrote:

	auto char var = 256;

Then this would emit a warning because the programmer did not explictly 
recognize 256 as overflow for a char.

> __attribute__((used)) would be more appropriate, I think.
> 

As far as I know, you can't use this on automatic variables and 
-Wuninitialized will still emit the warning message.  It's great for the 
static case.

		David
