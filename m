Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTEaInO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264232AbTEaInO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:43:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38412 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264231AbTEaInN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:43:13 -0400
Date: Sat, 31 May 2003 10:56:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, scrosby@cs.rice.edu, alexander.riesen@synopsys.COM,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030531085612.GE21673@alpha.home.local>
References: <oydd6i04gq8.fsf@bert.cs.rice.edu> <20030530.231813.59666274.davem@redhat.com> <20030531080205.GA776@pcw.home.local> <20030531.011210.34750891.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531.011210.34750891.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 01:12:10AM -0700, David S. Miller wrote:
>    From: Willy TARREAU <willy@w.ods.org>
>    Date: Sat, 31 May 2003 10:02:05 +0200
> 
>    With this simple change, jhash_mix is *exactly* three times faster
>    for me on athlon-xp, whatever gcc I use (2.95.3 or 3.2.3), on the
>    following do_hash() function, and about 40% faster when used on
>    local variables.
> 
> Interesting :-)

Not that much finally, because I cannot reproduce the slowdown I initially
observed with the original function on local variables. I think I may have
had a wrong type somewhere or a particular operation which prevented gcc
from fully optimizing the macro :-/

So at the moment, both the original and my version are the same speed on
local variables on athlon-xp.

BTW, I don't understand why, but I've just noticed that the Alpha is 25%
slower on my version when used on local variables !

So my version is only interesting when working on indirect variables, which
is never the case in the kernel... Never mind, that was just a try.

For info, here's what I measure here on the original version :

 - athlon-xp : 24 cycles, whatever -march/-mcpu
 - alpha ev6 : -mcpu=ev5       : 22 cycles
               -mcpu=ev6       : 24 cycles
 - sparc64   : default         : 26 cycles
               -mcpu=v9        : 24 cycles
               -mcpu=ultrasparc: 19 cycles (18 cycles for my version here)

Considering that the Alpha and the UltraSparc can issue up to 4 instruction
per cycle, I wonder whether it would be worse trying to implement such a hash
in assembler, optimized for each processor, with a default fall-back to the
C function for archs that have not been implemented.

Cheers,
Willy

