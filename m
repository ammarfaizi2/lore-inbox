Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWG2Bjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWG2Bjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWG2Bjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:39:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:26621 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751275AbWG2Bjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:39:41 -0400
Subject: Re: [patch] i386: switch_to(): misplaced parentheses
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200607251616_MC3-1-C618-C015@compuserve.com>
References: <200607251616_MC3-1-C618-C015@compuserve.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 21:39:11 -0400
Message-Id: <1154137151.19722.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 16:15 -0400, Chuck Ebbert wrote:
> Recent changes in i386 __switch_to() have a misplaced closing
> parenthesis causing an unlikely() to terminate early.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.18-rc2-32.orig/arch/i386/kernel/process.c
> +++ 2.6.18-rc2-32/arch/i386/kernel/process.c
> @@ -690,8 +690,8 @@ struct task_struct fastcall * __switch_t
>  	/*
>  	 * Now maybe handle debug registers and/or IO bitmaps
>  	 */
> -	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> -	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
> +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)))
>  		__switch_to_xtra(next_p, tss);
>  
>  	disable_tsc(prev_p, next_p);

Unlikely's with or's are kind of ambiguous.  An 'and' makes sense but
or's don't.  Because a branch is going to happen anyway.  Just to test
this out, I made a little function and tried out different types of
parenthesis placements.

Here: (the original placement)

	#define unlikely(x) __builtin_expect(!!(x), 0)

	int switch_to(int x, int y)
	{
		int a = 0;
		if (unlikely(x==24) || (y==83))
			a=10;
		return a;
	}


and now yours:

	#define unlikely(x) __builtin_expect(!!(x), 0)

	int switch_to(int x, int y)
	{
		int a = 0;
		if (unlikely(x==24 || y==83))
			a=10;
		return a;
	}

The original gave me this: gcc -O2 -c switch.c

objdump -Dr switch.o

00000000 <switch_to>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 7d 08 18             cmpl   $0x18,0x8(%ebp)
   7:   74 0a                   je     13 <switch_to+0x13>
   9:   31 c0                   xor    %eax,%eax
   b:   83 7d 0c 53             cmpl   $0x53,0xc(%ebp)
   f:   74 02                   je     13 <switch_to+0x13>
  11:   5d                      pop    %ebp
  12:   c3                      ret
  13:   5d                      pop    %ebp
  14:   b8 0a 00 00 00          mov    $0xa,%eax
  19:   c3                      ret


and then yours:  gcc -O2 -c switch_alt.c

objdump -Dr switch_alt.o

00000000 <switch_to>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 7d 08 18             cmpl   $0x18,0x8(%ebp)
   7:   74 0a                   je     13 <switch_to+0x13>
   9:   31 c0                   xor    %eax,%eax
   b:   83 7d 0c 53             cmpl   $0x53,0xc(%ebp)
   f:   74 02                   je     13 <switch_to+0x13>
  11:   5d                      pop    %ebp
  12:   c3                      ret
  13:   5d                      pop    %ebp
  14:   b8 0a 00 00 00          mov    $0xa,%eax
  19:   c3                      ret


They are identical!!!

This is not surprising since you still need to test the other OR case if
it fails, which you are saying it will.  So saying it is unlikely is
meaningless.  Likely's are good for 'or' and unlikely's are good for
'and'.  But not the other way around.

|| and && short circuit when they can.

So the statement of A || B is:

TEST A
JUMP_IF_TRUE true
TEST B
JUMP_IF_FALSE false
true:
 do true statement
JUMP out:
false:
 do else statement
out:

Saying TEST A is likely to fail really doesn't help the situation.
Saying it will likely pass will. Then we could do this:

TEST A
JUMP_IF_FALSE test2
true:
 do true statement
JUMP out:
false:
  do false statement
jump out:
test2:
TEST B
JUMP_IF_TRUE true
JUMP false:
out:

Where here we can move the true after the first compare and prevent the
conditional branch.

So what I'm saying is that unlikely(a || b) has really no good meaning.

Out of curiosity, I removed the unlikely altogether and here's what I
got.

gcc -O2 -c switch_none.c

00000000 <switch_to>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 7d 08 18             cmpl   $0x18,0x8(%ebp)
   7:   74 0a                   je     13 <switch_to+0x13>
   9:   31 c0                   xor    %eax,%eax
   b:   83 7d 0c 53             cmpl   $0x53,0xc(%ebp)
   f:   74 02                   je     13 <switch_to+0x13>
  11:   5d                      pop    %ebp
  12:   c3                      ret
  13:   5d                      pop    %ebp
  14:   b8 0a 00 00 00          mov    $0xa,%eax
  19:   c3                      ret


Ha! still the same.

Is that unlikely there really do any good?

-- Steve

