Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWIMVWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIMVWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWIMVWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:22:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbWIMVWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:22:13 -0400
Date: Wed, 13 Sep 2006 14:21:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
In-Reply-To: <450854F3.20603@goop.org>
Message-ID: <Pine.LNX.4.64.0609131358090.4388@g5.osdl.org>
References: <450854F3.20603@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Sep 2006, Jeremy Fitzhardinge wrote:
> *
> *   4 - unused			<==== new cacheline
> *   5 - unused

These _used_ to be the "user CS/DS" respectively, but that got changed 
around by me when did the "sysenter" support.

The sysenter logic (or, more properly, the sysexit one) requires that the 
user code segment number is the same as the kernel code segment +2 (ie 
"+16" in actual selector term). And the user data segment needs to be +3.

So with sysenter, we needed a block of four contiguous segments: kernel 
code, kernel data, user code, user data (in that order).

There are other possible things to do, but what we did was to move the 
user segments up to just above the kernel ones (which we left in place).

> *   6 - TLS segment #1			[ glibc's TLS segment ]
> *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
> *   8 - TLS segment #3
> *   9 - reserved
> *  10 - reserved
> *  11 - reserved

These are really reserved, I think we left them that way on purpose so 
that if we wanted to, we can allow more of the contiguous per-thread 
state. And segment #8 (ie 0x40) is special (TLS segment #3), of course. 
Anybody who wants to emulate windows or use the BIOS needs to use that for 
their "common BIOS area" thing, iirc.

I think it's generally a good idea to keep the low segment reserved (or at 
least free to use for whatever user code), since if there are any special 
magic segment descriptor numbers, they tend to be in that low range. The 
#8/0x40 thing is just an example.

> What are entries 1-3 and 9-11 reserved for?  Must they be unused for some
> reason, or is there some proposed use that has not been impemented yet?
> 
> Also, is there a particular reason kernel GDT entries start at 12?  Would
> there be a problem in using either 4 or 5 for a kernel GDT descriptor?

See above. The kernel and user segments have to be moved as a block of 
four, and obviously we'd like to keep them in the same cacheline too. 
Also, the cacheline that contains segment #8/0x40 is not available, so 
that together with keeping low segments for user space explains why it's 
at segment numbers #12-15 (selectors 0x60/0x68/0x73/0x7b).

But I don't think anything but 0x40 is "set in stone".

		Linus
