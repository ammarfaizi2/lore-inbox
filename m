Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315038AbSDWDBp>; Mon, 22 Apr 2002 23:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315039AbSDWDBo>; Mon, 22 Apr 2002 23:01:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1930 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315038AbSDWDBo>;
	Mon, 22 Apr 2002 23:01:44 -0400
Date: Mon, 22 Apr 2002 23:01:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module()
In-Reply-To: <20020422194214.D24927@one-eyed-alien.net>
Message-ID: <Pine.GSO.4.21.0204222250050.5686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Matthew Dharm wrote:

> The question then becomes one of how do I distinguish a race condition from
> a legitimate load/unload cycle?

> Isn't the problem here just the misuse of rmmod -a?  Perhaps we should
> attach a warning to the documentation to indicate the possible badness that
> can happen.

Not really.  _Any_ use of rmmod -a (i.e. unload stuff not in use) can
trigger that.

As for legitimate load/unload cycle... in this situation thing should be
considered busy.  It's that simple - what happens here is that we are asking
for module because we want to make it busy as soon as we get it.  Race
window is between the sys_create_module() from modprobe and try_inc_use_count()
in whatever wants it in the kernel or sys_init_module() for module depending
on it.

IOW, unload is _not_ legitimate here.

