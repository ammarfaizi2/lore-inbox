Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRKSQom>; Mon, 19 Nov 2001 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKSQoc>; Mon, 19 Nov 2001 11:44:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57095 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279998AbRKSQoX>; Mon, 19 Nov 2001 11:44:23 -0500
Date: Mon, 19 Nov 2001 08:39:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <E165lSM-000666-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111190833440.8103-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Alan Cox wrote:
>
> You can in theory get even stranger effects. Consider
>
> 	if(!(flag&4))
> 	{
> 		blahblah++;
> 		flag|=4;
> 	}
>
> The compiler is completely at liberty to turn that into
>
> 	test bit 2
> 	jz 1f
> 	inc blahblah
> 	add #4, flag
> 1f:

That's fine - if you have two threads modifying the same variable at the
same time, you need to lock it.

That's not the case under discussion.

The case under discussion is gcc writing back values to a variable that
NEVER HAD ANY VALIDITY, even in the single-threaded case. And it _is_
single-threaded at that point, you only have other users that test the
value, not change it.

That's not an optimization, that's just plain broken. It breaks even
user-level applications that use sigatomic_t.

And note how gcc doesn't actually do it. I'm not saying that gcc is broken
- I' saying that gcc is NOT broken, and we depend on it being not broken.

		Linus

