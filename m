Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbTCNGQL>; Fri, 14 Mar 2003 01:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbTCNGQL>; Fri, 14 Mar 2003 01:16:11 -0500
Received: from mail.coastside.net ([207.213.212.6]:1243 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S263249AbTCNGQK>; Fri, 14 Mar 2003 01:16:10 -0500
Mime-Version: 1.0
Message-Id: <p05210502ba97239e44cf@[207.213.214.37]>
In-Reply-To: <33130.4.64.238.61.1047616146.squirrel@www.osdl.org>
References: <Pine.LNX.4.44.0303131522390.23207-100000@home.transmeta.com> 
       <p05210514ba96db3fb9e9@[10.2.0.101]>
 <33130.4.64.238.61.1047616146.squirrel@www.osdl.org>
Date: Thu, 13 Mar 2003 22:26:39 -0800
To: "Randy.Dunlap" <rddunlap@osdl.org>
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Cc: <torvalds@transmeta.com>, <vonbrand@inf.utfsm.cl>,
       <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:29pm -0800 3/13/03, Randy.Dunlap wrote:
>  > If you've got a symbol some reasonable distance before EIP, you could
>>  decode from there. I wrote a little code that does that (using
>>  kallsyms) very crudely in the stack trace in order to give the reader  a
>>  hint about stack frames. Go to the prior symbol, which is usually  an entry
>>  point, and find the %esp arithmetic. Works pretty well for  figuring out the
>>  real call chain.
>
>as long as it's not a data symbol...
>can you determine that?

Sometimes/mostly, and btw my code is i386-only. The trace is question 
is arch/i386/kernel/traps.c:show_trace(). It already makes the test 
kernel_text_address(), which works in the kernel, but not for modules 
(at least in the kernel I'm using: 2.4.9 (don't ask)).

For addresses in the trace (as opposed to the trapped EIP), I look 
for a call instruction preceding the putative return address. That's 
backwards assembly, but since there are relatively few possibilities, 
it seems to work fairly well.

So finding a call is a good clue that we're looking at text. Look 
back from the call for argument pushes (I stop at the first non-push, 
because of the backwards-disassembly problem), then go to the 
previous symbol and scan forward for pushes and subtracts from %esp. 
The sum of all those, plus four bytes for the return link, gives me a 
lower limit on frame size. It's not perfect; a real disassembly 
forward from the symbol would maybe be better, but that seems like 
overkill (what to do with branches, etc).

The idea isn't to be perfect anyway, but to give me hints for 
manually reconstructing the call chain. Way better than nothing.

But for your purposes, disassembling from the previous symbol gives 
you a code dump, and you know that EIP had better be pointing to text.
-- 
/Jonathan Lundell.
