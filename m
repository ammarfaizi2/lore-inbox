Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUFYOz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUFYOz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUFYOz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:55:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:23493 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S266752AbUFYOzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:55:37 -0400
Subject: Re: gcc-3.4.1 and -Winline
From: John Cherry <cherry@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040624234455.GA4058@werewolf.able.es>
References: <20040624234455.GA4058@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1088175248.4344.6.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 25 Jun 2004 07:54:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> This are the warnings I get with gcc-3.4.1 CVS, when building
2.6.7-mm2.
> Just for if some is really serious, ie, something that does not work
if
> compiled out-of-line (but I suppose I had noticed ;) ).
> Or if it origins a huge performace penalty.
[...]
> 
>   CC      arch/i386/kernel/timers/timer_tsc.o
> arch/i386/kernel/timers/timer_tsc.c: In function `mark_offset_tsc':
> arch/i386/kernel/timers/timer_tsc.c:30: warning: inlining failed in
call to \
> 'cpufreq_delayed_get': function body not available \
> arch/i386/kernel/timers/timer_tsc.c:248: warning: called from here
[... more warnings deleted for brevity ...]

Well, gcc 3.2.2 with -Winline does not complain, but interestingly 
enough sparse does (at least in the above case and some others):

  CHECK   arch/i386/kernel/timers/timer_tsc.c
arch/i386/kernel/timers/timer_tsc.c:30:39: warning: marked inline, but without a definition

Basically this is a case of having:
        #1:     static inline void foo(void); /* forward decl without body */
        ...
        #2:     void bar(void) { foo(); } /* function using the inline */
        ...
        #3:     static inline void foo(void) { return; } /* actual inline def. */
in the above order.

I have not looked at resulting .o file with gcc 3.2.2, but would not be too
surprised if it also silently just ignores the "inline" in lines #1 and #3 above.

There are obviously two trivial fixes above, either just remove the inline (making
foo a normal static function) or reorder #2 and #3.

John


