Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSG2AnA>; Sun, 28 Jul 2002 20:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSG2AnA>; Sun, 28 Jul 2002 20:43:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48905 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317695AbSG2Am7>; Sun, 28 Jul 2002 20:42:59 -0400
Date: Sun, 28 Jul 2002 17:47:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
In-Reply-To: <3D448EAA.CE3382D8@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207281739360.8208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> We can do the rwsem thing, and that would be good.  But there may
> be filesystems which are relying on i_sem to provide protection
> against concurrent invokations of get_block(create=1), inside i_size.

We actually want to retain i_sem for directory operations anyway (ie the
rw-semaphore would be an addition, not a replacement), so the easiest
transition would probably be to move the i_sem thing into the filesystems
when the rwsem thing is done (the same way the BKL removal worked), and
then let the filesystems make their own decisions on when they need it
(and the decision might well be to take it in the "create = 1" case, which
is likely to be fairly rare for non-extending writes)

The other alternative is to move this _all_ into the filesystem entirely,
and not have "generic_file_write()" take any lock at all. Let the
filesystem first take whatever lock it thinks it needs, and then call
"generic_file_write()". Filesystems migh choose to just get i_sem
unconditionally both for extending and non-extending writes.

That would mean that the filesystems would have to always wrap their use
of "generic_file_write()", but a number of them do so anyway because they
want to do some other book-keeping. I dunno.

			Linus

