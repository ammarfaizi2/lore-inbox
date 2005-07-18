Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVGRNjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVGRNjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGRNjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 09:39:15 -0400
Received: from main.gmane.org ([80.91.229.2]:5774 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261715AbVGRNjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 09:39:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Volatile vs Non-Volatile Spin Locks on SMP.
Date: Mon, 18 Jul 2005 09:40:49 -0400
Message-ID: <dbgbb8$sas$1@sea.gmane.org>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl> <20050714051653.GP8907@alpha.home.local> <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl> <BAY108-DAV714C888634D31F28B5A5D93D00@phx.gbl> <dbdk3i$8si$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <dbdk3i$8si$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Seigh wrote:
> For synchronization you need memory barriers in most cases and the only
> way to get these is using assembler since there are no C or gcc intrinsics
> for these yet.  For inline assembler, the convention seems to be to use
> the volatile attribute, which I take as meaning no code movement across
> the inline assembler code.  It if doesn't mean that then a lot of stuff
> is broken AFAICT.
> 

Usenet rule #1.  If you don't find something in the documentation, you
will find it after you post about it.  Volatile does seem to be documented
somewhat in the gcc docs
http://gcc.gnu.org/onlinedocs/gcc-4.0.1/gcc/Extended-Asm.html#Extended-Asm

I was using "memory" in the clobber list as the main thing to keep optimization from
occurring across inline asm.  This seems to say that you also need to say "volatile" to
tell the compiler that you really mean it.

"If your assembler instructions access memory in an unpredictable fashion, add `memory' to the list of clobbered registers. This will cause GCC to not keep memory values cached in registers across the assembler instruction and not optimize stores or loads to that memory. You will also want to add the volatile keyword if the memory affected is not listed in the inputs or outputs of the asm, as the `memory' clobber does not count as a side-effect of the asm. If you know how large the accessed memory is, you can add it as input or output but if this is not known, you should add `memory'."

Also this needs to be looked at, i.e. does "sequence" mean in program order or with no interleaved
C statements.

"Similarly, you can't expect a sequence of volatile asm instructions to remain perfectly consecutive. If you want consecutive output, use a single asm. Also, GCC will perform some optimizations across a volatile asm instruction; GCC does not “forget everything” when it encounters a volatile asm instruction the way some other compilers do."

One of the problems with volatile in C was that the compiler could move code around the volatile
accesses and even accesses to other volatile variables.   This was a problem that Java had and
which they fixed with JSR-133 so you could actually do useful things with volatile in Java.  It's
just worse in C since C has nowhere as useful or clear definitions to work with.  The only
reason you can get away with something like

   do {
     while (lock != 0);
   } while (!testandset(&lock));  // interlocked test and set

is the correctness of the code isn't affected by how the compiler treats
the test for lock != 0 as long as it terminates in a finite amount of time.  Or by the fact
that's not the best way to do a spin wait on hyperthreaded Intel processors.  Intel
recommends you use a PAUSE intstruction in the wait loop.

Anyway it looks like I'll have to do a little more augury on the gcc docs. :)


--
Joe Seigh

