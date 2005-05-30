Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVE3Tlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVE3Tlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVE3TlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:41:09 -0400
Received: from smtpout.mac.com ([17.250.248.47]:25087 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261721AbVE3TjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:39:23 -0400
In-Reply-To: <20050530192826.GB25794@muc.de>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com> <20050530192826.GB25794@muc.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DE908D1-29A8-4A05-AC16-E3AD480C2F56@mac.com>
Cc: Chris Friesen <cfriesen@nortel.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft
Date: Mon, 30 May 2005 15:39:04 -0400
To: Andi Kleen <ak@muc.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2005, at 15:28:26, Andi Kleen wrote:
> On Mon, May 30, 2005 at 02:04:36PM -0400, Kyle Moffett wrote:
>>> I suspect any attempt to use time stamps in locks is a bad
>>> idea because of this.
>>
>> Something like this could be built only for CPUs that do support that
>> kind of cycle counter.
>
> That gets you into a problem with binary distribution kernels.
> While binary patching works to some extent, it also becomes
> messy pretty quickly.

Well, a runtime-set function-pointer isn't all that bad.  Basically
if a simple cycle-counter driver is available, it would use that,
otherwise it would fall back to ordinary spinlock behavior.

>> The idea behind these locks is for bigger systems (8-way or more) for
>> heavily contended locks (say 32 threads doing write() on the same  
>> fd).
>
> Didn't Dipankar & co just fix that with their latest RCU patchkit?
> (assuming you mean the FD locks)

That's lock-free FD lookup (open, close, and read/write to a certain
extent).  I'm handling something more like serialization on a fifo
accessed in both user context and interrupt context, which in a
traditional implementation would use a spinlock, but with a spinaphore,
one could do this:

In interrupt context:

spinaphore_lock_atomic(&fifo->sph);
put_stuff_in_fifo(fifo,stuff);
spinaphore_unlock(&fifo->sph);

In user context:

spinaphore_lock(&fifo->sph);
put_stuff_in_fifo(fifo,stuff);
spinaphore_unlock(&fifo->sph);

If there are multiple devices generating interrupts to put stuff in the
fifo and multiple processes also trying to put stuff in the fifo, all
bursting on different CPUs, then the fifo lock would be heavily loaded.
If the system had other things it could be doing while waiting for the
FIFO to become available, then it should be able to do those.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



