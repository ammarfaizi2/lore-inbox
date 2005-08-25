Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVHYWss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVHYWss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVHYWss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:48:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37831 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964990AbVHYWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:48:48 -0400
Date: Thu, 25 Aug 2005 23:51:52 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>, Paul Jackson <pj@sgi.com>,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825225152.GZ9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru> <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk> <20050825072731.GA876@mipter.zuzino.mipt.ru> <20050825190755.GV9322@parcelfarce.linux.theplanet.co.uk> <20050825221649.GA31305@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825221649.GA31305@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 03:16:49PM -0700, Richard Henderson wrote:
> On Thu, Aug 25, 2005 at 08:07:55PM +0100, Al Viro wrote:
> > IMO that's a question to rth: why do we really need to block always_inline
> > on alpha?
> 
> Because I use "extern inline" in the proper way.  That is, I have both
> inline and out-of-line versions of some routines.  These routines have
> their address taken to be put into the alpha_machine_vector structures,
> so we're guaranteed that they'll be out-of-line at least once.
> 
> But if you define inline to always_inline, the compiler complains when
> its forced to fall back to the out-of-line copy.  And rightly so -- the
> feature was INVENTED for using compiler intrinsics that would in fact
> not produce valid assembly unless certain parameters are constants.
> 
> I've complained about this before.  You always-inline savages have 
> obsconded with ALL THREE inline keywords -- "inline", "__inline" and
> "__inline__" -- so there is in fact no way to accomplish what I want.
> 
> So in a fit of pique I've locally undone not just one, but all of the
> always-inline crap.
> 
> All that said, something's wrong if we couldn't generate an out-of-line
> copy of kmalloc.  The entire block protected by __builtin_constant_p
> should have been eliminated.  File a gcc bugzilla report.  

It is eliminated.  As the result, the compile-time checks disappear.
In this case it's more or less harmless - we miss some bugs that could
be caught at compile time, but that's it.  In case of e.g. xchg() (same
technics of calling undefined function in the code that gets eliminated
if everything's right) it gave genuine bugs - gcc decided to create an
uninlined copy and to hell it went:

static inline unsigned long
__xchg(volatile void *ptr, unsigned long x, int size)
{
        switch (size) {
                case 1:
                        return __xchg_u8(ptr, x);
                case 2:
                        return __xchg_u16(ptr, x);
                case 4:
                        return __xchg_u32(ptr, x);
                case 8:
                        return __xchg_u64(ptr, x);
        }
        __xchg_called_with_bad_pointer();
        return x;
}
#define xchg(ptr,x)                                                          \
  ({                                                                         \
     __typeof__(*(ptr)) _x_ = (x);                                           \
     (__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr))); \
  })

blows to hell, since we have no way to tell gcc that it should _never_
be done non-inlined.  Well, no way short of making __xchg a macro...

So what do you propose to use for that class of compile-time checks?
#define whenever they are used?
