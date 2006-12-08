Return-Path: <linux-kernel-owner+w=401wt.eu-S1761177AbWLHUfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761177AbWLHUfS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761187AbWLHUfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:35:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33986 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761177AbWLHUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:35:16 -0500
Date: Fri, 8 Dec 2006 12:34:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208195949.GK31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612081221180.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com>
 <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org> <20061208190403.GH31068@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612081130110.3516@woody.osdl.org> <20061208195949.GK31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Russell King wrote:
>> 
> The only instructions which affect the exclusive access state are the
> exclusive access instructions themselves.

Not according to the docs I found.

The ARM1136 manual explicitly states that any attempt to modify that 
address clears the tag (for shared memory regions, by _any_ CPU, and for 
nonshared regions by _that_ CPU).

And btw, that _has_ to be true, because otherwise the whole ldrex/strex 
sequence would be totally unusable as a way to do atomic bit operations on 
UP in the presense of interrupts (well, you could have a clrex instruction 
in the interrupt handler, but as far as I know you don't, so that seems to 
be a moot point - you only seem to do it in __switch_to).

In other words, I _really_ think you're wrong. 

So the very code sequence you quote MUST NOT WORK the way you claim it 
does. And not only that, since the granularity of the mark is not just for 
the bytes in question, but potentially apparently up to 128 bytes, any 
store even _close_ to the memory you had xclusive access to will break the 
exclusive access.

Really, Russell. Your stance makes no sense. It doesn't make any sense 
from a microarchitectural standpoint (it's not how you'd normally 
implement these things), but it ALSO makes no sense from the way you 
already use those instructions (as a way to protect against other 
processors - including your own - touching that word).

                    Linus
