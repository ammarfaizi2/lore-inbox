Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUFJVO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUFJVO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUFJVO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:14:28 -0400
Received: from mail.inter-page.com ([12.5.23.93]:32782 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S263059AbUFJVOD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:14:03 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 10 Jun 2004 14:13:22 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAFnNl61uL20Wfr6jkoh79oAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <04061008351700.11472@tabby>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are missing the model:

To enable executable stack/heap you would:

if ((fd = open("/proc/self/NX",O_RDWR)) >= 0) {
   write(fd,"1",1);
   close(fd);
}

(disabling would be symmetric with "0")

Because this is a sequence of specific instructions (that shouldn't exist in the
default library to prevent stack return hack invocation) these instructions would
exist only in programs that want to be EX anyway.

Because it is /proc/self other tasks cannot "do it for you".

You could put together a stack image of these instructions and overflow them into
place, but if the stack/heap isn't already executable, you couldn't run them.  IF it
was already executable you wouldn't need to.

Note also that this is about old code and not new code.  In the existing model, one
"actively secures" his ELF image at compile time.  All the existing code is secure or
not with a kernel switch.  This proposal relaxes that system wide restriction.

-- The system is NX by default.
-- ELF marked PT_GNU_STACK apps are NX and are /proc/self/NX resistant.  (This is a
refinement I guess I didn't fully think about until last night.)
-- Any app that needs to be EX can leave their ELF unmarked and turn EX on and off by
tweaking this file.
-- Legacy apps can be EX enabled on a case-by-case basis with an LD_PRELOAD of a
shared library that contains the above in its __init().

So now, WINE (for instance) can put the above code in its startup system
unconditionally (since it is conditional on the presence of /proc/self/NX in the
first place) and WINE can be run on a system that is "otherwise NX".

The implementation doubles the "flag density" of the implementation because you have
to keep the ELF-set flag and the /procf/self/NX flag separately.  You would also need
to be able to alter and reload the segment descriptors in the running application.
Neither should be terribly onerous.

But now the NX kernel increases security by default even for apps that are already
existent or that cannot be recompiled due to being non-Open-Source.  This increases
both portability and security without requiring a complete rebuild of a distro.

So I would guess that this would be a "changeable default plus a hard lock" belt-and
suspenders approach to backwards compatability.

Rob.




-----Original Message-----
From: Jesse Pollard [mailto:jesse@cats-chateau.net] 
Sent: Thursday, June 10, 2004 6:35 AM
To: Robert White; 'Ingo Molnar'; 'Christoph Hellwig'; 'Mike McCormack';
linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2

On Wednesday 09 June 2004 15:53, Robert White wrote:
> Which is why I, later in the same message, wrote:
>
> Architecturally the easy-application-accessible switch should be something
> more than a syscall to prevent a return-address-twiddle invoking the call
> directly.  I'd make it a /proc/self something, or put it in a separate
> include-only-if-used shared library or something.  If the minimal distance
> is opening and writing a normally-untouched file then you get a nice
> support matrix.  (e.g. no file means no feature, file plus action means
> executable stack, no action means system default (old can, new cannot),
> hacks would require a variable (fd) and executing arbitrary code to open
> and write that file, programs/programmers that want/need the old behavior
> can achieve it without having to know how to manipulate their ELF headers
> or tool-chains, etc.)
>
> Which is not susceptible to the 1-2 attack you mention below because the
> open and write cannot be done on a protected stack or heap, since it would
> then have to be (er... ) executed to perform the hack.
>
> Ahhhh, yes...

no. This only means the 1-2 attack must be done in two steps (maybe three).

1. create the file (first buffer overflow)
2. write? (second buffer overflow - depends on whether file must have value)
3. disable NX (third)


