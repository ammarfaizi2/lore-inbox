Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWFCSJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWFCSJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWFCSJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 14:09:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:714 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751767AbWFCSJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 14:09:40 -0400
Subject: Re: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <1149010697.8104.11.camel@localhost.localdomain>
References: <20060529212109.GA2058@elte.hu> <20060529212328.GE3155@elte.hu>
	 <20060529183321.6c1a3cba.akpm@osdl.org>
	 <1149010697.8104.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 14:09:17 -0400
Message-Id: <1149358157.13993.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 13:38 -0400, Steven Rostedt wrote:
> On Mon, 2006-05-29 at 18:33 -0700, Andrew Morton wrote:
> > On Mon, 29 May 2006 23:23:28 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > add WARN_ON_ONCE(cond) to print once-per-bootup messages.
> > > 
> > > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > > ---
> > >  include/asm-generic/bug.h |   13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > Index: linux/include/asm-generic/bug.h
> > > ===================================================================
> > > --- linux.orig/include/asm-generic/bug.h
> > > +++ linux/include/asm-generic/bug.h
> > > @@ -44,4 +44,17 @@
> > >  # define WARN_ON_SMP(x)			do { } while (0)
> > >  #endif
> > >  
> > > +#define WARN_ON_ONCE(condition)				\
> > > +({							\
> > > +	static int __warn_once = 1;			\
> > > +	int __ret = 0;					\
> > > +							\
> > > +	if (unlikely(__warn_once && (condition))) {	\
> 
> Since __warn_once is likely to be true, and the condition is likely to
> be false, wouldn't it be better to switch this around to:
> 
>   if (unlikely((condition) && __warn_once)) {
> 
> So the && will fall out before having to check a global variable.
> 
> Only after the unlikely condition would the __warn_once be false.

Hi Ingo,

Not sure if you missed this request or didn't think it mattered.  But I
just tried out the difference between the two to see what gcc would do
to a simple function compiling with -O2.

Here's my code:

----- with the current WARN_ON_ONCE ----

#define unlikely(x) __builtin_expect(!!(x), 0)

#define WARN_ON_ONCE(condition)                         \
({                                                      \
        static int __warn_once = 1;                     \
        int __ret = 0;                                  \
                                                        \
        if (__warn_once && unlikely((condition))) {     \
                __warn_once = 0;                        \
                WARN_ON(1);                             \
                __ret = 1;                              \
        }                                               \
        __ret;                                          \
})

int warn (int x)
{
        WARN_ON_ONCE(x==1);
        return x+1;
}


----- with the version I suggest. ----

#define unlikely(x) __builtin_expect(!!(x), 0)

#define WARN_ON_ONCE(condition)                         \
({                                                      \
        static int __warn_once = 1;                     \
        int __ret = 0;                                  \
                                                        \
        if (unlikely((condition)) && __warn_once) {     \
                __warn_once = 0;                        \
                WARN_ON(1);                             \
                __ret = 1;                              \
        }                                               \
        __ret;                                          \
})

int warn(int x)
{
        WARN_ON_ONCE(x==1);
        return x+1;
}

-------


Compiling these two I get this:


current warn.o:

00000000 <warn>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   53                      push   %ebx
   4:   83 ec 04                sub    $0x4,%esp
   7:   a1 00 00 00 00          mov    0x0,%eax
   c:   8b 5d 08                mov    0x8(%ebp),%ebx

# here we test the __warn_once first and if it is not zero
# it jumps to warn+0x20 to do the condition test
   f:   85 c0                   test   %eax,%eax
  11:   75 0d                   jne    20 <warn+0x20>
  13:   5a                      pop    %edx
  14:   8d 43 01                lea    0x1(%ebx),%eax
  17:   5b                      pop    %ebx
  18:   5d                      pop    %ebp
  19:   c3                      ret
  1a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
  20:   83 fb 01                cmp    $0x1,%ebx
  23:   75 ee                   jne    13 <warn+0x13>
  25:   31 c9                   xor    %ecx,%ecx
  27:   89 0d 00 00 00 00       mov    %ecx,0x0
  2d:   c7 04 24 01 00 00 00    movl   $0x1,(%esp)
  34:   e8 fc ff ff ff          call   35 <warn+0x35>
  39:   eb d8                   jmp    13 <warn+0x13>
Disassembly of section .data:


My suggested change of doing the condition first:

00000000 <warn>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   53                      push   %ebx
   4:   83 ec 04                sub    $0x4,%esp
   7:   8b 5d 08                mov    0x8(%ebp),%ebx

# here we test the condition first, and if it the
# unlikely condition is true, then we jump to test
# the __warn_once.
   a:   83 fb 01                cmp    $0x1,%ebx
   d:   74 07                   je     16 <warn+0x16>
   f:   5a                      pop    %edx
  10:   8d 43 01                lea    0x1(%ebx),%eax
  13:   5b                      pop    %ebx
  14:   5d                      pop    %ebp
  15:   c3                      ret
  16:   a1 00 00 00 00          mov    0x0,%eax
  1b:   85 c0                   test   %eax,%eax
  1d:   74 f0                   je     f <warn+0xf>
  1f:   31 c9                   xor    %ecx,%ecx
  21:   89 0d 00 00 00 00       mov    %ecx,0x0
  27:   c7 04 24 01 00 00 00    movl   $0x1,(%esp)
  2e:   e8 fc ff ff ff          call   2f <warn+0x2f>
  33:   eb da                   jmp    f <warn+0xf>
Disassembly of section .data:


As you can see, because the whole thing is unlikely, the first condition
is expected to fail.  With the current WARN_ON logic, that means that
the __warn_once is expected to fail, but that's not the case.  So on a
normal system where the WARN_ON_ONCE condition would never happen, you
are always branching.   So simply reversing the order to test the
condition before testing the __warn_once variable should improve cache
performance.

Below is my recommended patch.

-- Steve

Index: linux-2.6.17-rc5-mm2/include/asm-generic/bug.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/include/asm-generic/bug.h	2006-06-03 14:01:22.000000000 -0400
+++ linux-2.6.17-rc5-mm2/include/asm-generic/bug.h	2006-06-03 14:01:50.000000000 -0400
@@ -43,7 +43,7 @@
 	static int __warn_once = 1;			\
 	int __ret = 0;					\
 							\
-	if (unlikely(__warn_once && (condition))) {	\
+	if (unlikely((condition) && __warn_once)) {	\
 		__warn_once = 0;			\
 		WARN_ON(1);				\
 		__ret = 1;				\


