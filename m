Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266402AbTGJTRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbTGJTRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:17:38 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:7858 "HELO
	develer.com") by vger.kernel.org with SMTP id S266402AbTGJTRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:17:33 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Richard Henderson <rth@twiddle.net>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Fix do_div() for all architectures
Date: Thu, 10 Jul 2003 21:31:45 +0200
User-Agent: KMail/1.5.9
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       Ian Molton <spyro@f2s.com>, gcc@gcc.gnu.org
References: <200307060133.15312.bernie@develer.com> <20030710161859.GP16313@dualathlon.random> <20030710163918.GB18697@twiddle.net>
In-Reply-To: <20030710163918.GB18697@twiddle.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307102131.45474.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 18:39, Richard Henderson wrote:

 > On Thu, Jul 10, 2003 at 06:18:59PM +0200, Andrea Arcangeli wrote:
 > > On Thu, Jul 10, 2003 at 08:40:19AM -0700, Richard Henderson wrote:
 > > > On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
 > > > > +extern uint32_t __div64_32(uint64_t *dividend, uint32_t
 > > > > divisor) __attribute_pure__;
 > > >
 > > > ...
 > > >
 > > > > +		__rem = __div64_32(&(n), __base);	\
 > > >
 > > > The pure declaration is very incorrect.  You're writing to N.
 > >
 > > now pure sounds more reasonable, I wondered how could gcc keep track
 > > of the stuff pointed by the parameters (especially if this stuff
 > > points to other stuff etc.. ;).

 The compiler could easily tell what memory can be clobbered by a pointer
by applying type-based aliasing rules. For example, a function taking a
"char *" can't clobber memory objects declared as "long bar" or
"struct foo".

 Without type based alias analysis, the compiler is forced to flush
all registers containing copies of memory objects before function
call and reloading values from memory afterwards.


 > Bernardo mis-interpreted the documentation. [...]

 I'm afraid you're right. Here's a code snippet from gcc/calls.c that
shows what the compiler _really_ does for pure calls:

  /* If the result of a pure or const function call is ignored (or void),
     and none of its arguments are volatile, we can avoid expanding the
     call and just evaluate the arguments for side-effects.  */
  if ((flags & (ECF_CONST | ECF_PURE))
      && (ignore || target == const0_rtx
          || TYPE_MODE (TREE_TYPE (exp)) == VOIDmode))
    {
      bool volatilep = false;
      tree arg;

      for (arg = actparms; arg; arg = TREE_CHAIN (arg))
        if (TREE_THIS_VOLATILE (TREE_VALUE (arg)))
          {
            volatilep = true;
            break;
          }

      if (! volatilep)
        {
          for (arg = actparms; arg; arg = TREE_CHAIN (arg))
            expand_expr (TREE_VALUE (arg), const0_rtx,
                         VOIDmode, EXPAND_NORMAL);
          return const0_rtx;
        }
    }


Therefore this optimization is to be undone. Would it work if
we could use references instead of pointers? I think it
wouldn't. A new attribute would be needed for this case.

Just to open some interesting speculation, do you think we'd
get better code by just getting rid of __attribute__((pure))
or by changing __do_div64() to do something like this?

 typedef struct { uint64_t quot, uint32_t rem } __quotrem64;
 __quotrem64 __do_div64(uint64_t div, uint32_t base) __attribute__((const));

 #define do_div(n,base) ({                                        \
        uint32_t __base = (base);                                 \
        uint32_t __rem;                                           \
        if (likely(((n) >> 32) == 0)) {                           \
                __rem = (uint32_t)(n) % __base;                   \
                (n) = (uint32_t)(n) / __base;                     \
        } else {                                                  \
                __quotrem64 __qr = __div64_32((n), __base);       \
                (n) = __qr.quot;                                  \
                __rem = __qr.rem;                                 \
        }                                                         \
        __rem;                                                    \
 })

Boy, that's ugly! It's too bad C can't do it the Perl way:

    (n,rem) = __div64_32(n, base);

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


