Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWCZXHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWCZXHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWCZXHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:07:16 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:64648 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S932171AbWCZXHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:07:14 -0500
Message-ID: <44271E88.6040101@tremplin-utc.net>
Date: Mon, 27 Mar 2006 01:06:48 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net>
In-Reply-To: <200603261609.10992.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv6.univ-lille1.fr [193.49.225.20]); Mon, 27 Mar 2006 01:06:56 +0200 (CEST)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

26.03.2006 23:09, Rob Landley wrote/a écrit:
> On Sunday 26 March 2006 9:31 am, Eric Piel wrote:
>> I completely agree with rules 1, 2 and 5. However, IMHO rule 4 should
>> just be the inverse of rule 5: The stuff in include/linux should always
>> be independent from KABI (and userspace of course). Simply because the
>> way we _implement_ things in the kernel has to be different from the
>> things that we _specify_ in the kernel ABI.
> 
> You know all the stuff that's marked __user?  It's all kernel ABI.  Having it 
> defined in two places invites version skew, and the kernel needs it too 
> because the kernel is parsing the stuff sent in by userspace and filling it 
> out to send back to userspace.
> 
> Lots of syscalls and ioctls and such pass a structure back and forth from 
> userspace to the kernel and back, right?  Doing a stat() fills out a 
> structure, doing an losetup fills out a structure, and so on.
> 
> Userspace needs to know what's in this structure.  It may be wrapped in a libc 
> function that fills out a different structure from the kernel structure, but 
> the data that goes back and forth between the program and the kernel has to 
> be defined in a header somewhere so the libc knows what the kernel's sending 
> and the kernel knows what the libc is sending.  (And for those functions with 
> no libc wrapper, the user program needs to know the structure directly, 
> somehow.)
> 
> Having a data-marshalling ABI structure defined in two places invites version 
> skew.  Userspace needs access to this (at least to build a libc), and the 
> kernel needs access to this, because it's a _communication_mechanism_.  You 
> can't have a communication mechanism that's only defined at one end.
Well, that's half true. Indeed, in general, having two separate 
definitions invites version skew. However, in this particular case, it's 
slightly different: because the principle of the ABI is to be stable, or 
more exactly _compatible_. This means that if one definition was right 
at some point in the time, it should always still be true ten years 
later. At worse, the ABI can be extended, but never changed. If the 
specification (KABI) and the implementation (Linux) are not compatible 
it means the kernel developers screwed up, not that the KABI maintainers 
haven't updated in time.

Of course, next to the theory, there is the reality. Some part of the 
ABI has already be changed (broken) in the past (like the alsa ABI, 
IIRC). In such case the KABI maintainers will have to handle the changes 
as promptly as possible, but the responsibility will be held by the 
kernel developer who has opted for breakage.

The real problem of sharing the same headers between kernel and KABI is 
that it will end up by having to re-implement the "#ifdef __KERNEL__"'s. 
Have a look at Kyle's second patch "Generalize fd_set handling across 
architectures". Some headers had a different version of the __FD_*() 
macros depending on the compiler. That's something you may want to have 
in the implementation but definitely not in the specification. In this 
situation, Kyle handled it nicely by writing versions compatible with 
any compiler. Good looking solution inside the kernel will not always be 
an option. IMHO, if KABI and the kernel share the same headers, it's 
just a matter of time before someone introduces an "#ifdef 
__KERNEL__"-alike mechanism, exactly what we've been trying to remove.

Eric
