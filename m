Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWDBTbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWDBTbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWDBTbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:31:09 -0400
Received: from smtpout.mac.com ([17.250.248.72]:53743 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751492AbWDBTbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:31:08 -0400
In-Reply-To: <20060402175859.GA9839@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060402175859.GA9839@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E3BAA12-E97A-410A-8CD1-837EE7F82DFE@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 2 Apr 2006 15:30:44 -0400
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 2, 2006, at 13:58:59, Sam Ravnborg wrote:
> Hi Kyle.
> Been watching this thread evolve for a while - and contributed a  
> little myself.  But I fail to find a rationale for the selected  
> approach.
>
> 1) Go through current set of headers and sanitize them - using  
> __KERNEL__ to identify kernel only stuff.

I'm working on this right now as step one.  I see two big problems  
with this approach.  Primarily it leaves no distinction or  
documentation for future maintenance; the sanitization doesn't last  
long at all, as we've seen by trying this approach in the past.

> 2) Keep user space interface (KABI in your term?) in include/ and  
> slowly move kernel specific definitions somewhere else.  This has  
> the great advantage to keep backward compaitibility.

The big problem with this approach is it starts off with the  
submission of a 1000-item change-the-world patchset to move all of  
the completely-kernel-only patches from linux/include to linux/ 
kinclude; destroying all mergeability in the process and completely  
serializing development.  Judging from the responses on this list  
when similar changes have happened before, that kind of thing is  
usually considered bad.

> 3) 'Preprocess' include/ and generate a set of KABI files based on  
> current set of (cleaned up) kernel header files.  'Preprocess in ''  
> because a C-preprocessor will not be suitable.

I got the idea of preprocessing, but your sentence seems to have  
gotten mangled somewhere.  Any chance you could clarify?  From what I  
can see by looking through the current headers, preprocessing will  
not solve some of the duplication I'd like to try to clean up.  One  
example being the duplication of bitops in various macros all over  
the place, FD_SET/FD_CLR/FD_ISSET being a prime example of that  
duplication.  It would be really nice to be able to implement those  
in terms of __set_bit, etc, however those macros themselves must be  
made userspace-clean, including adding C89-compat macros for non-GCC  
compilers and other mild ugliness, even though they'd never be  
directly exposed for user programs.

> 4) Introduce a virgin KABI (your approach). The virgin KABI has no  
> users today and does in no way preserve backward compatibility.
>
> Can you try to explain why the virgin approach is superior to the  
> others.

Your "#4" does not accurately describe what I feel I'm trying to do.   
In my first set of patches I'd like to create a set of KABI headers  
(recently I've been considering sticking them under "linux-klib" or  
similar) which provide a set of useful standards-clean compiler- 
independent typedefs, macros, and inline functions to both the kernel  
_and_ whatever ABI headers we decide to use.  (working on that now)   
Those headers would _not_ be for use directly from userspace, but  
only from within the kernel and any in-kernel ABI headers.  As a  
result, since they would be either shipped with the kernel which  
compiles against them or installed with the KABI headers which depend  
upon them, developers would be gleefully free from any obligations to  
maintain a stable interface within the linux-klib headers (although  
the code itself should be mostly C89 compliant).

As I do that I would like to adjust the kernel headers to use those  
klib includes, hopefully alleviating some of the unusual include- 
cycle problems in various headers (like the asm/posix_types.h wanting  
to use asm/bitops.h for FD_SET operations, which in some  
architectures indirectly includes asm/posix_types.h).  Along with  
that process I would be fixing up __KERNEL__ wherever they seemed  
misplaced.  Afterwards, I would try to clean up the actual guts of  
the ABI (like FD_SET, for example), I would migrate that to include/ 
linux-kabi headers or similar, trying to contain all the C89-compat  
code and macros for non-GCC compilers in include/linux-{kabi,klib}

For future maintenance it would hopefully provide a clean and easily  
noticeable break between "You can modify include/linux as much as you  
damn well please" and "This patch touches include/linux-kabi, let's  
check it carefully for ABI breakage."  I'd like to propose this as a  
natural extension to Greg KH's ABI documentation, sequestering the  
more sensitive code into a separate directory where it may be more  
carefully watched and documented.  Feel free to continue to criticize  
and dissent; even if it's eventually determined that my idea won't  
work, hopefully some other useful ideas will come up in the discussion.

Thanks for the comments!

Cheers,
Kyle Moffett

