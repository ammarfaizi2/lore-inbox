Return-Path: <linux-kernel-owner+w=401wt.eu-S933033AbWLSWER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbWLSWER (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932990AbWLSWER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:04:17 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37875 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933033AbWLSWEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:04:16 -0500
Date: Tue, 19 Dec 2006 23:01:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Rientjes <rientjes@cs.washington.edu>
cc: Bob Copeland <me@bobcopeland.com>, Dave Jones <davej@redhat.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <Pine.LNX.4.64N.0612191311590.24901@attu4.cs.washington.edu>
Message-ID: <Pine.LNX.4.61.0612192240460.26276@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
 <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
 <Pine.LNX.4.64N.0612191311590.24901@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19 2006 13:24, David Rientjes wrote:
>On Tue, 19 Dec 2006, Jan Engelhardt wrote:
>
>> > I don't know if anyone cares about them anymore, since I think gcc
>> > grew some smarts in the area recently, but there are a lot of lines of
>> > code matching "static int.*= *0;" and equivalents in the driver tree.
>> 
>> I'd really like to see the C compiler being enhanced to detect
>> "stupid casts", i.e. those, which when removed, do not change (a) the outcome
>> (b) the compiler warnings/error output.
>
>If your desire is for the compiler warnings output to be unchanged, I'm 

Oh well maybe I suck at writing exact definitions in one-phrase phrases.
Anyway, what was intended:


(1) Catch casts where they are usually not necessary, because the value
    would be anyhow discarded

    (void)strcpy(b, a);

    (Does not apply to e.g. cmpxchg -- that's why I mentioned (b)!)


(2) Catch casts which do not change the type of an expression, e.g.

    void *x = (void *)kmalloc(...)


(3) Catch casts which do not change the outcome, because from-to-void* is
    warningless

    struct foo *bar = (struct foo *)kmalloc(...)

    Quite often seen in kernel code.


(4) extension and truncation, implicit conversions - unneessary casts

    func_taking_u32( (u32)some_u16 );
    func_taking_u16( (u16)some_u32 );


(5) Slightly harder one: Where the evaluation process changes, but the
    outcome is the same

    #define V_FL_BASE_HI(x)  ((x) << 8)
    #define V_FL_INDEX_LO(x) (x)
    #define M_FL_INDEX_LO    0xFF

    static void t3_write_reg(struct adapter *, u32, u32);

    int t3_sge_init_flcntxt(struct adapter *adapter, unsigned int id,
                        int gts_enable, u64 base_addr, unsigned int size,
                        unsigned int bsize, unsigned int cong_thres, int gen,
                        unsigned int cidx)
    {
        t3_write_reg(adapter, A_SG_CONTEXT_DATA1,
                     V_FL_BASE_HI((u32) base_addr) |
                     V_FL_INDEX_LO(cidx & M_FL_INDEX_LO));
    }

    (Note that this is not exactly code found in the cxgb3 driver, but
    tweaked for this example)

    As far as I can see, even if base_addr was not truncated to u32, the end
    result would be, when the u64 value is passed to t3_write_reg.



>not sure how you'd enhance the compiler from detecting these casts.  All 
>of the casts that have been removed in these cleanup patches do not change 
>the assembly when using gcc; they simply reduce the amount of visual noise 
>in the source code.
>
>This is also true in terms of global static variables being initialized to 
>0 (or NULL).  While it is indeed unnecessary by the standard, it simply 
>moves the initialization from one segment of the assembly to the other, 
>regardless of how many different functions it is referenced in.  gcc does 
>not emit movl $0, var for these cases.
>
>It _would_ be helpful to add a macro such as:
>
>	#define	SILENCE_GCC(x)	= x
>
>to eliminate warnings such that:
>
>	auto int a SILENCE_GCC(a);
>	fill_a(&a);
>	if (a)
>		...
>
>would not produce a "may be used uninitialized" warning.

__attribute__((used)) would be more appropriate, I think.


	-`J'
-- 
