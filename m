Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTI0E2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTI0E2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:28:01 -0400
Received: from zero.aec.at ([193.170.194.10]:17419 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262106AbTI0E17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:27:59 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@napali.hpl.hp.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
From: Andi Kleen <ak@muc.de>
Date: Sat, 27 Sep 2003 06:26:40 +0200
In-Reply-To: <AepM.5Zb.41@gated-at.bofh.it> ("David S. Miller"'s message of
 "Sat, 27 Sep 2003 06:00:22 +0200")
Message-ID: <m33ceij1q7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <A4gy.8wi.13@gated-at.bofh.it> <A4gy.8wi.15@gated-at.bofh.it>
	<A4gy.8wi.17@gated-at.bofh.it> <A4gy.8wi.11@gated-at.bofh.it>
	<A4Tv.Ud.37@gated-at.bofh.it> <AepM.5Zb.41@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Fri, 26 Sep 2003 10:47:12 -0700
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
>> Arches that don't like/support unaligned accesses will certainly
>> have a copy_user() which handles misalignment just fine.  For
>> example, on ia64, the copy will run slightly slower because of an
>> additional shift in the loop, but that penalty only shows on fully
>> cached data.
>
> Exactly correct, and on many platforms (sparc64 happens to be one)
> there is _ZERO_ performance penalty for misalignment or source or
> destination buffer during a memcpy/memmove.

You handle misalignment->misalignment copies with zero or small cost -
when both source and destination have the same misalignment. I guess
you do that by just aligning the pointer at the beginning of the 
function. That works as long as both source and destination have
the same misalignment.

But that is not what happens here. The copy is a misaligned->aligned
copy and that cannot be handled at zero cost (unless you have zero
misalignment penalty in load/store). Either the load or the store in the 
copy loop will be always misaligned, no matter what tricks you play. You 
cannot avoid this by aligning the pointers.

The user buffers tend to be aligned, so when the kernel data is misaligned
the copy ends up requiring an misaligned load in the inner copy loop.

Of course you could try to teach the user to use intentionally misaligned
buffers in his programs to avoid this, but it would be likely a hard 
sell and be a bad idea on less crippled NICs.

The copy inside the device driver has the same problem: misaligned 
data -> aligned skb => the load in the copy will be misaligned, the store 
aligned. You avoid a few unaligned loads in the core stack, at the cost
of hundreds in the copy. Seems like a bad trade-off to me.

-Andi
