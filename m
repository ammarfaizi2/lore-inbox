Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbRFTEik>; Wed, 20 Jun 2001 00:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264476AbRFTEi3>; Wed, 20 Jun 2001 00:38:29 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:57102 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264436AbRFTEiQ>;
	Wed, 20 Jun 2001 00:38:16 -0400
From: Andrew Tridgell <tridge@valinux.com>
To: davem@redhat.com
Cc: zackw@stanford.edu, linux-kernel@vger.kernel.org
In-Reply-To: <15152.1911.886630.381952@pizda.ninka.net> (davem@redhat.com)
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Reply-To: tridge@valinux.com
In-Reply-To: <20010619184802.D5679@stanford.edu> <15152.1911.886630.381952@pizda.ninka.net>
Message-Id: <20010620043348.9B597474B@lists.samba.org>
Date: Tue, 19 Jun 2001 21:33:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davem wrote:
>  > The anonymous pipe code in 2.2 does not check the return value of
>  > copy_*_user.  This can lead to silent loss of data.
> 
> I remember Andrew Tridgell (cc:'d) spotting this a long time
> ago, and we didn't fix it, and I forget what the reason was.

Linus didn't want to fix it in pipe.c until copy_from_user was fixed
on all architectures to zero any parts of the destination that were
not written to (due to the source being invalid). He didn't want us to
fix just this one case and then forget about fixing the general case
by fixing copy_*_user.

I had a sample program that was able to dump all of memory to a file
as an unprivileged user by using a combination of pipe/fork/mmap in a
loop. It exploited the fact that a write from NULL on a pipe would end
up leaving uninitialised data in the pipe buffer which could be read
by the program. The fork/mmap loop was used to traverse all pages by
consuming the last freed page after each pipe close. This could then
be used to grab passwords or other sensitive information from other
users.

Is copy_from_user now fixed on all architectures? If so, then maybe we
can finally check the error return in pipe.c. I think that not telling
a program that a write to a fd failed is pretty bogus.

Cheers, Tridge
