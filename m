Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWJPDus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWJPDus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 23:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJPDus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 23:50:48 -0400
Received: from sigtuna.hangingditch.net ([88.198.191.26]:27874 "EHLO
	sigtuna.hangingditch.net") by vger.kernel.org with ESMTP
	id S1751441AbWJPDur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 23:50:47 -0400
In-Reply-To: <Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
References: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com> <Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C18CBF5-05A8-4A28-BAC7-73B2F4342F4C@garethknight.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Gareth Knight <gk@garethknight.com>
Date: Sun, 15 Oct 2006 20:50:37 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-SA-Exim-Connect-IP: 64.142.80.85
X-SA-Exim-Mail-From: gk@garethknight.com
Subject: Re: [PATCH] generic signal code (small new feature - userspace signal mask), kernel 2.6.16
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on sigtuna.hangingditch.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Thanks for the lightning fast response !

I take your points - the reason I favoured trying userspace access  
approach was to keep the feature portable.  I've seen this feature in  
other *nix kernels but always done with the mask kept on some sort of  
syspage shared between user and kernel space, at a fixed address but  
contents local to each thread.  I would love to add such a feature to  
Linux - perhaps keep the tid, timeofday and other popular things on  
there as well; however I felt that sort of work was beyond my kernel  
hacking abilities right now.  I guess it could either be done as an  
outright special case or part of supporting a MAP_LOCAL style of mmap  
on Linux.

I did google for MAP_LOCAL and syspage, but I didn't see any  
promising avenues in terms of previous work I could pickup.

Gareth.

>
>
> On Sun, 15 Oct 2006, Gareth Knight wrote:
>>
>> I looked in MAINTAINERS for a suitable person for the generic  
>> signal code, but
>> couldn't find anyone in particular.  Please Cc me on comments,  
>> which are most
>> welcome, as I am not on LKML, although I do peruse the archives.
>
> That's a truly horribly disfigured patch - your whitespace is all  
> screwed
> up.
>
> Anyway, the whole approach is not doable. At all.
>
> Why? You're doing user-space accesses from within critical sections  
> with a
> spinlock, and that's just a big no-no. Think page faults, swapping  
> etc.
>
> That's ignoring all the issues with the fact that doing the user  
> accesses
> during recalc_sigpending is broken for other reasons, namely that  
> we don't
> even _do_ the signal pending recalculation all the time, just when we
> "know" things may have changed. So your approach would miss updates  
> to the
> user-space masks.
>
> So the whole approach is flawed.
>
> You _could_ try to make it do something special at signal delivery  
> time,
> to see if delivery can be delayed at that point, but quite frankly,  
> it's
> going to be nasty there too (and that's going to be a disaster for the
> whole issue of non-thread-specific signals, which have been steered  
> to one
> thread, and then the new mask would say that they can't be accepted by
> that thread after all).
>
> Quite frankly, you'd probably be better off trying to do totally  
> different
> approaches. For example, it would be possible to block all signals
> entirely, and then just create a new system call that uses a  
> _synchronous_
> delivery method to avoid races with async delivery. Preferably a file
> descriptor, so that you can select/poll on it.
>
> That was discussed at some point. See for example:
>
> 	http://groups.google.com/group/linux.kernel/browse_thread/thread/ 
> 1332715ae3e26b9/1f3fc521db812a07? 
> lnk=st&q=&rnum=1&hl=en#1f3fc521db812a07
>
> which I found by just googling for "synchronous signal queue" with  
> me as
> the author. That's from almost four years ago, and nobody ever got  
> quite
> excited enough about it to actually take it any further, but I  
> still think
> it's a lot better than the alternatives like yours..
>
> 			Linus

