Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDESWs (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDESWs (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:22:48 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36613 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261805AbTDESWr (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 13:22:47 -0500
Date: Sat, 5 Apr 2003 20:34:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
Message-ID: <20030405183418.GA554@alpha.home.local>
References: <8765pshpd4.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765pshpd4.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Sat, Apr 05, 2003 at 06:37:43PM +0200, Florian Weimer wrote:
> Please read the following paper:
> 
> <http://www.cs.rice.edu/~scrosby/tr/HashAttack.pdf>

very interesting article.

> Then look at the 2.4 route cache implementation.

Since we need commutative source/dest addresses in many places, the use of a
XOR is a common practice. In fact, while working on hash tables a while ago, I
found that I could get very good results with something such as :

   RND1 = random_generated_at_start_time() ;
   RND2 = random_generated_at_start_time() ;
   /* RND2 may be 0 or equal to RND1, all cases seem OK */
   x = (RND1 - saddr) ^ (RND1 - daddr) ^ (RND2 + saddr + daddr);
   reduce(x) ...

With this method, I found no way to guess a predictable (saddr, daddr) couple
which gives a same result, and saddr/daddr are still commutative. It resists
common cases where saddr=daddr, saddr=~daddr, saddr=-daddr. And *I think* tha
the random makes other cases difficult to predict. I'm not specialized in
crypto or whatever, so I cannot tell how to generate the best RND1/2, and it's
obvious to me that stupid values like 0 or -1 may not help a lot, but this is
still better than a trivial saddr ^ daddr, at a very low cost.
For example, the x86 encoding of the simple XOR hash would result in :
  mov saddr, %eax
  xor daddr, %eax
 => 2 cycles with result in %eax

The new calculation will look like :
  mov saddr, %ebx
  mov daddr, %ecx

  lea (%ebx,%ecx,1), %eax
  neg %ecx

  add RND2, %eax		// can be omitted if zero
  add RND1, %ecx

  neg %ebx
  xor %ecx, %eax

  add RND1, %ebx
  xor %ebx, %eax
  
=> 5 cycles on dual-pipelines CPUs, result in eax, but uses 2 more regs.

Any comments ?

Regards,
Willy

