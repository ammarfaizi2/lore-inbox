Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTAPFn5>; Thu, 16 Jan 2003 00:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTAPFn5>; Thu, 16 Jan 2003 00:43:57 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:41926 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP
	id <S267034AbTAPFny>; Thu, 16 Jan 2003 00:43:54 -0500
Message-ID: <3E2648C8.4080507@aarnet.edu.au>
Date: Thu, 16 Jan 2003 16:23:12 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-au, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault
References: <200301150929.h0F9T1I10444@duna48.eth.ericsson.se> <20030115122324.GC32694@codemonkey.org.uk>
In-Reply-To: <20030115122324.GC32694@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -102.3 IN_REP_TO,DOUBLE_CAPSWORD,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Jan 15, 2003 at 10:29:01AM +0100, Miklos Szeredi wrote:
>  > 
>  > I just bought a VIA C3 866 processor, and under very special
>  > circumstances some programs (e.g. mplayer, xmms) randomly crash with
>  > trace/breakpoint trap or segmentation fault.  Otherwise the system
>  > seems stable even under high load.
> 
> Be sure that those programs aren't compiled for 686. The C3 lacks
> cmov, so it'll segfault when it hits that opcode. You can confirm
> this by running it under gdb, and disassembling where it segv's to.
> This is still a common problem thats biting some people. The debian
> folks had a broken libssl for months up until recently.
> 
> Note to userspace developers: If you're compiling something as
> a 686 binary, you *NEED* to check the feature flags (in an i386
> compiled program) to see if the CPU has cmov before you load 686
> optimised parts of your app.  This is *NOT* a kernel problem,
> it is *NOT* a CPU bug. The cmov extension is optional.
> VIA chose to save silicon space by not implementing it. 
> Gcc unfortunatly always uses cmov when compiling for 686.

Why not use a CMOV in a i686-specific crt0.c?

Then programs compiled for i686 but run on i586 will SIGILL
deterministically at program start-up.  It seems to me that
the major problem with SIGILL is that it occurs depending
upon the program execution flow, and thus appears indeterministic
to the user.

This doesn't solve the problem of a i386 executable calling
a i686 library, but solving that problem deterministically
requires a lot of baggage:

   - compiler to produce an object file header stating CPU
     features used.

   - run time linker to take union of all CPU features in
     object file headers and check against CPU features
     returned by CPUID.

Even this isn't perfect, consider multi-processor machines
with differing CPU feature sets or applications which attempt
to implement their own run-time checking:

    get_cpu_features(&feature);
    if (feature.cmov && feature.somethingelse && ...)
        mytask_i686();
    else
        mytask_i386();

This leads inevitably more flags in the object file header
to instruct the run-time linker to skip particular CPU feature
checks

   gcc -c -mdisable_cpu_feature_check=cmov -o mytask.o mytask.c

SIGILL starts to look lightweight :-)

-- 
  Glen Turner                (08) 8303 3936 or +61 8 8303 3936
  Australian Academic and Research Network   www.aarnet.edu.au

