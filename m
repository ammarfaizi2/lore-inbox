Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWHGUnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHGUnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWHGUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:43:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:29856 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932348AbWHGUnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:43:24 -0400
X-Authenticated: #271361
Date: Mon, 7 Aug 2006 22:41:44 +0200
From: Edgar Toernig <froese@gmx.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060807224144.3bb64ac4.froese@gmx.de>
In-Reply-To: <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
>
> On 8/7/06, Edgar Toernig <froese@gmx.de> wrote:
> > Why do we need [f]revoke at all?  As it doesn't implement the
> > BSD semantic I can't see why it's better than fuser -k.
> 
> Which part of the BSD semantics is that?

That which talks about character devices, in particular ttys.

NetBSD revoke(2):
|
| ... a read() from a character device file which has been revoked
| returns a count of zero (end of file), and a close() call will
| succeed.
|...
| revoke is normally used to prepare a terminal device for a new
| login session, preventing any access by a previous user of the
| terminal.

Irix revoke(2) even mentions:
|
| ERRORS:
|  ...
|  [EINVAL] The named file is not a character-special file.

It seems, revoke was intended to disable access to tty devices
from old processes in a controlled way.  Sounds sane.

Your implementation is much cruder - it simply takes the fd
away from the app; any future use gives EBADF.  As a bonus,
it works for regular files and even goes as far as destroying
all mappings of the file from all processes (even root processes).
IMVHO this is a disaster from a security and reliability point
of view.

So, the behaviour regarding ttys is completely different to
other implementations and for other types of fds the Linux
semantic seems unique (the man-pages of the other systems
are pretty silent about that).

A serious question: What do you need this feature of revoking
regular files (or block devices) for?  Maybe my imagination
is lacking, but I can't find a use where fuser(1) (or similar
tools) wouldn't be as good or even better than revoke(2).

Ciao, ET.
