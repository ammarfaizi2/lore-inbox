Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbUJ2T5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUJ2T5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbUJ2Tyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:54:49 -0400
Received: from hermes.domdv.de ([193.102.202.1]:6925 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S263477AbUJ2TkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:40:07 -0400
Message-ID: <41829C91.5030709@domdv.de>
Date: Fri, 29 Oct 2004 21:40:01 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>  <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com>  <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de> <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com> <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de> <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 29 Oct 2004, Andreas Steinmetz wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>>Somebody should check what the Pentium M does. It might just notice that 
>>>"lea 4(%esp),%esp" is the same as "add 4 to esp", but it's entirely 
>>>possible that lea will confuse its stack engine logic and cause 
>>>stack-related address generation stalls..
>>
>>Now especially Intel tells everybody in their Pentium Optimization 
>>manuals to *use* lea whereever possible as this operation doesn't depend 
>>on the ALU and is processed in other parts of the CPU.
>>
>>Sample quote from said manual (P/N 248966-05):
>>"Use the lea instruction and the full range of addressing modes to do 
>>address calculation"
> 
> 
> Does it say this about %esp?
> 
> The stack pointer is SPECIAL, guys. It's special exactly because there is
> potentially extra hardware in CPU's that track its value _independently_
> of the actual physical register.

It doesn't say anything about esp being specially treated by the 
underlying hardware as far as I can see. Thus either you know details 
about the cpu not being publically available or you're speculating about 
  undocumented features.

Some more data from said manual (lea is better on P3 and the same as add 
on P4):

Instruction	Latency		Execution Unit
ADD/SUB:	0.5		ALU
POP		1.5		MEM_LOAD,ALU

Now, a P4 had two ALUs (Ports 0 and 1) but only one MEM_LOAD Unit (Port 
2). So after all you will be stalled more likely by an additional pop 
instruction than by lea/add. I don't know about P4 internals but let me 
make some guess: There's lot of software around that needs to run on 
older processors where lea has quite some performance advantage. Thus I 
would guess that the P4 design respects this by handling lea x(esp),esp 
efficiently.

If you still believe in features I can't find any manufacturer 
documentation for, well, you're Linus so it's your decision.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
