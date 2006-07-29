Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWG2CIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWG2CIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWG2CIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:08:51 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34293 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161156AbWG2CIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:08:50 -0400
Subject: Re: [patch] i386: switch_to(): misplaced parentheses
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1154137151.19722.63.camel@localhost.localdomain>
References: <200607251616_MC3-1-C618-C015@compuserve.com>
	 <1154137151.19722.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 22:08:45 -0400
Message-Id: <1154138925.19722.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:39 -0400, Steven Rostedt wrote:

> 
> Unlikely's with or's are kind of ambiguous.  An 'and' makes sense but
> or's don't.  Because a branch is going to happen anyway.  Just to test
> this out, I made a little function and tried out different types of
> parenthesis placements.

OK, I take this back. Thinking that it might make a difference to the
second compare, I added a little more to my test program:

---
#define unlikely(x) __builtin_expect(!!(x), 0)

int do_func(void);
int a;

int switch_to(int x, int y)
{
        a = 2;
        if (unlikely(x==24 || y==83))
                a=10;
        do_func();
        return a;
}
---


This way I now have a global 'a' and a function that just might use that
'a'.  So this does make a difference:  Kind of funky though. It wastes
space to make it avoid branching when we don't have your total unlikely
(see below):

The above gave:

00000000 <switch_to>:
   0:   55                      push   %ebp
   1:   ba 02 00 00 00          mov    $0x2,%edx
   6:   89 e5                   mov    %esp,%ebp
   8:   83 ec 08                sub    $0x8,%esp
   b:   83 7d 08 18             cmpl   $0x18,0x8(%ebp)
   f:   89 15 00 00 00 00       mov    %edx,0x0
                        11: R_386_32    a
  15:   74 12                   je     29 <switch_to+0x29>
  17:   83 7d 0c 53             cmpl   $0x53,0xc(%ebp)
  1b:   74 0c                   je     29 <switch_to+0x29>
  1d:   e8 fc ff ff ff          call   1e <switch_to+0x1e>
                        1e: R_386_PC32  do_func
  22:   a1 00 00 00 00          mov    0x0,%eax
                        23: R_386_32    a
  27:   c9                      leave
  28:   c3                      ret
  29:   b8 0a 00 00 00          mov    $0xa,%eax
  2e:   a3 00 00 00 00          mov    %eax,0x0
                        2f: R_386_32    a
  33:   eb e8                   jmp    1d <switch_to+0x1d>


Which looks the best, so your patch may be good after all :-)

The other tests looked pretty much the same:

  Between (unlikely(x==24) || (y==83)) and
      ((x==24) || unlikely(y==83)) and
      (x==24 || y==83)

which was this: (done with the unlikely(y==83))

00000000 <switch_to>:
   0:   55                      push   %ebp
   1:   ba 02 00 00 00          mov    $0x2,%edx
   6:   89 e5                   mov    %esp,%ebp
   8:   83 ec 08                sub    $0x8,%esp
   b:   83 7d 08 18             cmpl   $0x18,0x8(%ebp)
   f:   89 15 00 00 00 00       mov    %edx,0x0
                        11: R_386_32    a
  15:   74 19                   je     30 <switch_to+0x30>
  17:   83 7d 0c 53             cmpl   $0x53,0xc(%ebp)
  1b:   74 13                   je     30 <switch_to+0x30>
  1d:   e8 fc ff ff ff          call   1e <switch_to+0x1e>
                        1e: R_386_PC32  do_func
  22:   a1 00 00 00 00          mov    0x0,%eax
                        23: R_386_32    a
  27:   c9                      leave
  28:   c3                      ret
  29:   8d b4 26 00 00 00 00    lea    0x0(%esi),%esi
  30:   b8 0a 00 00 00          mov    $0xa,%eax
  35:   a3 00 00 00 00          mov    %eax,0x0
                        36: R_386_32    a
  3a:   e8 fc ff ff ff          call   3b <switch_to+0x3b>
                        3b: R_386_PC32  do_func
  3f:   a1 00 00 00 00          mov    0x0,%eax
                        40: R_386_32    a
  44:   c9                      leave
  45:   c3                      ret


So the big savings isn't the branching, but the entire branch is
expected to fail, so it doesn't bother with the duplicate code to speed
things up (see the two do_func calls).  So your patch really just saves
space, and not really speed (but you can argue that this space savings
increases speed by not wasting cache).

So I do give credence to your patch.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve



