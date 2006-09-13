Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWIMVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWIMVrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIMVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:47:48 -0400
Received: from gw.goop.org ([64.81.55.164]:18082 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751213AbWIMVrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:47:47 -0400
Message-ID: <45087C78.20308@goop.org>
Date: Wed, 13 Sep 2006 14:47:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org> <Pine.LNX.4.64.0609131358090.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609131358090.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> These _used_ to be the "user CS/DS" respectively, but that got changed 
> around by me when did the "sysenter" support.
>   

So does this mean that moving the user-visible cs/ds isn't likely to 
break stuff, if it has been done before?

> The sysenter logic (or, more properly, the sysexit one) requires that the 
> user code segment number is the same as the kernel code segment +2 (ie 
> "+16" in actual selector term). And the user data segment needs to be +3.
>   

Yep, I'm aware of that constraint.

> And segment #8 (ie 0x40) is special (TLS segment #3), of course. 
> Anybody who wants to emulate windows or use the BIOS needs to use that for 
> their "common BIOS area" thing, iirc.
>   

Do you mean that something like dosemu/Wine needs to be able to use GDT 
#8?  Or is it only used in kernel code?

> See above. The kernel and user segments have to be moved as a block of 
> four, and obviously we'd like to keep them in the same cacheline too. 
> Also, the cacheline that contains segment #8/0x40 is not available,

Why's that?  That cacheline (assuming 64 byte line size) already 
contains the user/kernel/cs/ds descriptors.

I'm thinking of putting together a patch to change the descriptor use to:

    8  - TLS #1
    9  - TLS #2
    10 - TLS #3
    11 - Kernel PDA
    12 - Kernel CS
    13 - Kernel DS
    14 - User CS
    15 - User DS
      

This has the advantage of leaving the user cs/ds unchanged.  From what 
people had said so far, this should be OK, other than making the heavily 
used TLS #1 share the BIOS common area entry number.  If this needs to 
be usable by userspace for something special, then making it TLS #1 
won't fly...

Alternatively, maybe:

    0  - NULL
    1  - Kernel PDA
    2  - Kernel CS
    3  - Kernel DS
    4  - User CS
    5  - User DS
    6  - TLS #1
    7  - TLS #2
      

which moves the user cs/ds, but avoids #8.

    J
