Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWKVAqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWKVAqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031390AbWKVAqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:46:24 -0500
Received: from nz-out-0102.google.com ([64.233.162.204]:21878 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1031385AbWKVAqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:46:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K377y3r17BNRZPRERPGB2Qu/8aYIShtWwdRoXPLQd389NWoa5gC76aKguJ+9rE8Vnp5na9bk2uy6jBROOzdXWxsg46nJxRGfIheIVQTBwnitYYX6M2SBTvCSp2E81jPXvt0i/LmYuwNpoxRV6ymSmPb59be4Ty0j4YTaQQB6tQ0=
Message-ID: <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
Date: Wed, 22 Nov 2006 01:46:22 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 17/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 17/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> [...]
> > > and just run the resulting kernel version for a day or two. If an hour
> > > wasn't really good enough, it's not as repeatable as we'd have wished, but
> > > even if it takes a few days to narrow it down by just two bisections or
> > > so, it will cut things down from ten thousand commits to "just" 2500..
> > >
> > Ok, sure. I'll do a days run of 2.6.19-rc2 first, just to see if it's
> > been fixed in the mean time. If it's still there I'll try to get a
> > sysrq+t and post that, then I'll restart bisection and give each
> > kernel a full 24hrs of testing before concluding it is good.
> >
> > I'll report back as soon as I have some results.
> >
> Ok, I've been unable to do any testing for a few days, but today I had
> some spare time and set my box to run my test script while doing some
> other work. It was running latest git at the time of 2.6.19-rc2 + a
> day or two and it locked up after ~20min.
> So we are not so lucky that the problem has been fixed by some of the
> patches that have gone in recently :-(
>
> Since there was nothing in the system logs and the box was completely
> frozen (not even sysrq worked) I goess I'll have to try and restart
> the bisection.
>
> Just wanted to report the little data I had. I'll be back with more
> (hopefully soon).
>

A little more data :

I'm still able to reproduce the lockups with 2.6.19-rc6 and 2.6.19 git
HEAD as of yesterday.

I've still not been able to get a sysrq-t dump or anything in my logs yet :(

One thing I have found though is that I don't have to use my test
script to reproduce. Usually building an allyesconfig kernel (or two)
is enough.
The lockups seem to happen when my box runs low on memory. What
happens is that I can see all my memory being used up and the kernel
starts dipping into swap. Interactive behaviour in X then gets
significantly worse - changing between windows starts lagging and
eventually even moving the mouse gets jerky, it makes large jumps with
several seconds delay - that's a sure sign a lockup is comming very
soon.
The box has 2GB of RAM and 768MB swap. When it starts getting
unresponsive before a hang there's usually plenty of swap (a few
hundred MB) left and also a bit of RAM free.

So it *seems* to be somehow related to running low on RAM and swap
starting to be used.

One other thing that I've noticed, that may or may not be related, is
that when I shutdown my machine after a session where a significant
amount of RAM has been in use at some point (especially bad if some
swap has also been in use), then unmounting my filesystems takes ages.
Normally it just takes a few seconds to unmount the filesystems upon a
shutdown, or at most 10 seconds, but if I'm at the point where the
machine has dipped into swap (or has been very close to), then
unmounting the filesystems often takes 10-15 *minutes* or more
(sometimes I just give up and power off the box after 30min or
thereabouts).

Hope that helps in some way... I still want to redo/complete a new
bisection, but havent found the time yet.
More details when I have some.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
