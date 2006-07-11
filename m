Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWGKDdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWGKDdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWGKDdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:33:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:2542 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965089AbWGKDdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:33:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DIh5TafSl3x+uDLFENs2iu6o2sw3wPXG5tqJA5e1GxzBlBSTiqvE/g459LXUAgohutY39RnFPXpODkqjj9NgjmStDR/st1aZz2JfkFrlmMbtR7no7tExvi4Ccbwg4N64h76Ii7VTmH4oI7mZ8vTDfp8l+Ol4lhpTtPVAU/VpiAY=
Message-ID: <9e4733910607102033u3e308142o9be47e5a7e0c0af7@mail.gmail.com>
Date: Mon, 10 Jul 2006 23:33:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
In-Reply-To: <20060711012904.GD30332@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jul 10, 2006 at 07:49:31PM -0400, Jon Smirl wrote:
> > How about the use of lock/unlock_kernel(). Is there some hidden global
> > synchronization going on? Every time lock/unlock_kernel() is used
> > there is a tty_struct available. My first thought would be to turn
> > this into a per tty spinlock. Looking at where it is used it looks
> > like it was added to protect all of the VFS calls. I see no obvious
> > coordination with other ttys that isn't handled by other locks.
>
> No, it was just a case of not being worth it to get rid of the BKL for
> the tty subsystem, since opening and closing tty's isn't exactly a
> common event.  Switching it to use a per-tty spinlock makes sense if
> we're going to rototill the code, but to be honest it's probably not
> going to make a noticeable difference on any benchmark and most
> workloads.

I tried changing it to a per tty spinlock. Now I know that the code
relies on the BKL being broken when a task sleeps. That's a part of
the BKL I don't like, unlocks are happening implicitly instead of
explicitly. I always wonder if the code should have reacquired the BKL
when it woke up. In this case the sleep happens inside the line
discipline read functions.

Now I'm wondering if read and write should have taken BKL to begin
with. Read sleeps in a loop so after the first pass it has lost the
BKL. Read and write also have the own locking code internally.

-- 
Jon Smirl
jonsmirl@gmail.com
