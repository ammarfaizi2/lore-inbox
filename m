Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWC0Ake@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWC0Ake (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWC0Ake
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:40:34 -0500
Received: from smtpout.mac.com ([17.250.248.45]:2281 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932269AbWC0Akd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:40:33 -0500
In-Reply-To: <44271E88.6040101@tremplin-utc.net>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
Cc: Rob Landley <rob@landley.net>, nix@esperi.org.uk, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 19:40:14 -0500
To: Eric Piel <Eric.Piel@tremplin-utc.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 18:06:48, Eric Piel wrote:
> The real problem of sharing the same headers between kernel and  
> KABI is that it will end up by having to re-implement the "#ifdef  
> __KERNEL__"'s. Have a look at Kyle's second patch "Generalize  
> fd_set handling across architectures". Some headers had a different  
> version of the __FD_*() macros depending on the compiler. That's  
> something you may want to have in the implementation but definitely  
> not in the specification.

Actually, I think it's the other way around.  The <kabi/*.h> files  
should (eventually) be useable in basically any compilation  
environment thrown at it.  This means it should work from C and C++,  
using GCC, ICC, or some custom barely-standards-compliant compiler.   
I didn't bother with that part right now, since I still want to try  
to reuse the generic bitops if possible, but it's something I plan to  
address in future versions of the patchset (see below).

> In this situation, Kyle handled it nicely by writing versions  
> compatible with any compiler.

Eh, not really.  "__inline__" is GCC-specific and probably won't work  
in other compilers (unless you did "#define __inline__", which would  
bloat the code a lot).

This case highlights something else I'd like to do.  A good chunk of  
the functionality in the Linux kernel works both in userspace and  
kernelspace, and some of those arch-specific primitives (like the  
inline bitops) would be useful in defining the kabi headers.   
According to Jeff Dike, UML would like access to some of that stuff  
unrestricted by __KERNEL__ too.  In all of those cases, it's not an  
ABI and all the users are in-kernel so it could be changed at will.   
I'd like to try to put some of that into a "klib" directory (though  
with dependencies crossing between kabi and klib) so that it could be  
used in kabi and UML without duplicating functionality.  Naturally  
much of that would be C-only and depend on GCC, but I would have to  
be careful that the kabi portions used least-common-denominator  
functionality.

That brings up one final point: Does anybody actually use any  
compilers on Linux other than GCC?

Cheers,
Kyle Moffett

