Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWCZVJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWCZVJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCZVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:09:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7119 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750994AbWCZVJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:09:25 -0500
From: Rob Landley <rob@landley.net>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 16:09:10 -0500
User-Agent: KMail/1.8.3
Cc: Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net>
In-Reply-To: <4426A5BF.2080804@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261609.10992.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 9:31 am, Eric Piel wrote:
> I completely agree with rules 1, 2 and 5. However, IMHO rule 4 should
> just be the inverse of rule 5: The stuff in include/linux should always
> be independent from KABI (and userspace of course). Simply because the
> way we _implement_ things in the kernel has to be different from the
> things that we _specify_ in the kernel ABI.

You know all the stuff that's marked __user?  It's all kernel ABI.  Having it 
defined in two places invites version skew, and the kernel needs it too 
because the kernel is parsing the stuff sent in by userspace and filling it 
out to send back to userspace.

Lots of syscalls and ioctls and such pass a structure back and forth from 
userspace to the kernel and back, right?  Doing a stat() fills out a 
structure, doing an losetup fills out a structure, and so on.

Userspace needs to know what's in this structure.  It may be wrapped in a libc 
function that fills out a different structure from the kernel structure, but 
the data that goes back and forth between the program and the kernel has to 
be defined in a header somewhere so the libc knows what the kernel's sending 
and the kernel knows what the libc is sending.  (And for those functions with 
no libc wrapper, the user program needs to know the structure directly, 
somehow.)

Having a data-marshalling ABI structure defined in two places invites version 
skew.  Userspace needs access to this (at least to build a libc), and the 
kernel needs access to this, because it's a _communication_mechanism_.  You 
can't have a communication mechanism that's only defined at one end.

> As for rule 3, if you have independent headers, this should be much less
> necessary. Additionally, keeping all the names identical to what they
> are already called will allow userspace to just use include/kabi/ as the
> /usr/include/linux/ directory. Avoiding smelly things like:
>
> linux/foo.h:
>    #define __kabi_foo foo
>    #include <kabi/foo.h>

The #define is, indeed, smelly.

Rob
-- 
Never bet against the cheap plastic solution.
